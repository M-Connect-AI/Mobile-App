import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/components/app_text_field.dart';
import '../../../common/components/app_toast.dart';
import '../../../common/components/irh_button.dart';
import '../../../common/components/irh_text.dart';
import '../../../common/extensions/responsive_extension.dart';
import '../../../common/themes/theme_extensions/app_color_scheme.dart';
import '../../../domain/model/outlook.dart';
import '../../../domain/repository/outlook_repository.dart';
import '../../../domain/service/data_refresh_coordinator.dart';
import '../../../generated/l10n.dart';
import '../../../route/go_router.dart';
import '../home/widgets/home_back_button.dart';
import 'bloc/outlook_cubit.dart';

class OutlookConnectionPage extends StatelessWidget {
  const OutlookConnectionPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => OutlookCubit(
      context.read<OutlookRepository>(),
      refreshCoordinator: context.read<DataRefreshCoordinator?>(),
    )..loadStatus(),
    child: const _OutlookConnectionView(),
  );
}

class OutlookCalendarPage extends StatelessWidget {
  const OutlookCalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final end = now.add(const Duration(days: 14));
    return BlocProvider(
      create: (context) => OutlookCubit(
        context.read<OutlookRepository>(),
        refreshCoordinator: context.read<DataRefreshCoordinator?>(),
      )..loadCalendar(from: _ymd(now), to: _ymd(end)),
      child: _OutlookCalendarView(from: _ymd(now), to: _ymd(end)),
    );
  }
}

class OutlookConflictPage extends StatelessWidget {
  const OutlookConflictPage({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final end = now.add(const Duration(days: 14));
    return BlocProvider(
      create: (context) => OutlookCubit(
        context.read<OutlookRepository>(),
        refreshCoordinator: context.read<DataRefreshCoordinator?>(),
      )..loadCalendar(from: _ymd(now), to: _ymd(end), conflictsOnly: true),
      child: _OutlookCalendarView(
        from: _ymd(now),
        to: _ymd(end),
        conflictsOnly: true,
      ),
    );
  }
}

class OutlookMailListPage extends StatelessWidget {
  const OutlookMailListPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => OutlookCubit(
      context.read<OutlookRepository>(),
      refreshCoordinator: context.read<DataRefreshCoordinator?>(),
    )..loadMails(),
    child: const _OutlookMailListView(),
  );
}

class OutlookMailDetailPage extends StatelessWidget {
  const OutlookMailDetailPage({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => OutlookCubit(
      context.read<OutlookRepository>(),
      refreshCoordinator: context.read<DataRefreshCoordinator?>(),
    )..loadMail(id),
    child: _OutlookMailDetailView(id: id),
  );
}

class _OutlookConnectionView extends StatefulWidget {
  const _OutlookConnectionView();

  @override
  State<_OutlookConnectionView> createState() => _OutlookConnectionViewState();
}

class _OutlookConnectionViewState extends State<_OutlookConnectionView>
    with WidgetsBindingObserver {
  bool _waitingForOAuth = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _waitingForOAuth) {
      _waitingForOAuth = false;
      context.read<OutlookCubit>().loadStatus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _OutlookScaffold(
      title: S.of(context).outlookTitle,
      child: BlocBuilder<OutlookCubit, OutlookState>(
        builder: (context, state) {
          if (state.status == OutlookLoadStatus.loading &&
              state.connection == null) {
            return const _OutlookLoading();
          }
          if (state.status == OutlookLoadStatus.failure) {
            return _OutlookFailure(
              state: state,
              onRetry: context.read<OutlookCubit>().loadStatus,
            );
          }
          final connection = state.connection;
          if (connection == null) return const _OutlookLoading();
          return _ConnectionContent(
            connection: connection,
            actionInProgress: state.actionInProgress,
            onConnect: _connect,
          );
        },
      ),
    );
  }

  Future<void> _connect() async {
    final uri = await context.read<OutlookCubit>().getAuthUri();
    if (uri == null || !mounted) return;
    _waitingForOAuth = true;
    try {
      final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (opened) return;
    } on Object {
      // The same localized recovery message is shown below.
    }
    _waitingForOAuth = false;
    if (mounted) AppToast.failed(context, S.of(context).linkOpenFailed);
  }
}

