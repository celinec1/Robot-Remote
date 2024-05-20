//
//  ContentView.swift
//  CC_Remote
//
//  Created by Celine on 2/1/24.
//

// THIS WORKS!!!!!!!!

import SwiftUI
import CoreBluetooth
//
//struct ContentView: View {
//    @ObservedObject var bluetoothManager = BluetoothManager()
//    @State private var showDeviceList = false
//    @State private var isConnected = false
//
//    var body: some View {
//        NavigationView {
//            if isConnected {
//                RobotControlView(bluetoothManager: bluetoothManager) {
//                    // This closure is called when the user taps the disconnect button
//                    self.isConnected = false
//                    self.showDeviceList = true // Show the device list again
//                }
//            } else if showDeviceList {
//                DeviceListView(bluetoothManager: bluetoothManager, isConnected: $isConnected)
//                    // Add a callback for when you want to hide the device list,
//                    // such as when the user selects a device to connect to or if they cancel
////                    self.showDeviceList = false
//                }
//            else {
//                WelcomeView {
//                    self.showDeviceList = true
//                }
//            }
//        }
//    }
//}



//4/16
import SwiftUI

struct ContentView: View {
    @ObservedObject var bluetoothManager = BluetoothManager()
    @State private var showDeviceList = false
    @State private var isConnected = false

    var body: some View {
        NavigationView {
            if isConnected {
                // Now showing RobotSelectionView instead of RobotControlView after connection
                RobotSelectionView(bluetoothManager: bluetoothManager, onDisconnect: {
                    // When disconnect is pressed in RobotSelectionView
                    self.isConnected = false
                    self.showDeviceList = false // Hide the device list as you are disconnecting
                })
            } else if showDeviceList {
                // The DeviceListView is presented and will set isConnected to true when a device is connected
                DeviceListView(bluetoothManager: bluetoothManager, isConnected: $isConnected)
            } else {
                // The WelcomeView is shown initially and will set showDeviceList to true when ready to connect to devices
                WelcomeView {
                    self.showDeviceList = true
                }
            }
        }
    }
}

