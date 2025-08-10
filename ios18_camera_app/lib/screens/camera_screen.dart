import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';
import 'package:glassmorphism/glassmorphism.dart';
import '../widgets/camera_controls.dart';
import '../widgets/blur_overlay.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  CameraController? controller;
  bool _isCameraInitialized = false;
  bool _isRearCameraSelected = true;
  bool _isBlurEnabled = false;
  double _zoomLevel = 1.0;
  double _minZoomLevel = 1.0;
  double _maxZoomLevel = 1.0;
  List<CameraDescription> cameras = [];

  @override
  void initState() {
    super.initState();
    _initializeCameraList();
    WidgetsBinding.instance.addObserver(this);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  Future<void> _initializeCameraList() async {
    try {
      cameras = await availableCameras();
      _initializeCamera();
    } catch (e) {
      debugPrint('Error getting cameras: $e');
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    WidgetsBinding.instance.removeObserver(this);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (controller == null || !controller!.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initializeCamera();
    }
  }

  Future<void> _initializeCamera() async {
    if (cameras.isEmpty) return;

    final camera = _isRearCameraSelected ? cameras.first : cameras.last;
    
    controller = CameraController(
      camera,
      ResolutionPreset.veryHigh,
      enableAudio: false,
    );

    try {
      await controller!.initialize();
      
      _minZoomLevel = await controller!.getMinZoomLevel();
      _maxZoomLevel = await controller!.getMaxZoomLevel();
      
      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
        });
      }
    } catch (e) {
      debugPrint('Camera initialization error: $e');
    }
  }

  void _switchCamera() {
    setState(() {
      _isRearCameraSelected = !_isRearCameraSelected;
      _isCameraInitialized = false;
    });
    controller?.dispose();
    _initializeCamera();
  }

  void _toggleBlur() {
    setState(() {
      _isBlurEnabled = !_isBlurEnabled;
    });
  }

  void _onZoomChanged(double zoom) {
    if (controller != null && controller!.value.isInitialized) {
      controller!.setZoomLevel(zoom);
      setState(() {
        _zoomLevel = zoom;
      });
    }
  }

  Widget _buildCameraPreview() {
    if (!_isCameraInitialized) {
      return Container(
        color: Colors.black,
        child: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ),
      );
    }

    return Stack(
      children: [
        // Camera preview
        Positioned.fill(
          child: CameraPreview(controller!),
        ),
        
        // Blur overlay if enabled
        if (_isBlurEnabled)
          BlurOverlay(),
        
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
          CameraControls(
            controller: controller,
            onSwitchCamera: _switchCamera,
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