import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/components/irh_button.dart';
import '../../../common/components/irh_text.dart';
import '../../../common/extensions/responsive_extension.dart';
import '../../../common/themes/theme_extensions/app_color_scheme.dart';
import '../../../domain/model/auth_session.dart';
import '../../../domain/model/home_data.dart';
import '../../../domain/repository/credential_repository.dart';
import '../../../domain/repository/home_repository.dart';
import '../../../gen/assets.gen.dart';
import '../../../generated/l10n.dart';
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
        backgroundColor: colors.surfacePrimary,
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state.status == HomeStatus.success && state.data != null) {
              return switch (state.tab) {
                HomeTab.home => _HomeContent(data: state.data!),
                HomeTab.utilities => const _UtilitiesContent(),
              };
            }
            if (state.status == HomeStatus.failure &&
                state.failureType != HomeFailureType.sessionExpired) {
              return _HomeError(state: state);
            }
            return Center(
              child: CircularProgressIndicator(color: colors.iconBrand),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: _AssistantButton(
          onPressed: () => const HomeChatAiRoute().push(context),
        ),
        bottomNavigationBar: BlocBuilder<HomeCubit, HomeState>(
          buildWhen: (previous, current) => previous.tab != current.tab,
          builder: (context, state) => _HomeBottomAppBar(activeTab: state.tab),
        ),
      ),
    );
  }
}

class _HomeBottomAppBar extends StatelessWidget {
  const _HomeBottomAppBar({required this.activeTab});

  final HomeTab activeTab;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final colors = context.appColorScheme;
    return BottomAppBar(
      height: 72.height + MediaQuery.paddingOf(context).bottom,
      padding: EdgeInsets.zero,
      color: colors.surfaceSecondary.withValues(alpha: .96),
      surfaceTintColor: colors.surfaceSecondary,
      shadowColor: colors.iconPrimary.withValues(alpha: .12),
      elevation: 16,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.width,
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            _NavigationItem(
              key: const Key('home-navigation-item'),
              icon: Icons.home_rounded,
              label: strings.navigationHome,
              isSelected: activeTab == HomeTab.home,
              onPressed: () =>
                  context.read<HomeCubit>().selectTab(HomeTab.home),
            ).expanded(),
            _NavigationItem(
              icon: Icons.person_rounded,
              label: strings.navigationHris,
              onPressed: () {},
            ).expanded(),
            SizedBox(width: 80.width),
            _NavigationItem(
              icon: Icons.article_rounded,
              label: strings.navigationFeed,
              onPressed: () {},
            ).expanded(),
            _NavigationItem(
              key: const Key('utilities-navigation-item'),
              icon: Icons.grid_view_rounded,
              label: strings.navigationUtilities,
              isSelected: activeTab == HomeTab.utilities,
              onPressed: () =>
                  context.read<HomeCubit>().selectTab(HomeTab.utilities),
            ).expanded(),
          ],
        ),
      ),
    );
  }
}

