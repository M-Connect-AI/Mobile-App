import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../common/components/irh_button.dart';
import '../../../common/components/app_toast.dart';
import '../../../common/components/irh_text.dart';
import '../../../common/extensions/responsive_extension.dart';
import '../../../common/themes/theme_extensions/app_color_scheme.dart';
import '../../../domain/model/home_data.dart';
import '../../../domain/repository/credential_repository.dart';
import '../../../domain/model/hr_request.dart';
import '../../../domain/repository/hr_request_repository.dart';
import '../../../domain/service/data_refresh_coordinator.dart';
import '../../../generated/l10n.dart';
import '../../../route/go_router.dart';
import '../home/widgets/home_back_button.dart';
import 'bloc/hr_request_cubit.dart';

class HrRequestListPage extends StatelessWidget {
  const HrRequestListPage({super.key, required this.kind});

  final HrRequestKind kind;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => HrRequestCubit(
      context.read<HrRequestRepository>(),
      context.read<CredentialRepository>(),
      refreshCoordinator: context.read<DataRefreshCoordinator?>(),
    )..loadList(kind),
    child: _RequestScreen(kind: kind),
  );
}

class HrRequestDetailPage extends StatelessWidget {
  const HrRequestDetailPage({
    super.key,
    required this.kind,
    required this.id,
    this.employeeName,
    this.initialTrip,
  });

  final HrRequestKind kind;
  final String id;
  final String? employeeName;
  final TripRequest? initialTrip;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => HrRequestCubit(
      context.read<HrRequestRepository>(),
      context.read<CredentialRepository>(),
      refreshCoordinator: context.read<DataRefreshCoordinator?>(),
    )..loadDetail(kind, id, employeeName: employeeName, initialTrip: initialTrip),
    child: _RequestScreen(kind: kind, id: id),
  );
}

class _RequestScreen extends StatelessWidget {
  const _RequestScreen({required this.kind, this.id});

