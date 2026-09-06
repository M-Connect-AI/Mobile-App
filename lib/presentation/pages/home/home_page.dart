import 'package:flutter/material.dart';

import '../../../resources/app_constants.dart';
import '../../../route/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _openAssistant(BuildContext context) {
    const ChatRoute().push(context);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(child: _HomeContent()),
          Positioned(
            right: 20,
            bottom: 24 + MediaQuery.paddingOf(context).bottom,
            child: _AssistantBubble(onTap: () => _openAssistant(context)),
          ),
        ],
      ),
      backgroundColor: colors.surface,
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          toolbarHeight: 72,
          backgroundColor: colors.surface.withValues(alpha: .92),
          surfaceTintColor: Colors.transparent,
          titleSpacing: 20,
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Xin chào, Minh 👋',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
              SizedBox(height: 2),
              Text(
                'Chúc bạn một ngày làm việc hiệu quả',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          actions: [
            IconButton.filledTonal(
              tooltip: 'Thông báo',
              onPressed: () {},
              icon: const Badge(
                smallSize: 7,
                child: Icon(Icons.notifications_none_rounded),
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 116),
          sliver: SliverList.list(
            children: const [
              _NextTripCard(),
              SizedBox(height: 28),
              _SectionTitle(title: 'Truy cập nhanh', action: 'Tuỳ chỉnh'),
              SizedBox(height: 14),
              _QuickActions(),
              SizedBox(height: 28),
              _SectionTitle(title: 'Công việc hôm nay', action: 'Xem tất cả'),
              SizedBox(height: 14),
              _TaskCard(
                icon: Icons.flight_takeoff_rounded,
                iconColor: Color(0xFFF4600C),
                title: 'Hoàn tất kế hoạch công tác',
                subtitle: 'Hà Nội · 03–05 Tháng 9',
                tag: 'Cần xử lý',
              ),
              SizedBox(height: 12),
              _TaskCard(
                icon: Icons.receipt_long_rounded,
                iconColor: Color(0xFFEF8D32),
                title: 'Gửi báo cáo chi phí',
                subtitle: 'Chuyến đi Đà Nẵng · Hạn 17:00',
                tag: 'Đang chờ',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _NextTripCard extends StatelessWidget {
  const _NextTripCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF8A45), Color(0xFFF4600C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFF4600C).withValues(alpha: .24),
            blurRadius: 28,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: .16),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'CHUYẾN ĐI SẮP TỚI',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: .8,
                  ),
                ),
              ),
              const Spacer(),
              const Icon(Icons.more_horiz_rounded, color: Colors.white70),
            ],
          ),
          const SizedBox(height: 22),
          const Text(
            'TP. Hồ Chí Minh  →  Hà Nội',
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 9),
          const Text(
            '03 Tháng 9 · 08:30  •  VN 216',
            style: TextStyle(color: Color(0xFFFFE2D1), fontSize: 13),
          ),
          const SizedBox(height: 22),
          const Row(
            children: [
              Icon(Icons.calendar_month_rounded, color: Colors.white, size: 18),
              SizedBox(width: 8),
              Text(
                'Còn 3 ngày',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              Text(
                'Xem chi tiết',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: 4),
              Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 18),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.action});

  final String title;
  final String action;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
          ),
        ),
        Text(
          action,
          style: TextStyle(
            fontSize: 13,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: _QuickAction(
            icon: Icons.add_rounded,
            label: 'Tạo yêu cầu',
            color: Color(0xFFF4600C),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _QuickAction(
            icon: Icons.airplane_ticket_outlined,
            label: 'Chuyến đi',
            color: Color(0xFF279D79),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _QuickAction(
            icon: Icons.payments_outlined,
            label: 'Chi phí',
            color: Color(0xFFEF8D32),
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
    final colors = Theme.of(context).colorScheme;
    return Material(
      color: colors.surfaceContainerLowest,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 16),
          child: Column(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: .12),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(icon, color: color, size: 22),
              ),
              const SizedBox(height: 9),
              Text(
                label,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  const _TaskCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.tag,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String tag;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colors.outlineVariant.withValues(alpha: .5)),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: .11),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            tag,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: iconColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _AssistantBubble extends StatefulWidget {
  const _AssistantBubble({required this.onTap});

  final VoidCallback onTap;

  @override
  State<_AssistantBubble> createState() => _AssistantBubbleState();
}

class _AssistantBubbleState extends State<_AssistantBubble> {
  bool _showHint = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AnimatedSize(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          child: _showHint
              ? Container(
                  key: const Key('assistant-hint'),
                  constraints: const BoxConstraints(maxWidth: 190),
                  margin: const EdgeInsets.only(right: 10, bottom: 5),
                  padding: const EdgeInsets.fromLTRB(14, 10, 8, 10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: .10),
                        blurRadius: 18,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Flexible(
                        child: Text(
                          'Bạn cần mình hỗ trợ?',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      InkWell(
                        onTap: () => setState(() => _showHint = false),
                        borderRadius: BorderRadius.circular(20),
                        child: const Padding(
                          padding: EdgeInsets.all(3),
                          child: Icon(Icons.close_rounded, size: 15),
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ),
        Semantics(
          button: true,
          label: 'Mở $AppConstants.chatbotName',
          child: Material(
            key: const Key('assistant-bubble'),
            color: Colors.transparent,
            shape: const CircleBorder(),
            child: InkWell(
              onTap: widget.onTap,
              customBorder: const CircleBorder(),
              child: Ink(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF8A45), Color(0xFFF4600C)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFF4600C).withValues(alpha: .35),
                      blurRadius: 22,
                      offset: const Offset(0, 9),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.auto_awesome_rounded,
                  color: Colors.white,
                  size: 27,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