class _NavigationItem extends StatelessWidget {
  const _NavigationItem({
    super.key,
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
              IrhText.small(label, color: color, maxLines: 1),
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

class _UtilitiesContent extends StatelessWidget {
  const _UtilitiesContent();

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    final strings = S.of(context);
    return SafeArea(
      bottom: false,
      child: CustomScrollView(
        key: const Key('utilities-content'),
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: EdgeInsets.fromLTRB(
              16.width,
              24.height,
              16.width,
              120.height,
            ),
            sliver: SliverList.list(
              children: [
                IrhText.title(
                  strings.navigationUtilities,
                  color: colors.textPrimary,
                ),
                24.height.heightBox,
                const _ServerConfigUtilityItem(),
                12.height.heightBox,
                const _LogoutUtilityItem(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ServerConfigUtilityItem extends StatelessWidget {
  const _ServerConfigUtilityItem();

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    return Container(
      height: 64.height,
      decoration: BoxDecoration(
        color: colors.surfaceSecondary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          IrhText.regular(
            S.of(context).serverConfigButton,
            color: colors.textPrimary,
          ).expanded(),
          const ServerConfigButton(),
        ],
      ).paddingOnly(left: 16.width, right: 8.width),
    );
  }
}

class _LogoutUtilityItem extends StatelessWidget {
  const _LogoutUtilityItem();

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    final strings = S.of(context);
    return Container(
      height: 64.height,
      decoration: BoxDecoration(
        color: colors.surfaceSecondary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) => Semantics(
          button: true,
          label: strings.logout,
          child: CupertinoButton(
            key: const Key('logout-button'),
            minimumSize: Size.zero,
            padding: EdgeInsets.symmetric(
              horizontal: 16.width,
              vertical: 12.height,
            ),
            onPressed: state.status == HomeStatus.loggingOut
                ? null
                : context.read<HomeCubit>().logout,
            child: Row(
              children: [
                IrhText.regular(
                  strings.logout,
                  color: colors.textError,
                ).expanded(),
                if (state.status == HomeStatus.loggingOut)
                  CupertinoActivityIndicator(
                    radius: 12.width,
                    color: colors.iconSecondary,
                  )
                else
                  Icon(
                    CupertinoIcons.square_arrow_right,
                    size: 24.sp,
                    color: colors.textError,
                  ),
              ],
            ),
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
    return SafeArea(
      bottom: false,
      child: CustomScrollView(
        key: const Key('home-content'),
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(child: _HomeHeader(user: data.user)),
          SliverPadding(
            padding: EdgeInsets.only(top: 16.height),
            sliver: SliverToBoxAdapter(
              child: _TaskSummary(role: data.user.role),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(
              16.width,
              24.height,
              16.width,
              120.height,
            ),
            sliver: SliverList.list(
              children: [
                _HomeSectionTitle(title: S.of(context).homeUtilities),
                16.height.heightBox,
                const _UtilityActions(),
                24.height.heightBox,
                const _CultureBanner(),
                8.height.heightBox,
                const _BannerIndicator(),
                24.height.heightBox,
                _HomeSectionTitle(title: S.of(context).featuredNews),
                16.height.heightBox,
                const _FeaturedNews(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  const _HomeHeader({required this.user});

  final AuthUser user;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    final strings = S.of(context);
    final name = user.fullName.trim();
    final initial = name.isEmpty ? '' : name.substring(0, 1).toUpperCase();
    return Row(
      children: [
        Container(
          width: 44.width,
          height: 44.width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: colors.surfaceTemary,
            shape: BoxShape.circle,
          ),
          child: IrhText.medium(initial, color: colors.textBrand),
        ),
        12.width.widthBox,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IrhText.medium(
              strings.homeGreetingName(user.fullName),
              color: colors.textPrimary,
            ),
            4.height.heightBox,
            IrhText.small(
              strings.homeMorningGreeting,
              color: colors.textSecondary,
            ),
          ],
        ).expanded(),
        const _NotificationButton(),
      ],
    ).paddingSymmetric(horizontal: 16.width, vertical: 12.height);
  }
}

class _NotificationButton extends StatelessWidget {
  const _NotificationButton();

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CupertinoButton(
          minimumSize: Size(40.width, 40.height),
          padding: EdgeInsets.zero,
          onPressed: () {},
          child: Icon(
            CupertinoIcons.bell,
            size: 24.sp,
            color: colors.iconPrimary,
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            width: 16.width,
            height: 16.width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colors.iconBrand,
              shape: BoxShape.circle,
            ),
            child: IrhText.small(
              S.of(context).notificationCount,
              color: colors.surfaceSecondary,
            ),
          ),
        ),
      ],
    );
  }
}

class _TaskSummary extends StatelessWidget {
  const _TaskSummary({required this.role});

  final UserRole role;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final colors = context.appColorScheme;
    final cardWidth = MediaQuery.sizeOf(context).width * 2 / 3;
    final needsAttentionCount = role == UserRole.manager
        ? strings.taskThreeCount
        : null;
    final cards = <Widget>[
      _TaskCard(
        key: const Key('leave-summary-card'),
        background: Assets.image.bgCardPink,
        icon: Assets.image.icLateAndSoonAbsent.svg(
          width: 28.width,
          height: 28.width,
          excludeFromSemantics: true,
          colorFilter: ColorFilter.mode(
            colors.surfaceSecondary,
            BlendMode.srcIn,
          ),
        ),
        title: strings.leaveRequest,
        waitingCount: strings.taskTwelveCount,
        needsAttentionCount: needsAttentionCount,
      ),
      _TaskCard(
        key: const Key('supplement-summary-card'),
        background: Assets.image.bgCardPurple,
        icon: Icon(
          Icons.fingerprint_rounded,
          size: 28.sp,
          color: colors.surfaceSecondary,
        ),
        title: strings.attendanceSupplement,
        waitingCount: strings.taskTwelveCount,
        needsAttentionCount: needsAttentionCount,
      ),
      _TaskCard(
        key: const Key('edocman-summary-card'),
        background: Assets.image.bgCardBlue,
        icon: Assets.image.icOtherFile.svg(
          width: 28.width,
          height: 28.width,
          excludeFromSemantics: true,
          colorFilter: ColorFilter.mode(
            colors.surfaceSecondary,
            BlendMode.srcIn,
          ),
        ),
        title: strings.edocman,
        waitingCount: strings.taskTwelveCount,
        needsAttentionCount: needsAttentionCount,
      ),
      _TaskCard(
        key: const Key('eis-summary-card'),
        background: Assets.image.bgCardEis,
        icon: Assets.image.icEisMsb.svg(
          width: 28.width,
          height: 28.width,
          excludeFromSemantics: true,
          colorFilter: ColorFilter.mode(
            colors.surfaceSecondary,
            BlendMode.srcIn,
          ),
        ),
        title: strings.eis,
        waitingCount: strings.taskTwelveCount,
        needsAttentionCount: needsAttentionCount,
      ),
    ];
    return SizedBox(
      height: 120.height,
      child: ListView.separated(
        key: const Key('task-summary-list'),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: cards.length,
        separatorBuilder: (context, index) => 12.width.widthBox,
        itemBuilder: (context, index) {
          final card = SizedBox(width: cardWidth, child: cards[index]);
          if (index == 0) {
            return card.paddingOnly(left: 16.width);
          }
          if (index == cards.length - 1) {
            return card.paddingOnly(right: 16.width);
          }
          return card;
        },
      ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  const _TaskCard({
    super.key,
    required this.background,
    required this.icon,
    required this.title,
    required this.waitingCount,
    this.needsAttentionCount,
  });

  final SvgGenImage background;
  final Widget icon;
  final String title;
  final String waitingCount;
  final String? needsAttentionCount;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    final strings = S.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        fit: StackFit.expand,
        children: [
          background.svg(fit: BoxFit.cover, excludeFromSemantics: true),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  icon,
                  8.width.widthBox,
                  IrhText.medium(
                    title,
                    color: colors.surfaceSecondary,
                    maxLines: 1,
                  ).expanded(),
                ],
              ),
              const Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (needsAttentionCount != null) ...[
                    _TaskMetric(
                      count: needsAttentionCount!,
                      label: strings.homeNeedsAttention,
                    ).expanded(),
                    8.width.widthBox,
                  ],
                  _TaskMetric(
                    count: waitingCount,
                    label: strings.homeWaitingApproval,
                  ).expanded(),
                  Container(
                    width: 24.width,
                    height: 24.width,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: colors.surfaceSecondary.withValues(alpha: .24),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      CupertinoIcons.chevron_right,
                      size: 12.sp,
                      color: colors.surfaceSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ).paddingAll(12.width),
        ],
      ),
    );
  }
}

class _TaskMetric extends StatelessWidget {
  const _TaskMetric({required this.count, required this.label});

  final String count;
  final String label;

  @override
  Widget build(BuildContext context) {
    final color = context.appColorScheme.surfaceSecondary;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        IrhText.medium(count, color: color),
        IrhText.small(label, color: color.withValues(alpha: .84), maxLines: 2),
      ],
    );
  }
}

class _HomeSectionTitle extends StatelessWidget {
  const _HomeSectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    return Row(
      children: [
        IrhText.medium(title, color: colors.textSecondary),
        8.width.widthBox,
        Icon(
          CupertinoIcons.chevron_right_circle_fill,
          size: 16.sp,
          color: colors.iconSecondary,
        ),
      ],
    );
  }
}

class _UtilityActions extends StatelessWidget {
  const _UtilityActions();

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _UtilityItem(
          icon: Icons.access_time_filled_rounded,
          label: strings.timeManagement,
        ).expanded(),
        _UtilityItem(
          icon: Icons.directions_run_rounded,
          label: strings.mRun,
        ).expanded(),
        _UtilityItem(
          icon: Icons.event_rounded,
          label: strings.events,
        ).expanded(),
        _UtilityItem(
          icon: Icons.volunteer_activism_rounded,
          label: strings.newMembers,
        ).expanded(),
      ],
    );
  }
}

