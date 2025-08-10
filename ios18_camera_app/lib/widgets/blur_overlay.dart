import 'package:flutter/material.dart';

class BlurOverlay extends StatelessWidget {
  final double blurAmount;
  final Color overlayColor;

  const BlurOverlay({
    super.key,
    this.blurAmount = 10.0,
    this.overlayColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blurAmount,
          sigmaY: blurAmount,
        ),
        child: Container(
          color: overlayColor,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.blur_on,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Portrait Mode',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedBlurOverlay extends StatefulWidget {
  final bool isEnabled;
  final double maxBlur;
  final Duration animationDuration;

  const AnimatedBlurOverlay({
    super.key,
    required this.isEnabled,
    this.maxBlur = 15.0,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  State<AnimatedBlurOverlay> createState() => _AnimatedBlurOverlayState();
}

class _AnimatedBlurOverlayState extends State<AnimatedBlurOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _blurAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _blurAnimation = Tween<double>(
      begin: 0.0,
      end: widget.maxBlur,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void didUpdateWidget(AnimatedBlurOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isEnabled != oldWidget.isEnabled) {
      if (widget.isEnabled) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _blurAnimation,
      builder: (context, child) {
        if (_blurAnimation.value == 0.0) {
          return const SizedBox.shrink();
        }
        
        return BlurOverlay(
          blurAmount: _blurAnimation.value,
          overlayColor: Colors.black.withValues(alpha: 0.1),
        );
      },
    );
  }
}