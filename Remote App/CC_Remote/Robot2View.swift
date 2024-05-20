//
//  Robot2View.swift
//  CC_Remote
//
//  Created by Celine on 4/16/24.
//

import SwiftUI
import CoreBluetooth

struct Robot2View: View {
    @ObservedObject var bluetoothManager: BluetoothManager
    var onDisconnect: () -> Void
    
    @State private var duration = ""
    @State private var repetitions = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Duration (ms)", text: $duration)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad) // Ensure numeric input
                .padding()
            
            TextField("Repetitions", text: $repetitions)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad) // Ensure numeric input
                .padding()

            
            HStack(spacing: 20) {
                Button("Right On") {
                    sendCommand(to: 1)
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                

                Button("Left On") {
                    sendCommand(to: 3)
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
                
            }
            
            HStack(spacing: 20) {
                Button("Right2 On") {
                    sendCommand(to: 4)
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
                
                
                Button("Left2 On") {
                    sendCommand(to: 5)
                }
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
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .navigationBarTitle("Robot 2", displayMode: .large)
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Invalid Input"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func sendCommand(to command: UInt8) {
        guard let durationInt = UInt32(duration), !duration.isEmpty, let repetitionsInt = UInt32(repetitions), !repetitions.isEmpty else {
            self.alertMessage = "Please enter valid duration and repetitions."
            self.showAlert = true
            return
        }
        
        let commandString = "\(command),\(durationInt),\(repetitionsInt)" // Include repetitions in the command string
        bluetoothManager.writeCommandWithParameters(command: commandString)
    }

}

