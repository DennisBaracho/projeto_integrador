#include <neotimer.h> //Biblioteca que simplifica o Millis
#include <ServoTimer2.h> //Bilioteca do servomotor
#include <SoftwareSerial.h> //Biblioteca do bluetooth

SoftwareSerial bluetooth(1, 0);  // TX, RX (Bluetooth).
ServoTimer2 Vertical; //Iniciando servo vertical
ServoTimer2 Horizontal; //Iniciando servo horizontal

Neotimer enviar; //Iniciando temporizador de envio
Neotimer movimentar; //Iniciando temporizador de movimento

float tensao;
float potencia;

int ServoHorizontal = 1500;  //Estabelece valor fixo ao ServoHorizontal
int ServoVertical = 1500; //Estabelece valor fixo ao ServoVertical

void setup() {

  enviar.set(3000); //Definindo temporizador para 3 em 3 segundos
  movimentar.set(100); //Definindo temporizador para 0,1 em 0,1 segundos

  Vertical.attach(5); //Pino do servo vertical
  Horizontal.attach(3); //Pino do servo horizontal
  Vertical.write(1125); //Inicia com Servo vertical a 45 graus
  Horizontal.write(1500); //Inicia com Servo horizontal a 90 graus

  bluetooth.begin(9600); //Inicia o Bluetooth
}
void loop() {
  if (movimentar.repeat()) {
    //Leitura dos LDR's
    int LDS = analogRead(A3);
    int LES = analogRead(A2);
    int LDI = analogRead(A1);
    int LEI = analogRead(A0);

    int Superior = (LDS + LES) / 2;  // Média da leitura dos LDR superiores
    int Inferior = (LDI + LEI) / 2;  // Média da leitura dos LDR inferiores
    int Direita = (LDS + LDI) / 2;   // Média da leitura dos LDR da direita
    int Esquerda = (LES + LEI) / 2;  // Média da leitura dos LDR da esquerda

    int Sensibilidade = 50;
    // Realiza a leitura e executa os movimentos do Servo Vertical
    if (-1 * Sensibilidade > (Superior - Inferior) || (Superior - Inferior) > Sensibilidade) {
      if (Superior > Inferior) {
        ServoVertical = ServoVertical + 10;
        if (ServoVertical > 2250) {
          ServoVertical = 2250;
        }
      } else if (Inferior > Superior) {
        ServoVertical = ServoVertical - 10;
        if (ServoVertical < 750) {
          ServoVertical = 750;
        }
      }
      Vertical.write(ServoVertical);
    }
      // Realiza a leitura e executa os movimentos do Servo Horizontal
      if (-1 * Sensibilidade > (Direita - Esquerda) || (Direita - Esquerda) > Sensibilidade) {
        if (Direita > Esquerda) {
          ServoHorizontal = ServoHorizontal - 10;
          if (ServoHorizontal < 750) {
            ServoHorizontal = 750;
          }
        } else if (Direita < Esquerda) {
          ServoHorizontal = ServoHorizontal + 10;
          if (ServoHorizontal > 2250) {
            ServoHorizontal = 2250;
          }
        }
        Horizontal.write(ServoHorizontal);
      }
    
  }
    if (enviar.repeat()) { //Envio de dados de 3 em 3s.
      tensao = analogRead(A4) * 5 / 1023.0; //Lê a corrente na placa.
      potencia = (tensao*tensao)/26; //Cálculo da potência.
      bluetooth.print(potencia); //Envio do dado de potência.
    }
  
}