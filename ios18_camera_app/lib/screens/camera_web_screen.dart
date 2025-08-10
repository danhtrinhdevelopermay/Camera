import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import '../widgets/camera_controls_web.dart';
import '../widgets/blur_overlay.dart';

class CameraWebScreen extends StatefulWidget {
  const CameraWebScreen({super.key});

  @override
  State<CameraWebScreen> createState() => _CameraWebScreenState();
}

class _CameraWebScreenState extends State<CameraWebScreen>
    with WidgetsBindingObserver {
  bool _isBlurEnabled = false;
  double _zoomLevel = 1.0;
  final double _minZoomLevel = 1.0;
  final double _maxZoomLevel = 5.0;

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

  void _toggleBlur() {
    setState(() {
      _isBlurEnabled = !_isBlurEnabled;
    });
  }

  void _onZoomChanged(double zoom) {
    setState(() {
      _zoomLevel = zoom;
    });
  }

  Widget _buildCameraPreview() {
    return Stack(
      children: [
        // Camera preview simulation with gradient
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.grey[800]!,
                  Colors.grey[900]!,
                  Colors.black,
                ],
              ),
            ),
            child: Stack(
              children: [
                // Simulated camera view with some elements
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.3),
                            width: 2,
                          ),
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 80,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'iOS 18 Camera Demo',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.7),
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Web Version - Camera Simulation',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.5),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Grid lines for camera
                if (!_isBlurEnabled)
                  Positioned.fill(
                    child: CustomPaint(
                      painter: GridPainter(),
                    ),
                  ),
              ],
            ),
          ),
        ),
        
        // Blur overlay if enabled
        if (_isBlurEnabled)
          BlurOverlay(blurAmount: 8.0),
        
        // iOS 18 style gradient overlays
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 200,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.6),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: 250,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.8),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Camera preview
          _buildCameraPreview(),
          
          // Top controls
          SafeArea(
            child: Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Close button
                    GlassmorphicContainer(
                      width: 44,
                      height: 44,
                      borderRadius: 22,
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
                        Icons.close,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    
                    // Flash and other controls
                    Row(
                      children: [
                        // Blur toggle
                        GestureDetector(
                          onTap: _toggleBlur,
                          child: GlassmorphicContainer(
                            width: 44,
                            height: 44,
                            borderRadius: 22,
                            blur: 20,
                            alignment: Alignment.center,
                            border: 0,
                            linearGradient: LinearGradient(
                              colors: [
                                _isBlurEnabled 
                                  ? Colors.blue.withValues(alpha: 0.3)
                                  : Colors.white.withValues(alpha: 0.1),
                                _isBlurEnabled 
                                  ? Colors.blue.withValues(alpha: 0.2)
                                  : Colors.white.withValues(alpha: 0.05),
                              ],
                            ),
                            borderGradient: LinearGradient(
                              colors: [
                                Colors.white.withValues(alpha: 0.2),
                                Colors.white.withValues(alpha: 0.1),
                              ],
                            ),
                            child: Icon(
                              Icons.blur_on,
                              color: _isBlurEnabled ? Colors.blue : Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        
                        // Settings
                        GlassmorphicContainer(
                          width: 44,
                          height: 44,
                          borderRadius: 22,
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
                            Icons.tune,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Bottom controls
          CameraControlsWeb(
            onZoomChanged: _onZoomChanged,
            zoomLevel: _zoomLevel,
            minZoomLevel: _minZoomLevel,
            maxZoomLevel: _maxZoomLevel,
          ),
        ],
      ),
    );
  }
}

// Custom painter for camera grid lines
class GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.2)
      ..strokeWidth = 1;

    // Vertical lines
    canvas.drawLine(
      Offset(size.width / 3, 0),
      Offset(size.width / 3, size.height),
      paint,
    );
    canvas.drawLine(
      Offset(size.width * 2 / 3, 0),
      Offset(size.width * 2 / 3, size.height),
      paint,
    );

    // Horizontal lines
    canvas.drawLine(
      Offset(0, size.height / 3),
      Offset(size.width, size.height / 3),
      paint,
    );
    canvas.drawLine(
      Offset(0, size.height * 2 / 3),
      Offset(size.width, size.height * 2 / 3),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}