class _UtilityItem extends StatelessWidget {
  const _UtilityItem({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    return CupertinoButton(
      minimumSize: Size.zero,
      padding: EdgeInsets.zero,
      onPressed: () {},
      child: Column(
        children: [
          Container(
            width: 48.width,
            height: 48.width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colors.iconBrand,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 24.sp, color: colors.surfaceSecondary),
          ),
          8.height.heightBox,
          IrhText.small(
            label,
            color: colors.textPrimary,
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}

class _CultureBanner extends StatelessWidget {
  const _CultureBanner();

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    final strings = S.of(context);
    final bannerStart = Color.lerp(colors.iconPrimary, colors.textError, .16)!;
    final bannerEnd = Color.lerp(colors.iconPrimary, colors.iconBrand, .28)!;
    return Container(
      key: const Key('home-banner-placeholder'),
      height: 144.height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [bannerStart, bannerEnd]),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -32.width,
            top: -48.height,
            child: Container(
              width: 184.width,
              height: 184.width,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: colors.iconBrand.withValues(alpha: .72),
                  width: 20.width,
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IrhText.small(
                strings.homeBannerEyebrow,
                color: colors.surfaceSecondary,
              ),
              12.height.heightBox,
              IrhText.title(
                strings.homeBannerTitle,
                color: colors.surfaceSecondary,
              ),
              8.height.heightBox,
              IrhText.small(
                strings.homeBannerSubtitle,
                color: colors.surfaceSecondary.withValues(alpha: .76),
              ),
            ],
          ).paddingSymmetric(horizontal: 20.width),
        ],
      ),
    );
  }
}

