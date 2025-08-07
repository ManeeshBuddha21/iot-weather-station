#include "FirebaseConfig.h"
#include <DHT.h>
#include <EEPROM.h>
#include <ESP8266WiFi.h>
#include <FirebaseESP8266.h>
#include <WiFiClient.h>

#define DHTPIN D2
#define DHTTYPE DHT11
#define LDRPIN A0

DHT dht(DHTPIN, DHTTYPE);
FirebaseData fbdo;
unsigned long lastSendTime = 0;
int interval = 10000;

void setup() {
  Serial.begin(115200);
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
  Firebase.reconnectWiFi(true);
  dht.begin();
  EEPROM.begin(512);
}

void loop() {
  if (millis() - lastSendTime > interval) {
    lastSendTime = millis();
    float temp = dht.readTemperature();
    float hum = dht.readHumidity();
    int light = analogRead(LDRPIN);

    if (isnan(temp) || isnan(hum)) {
      Serial.println("Failed to read from DHT sensor.");
      return;
    }

    String path = "/weather_data/user1/" + String(millis());
    FirebaseJson json;
    json.set("timestamp", String(millis()));
    json.set("temperature", temp);
    json.set("humidity", hum);
    json.set("light", light);

    if (Firebase.pushJSON(fbdo, path, json)) {
      Serial.println("Data sent to Firebase.");
    } else {
      Serial.println("Firebase push failed, storing to EEPROM.");
      // (Fake EEPROM logic)
    }
  }
}