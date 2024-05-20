import CoreBluetooth

class BluetoothManager: NSObject, ObservableObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    @Published var centralManager: CBCentralManager!
    @Published var ledPeripheral: CBPeripheral?
    @Published var discoveredPeripherals: [CBPeripheral] = []
    
    let ledServiceUUID = CBUUID(string: "19B10000-E8F2-537E-4F6C-D104768A1214")
    let commandCharacteristicUUID = CBUUID(string: "19B10002-E8F2-537E-4F6C-D104768A1214")

    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            centralManager.scanForPeripherals(withServices: [ledServiceUUID], options: nil)
        }
    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if !discoveredPeripherals.contains(where: { $0.identifier == peripheral.identifier }) {
            discoveredPeripherals.append(peripheral)
        }
    }

    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.delegate = self
        peripheral.discoverServices([ledServiceUUID])
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }
        for service in services {
            peripheral.discoverCharacteristics([commandCharacteristicUUID], for: service)
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else { return }
        for characteristic in characteristics where characteristic.uuid == commandCharacteristicUUID {
            self.ledPeripheral = peripheral
        }
    }

    func writeCommandWithParameters(command: String) {
        guard let peripheral = self.ledPeripheral,
              let service = peripheral.services?.first(where: { $0.uuid == ledServiceUUID }),
              let commandCharacteristic = service.characteristics?.first(where: { $0.uuid == commandCharacteristicUUID }) else {
            print("Failed to find peripheral, service, or characteristic.")
            return
        }

        if let data = command.data(using: .utf8) {
            peripheral.writeValue(data, for: commandCharacteristic, type: .withResponse)
        } else {
            print("Failed to create data from command string.")
        }
    }
    
    func disconnect() {
        guard let peripheral = ledPeripheral else { return }
        centralManager.cancelPeripheralConnection(peripheral)
    }
}
