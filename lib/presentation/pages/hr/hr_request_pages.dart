import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/components/irh_button.dart';
import '../../../common/components/irh_text.dart';
import '../../../common/extensions/responsive_extension.dart';
import '../../../common/themes/theme_extensions/app_color_scheme.dart';
import '../../../domain/model/home_data.dart';
import '../../../domain/model/hr_request.dart';
import '../../../domain/repository/hr_request_repository.dart';
import '../../../generated/l10n.dart';
import '../../../route/go_router.dart';
import '../home/widgets/home_back_button.dart';
import 'bloc/hr_request_cubit.dart';

class HrRequestListPage extends StatelessWidget {
  const HrRequestListPage({super.key, required this.kind});

  final HrRequestKind kind;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) =>
        HrRequestCubit(context.read<HrRequestRepository>())..loadList(kind),
    child: _RequestScreen(kind: kind),
  );
}

class HrRequestDetailPage extends StatelessWidget {
  const HrRequestDetailPage({super.key, required this.kind, required this.id});

  final HrRequestKind kind;
  final String id;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) =>
        HrRequestCubit(context.read<HrRequestRepository>())
          ..loadDetail(kind, id),
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
    final title = kind == HrRequestKind.leave
        ? strings.leaveRequest
        : strings.businessTrip;
    return BlocListener<HrRequestCubit, HrRequestState>(
      listenWhen: (previous, current) =>
          previous.failure != current.failure &&
          current.failure == HrFailureType.sessionExpired,
      listener: (context, state) => const LoginRoute().go(context),
      child: Scaffold(
        backgroundColor: context.appColorScheme.surfacePrimary,
        body: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  HomeBackButton(semanticLabel: strings.backToHome),
                  12.width.widthBox,
                  IrhText.title(
                    id == null ? title : strings.requestDetailTitle(title),
                  ).expanded(),
                ],
              ).paddingSymmetric(horizontal: 16.width, vertical: 12.height),
              BlocBuilder<HrRequestCubit, HrRequestState>(
                builder: (context, state) {
                  if (state.status == HrRequestStatus.loading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: context.appColorScheme.iconBrand,
                      ),
                    ).expanded();
                  }
                  if (state.status == HrRequestStatus.failure) {
                    return _RequestError(
                      kind: kind,
                      id: id,
                      failure: state.failure!,
                    ).expanded();
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
    final count = kind == HrRequestKind.leave
        ? state.leaves.length
        : state.trips.length;
    if (count == 0) {
      return Center(
        child: IrhText.regular(
          kind == HrRequestKind.leave
              ? S.of(context).leaveListEmpty
              : S.of(context).tripListEmpty,
          textAlign: TextAlign.center,
          color: context.appColorScheme.textSecondary,
        ).paddingAll(24.width),
      );
    }
    return RefreshIndicator(
      onRefresh: () => context.read<HrRequestCubit>().loadList(kind),
      child: ListView.separated(
        padding: EdgeInsets.fromLTRB(16.width, 8.height, 16.width, 24.height),
        itemCount: count,
        separatorBuilder: (context, index) => 12.height.heightBox,
        itemBuilder: (context, index) {
          final leave = kind == HrRequestKind.leave
              ? state.leaves[index]
              : null;
          final trip = kind == HrRequestKind.trip ? state.trips[index] : null;
          return _RequestCard(
            title: leave == null
                ? trip!.destination
                : _leaveType(context, leave.type),
            subtitle: leave == null ? trip!.purpose : leave.reason,
            from: leave?.from ?? trip!.from,
            to: leave?.to ?? trip!.to,
            status: leave?.status ?? trip!.status,
            onPressed: () => kind == HrRequestKind.leave
                ? LeaveDetailRoute(leave!.id).push(context)
                : TripDetailRoute(trip!.id).push(context),
          );
        },
      ),
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
            IrhText.small(
              S.of(context).tripDateRange(_formatDate(from), _formatDate(to)),
            ),
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
              _RequestStatus(status: status),
              20.height.heightBox,
              _DetailField(
                label: strings.requestCode,
                value: leave?.id ?? trip!.id,
              ),
              _DetailField(
                label: strings.employeeCode,
                value: leave?.employeeCode ?? trip!.employeeCode,
              ),
              if (leave != null) ...[
                _DetailField(
                  label: strings.leaveType,
                  value: _leaveType(context, leave.type),
                ),
                _DetailField(
                  label: strings.requestFrom,
                  value: _formatDate(leave.from),
                ),
                _DetailField(
                  label: strings.requestTo,
                  value: _formatDate(leave.to),
                ),
                _DetailField(
                  label: strings.leaveDays,
                  value: leave.days.toString(),
                ),
                _DetailField(label: strings.leaveReason, value: leave.reason),
              ] else ...[
                _DetailField(
                  label: strings.tripDestination,
                  value: trip!.destination,
                ),
                _DetailField(
                  label: strings.requestFrom,
                  value: _formatDate(trip.from),
                ),
                _DetailField(
                  label: strings.requestTo,
                  value: _formatDate(trip.to),
                ),
                _DetailField(label: strings.tripPurpose, value: trip.purpose),
              ],
              if ((leave?.createdAt ?? trip?.createdAt) case final createdAt?)
                _DetailField(
                  label: strings.requestCreatedAt,
                  value: _formatDate(createdAt.toLocal()),
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
      IrhText.regular(value),
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
      RequestStatus.pending => strings.statusPending,
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
    return IrhText.small(label, color: color);
  }
}

class _RequestError extends StatelessWidget {
  const _RequestError({
    required this.kind,
    required this.id,
    required this.failure,
  });

  final HrRequestKind kind;
  final String? id;
  final HrFailureType failure;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final message = switch (failure) {
      HrFailureType.permissionDenied => strings.homePermissionError,
      HrFailureType.notFound => strings.requestNotFound,
      HrFailureType.network => strings.requestNetworkError,
      HrFailureType.server => strings.homeServerError,
      HrFailureType.invalidResponse => strings.requestInvalidResponse,
      HrFailureType.sessionExpired => strings.homeSessionExpired,
    };
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

String _formatDate(DateTime date) =>
    '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';

String _leaveType(BuildContext context, LeaveType type) => switch (type) {
  LeaveType.annual => S.of(context).leaveAnnualType,
  LeaveType.sick => S.of(context).leaveSickType,
  LeaveType.unpaid => S.of(context).leaveUnpaidType,
};