class _ConnectionContent extends StatelessWidget {
  const _ConnectionContent({
    required this.connection,
    required this.actionInProgress,
    required this.onConnect,
  });

  final OutlookConnectionStatus connection;
  final bool actionInProgress;
  final VoidCallback onConnect;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final colors = context.appColorScheme;
    return ListView(
      padding: EdgeInsets.fromLTRB(16.width, 8.height, 16.width, 24.height),
      children: [
        Container(
          padding: EdgeInsets.all(16.width),
          decoration: BoxDecoration(
            color: colors.surfaceSecondary,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colors.borderSecondary),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              IrhText.medium(
                connection.connected
                    ? strings.outlookConnected
                    : strings.outlookNotConnected,
                color: connection.connected
                    ? colors.textSuccess
                    : colors.textSecondary,
              ),
              if (connection.microsoftEmail != null) ...[
                8.height.heightBox,
                IrhText.regular(connection.microsoftEmail!),
              ],
              if (!connection.configured) ...[
                8.height.heightBox,
                IrhText.small(
                  strings.outlookNotConfigured,
                  color: colors.textError,
                ),
              ],
            ],
          ),
        ),
        16.height.heightBox,
        if (connection.connected) ...[
          _OutlookNavigationItem(
            label: strings.outlookCalendar,
            onPressed: () => const OutlookCalendarRoute().push(context),
          ),
          12.height.heightBox,
          _OutlookNavigationItem(
            label: strings.outlookConflicts,
            onPressed: () => const OutlookConflictRoute().push(context),
          ),
          12.height.heightBox,
          _OutlookNavigationItem(
            label: strings.outlookMail,
            onPressed: () => const OutlookMailListRoute().push(context),
          ),
          12.height.heightBox,
          IrhButton(
            label: strings.outlookDisconnect,
            secondary: true,
            onPressed: actionInProgress
                ? null
                : context.read<OutlookCubit>().disconnect,
          ),
        ] else if (connection.configured) ...[
          IrhButton(
            label: strings.outlookConnect,
            onPressed: actionInProgress ? null : onConnect,
          ),
          12.height.heightBox,
          IrhButton(
            label: strings.outlookCheckConnection,
            secondary: true,
            onPressed: actionInProgress
                ? null
                : context.read<OutlookCubit>().loadStatus,
          ),
          12.height.heightBox,
          IrhText.small(
            strings.outlookOAuthReturnHint,
            color: colors.textSecondary,
          ),
        ],
      ],
    );
  }
}

class _OutlookCalendarView extends StatelessWidget {
  const _OutlookCalendarView({
    required this.from,
    required this.to,
    this.conflictsOnly = false,
  });

  final String from;
  final String to;
  final bool conflictsOnly;

  @override
  Widget build(BuildContext context) => _OutlookScaffold(
    title: conflictsOnly
        ? S.of(context).outlookConflicts
        : S.of(context).outlookCalendar,
    child: BlocBuilder<OutlookCubit, OutlookState>(
      builder: (context, state) {
        if (state.status == OutlookLoadStatus.loading) {
          return const _OutlookLoading();
        }
        if (state.status == OutlookLoadStatus.failure) {
          return _OutlookFailure(
            state: state,
            onRetry: () => context.read<OutlookCubit>().loadCalendar(
              from: from,
              to: to,
              conflictsOnly: conflictsOnly,
            ),
          );
        }
        final events = state.calendar?.events ?? const [];
        if (events.isEmpty) {
          return _OutlookEmpty(
            message: conflictsOnly
                ? S.of(context).outlookConflictsEmpty
                : S.of(context).outlookCalendarEmpty,
          );
        }
        return RefreshIndicator(
          onRefresh: () => context.read<OutlookCubit>().loadCalendar(
            from: from,
            to: to,
            conflictsOnly: conflictsOnly,
          ),
          child: ListView.separated(
            padding: EdgeInsets.fromLTRB(
              16.width,
              8.height,
              16.width,
              24.height,
            ),
            itemCount: events.length,
            separatorBuilder: (context, index) => 12.height.heightBox,
            itemBuilder: (context, index) =>
                _CalendarEventCard(event: events[index]),
          ),
        );
      },
    ),
  );
}