class _BannerIndicator extends StatelessWidget {
  const _BannerIndicator();

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 28.width,
          height: 4.height,
          decoration: BoxDecoration(
            color: colors.iconBrand,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        8.width.widthBox,
        for (var index = 0; index < 2; index++) ...[
          Container(
            width: 8.width,
            height: 4.height,
            decoration: BoxDecoration(
              color: colors.borderPrimary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          if (index == 0) 8.width.widthBox,
        ],
      ],
    );
  }
}

class _FeaturedNews extends StatelessWidget {
  const _FeaturedNews();

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    return SizedBox(
      height: 184.height,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: [
          _NewsCard(icon: Icons.groups_rounded, title: strings.newsRetailTitle),
          12.width.widthBox,
          _NewsCard(
            icon: Icons.laptop_mac_rounded,
            title: strings.newsKnowledgeTitle,
          ),
        ],
      ),
    );
  }
}

class _NewsCard extends StatelessWidget {
  const _NewsCard({required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColorScheme;
    return SizedBox(
      width: 168.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 112.height,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [colors.surfaceTemary, colors.borderSecondary],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 40.sp, color: colors.iconSecondary),
          ),
          8.height.heightBox,
          IrhText.small(title, color: colors.textPrimary, maxLines: 3),
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
            IrhText.regular(
              message,
              textAlign: TextAlign.center,
              color: context.appColorScheme.textSecondary,
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
