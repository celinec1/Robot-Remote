//
//  DeviceListView.swift
//  CC_Remote
//
//  Created by Celine on 2/1/24.
//

import SwiftUI
import CoreBluetooth

struct DeviceListView: View {
    @ObservedObject var bluetoothManager: BluetoothManager
    @Binding var isConnected: Bool

    var body: some View {
        List {
            ForEach(bluetoothManager.discoveredPeripherals, id: \.identifier) { peripheral in
                HStack {
                    Text(peripheral.name ?? "Unknown Device")
                    Spacer()
                    Button("Connect") {
                        connectToPeripheral(peripheral)
                    }
                }
            }
        }
        .navigationBarTitle("Bluetooth Devices", displayMode: .large)
//        .onAppear {
//            bluetoothManager.scanForPeripherals()
//        }
    }

    private func connectToPeripheral(_ peripheral: CBPeripheral) {
        bluetoothManager.centralManager.stopScan()
        bluetoothManager.centralManager.connect(peripheral, options: nil)
        // Assuming immediate connection for simplicity
        self.isConnected = true
    }
}