class _CalendarEventCard extends StatelessWidget {
  const _CalendarEventCard({required this.event});

  final OutlookCalendarEvent event;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    return Container(
      padding: EdgeInsets.all(16.width),
      decoration: BoxDecoration(
        color: colors.surfaceSecondary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.borderSecondary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IrhText.medium(event.subject),
          8.height.heightBox,
          IrhText.small(
            '${_formatDateTime(event.start)} → ${_formatDateTime(event.end)}',
            color: colors.textSecondary,
          ),
          if (event.location != null) ...[
            8.height.heightBox,
            IrhText.small(event.location!, color: colors.textSecondary),
          ],
        ],
      ),
    );
  }
}

class _OutlookMailListView extends StatefulWidget {
  const _OutlookMailListView();

  @override
  State<_OutlookMailListView> createState() => _OutlookMailListViewState();
}

class _OutlookMailListViewState extends State<_OutlookMailListView> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) => _OutlookScaffold(
    title: S.of(context).outlookMail,
    child: Column(
      children: [
        FormBuilder(
          key: _formKey,
          child: Row(
            children: [
              AppTextField(
                context,
                name: 'search',
                labelText: S.of(context).outlookSearchMail,
                textInputAction: TextInputAction.search,
                onSubmitted: (_) => _search(),
              ).expanded(),
              8.width.widthBox,
              SizedBox(
                width: 96.width,
                child: IrhButton(
                  label: S.of(context).search,
                  onPressed: _search,
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: 16.width, vertical: 8.height),
        ),
        BlocBuilder<OutlookCubit, OutlookState>(
          builder: (context, state) {
            if (state.status == OutlookLoadStatus.loading) {
              return const _OutlookLoading();
            }
            if (state.status == OutlookLoadStatus.failure) {
              return _OutlookFailure(
                state: state,
                onRetry: () => context.read<OutlookCubit>().loadMails(),
              );
            }
            final mails = state.mailList?.mails ?? const [];
            if (mails.isEmpty) {
              return _OutlookEmpty(message: S.of(context).outlookMailEmpty);
            }
            return RefreshIndicator(
              onRefresh: () => context.read<OutlookCubit>().loadMails(
                search: _searchValue(),
              ),
              child: ListView.separated(
                padding: EdgeInsets.fromLTRB(
                  16.width,
                  8.height,
                  16.width,
                  24.height,
                ),
                itemCount: mails.length,
                separatorBuilder: (context, index) => 12.height.heightBox,
                itemBuilder: (context, index) => _MailCard(mail: mails[index]),
              ),
            );
          },
        ).expanded(),
      ],
    ),
  );

  String? _searchValue() {
    _formKey.currentState?.save();
    final value = _formKey.currentState?.value['search']?.toString().trim();
    return value == null || value.isEmpty ? null : value;
  }

  void _search() {
    context.read<OutlookCubit>().loadMails(search: _searchValue());
  }
}

class _MailCard extends StatelessWidget {
  const _MailCard({required this.mail});

  final OutlookMail mail;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () => OutlookMailDetailRoute(id: mail.id).push(context),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.width),
        decoration: BoxDecoration(
          color: colors.surfaceSecondary,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colors.borderSecondary),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IrhText.small(mail.from, color: colors.textSecondary),
            4.height.heightBox,
            IrhText.medium(mail.subject, maxLines: 2),
            if (mail.preview.isNotEmpty) ...[
              8.height.heightBox,
              IrhText.small(
                mail.preview,
                maxLines: 3,
                color: colors.textSecondary,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _OutlookMailDetailView extends StatelessWidget {
  const _OutlookMailDetailView({required this.id});

  final String id;

  @override
  Widget build(BuildContext context) => _OutlookScaffold(
    title: S.of(context).outlookMailDetail,
    child: BlocBuilder<OutlookCubit, OutlookState>(
      builder: (context, state) {
        if (state.status == OutlookLoadStatus.loading) {
          return const _OutlookLoading();
        }
        if (state.status == OutlookLoadStatus.failure) {
          return _OutlookFailure(
            state: state,
            onRetry: () => context.read<OutlookCubit>().loadMail(id),
          );
        }
        final mail = state.mail;
        if (mail == null) {
          return _OutlookEmpty(message: S.of(context).outlookMailEmpty);
        }
        return ListView(
          padding: EdgeInsets.fromLTRB(16.width, 8.height, 16.width, 24.height),
          children: [
            Container(
              padding: EdgeInsets.all(16.width),
              decoration: BoxDecoration(
                color: context.appColorScheme.surfaceSecondary,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: context.appColorScheme.borderSecondary,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IrhText.title(mail.subject),
                  8.height.heightBox,
                  IrhText.small(mail.from),
                  8.height.heightBox,
                  IrhText.small(_formatDateTime(mail.receivedAt)),
                  20.height.heightBox,
                  IrhText.regular(mail.body ?? mail.preview),
                ],
              ),
            ),
          ],
        );
      },
    ),
  );
}

class _OutlookScaffold extends StatelessWidget {
  const _OutlookScaffold({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: context.appColorScheme.surfacePrimary,
    body: BlocListener<OutlookCubit, OutlookState>(
      listenWhen: (previous, current) =>
          previous.failure != current.failure &&
          current.failure == OutlookFailureType.sessionExpired,
      listener: (context, state) => const LoginRoute().go(context),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                HomeBackButton(semanticLabel: S.of(context).backToHome),
                12.width.widthBox,
                IrhText.title(title).expanded(),
              ],
            ).paddingSymmetric(horizontal: 16.width, vertical: 12.height),
            child.expanded(),
          ],
        ),
      ),
    ),
  );
}

