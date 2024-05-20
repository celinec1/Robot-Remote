//
//  Robot1View.swift
//  CC_Remote
//
//  Created by Celine on 2/1/24.
//
// THIS WORKS FOR JUST TURNING ON AND OFF FOR BOTH PINS
//import SwiftUI
//import CoreBluetooth
////
//struct RobotControlView: View {
//    @ObservedObject var bluetoothManager: BluetoothManager
//    var onDisconnect: () -> Void  // Callback for handling UI changes on disconnect
//
//    var body: some View {
//        VStack(spacing: 20) {
//            HStack(spacing: 20){
//                Button("Right On") {
//                    bluetoothManager.writeLEDValue(value: 1)
//                }
//                .padding()
//                .background(Color.green)
//                .foregroundColor(.white)
//                .cornerRadius(10)
//
//                Button("Right Off") {
//                    bluetoothManager.writeLEDValue(value: 0)
//                }
//                .padding()
//                .background(Color.red)
//                .foregroundColor(.white)
//                .cornerRadius(10)
//
//            }
//            HStack(spacing: 20){
//                Button("Left On") {
//                    bluetoothManager.writeLEDValue(value: 3)
//                }
//                .padding()
//                .background(Color.green)
//                .foregroundColor(.white)
//                .cornerRadius(10)
//
//
//                Button("Left Off") {
//                    bluetoothManager.writeLEDValue(value: 2)
//                }
//                .padding()
//                .background(Color.red)
//                .foregroundColor(.white)
//                .cornerRadius(10)
//            }
//
//            Button("Disconnect") {
//                bluetoothManager.disconnect()
//                onDisconnect()
//            }
//            .padding()
//            .background(Color.blue)
//            .foregroundColor(.white)
//            .cornerRadius(10)
//        }
//        .navigationBarTitle("Robot 1", displayMode: .large)
//    }
//}
//

////WORKS FOR DURATION
//import SwiftUI
//import CoreBluetooth
//
//struct RobotControlView: View {
//    @ObservedObject var bluetoothManager: BluetoothManager
//    var onDisconnect: () -> Void
//    
//    @State private var duration = ""
//    @State private var showAlert = false
//    @State private var alertMessage = ""
//    
//    var body: some View {
//        VStack(spacing: 20) {
//            TextField("Duration (s)", text: $duration)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .keyboardType(.numberPad) // Ensure numeric input
//                .padding()
//            
//            HStack(spacing: 20) {
//                Button("Right On") {
//                    sendCommand(to: 1)
//                }
//                .padding()
//                .background(Color.green)
//                .foregroundColor(.white)
//                .cornerRadius(10)
//                
//                Button("Right Off") {
//                    sendCommand(to: 0)
//                }
//                .padding()
//                .background(Color.red)
//                .foregroundColor(.white)
//                .cornerRadius(10)
//            }
//            
//            HStack(spacing: 20) {
//                Button("Left On") {
//                    sendCommand(to: 3)
//                }
//                .padding()
//                .background(Color.green)
//                .foregroundColor(.white)
//                .cornerRadius(10)
//                
//                Button("Left Off") {
//                    sendCommand(to: 2)
//                }
//                .padding()
//                .background(Color.red)
//                .foregroundColor(.white)
//                .cornerRadius(10)
//            }
//            
//            Button("Disconnect") {
//                bluetoothManager.disconnect()
//                onDisconnect()
//            }
//            .padding()
//            .background(Color.blue)
//            .foregroundColor(.white)
//            .cornerRadius(10)
//        }
//        .navigationBarTitle("Robot 1", displayMode: .large)
//        .padding()
//        .alert(isPresented: $showAlert) {
//            Alert(title: Text("Invalid Input"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
//        }
//    }
//    
//    func sendCommand(to command: UInt8) {
//        guard let durationInt = UInt32(duration), !duration.isEmpty else {
//            self.alertMessage = "Please enter a valid duration in seconds."
//            self.showAlert = true
//            return
//        }
//        
//        let commandString = "\(command),\(durationInt)" // Format command and duration as a single string
//        bluetoothManager.writeCommandWithParameters(command: commandString) // Correct method call
//    }
//
//}
//



import SwiftUI
import CoreBluetooth

struct Robot1View: View {
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
                
//                Button("Right Off") {
//                    sendCommand(to: 0)
//                }
//                .padding()
//                .background(Color.red)
//                .foregroundColor(.white)
//                .cornerRadius(10)
//            }
            
//            HStack(spacing: 20) {
                Button("Left On") {
                    sendCommand(to: 3)
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
                
//                Button("Left Off") {
//                    sendCommand(to: 2)
//                }
//                .padding()
//                .background(Color.red)
//                .foregroundColor(.white)
//                .cornerRadius(10)
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
        .navigationBarTitle("Robot 1", displayMode: .large)
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

