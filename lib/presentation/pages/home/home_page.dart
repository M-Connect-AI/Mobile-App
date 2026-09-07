import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../common/components/irh_button.dart';
import '../../../common/components/app_text_style.dart';
import '../../../common/extensions/responsive_extension.dart';
import '../../../common/themes/theme_extensions/app_color_scheme.dart';
import '../../../generated/l10n.dart';
import '../../../domain/model/home_data.dart';
import '../../../domain/repository/credential_repository.dart';
import '../../../domain/repository/home_repository.dart';
import '../../../route/go_router.dart';
import '../../server_config/server_config_dialog.dart';
import 'bloc/home_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(
        context.read<HomeRepository>(),
        context.read<CredentialRepository>(),
      )..load(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    return BlocListener<HomeCubit, HomeState>(
      listenWhen: (previous, current) =>
          (previous.failureType != current.failureType &&
              current.failureType == HomeFailureType.sessionExpired) ||
          (previous.status != current.status &&
              current.status == HomeStatus.loggedOut),
      listener: (context, state) => const LoginRoute().go(context),
      child: Scaffold(
        extendBody: true,
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state.status == HomeStatus.success && state.data != null) {
              return _HomeContent(data: state.data!);
            }
            if (state.status == HomeStatus.failure &&
                state.failureType != HomeFailureType.sessionExpired) {
              return _HomeError(state: state);
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _AssistantButton(
          onPressed: () => const HomeChatAiRoute().push(context),
        ),
        bottomNavigationBar: const _HomeBottomAppBar(),
        backgroundColor: colors.surfacePrimary,
      ),
    );
  }
}

class _HomeBottomAppBar extends StatelessWidget {
  const _HomeBottomAppBar();

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final colors = context.appColorScheme;
    return BottomAppBar(
      height: 70.height + MediaQuery.paddingOf(context).bottom,
      padding: EdgeInsets.zero,
      color: colors.surfaceSecondary,
      surfaceTintColor: colors.surfaceSecondary,
      shadowColor: colors.iconPrimary.withValues(alpha: .16),
      elevation: 16,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.width,
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            _NavigationItem(
              icon: Icons.home_rounded,
              label: strings.navigationHome,
              isSelected: true,
              onPressed: () {},
            ).expanded(),
            _NavigationItem(
              icon: Icons.search_rounded,
              label: strings.navigationSearch,
              onPressed: () {},
            ).expanded(),
            SizedBox(width: 80.width),
            _NavigationItem(
              icon: Icons.article_rounded,
              label: strings.navigationFeed,
              onPressed: () {},
            ).expanded(),
            _NavigationItem(
              icon: Icons.person_rounded,
              label: strings.navigationPersonal,
              onPressed: () {},
            ).expanded(),
          ],
        ),
      ),
    );
  }
}