class _OutlookNavigationItem extends StatelessWidget {
  const _OutlookNavigationItem({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => CupertinoButton(
    padding: EdgeInsets.zero,
    onPressed: onPressed,
    child: Container(
      height: 64.height,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 16.width),
      decoration: BoxDecoration(
        color: context.appColorScheme.surfaceSecondary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.appColorScheme.borderSecondary),
      ),
      child: IrhText.regular(label),
    ),
  );
}

class _OutlookLoading extends StatelessWidget {
  const _OutlookLoading();

  @override
  Widget build(BuildContext context) => Center(
    child: CupertinoActivityIndicator(color: context.appColorScheme.iconBrand),
  );
}

class _OutlookEmpty extends StatelessWidget {
  const _OutlookEmpty({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) => Center(
    child: IrhText.regular(
      message,
      textAlign: TextAlign.center,
      color: context.appColorScheme.textSecondary,
    ).paddingAll(24.width),
  );
}

class _OutlookFailure extends StatelessWidget {
  const _OutlookFailure({required this.state, required this.onRetry});

  final OutlookState state;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final message = state.failureMessage?.trim().isNotEmpty == true
        ? state.failureMessage!
        : switch (state.failure) {
            OutlookFailureType.notConfigured => strings.outlookNotConfigured,
            OutlookFailureType.notConnected => strings.outlookNotConnected,
            OutlookFailureType.permissionDenied => strings.homePermissionError,
            OutlookFailureType.network => strings.requestNetworkError,
            OutlookFailureType.sessionExpired => strings.homeSessionExpired,
            OutlookFailureType.invalidResponse =>
              strings.requestInvalidResponse,
            OutlookFailureType.business ||
            OutlookFailureType.server ||
            null => strings.homeServerError,
          };
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IrhText.regular(message, textAlign: TextAlign.center),
          16.height.heightBox,
          SizedBox(
            width: 160.width,
            child: IrhButton(label: strings.retry, onPressed: onRetry),
          ),
        ],
      ).paddingAll(24.width),
    );
  }
}

String _ymd(DateTime value) =>
    '${value.year.toString().padLeft(4, '0')}-${value.month.toString().padLeft(2, '0')}-${value.day.toString().padLeft(2, '0')}';

String _formatDateTime(String value) {
  final date = DateTime.tryParse(value)?.toLocal();
  if (date == null) return value;
  final day = date.day.toString().padLeft(2, '0');
  final month = date.month.toString().padLeft(2, '0');
  final hour = date.hour.toString().padLeft(2, '0');
  final minute = date.minute.toString().padLeft(2, '0');
  return '$day/$month/${date.year} $hour:$minute';
}
