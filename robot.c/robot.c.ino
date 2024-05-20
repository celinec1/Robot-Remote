#include <ArduinoBLE.h>

BLEService ledService("19B10000-E8F2-537E-4F6C-D104768A1214"); // Service UUID
BLEStringCharacteristic commandCharacteristic("19B10002-E8F2-537E-4F6C-D104768A1214", BLERead | BLEWrite, 20); // Characteristic UUID

const int HI_PIN = D0; // High pin for robot 1
const int LOW_PIN = D2; // Low pin for robot 1
const int HI_PIN2 = D3; // High pin for robot 2
const int LOW_PIN2 = D4; // Low pin for robot 2
const int HI_PIN3 = D5;
const int LOW_PIN3 = D6;

unsigned long previousMillis = 0;
int commandActive = -1; // -1 indicates no active command
unsigned long commandDuration = 0;
int repetitions = 0; // Number of repetitions remaining
bool isOnPhase = true; // Indicates if currently in the on-phase of the cycle

void setup() {
  Serial.begin(9600);
  while (!Serial);

  pinMode(HI_PIN, OUTPUT);
  pinMode(LOW_PIN, OUTPUT);
  pinMode(LOW_PIN2, OUTPUT);
  pinMode(HI_PIN2, OUTPUT);
  pinMode(LOW_PIN3, OUTPUT);
  pinMode(HI_PIN3, OUTPUT);
  if (!BLE.begin()) {
    Serial.println("Starting BLE failed!");
    while (1);
  }

  BLE.setLocalName("LED");
  BLE.setAdvertisedService(ledService);

  ledService.addCharacteristic(commandCharacteristic);
  BLE.addService(ledService);
  BLE.advertise();

  Serial.println("BLE LED Peripheral Ready");
}

void loop() {
    BLEDevice central = BLE.central();
    if (central) {
        Serial.print("Connected to central: ");
        Serial.println(central.address());

        while (central.connected()) {
            if (commandCharacteristic.written()) {
                String value = commandCharacteristic.value();
                int commaIndex = value.indexOf(',');
                int secondCommaIndex = value.indexOf(',', commaIndex + 1);
                if (commaIndex != -1 && secondCommaIndex != -1) {
                    int command = value.substring(0, commaIndex).toInt();
                    unsigned long duration = value.substring(commaIndex + 1, secondCommaIndex).toInt();
                    repetitions = value.substring(secondCommaIndex + 1).toInt(); // Repetitions

                    Serial.print("command: ");
                    Serial.println(command);
                    Serial.print("duration: ");
                    Serial.println(duration);
                    Serial.print("repetitions: ");
                    Serial.println(repetitions);

                    executeCommand(command, duration, repetitions);
                }
            }

            if (commandActive != -1 && millis() - previousMillis >= commandDuration) {
              if (repetitions > 0) {
                  // Toggle pin state based on the phase and command
                  if (commandActive == 1 || commandActive == 3) {
                      // Robot 1 pins
                      digitalWrite(commandActive == 1 ? HI_PIN : LOW_PIN, isOnPhase ? HIGH : LOW);
                  } else if (commandActive == 4 || commandActive == 5) {
                      // Robot 2 pins
                      digitalWrite(commandActive == 4 ? HI_PIN2 : LOW_PIN2, isOnPhase ? HIGH : LOW);
                  } else if (commandActive == 6 || commandActive == 7) {
                      // Robot 3 pins
                      digitalWrite(commandActive == 6 ? HI_PIN3 : LOW_PIN3, isOnPhase ? HIGH : LOW);
                  }
                  isOnPhase = !isOnPhase; // Switch phase

                  // Only decrement repetitions after a full on/off cycle
                  if (!isOnPhase) { // This means we just finished an off phase, completing one cycle
                      repetitions--;
                  }

                  previousMillis = millis(); // Reset timer for the next phase
              } else if (!isOnPhase) { // Ensure we finish on an off phase
                  if (commandActive == 1 || commandActive == 3) {
                      // Robot 1 pins
                      digitalWrite(commandActive == 1 ? HI_PIN : LOW_PIN, LOW);
                  } else if (commandActive == 4 || commandActive == 5) {
                      // Robot 2 pins
                      digitalWrite(commandActive == 4 ? HI_PIN2 : LOW_PIN2, LOW);
                  }else if (commandActive == 6 || commandActive == 7) {
                      // Robot 3 pins
                      digitalWrite(commandActive == 6 ? HI_PIN3 : LOW_PIN3, LOW);
                  }
                  commandActive = -1; // Reset command to indicate no active command
              }
          }

        }

        if (!central.connected()) {
            Serial.print("Disconnected from central: ");
            Serial.println(central.address());
        }
    }
}

void executeCommand(int command, unsigned long duration, int rep) {
    repetitions = rep; 
    isOnPhase = true; 

    // Execute the command immediately
    switch (command) {
        case 0: digitalWrite(HI_PIN, LOW); break;
        case 1: digitalWrite(HI_PIN, HIGH); break;
        case 2: digitalWrite(LOW_PIN, LOW); break;
        case 3: digitalWrite(LOW_PIN, HIGH); break;
        case 4: digitalWrite(HI_PIN2, HIGH); break;
        case 5: digitalWrite(LOW_PIN2, HIGH); break;
        case 6: digitalWrite(HI_PIN3, HIGH); break;
        case 7: digitalWrite(LOW_PIN3, HIGH); break;
    }

    // For commands that require duration handling, set the active command and duration
    if (command == 1 || command == 3 || command == 4 || command == 5 || command == 6 || command == 7) {
        commandActive = command;
        commandDuration = duration ;
        previousMillis = millis(); // Capture the start time
    }
}


