import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';
import 'package:glassmorphism/glassmorphism.dart';

class CameraControls extends StatefulWidget {
  final CameraController? controller;
  final VoidCallback onSwitchCamera;
  final Function(double) onZoomChanged;
  final double zoomLevel;
  final double minZoomLevel;
  final double maxZoomLevel;

  const CameraControls({
    super.key,
    required this.controller,
    required this.onSwitchCamera,
    required this.onZoomChanged,
    required this.zoomLevel,
    required this.minZoomLevel,
    required this.maxZoomLevel,
  });

  @override
  State<CameraControls> createState() => _CameraControlsState();
}

class _CameraControlsState extends State<CameraControls> {
  String _selectedMode = 'PHOTO';
  final List<String> _modes = ['VIDEO', 'PHOTO', 'PORTRAIT'];

  Future<void> _takePicture() async {
    if (widget.controller == null || !widget.controller!.value.isInitialized) {
      return;
    }

    try {
      await widget.controller!.takePicture();
      // Add haptic feedback
      HapticFeedback.lightImpact();
      
      // Show capture animation
      _showCaptureAnimation();
    } catch (e) {
      debugPrint('Error taking picture: $e');
    }
  }

  void _showCaptureAnimation() {
    // Simple flash animation
    final navigator = Navigator.of(context);
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.white.withValues(alpha: 0.8),
      builder: (context) => Container(),
    );
    
    Future.delayed(const Duration(milliseconds: 100), () {
      navigator.pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          height: 200,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              // Camera modes
              SizedBox(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _modes.map((mode) {
                    bool isSelected = mode == _selectedMode;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedMode = mode;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: isSelected 
                            ? Colors.yellow.withValues(alpha: 0.2)
                            : Colors.transparent,
                        ),
                        child: Text(
                          mode,
                          style: TextStyle(
                            color: isSelected ? Colors.yellow : Colors.white,
                            fontSize: 16,
                            fontWeight: isSelected 
                              ? FontWeight.w600 
                              : FontWeight.normal,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              
              const SizedBox(height: 30),
              
              // Main controls row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Gallery/Last photo
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.3),
                        width: 2,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        color: Colors.grey.withValues(alpha: 0.3),
                        child: const Icon(
                          Icons.photo_library,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                  
                  // Capture button
                  GestureDetector(
                    onTap: _takePicture,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 4,
                        ),
                      ),
                      child: Container(
                        margin: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  
                  // Switch camera
                  GestureDetector(
                    onTap: widget.onSwitchCamera,
                    child: GlassmorphicContainer(
                      width: 50,
                      height: 50,
                      borderRadius: 25,
                      blur: 20,
                      alignment: Alignment.center,
                      border: 0,
                      linearGradient: LinearGradient(
                        colors: [
                          Colors.white.withValues(alpha: 0.1),
                          Colors.white.withValues(alpha: 0.05),
                        ],
                      ),
                      borderGradient: LinearGradient(
                        colors: [
                          Colors.white.withValues(alpha: 0.2),
                          Colors.white.withValues(alpha: 0.1),
                        ],
                      ),
                      child: const Icon(
                        Icons.flip_camera_ios,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 20),
              
              // Zoom slider
              if (widget.maxZoomLevel > widget.minZoomLevel)
                SizedBox(
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${widget.minZoomLevel.toStringAsFixed(1)}x',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            activeTrackColor: Colors.yellow,
                            inactiveTrackColor: Colors.white.withValues(alpha: 0.3),
                            thumbColor: Colors.yellow,
                            thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 8,
                            ),
                            overlayShape: const RoundSliderOverlayShape(
                              overlayRadius: 16,
                            ),
                          ),
                          child: Slider(
                            value: widget.zoomLevel,
                            min: widget.minZoomLevel,
                            max: widget.maxZoomLevel,
                            onChanged: widget.onZoomChanged,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '${widget.maxZoomLevel.toStringAsFixed(1)}x',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}