  final HrRequestKind kind;
  final String? id;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final title = kind == HrRequestKind.leave ? strings.leaveRequest : strings.businessTrip;
    return BlocListener<HrRequestCubit, HrRequestState>(
      listener: (context, state) {
        if (state.failure == HrFailureType.sessionExpired ||
            state.actionError?.type == HrFailureType.sessionExpired) {
          const LoginRoute().go(context);
        } else if (state.batchResult != null) {
          final message = state.batchFailed == 0
              ? strings.batchResult(state.batchResult!)
              : strings.batchResultPartial(state.batchResult!, state.batchFailed);
          if (state.batchFailed == 0) {
            AppToast.showSuccess(context, message);
          } else {
            AppToast.showWarning(context, message);
          }
        } else if (state.actionError != null) {
          AppToast.showError(
            context,
            state.actionError!.message ?? _failureMessage(context, state.actionError!.type),
          );
        } else if (state.actionSuccess != null) {
          final message = switch ((kind, state.actionSuccess!)) {
            (HrRequestKind.leave, HrAction.approve) => strings.approveLeavesSuccess,
            (HrRequestKind.leave, HrAction.reject) => strings.rejectLeavesSuccess,
            (HrRequestKind.trip, HrAction.approve) => strings.approveTripsSuccess,
            _ => strings.rejectTripsSuccess,
          };
          AppToast.showSuccess(context, message);
        }
      },
      child: Scaffold(
        backgroundColor: context.appColorScheme.surfacePrimary,
        bottomNavigationBar: id == null
            ? null
            : BlocBuilder<HrRequestCubit, HrRequestState>(
                builder: (context, state) {
                  final status = kind == HrRequestKind.leave
                      ? state.leave?.status
                      : state.trip?.status;
                  if (state.status != HrRequestStatus.success ||
                      !state.isManager ||
                      status != RequestStatus.pending) {
                    return const SizedBox.shrink();
                  }
                  return _ActionBar(kind: kind, action: state.action);
                },
              ),
        body: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  HomeBackButton(semanticLabel: strings.backToHome),
                  12.width.widthBox,
                  IrhText.title(
                    id == null
                        ? title
                        : kind == HrRequestKind.leave
                        ? strings.leaveDetailTitle
                        : strings.requestDetailTitle(title),
                  ).expanded(),
                ],
              ).paddingSymmetric(horizontal: 16.width, vertical: 12.height),
              BlocBuilder<HrRequestCubit, HrRequestState>(
                builder: (context, state) {
                  if (state.status == HrRequestStatus.loading) {
                    return Center(
                      child: CircularProgressIndicator(color: context.appColorScheme.iconBrand),
                    ).expanded();
                  }
                  if (state.status == HrRequestStatus.failure) {
                    return _RequestError(kind: kind, id: id, failure: state.failure!).expanded();
                  }
                  if (id != null) {
                    return _RequestDetail(kind: kind, state: state).expanded();
                  }
                  return _RequestList(kind: kind, state: state).expanded();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RequestList extends StatelessWidget {
  const _RequestList({required this.kind, required this.state});

  final HrRequestKind kind;
  final HrRequestState state;

  @override
  Widget build(BuildContext context) {
    final count = kind == HrRequestKind.leave ? state.leaves.length : state.trips.length;
    if (count == 0) {
      return Center(
        child: IrhText.regular(
          kind == HrRequestKind.leave ? S.of(context).leaveListEmpty : S.of(context).tripListEmpty,
          textAlign: TextAlign.center,
          color: context.appColorScheme.textSecondary,
        ).paddingAll(24.width),
      );
    }
    return Column(
      children: [
        if (kind == HrRequestKind.leave && state.isManager && state.selectedIds.isNotEmpty)
          IrhButton(
            label: S.of(context).approveBatchCount(state.selectedIds.length),
            loading: state.action == HrAction.batchApprove,
            onPressed: state.action != null
                ? null
                : () => _confirmAction(context, HrAction.batchApprove, kind),
          ).paddingSymmetric(horizontal: 16.width, vertical: 8.height),
        RefreshIndicator(
          onRefresh: () => context.read<HrRequestCubit>().loadList(kind),
          child: ListView.separated(
            padding: EdgeInsets.fromLTRB(16.width, 8.height, 16.width, 24.height),
            itemCount: count,
            separatorBuilder: (context, index) => 12.height.heightBox,
            itemBuilder: (context, index) {
              final leave = kind == HrRequestKind.leave ? state.leaves[index] : null;
              final trip = kind == HrRequestKind.trip ? state.trips[index] : null;
              return Row(
                children: [
                  if (leave != null && state.isManager && leave.status == RequestStatus.pending)
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: state.action != null
                          ? null
                          : () => context.read<HrRequestCubit>().toggleSelection(leave.id),
                      child: IrhText.medium(
                        state.selectedIds.contains(leave.id) ? '☑' : '□',
                        color: context.appColorScheme.textBrand,
                      ),
                    ),
                  _RequestCard(
                    title: leave == null ? trip!.destination : _leaveType(context, leave.type),
                    subtitle: leave == null ? trip!.purpose : leave.employeeName ?? leave.reason,
                    from: leave?.from ?? trip!.from,
                    to: leave?.to ?? trip!.to,
                    status: leave?.status ?? trip!.status,
                    onPressed: () => kind == HrRequestKind.leave
                        ? LeaveDetailRoute(leave!.id, $extra: leave.employeeName).push(context)
                        : TripDetailRoute(trip!.id, $extra: trip).push(context),
                  ).expanded(),
                ],
              );
            },
          ),
        ).expanded(),
      ],
    );
  }
}

class _RequestCard extends StatelessWidget {
  const _RequestCard({
    required this.title,
    required this.subtitle,
    required this.from,
    required this.to,
    required this.status,
    required this.onPressed,
  });

  final String title;
  final String subtitle;
  final DateTime from;
  final DateTime to;
  final RequestStatus status;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: colors.surfaceSecondary,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colors.borderSecondary),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IrhText.medium(title, maxLines: 1).expanded(),
                8.width.widthBox,
                _RequestStatus(status: status),
              ],
            ),
            8.height.heightBox,
            IrhText.small(S.of(context).tripDateRange(_formatDate(from), _formatDate(to))),
            8.height.heightBox,
            IrhText.small(subtitle, maxLines: 2),
          ],
        ).paddingAll(16.width),
      ),
    );
  }
}

