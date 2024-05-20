# Robot-Remote

## BU Morphable Biorobotics - Squid Inspired Jet Propulsion Robot
#### Developer: Celine Chen

Welcome to the Robot-Remote repository, a two-part project consisting of an iOS application that serves as a remote control, and corresponding C code that operates a Squid Inspired Jet Propulsion Robot.

### Overview
Robot-Remote enables seamless interaction between a custom-built iOS application and a robotic system powered by a microcontroller, specifically XIAO ESP32. 

### Repository Structure

#### 1. Remote App
The Remote App directory contains all the components necessary for the iOS application. Key elements include:

- **CC_Remote**: This folder is the heart of the iOS application, housing all modules related to the application's pages and features. The folder is organized to facilitate easy navigation and modification.

#### 2. C Code
Corresponding C code that integrates with the iOS app to control the robotic functions. This part ensures that commands sent from the iOS application are executed by the robot accurately.

### Getting Started

#### Prerequisites
- iOS device (iPhone or iPad) running iOS 13.0 or later.
- Microcontroller that is compatible with the provided code.

#### Installation
1. **iOS Application**: 
   - Clone the repository to your local machine.
   - Navigate to the `Remote App` directory.
   - Open `CC_Remote.xcodeproj` with Xcode.
   - Change the UUID to the microcontroller used in BluetoothManager.swift
   - Build and run the application on your iOS device.

2. **Arduino Setup**:
   - Upload the provided Arduino code to your Arduino board using the Arduino IDE.

### Usage
- **Remote App**: Once installed, the app can be used to control the robot's movements and operations remotely.
- **Arduino**: Ensure the microcontroller is properly connected and powered for operation.