class _NavigationItem extends StatelessWidget {
  const _NavigationItem({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.isSelected = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    final color = isSelected ? colors.iconBrand : colors.iconSecondary;
    return Semantics(
      button: true,
      selected: isSelected,
      label: label,
      child: CupertinoButton(
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 24.sp, color: color),
              4.height.heightBox,
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.m12.copyWith(color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AssistantButton extends StatefulWidget {
  const _AssistantButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  State<_AssistantButton> createState() => _AssistantButtonState();
}

class _AssistantButtonState extends State<_AssistantButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _emphasis;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..forward();
    _emphasis = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 0,
          end: 1,
        ).chain(CurveTween(curve: Curves.easeOutCubic)),
        weight: 45,
      ),
      TweenSequenceItem(
        tween: Tween<double>(
          begin: 1,
          end: 0,
        ).chain(CurveTween(curve: Curves.easeInOutCubic)),
        weight: 55,
      ),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    return AnimatedBuilder(
      animation: _emphasis,
      builder: (context, child) {
        final scale = 1 + (_emphasis.value * .05);
        return Transform.scale(
          scale: scale,
          child: Container(
            width: 72.width,
            height: 72.width,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(-.4, -.45),
                radius: 1.05,
                colors: [
                  Color.lerp(colors.iconBrand, colors.surfaceSecondary, .32)!,
                  colors.iconBrand,
                  Color.lerp(colors.iconBrand, colors.iconPrimary, .38)!,
                ],
                stops: const [0, .58, 1],
              ),
              shape: BoxShape.circle,
              border: Border.all(color: colors.surfacePrimary, width: 4.width),
              boxShadow: [
                BoxShadow(
                  color: colors.iconBrand.withValues(
                    alpha: .28 + (_emphasis.value * .18),
                  ),
                  blurRadius: 16.width + (_emphasis.value * 12.width),
                  spreadRadius: _emphasis.value * 4.width,
                  offset: Offset(0, 8.height),
                ),
              ],
            ),
            child: child,
          ),
        );
      },
      child: Semantics(
        button: true,
        label: S.of(context).navigationChat,
        child: CupertinoButton(
          key: const Key('assistant-bubble'),
          minimumSize: Size.zero,
          padding: EdgeInsets.zero,
          borderRadius: BorderRadius.circular(36),
          onPressed: widget.onPressed,
          child: Icon(
            Icons.auto_awesome_rounded,
            color: colors.surfaceSecondary,
            size: 32.sp,
          ),
        ),
      ),
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({required this.data});

  final HomeData data;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    final strings = S.of(context);
    final nextTrip = data.upcomingTrips.isEmpty
        ? null
        : data.upcomingTrips.first;
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          toolbarHeight: 72.height,
          backgroundColor: colors.surfacePrimary.withValues(alpha: .92),
          surfaceTintColor: colors.surfacePrimary,
          titleSpacing: 20.width,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                strings.homeGreetingName(data.user.fullName),
                style: AppTextStyle.b20.copyWith(color: colors.textPrimary),
              ),
              4.height.heightBox,
              Text(
                strings.homeSubtitle,
                style: AppTextStyle.r12.copyWith(color: colors.textSecondary),
              ),
            ],
          ),
          actions: [
            const ServerConfigButton(),
            BlocBuilder<HomeCubit, HomeState>(
              buildWhen: (previous, current) =>
                  previous.status != current.status,
              builder: (context, state) => Semantics(
                button: true,
                label: strings.logout,
                child: CupertinoButton(
                  key: const Key('logout-button'),
                  minimumSize: Size(44.width, 44.height),
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.width,
                    vertical: 12.height,
                  ),
                  onPressed: state.status == HomeStatus.loggingOut
                      ? null
                      : context.read<HomeCubit>().logout,
                  child: state.status == HomeStatus.loggingOut
                      ? CupertinoActivityIndicator(
                          radius: 12.width,
                          color: colors.iconSecondary,
                        )
                      : Icon(
                          CupertinoIcons.square_arrow_right,
                          size: 24.sp,
                          color: colors.iconSecondary,
                        ),
                ),
              ),
            ),
            12.width.widthBox,
          ],
        ),
        SliverPadding(
          padding: EdgeInsets.fromLTRB(
            20.width,
            20.height,
            20.width,
            116.height,
          ),
          sliver: SliverList.list(
            children: [
              _LeaveBalanceCard(balance: data.leaveBalance),
              28.height.heightBox,
              _SectionTitle(title: strings.upcomingTrip),
              16.height.heightBox,
              if (nextTrip != null)
                _NextTripCard(trip: nextTrip)
              else
                const _NoUpcomingTripCard(),
              28.height.heightBox,
              _SectionTitle(title: strings.quickAccess),
              16.height.heightBox,
              const _QuickActions(),
              if (data.upcomingTrips.length > 1) ...[
                28.height.heightBox,
                _SectionTitle(title: strings.otherUpcomingTrips),
                16.height.heightBox,
                ...data.upcomingTrips
                    .skip(1)
                    .map(
                      (trip) => Padding(
                        padding: EdgeInsets.only(bottom: 12.height),
                        child: _TripListItem(trip: trip),
                      ),
                    ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _NextTripCard extends StatelessWidget {
  const _NextTripCard({required this.trip});

  final BusinessTrip trip;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    final strings = S.of(context);
    final dateFormat = DateFormat('dd/MM/yyyy');
    return Container(
      padding: EdgeInsets.all(24.width),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.lerp(colors.iconBrand, colors.surfaceSecondary, .24)!,
            colors.iconBrand,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: colors.iconBrand.withValues(alpha: .24),
            blurRadius: 28.width,
            offset: Offset(0, 12.height),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            trip.destination,
            style: AppTextStyle.b20.copyWith(color: colors.surfacePrimary),
          ),
          12.height.heightBox,
          Text(
            strings.tripDateRange(
              dateFormat.format(trip.from),
              dateFormat.format(trip.to),
            ),
            style: AppTextStyle.m12.copyWith(
              color: colors.surfacePrimary.withValues(alpha: .88),
            ),
          ),
          16.height.heightBox,
          Row(
            children: [
              Icon(
                Icons.calendar_month_rounded,
                color: colors.surfacePrimary,
                size: 20.sp,
              ),
              8.width.widthBox,
              Text(
                _statusLabel(strings, trip.status),
                style: AppTextStyle.sm12.copyWith(color: colors.surfacePrimary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyle.b16.copyWith(
        color: context.appColorScheme.textPrimary,
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions();

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final colors = context.appColorScheme;
    return Row(
      children: [
        Expanded(
          child: _QuickAction(
            icon: Icons.event_available_rounded,
            label: strings.leaveRequest,
            color: colors.iconBrand,
          ),
        ),
        12.width.widthBox,
        Expanded(
          child: _QuickAction(
            icon: Icons.airplane_ticket_outlined,
            label: strings.businessTrip,
            color: colors.iconPrimary,
          ),
        ),
      ],
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    return Material(
      color: colors.surfaceSecondary,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: () => const HomeChatAiRoute().push(context),
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 8.width,
            vertical: 16.height,
          ),
          child: Column(
            children: [
              Container(
                width: 44.width,
                height: 44.height,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: .12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 24.sp),
              ),
              8.height.heightBox,
              Text(
                label,
                maxLines: 1,
                style: AppTextStyle.sm12.copyWith(color: colors.textPrimary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LeaveBalanceCard extends StatelessWidget {
  const _LeaveBalanceCard({required this.balance});

  final LeaveBalance balance;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final colors = context.appColorScheme;
    return Container(
      padding: EdgeInsets.all(20.width),
      decoration: BoxDecoration(
        color: colors.surfaceSecondary,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colors.borderSecondary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            strings.leaveBalance,
            style: AppTextStyle.b16.copyWith(color: colors.textPrimary),
          ),
          16.height.heightBox,
          Row(
            children: [
              _BalanceValue(
                value: '${balance.annualRemaining}/${balance.annualTotal}',
                label: strings.annualLeave,
              ),
              16.width.widthBox,
              _BalanceValue(
                value: '${balance.sickRemaining}',
                label: strings.sickLeave,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BalanceValue extends StatelessWidget {
  const _BalanceValue({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: AppTextStyle.b24.copyWith(color: colors.textBrand),
          ),
          4.height.heightBox,
          Text(
            label,
            style: AppTextStyle.r12.copyWith(color: colors.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _NoUpcomingTripCard extends StatelessWidget {
  const _NoUpcomingTripCard();

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.width),
      decoration: BoxDecoration(
        color: colors.surfaceSecondary,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colors.borderSecondary),
      ),
      child: Text(
        S.of(context).noUpcomingTrips,
        textAlign: TextAlign.center,
        style: AppTextStyle.r14.copyWith(color: colors.textSecondary),
      ),
    );
  }
}

class _TripListItem extends StatelessWidget {
  const _TripListItem({required this.trip});

  final BusinessTrip trip;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    final strings = S.of(context);
    final format = DateFormat('dd/MM/yyyy');
    return Container(
      padding: EdgeInsets.all(16.width),
      decoration: BoxDecoration(
        color: colors.surfaceSecondary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.borderSecondary),
      ),
      child: Row(
        children: [
          Icon(
            Icons.flight_takeoff_rounded,
            color: colors.iconBrand,
            size: 24.sp,
          ),
          12.width.widthBox,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trip.destination,
                  style: AppTextStyle.sm14.copyWith(color: colors.textPrimary),
                ),
                4.height.heightBox,
                Text(
                  strings.tripDateRange(
                    format.format(trip.from),
                    format.format(trip.to),
                  ),
                  style: AppTextStyle.r12.copyWith(color: colors.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeError extends StatelessWidget {
  const _HomeError({required this.state});

  final HomeState state;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final message = switch (state.failureType) {
      HomeFailureType.network => strings.homeNetworkError,
      HomeFailureType.permissionDenied => strings.homePermissionError,
      HomeFailureType.server => strings.homeServerError,
      HomeFailureType.invalidResponse => strings.homeInvalidResponse,
      HomeFailureType.sessionExpired || null => strings.homeSessionExpired,
    };
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyle.r14.copyWith(
                color: context.appColorScheme.textSecondary,
              ),
            ),
            16.height.heightBox,
            SizedBox(
              width: 160.width,
              child: IrhButton(
                label: strings.retry,
                onPressed: context.read<HomeCubit>().load,
              ),
            ),
          ],
        ).paddingAll(24.width),
      ),
    );
  }
}

String _statusLabel(S strings, RequestStatus status) => switch (status) {
  RequestStatus.pending => strings.statusPending,
  RequestStatus.approved => strings.statusApproved,
  RequestStatus.rejected => strings.statusRejected,
  RequestStatus.cancelled => strings.statusCancelled,
};
