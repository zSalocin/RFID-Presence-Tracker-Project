#include <ESP8266WiFi.h>
WiFiServer server(80);

void setup() {
  Serial.begin(115200);
  WiFi.softAP("ESP8266-Network", "password"); // Cria uma rede Wi-Fi
  server.begin(); // Inicia o servidor na porta 80
}

void loop() {
  WiFiClient client = server.available(); // Aguarda uma conexão
  if (client) {
    client.println("Hello, Flutter!"); // Envia dados para o cliente
    client.stop(); // Fecha a conexão
  }
}
