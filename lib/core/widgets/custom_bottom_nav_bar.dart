import 'package:flutter/material.dart';
import 'package:weight_tracker_app/core/extensions/context_extension.dart';
import 'package:weight_tracker_app/core/mixins/localization_mixin.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({
    required this.currentIndex,
    required this.onTap,
    super.key,
  });
  final int currentIndex;
  final Function(int) onTap;

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar>
    with LocalizationMixin, TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      3,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 200),
        vsync: this,
      ),
    );

    _animations = List.generate(
      3,
      (index) => Tween<double>(begin: 1, end: 1.2).animate(
        CurvedAnimation(
          parent: _controllers[index],
          curve: Curves.easeInOut,
        ),
      ),
    );

    _updateAnimations();
  }

  @override
  void didUpdateWidget(CustomBottomNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _updateAnimations();
    }
  }

  void _updateAnimations() {
    for (var i = 0; i < _controllers.length; i++) {
      if (i == widget.currentIndex) {
        _controllers[i].forward();
      } else {
        _controllers[i].reverse();
      }
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          height: context.dynamicHeight(0.08),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, Icons.fitness_center_outlined, l10n.navHome),
              _buildNavItem(1, Icons.history, l10n.navHistory),
              _buildNavItem(2, Icons.person_2_rounded, l10n.navProfile),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = widget.currentIndex == index;
    final color = isSelected ? Theme.of(context).colorScheme.primary : Colors.grey;

    return GestureDetector(
      onTap: () => widget.onTap(index),
      child: ScaleTransition(
        scale: _animations[index],
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: context.lowValue,
            vertical: context.lowValue / 2,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: color,
                size: isSelected ? context.highValue : context.highValue - 4,
              ),
              SizedBox(height: context.lowValue / 4),
              Text(
                label,
                style: context.bodySmall.copyWith(
                  color: color,
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
