# iOS 18 Camera App - Flutter Project

## Project Overview
This is a Flutter mobile application that replicates the iOS 18 camera interface with advanced features including Gaussian blur effects. The app is designed to work on Android devices and includes a complete CI/CD pipeline for building APKs via GitHub Actions.

## Architecture
- **Framework**: Flutter 3.32.0
- **Target Platform**: Android (API 21+)
- **UI Style**: iOS 18 Camera Interface
- **Key Features**: 
  - Real-time camera preview
  - Gaussian blur effects (Portrait mode)
  - Zoom controls with slider
  - Camera switching (front/rear)
  - Glassmorphic UI components
  - Photo capture with haptic feedback

## Dependencies
- `camera: ^0.10.6` - Camera functionality
- `glassmorphism: ^3.0.0` - iOS-like glassmorphic UI effects
- `flutter_bloc: ^8.1.6` - State management
- `permission_handler: ^11.3.1` - Camera permissions
- `path_provider: ^2.1.4` - File system access
- `image: ^4.2.0` - Image processing

## Project Structure
```
lib/
├── main.dart - App entry point and camera initialization
├── screens/
│   └── camera_screen.dart - Main camera interface
├── widgets/
│   ├── camera_controls.dart - Bottom controls (capture, modes, zoom)
│   └── blur_overlay.dart - Gaussian blur effect overlay
└── models/ - Data models (future use)
```

## Build Configuration
- **Minimum SDK**: API 21 (Android 5.0)
- **Target SDK**: Latest
- **Build Features**: 
  - Multi-APK generation (split by ABI)
  - ProGuard optimization enabled
  - Resource shrinking enabled

## GitHub Actions CI/CD
- Automated APK building on push/PR
- Multiple APK variants (debug and release)
- Artifact upload and release creation
- Support for arm64-v8a, armeabi-v7a, x86, x86_64

## User Preferences
- Language: Vietnamese
- Focus: iOS-like UI design and user experience
- Priority: Camera functionality with blur effects

## Recent Changes
- ✓ Created Flutter project with iOS 18 camera theme
- ✓ Implemented camera preview with permissions
- ✓ Added glassmorphic UI components
- ✓ Created Gaussian blur overlay system
- ✓ Built camera controls with zoom slider
- ✓ Configured GitHub Actions for APK building
- ✓ Optimized Android build configuration

## Next Steps
- Test camera functionality
- Fine-tune blur effects
- Add more iOS 18 specific UI animations
- Implement photo gallery integration