class _RequestDetail extends StatelessWidget {
  const _RequestDetail({required this.kind, required this.state});

  final HrRequestKind kind;
  final HrRequestState state;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final leave = state.leave;
    final trip = state.trip;
    if (leave == null && trip == null) {
      return Center(child: IrhText.regular(strings.requestNotFound));
    }
    final status = leave?.status ?? trip!.status;
    return ListView(
      padding: EdgeInsets.fromLTRB(16.width, 8.height, 16.width, 24.height),
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: context.appColorScheme.surfaceSecondary,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: context.appColorScheme.borderSecondary),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IrhText.medium(
                    leave == null ? trip!.destination : _leaveType(context, leave.type),
                  ).expanded(),
                  8.width.widthBox,
                  _RequestStatus(status: status),
                ],
              ),
              20.height.heightBox,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _DetailField(
                    label: strings.employeeCode,
                    value: leave?.employeeCode ?? trip!.employeeCode,
                  ).expanded(),
                  12.width.widthBox,
                  _DetailField(
                    label: strings.requestCreatedAt,
                    value: (leave?.createdAt ?? trip?.createdAt) == null
                        ? strings.valueUnavailable
                        : _formatDate((leave?.createdAt ?? trip!.createdAt)!.toLocal()),
                  ).expanded(),
                ],
              ),
              if ((leave?.employeeName ?? trip?.employeeName) case final name?) ...[
                _DetailField(label: strings.employeeName, value: name),
              ],
              _DetailField(
                label: strings.requestPeriod,
                value: leave == null
                    ? _formatPeriod(trip!.from, trip.to)
                    : _formatPeriod(leave.from, leave.to, days: leave.days, strings: strings),
              ),
              _DetailField(
                label: leave == null ? strings.tripPurpose : strings.leaveReason,
                value: leave?.reason ?? trip!.purpose,
              ),
            ],
          ).paddingAll(20.width),
        ),
      ],
    );
  }
}

class _DetailField extends StatelessWidget {
  const _DetailField({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      IrhText.small(label),
      4.height.heightBox,
      IrhText.regular(value, color: context.appColorScheme.textPrimary),
      16.height.heightBox,
    ],
  );
}

class _RequestStatus extends StatelessWidget {
  const _RequestStatus({required this.status});

  final RequestStatus status;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final colors = context.appColorScheme;
    final label = switch (status) {
      RequestStatus.pending => strings.statusPendingShort,
      RequestStatus.approved => strings.statusApproved,
      RequestStatus.rejected => strings.statusRejected,
      RequestStatus.cancelled => strings.statusCancelled,
    };
    final color = switch (status) {
      RequestStatus.approved => colors.textSuccess,
      RequestStatus.rejected => colors.textError,
      RequestStatus.pending => colors.textBrand,
      RequestStatus.cancelled => colors.textSecondary,
    };
    return Container(
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
      ),
      child: IrhText.small(
        label,
        color: color,
      ).paddingSymmetric(horizontal: 8.width, vertical: 4.height),
    );
  }
}

class _RequestError extends StatelessWidget {
  const _RequestError({required this.kind, required this.id, required this.failure});

  final HrRequestKind kind;
  final String? id;
  final HrFailureType failure;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final message = _failureMessage(context, failure);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IrhText.regular(message, textAlign: TextAlign.center),
          16.height.heightBox,
          SizedBox(
            width: 160.width,
            child: IrhButton(
              label: strings.retry,
              onPressed: () => id == null
                  ? context.read<HrRequestCubit>().loadList(kind)
                  : context.read<HrRequestCubit>().loadDetail(kind, id!),
            ),
          ),
        ],
      ).paddingAll(24.width),
    );
  }
}

