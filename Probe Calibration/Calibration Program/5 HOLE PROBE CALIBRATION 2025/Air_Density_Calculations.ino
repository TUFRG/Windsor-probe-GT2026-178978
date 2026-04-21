#include <Wire.h>
#include <SPI.h>
#include <Adafruit_BMP280.h>
#include "DHT.h"

// Pin Definitions for BMP280 SPI
#define BMP_SCK  (13)
#define BMP_MISO (12)
#define BMP_MOSI (11)
#define BMP_CS   (10)

// DHT11 Sensor Pin and Type
#define DHTPIN 2
#define DHTTYPE DHT11

// Constants for air density calculation
const float Rd = 287.05;  // Specific gas constant for dry air (J/(kg·K))
const float Rv = 461.5;   // Specific gas constant for water vapor (J/(kg·K))

// Create instances of BMP280 and DHT11
Adafruit_BMP280 bmp(BMP_CS, BMP_MOSI, BMP_MISO, BMP_SCK);
DHT dht(DHTPIN, DHTTYPE);

void setup() {
  Serial.begin(9600);
  
  // Initialize BMP280
  if (!bmp.begin()) {
    Serial.println(F("Could not find a valid BMP280 sensor, check wiring!"));
    while (1) delay(10);
  }

  // Initialize DHT11
  dht.begin();

  // Set BMP280 sampling parameters
  bmp.setSampling(Adafruit_BMP280::MODE_NORMAL,     // Operating Mode
                  Adafruit_BMP280::SAMPLING_X2,     // Temp. oversampling
                  Adafruit_BMP280::SAMPLING_X16,    // Pressure oversampling
                  Adafruit_BMP280::FILTER_X16,      // Filtering
                  Adafruit_BMP280::STANDBY_MS_500); // Standby time
}

void loop() {
  // Read temperature from BMP280
  float bmpTemperatureC = bmp.readTemperature();
  float bmpTemperatureK = bmpTemperatureC + 273.15; // Convert to Kelvin
  
  // Read pressure from BMP280
  float pressure = bmp.readPressure(); // in Pa

  // Read humidity from DHT11
  float humidity = dht.readHumidity();

  // Check if DHT11 reading failed
  if (isnan(humidity)) {
    Serial.println("Failed to read from DHT sensor!");
  } else {
    // Calculate saturation vapor pressure (e_s) in hPa
    float es = 6.1078 * pow(10, (17.27 * bmpTemperatureC) / (bmpTemperatureC + 237.3));

    // Calculate actual vapor pressure (p_v) in Pa
    float pv = es * (humidity / 100.0) * 100; // Convert from hPa to Pa

    // Calculate partial pressure of dry air (p_d) in Pa
    float pd = pressure - pv;

    // Calculate air density (rho) in kg/m^3
    float airDensity = (pd / (Rd * bmpTemperatureK)) + (pv / (Rv * bmpTemperatureK));

    // Send data as a CSV line: "Temperature,Humidity,Pressure,AirDensity"
    //Serial.print(bmpTemperatureC);
    //Serial.print(",");
    //Serial.print(humidity);
    //Serial.print(",");
    //Serial.print(pressure);
    //Serial.print(",");
    Serial.println(airDensity);

    // Delay to achieve 0.5 Hz (2 seconds)
    delay(2000);
  }
}
