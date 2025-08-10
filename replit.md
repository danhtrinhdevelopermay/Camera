h# iOS 18 Camera App - Flutter Project

## Overview
This is a Flutter mobile application that replicates the iOS 18 camera interface with advanced features including Gaussian blur effects. The app is designed to work across multiple platforms (Android, iOS, Linux, Windows, macOS, and Web) with a focus on delivering an authentic iOS 18 camera experience with real-time camera preview, portrait mode effects, and glassmorphic UI components.

## User Preferences
Preferred communication style: Simple, everyday language.

## System Architecture

### Framework and Platform Support
- **Primary Framework**: Flutter 3.x with Dart
- **Target Platforms**: Multi-platform support including Android (API 21+), iOS, Web, Windows, Linux, and macOS
- **UI Design Pattern**: iOS 18-inspired interface with glassmorphic design elements
- **State Management**: BLoC pattern using flutter_bloc for reactive state management

### Camera System Architecture
- **Camera Integration**: Native camera access through the camera plugin with platform-specific implementations
- **Real-time Processing**: Live camera preview with real-time Gaussian blur effects for portrait mode
- **Permission Management**: Integrated permission handling for camera access across platforms
- **Image Processing**: Built-in image manipulation capabilities for photo capture and effects

### UI/UX Architecture
- **Design System**: iOS 18-style interface with glassmorphic UI components
- **Responsive Design**: Adaptive layouts that work across different screen sizes and orientations
- **Visual Effects**: Gaussian blur overlays and glassmorphic elements for authentic iOS appearance
- **Interactive Controls**: Touch-based camera controls including zoom sliders, mode switching, and capture buttons

### Build and Deployment
- **Multi-target Builds**: Separate build configurations for each supported platform
- **Native Platform Integration**: Platform-specific CMake configurations for desktop platforms
- **Web Support**: Progressive Web App capabilities with manifest configuration
- **Asset Management**: Centralized asset handling with platform-specific icon sets

## External Dependencies

### Core Camera Functionality
- **camera (^0.10.6)**: Primary camera functionality with cross-platform support
- **permission_handler (^11.3.1)**: Runtime permission management for camera access
- **path_provider (^2.1.4)**: File system access for photo storage

### UI and Visual Effects
- **glassmorphism (^3.0.0)**: iOS-style glassmorphic UI effects and backgrounds
- **cupertino_icons**: iOS-style iconography for authentic appearance

### State Management and Architecture
- **flutter_bloc (^8.1.6)**: Reactive state management using the BLoC pattern
- **image (^4.2.0)**: Image processing and manipulation capabilities

### Development Tools
- **flutter_lints (^5.0.0)**: Code quality and style enforcement
- **flutter_test**: Unit and widget testing framework

### Platform-Specific Integrations
- **Native Build Systems**: CMake for Windows and Linux builds
- **iOS/macOS Integration**: Xcode project configuration with asset catalogs
- **Web PWA Support**: Service worker and manifest configurations for web deployment