class _ActionBar extends StatelessWidget {
  const _ActionBar({required this.kind, required this.action});

  final HrRequestKind kind;
  final HrAction? action;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final colors = context.appColorScheme;
    return SafeArea(
      top: false,
      child: Row(
        children: [
          IrhIconTextButton(
            label: strings.rejectRequest,
            icon: const SizedBox.shrink(),
            foregroundColor: colors.textError,
            borderColor: colors.textError,
            loading: action == HrAction.reject,
            onPressed: action == null ? () => _confirmAction(context, HrAction.reject, kind) : null,
          ).expanded(),
          12.width.widthBox,
          IrhButton(
            label: strings.approveRequest,
            loading: action == HrAction.approve,
            onPressed: action == null
                ? () => _confirmAction(context, HrAction.approve, kind)
                : null,
          ).expanded(),
        ],
      ).paddingSymmetric(horizontal: 16.width, vertical: 12.height),
    );
  }
}

Future<void> _confirmAction(BuildContext context, HrAction action, HrRequestKind kind) async {
  final strings = S.of(context);
  final confirmed = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) => AlertDialog(
      title: IrhText.medium(
        action == HrAction.reject
            ? kind == HrRequestKind.trip
                  ? strings.rejectTripConfirmTitle
                  : strings.rejectConfirmTitle
            : action == HrAction.batchApprove
            ? strings.approveBatchCount(context.read<HrRequestCubit>().state.selectedIds.length)
            : kind == HrRequestKind.trip
            ? strings.approveTripConfirmTitle
            : strings.approveConfirmTitle,
      ),
      content: IrhText.regular(
        action == HrAction.reject
            ? kind == HrRequestKind.trip
                  ? strings.rejectTripConfirmBody
                  : strings.rejectConfirmBody
            : kind == HrRequestKind.trip
            ? strings.approveTripConfirmBody
            : strings.approveConfirmBody,
      ),
      actions: [
        IrhTextButton(
          label: strings.closeAssistant,
          onPressed: () => GoRouterHelper(dialogContext).pop(false),
        ),
        IrhTextButton(
          label: action == HrAction.reject ? strings.rejectRequest : strings.approveRequest,
          onPressed: () => GoRouterHelper(dialogContext).pop(true),
        ),
      ],
    ),
  );
  if (confirmed != true || !context.mounted) return;
  final cubit = context.read<HrRequestCubit>();
  if (action == HrAction.batchApprove) {
    await cubit.approveSelected();
  } else {
    await cubit.setStatus(
      kind,
      action == HrAction.approve ? RequestStatus.approved : RequestStatus.rejected,
    );
  }
}

String _formatDate(DateTime date) =>
    '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';

String _formatPeriod(DateTime from, DateTime to, {int? days, S? strings}) {
  final range = from.year == to.year && from.month == to.month && from.day == to.day
      ? _formatDate(from)
      : '${_formatDate(from)} → ${_formatDate(to)}';
  return days == null || strings == null ? range : '$range · ${strings.leaveDayCount(days)}';
}

String _failureMessage(BuildContext context, HrFailureType failure) {
  final strings = S.of(context);
  return switch (failure) {
    HrFailureType.permissionDenied => strings.homePermissionError,
    HrFailureType.notFound => strings.requestNotFound,
    HrFailureType.network => strings.requestNetworkError,
    HrFailureType.server => strings.homeServerError,
    HrFailureType.invalidResponse => strings.requestInvalidResponse,
    HrFailureType.sessionExpired => strings.homeSessionExpired,
  };
}

String _leaveType(BuildContext context, LeaveType type) => switch (type) {
  LeaveType.annual => S.of(context).leaveAnnualType,
  LeaveType.sick => S.of(context).leaveSickType,
  LeaveType.unpaid => S.of(context).leaveUnpaidType,
};
