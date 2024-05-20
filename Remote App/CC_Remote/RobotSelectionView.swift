//
//  RobotSelectionView.swift
//  CC_Remote
//
//  Created by Celine on 4/16/24.
//

import SwiftUI

struct RobotSelectionView: View {
    @ObservedObject var bluetoothManager: BluetoothManager
    var onDisconnect: () -> Void

    var body: some View {
        VStack {
            NavigationLink(destination: Robot1View(bluetoothManager: bluetoothManager, onDisconnect: onDisconnect)) {
                Text("Robot 1")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            NavigationLink(destination: Robot2View(bluetoothManager: bluetoothManager, onDisconnect: onDisconnect)) {
                Text("Robot 2")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            NavigationLink(destination: Robot3View(bluetoothManager: bluetoothManager, onDisconnect: onDisconnect)) {
                Text("Robot 3")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            Button("Disconnect") {
                bluetoothManager.disconnect()
                onDisconnect()
            }
            .padding()
            .background(Color.gray)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .navigationBarTitle("Select Robot", displayMode: .large)
        .padding()
    }
}
