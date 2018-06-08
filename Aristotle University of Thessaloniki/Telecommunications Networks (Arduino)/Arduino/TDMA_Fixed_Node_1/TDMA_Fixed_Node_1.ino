#include <SPI.h>
#include <RF22.h>
#include <RF22Router.h>

#define SOURCE_ADDRESS 1
#define BASE_ADDRESS6 6

RF22Router rf22(SOURCE_ADDRESS);

float frequency1 = 868.0;
float frequency2 = 890.0;
float current_frequency = frequency1;


//--- Maybe unused
char inData[RF22_ROUTER_MAX_MESSAGE_LEN]; // Allocate some space for the string
char inChar; // Where to store the character read
byte index = 0; // Index into array; where to store the character
char freq[RF22_ROUTER_MAX_MESSAGE_LEN];
char inputpower[RF22_ROUTER_MAX_MESSAGE_LEN];
char freq_change[RF22_ROUTER_MAX_MESSAGE_LEN];
char baseaddr[RF22_ROUTER_MAX_MESSAGE_LEN];
uint8_t rssi;
float Pr = -90;
const int sensorPin = A0;  // named constant for the pin the sensor is connected to
//---

//char sendSize[]="sendSize";
char sendData[] = "sendData";
char initNetwork[] = "initNetwork";

int sending_interval = 1;
int maxrecvTime = 300;
int maxFreqTime = 100000;
float measurement_time=30000;

unsigned long wtStart = 0, wtStop = 0; //waiting time
unsigned long averageWT = 0;
int loopCounter = 0;

void setup()
{
  rf22.addRouteTo(BASE_ADDRESS6, BASE_ADDRESS6);
  Serial.begin(9600);
  if (!rf22.init())
    Serial.println("RF22 init failed");
  // Defaults after init are 434.0MHz, 0.05MHz AFC pull-in, modulation FSK_Rb2_4Fd36
  if (!rf22.setFrequency(frequency1))
    Serial.println("change frequency");
  rf22.setTxPower(RF22_TXPOW_17DBM);
  //1,2,5,8,11,14,17,20 DBM
  rf22.setModemConfig(RF22::FSK_Rb125Fd125);
  //modulation
  wtStart = millis();
}//setup


void loop()
{
  loopCounter++;

  uint8_t buf[RF22_ROUTER_MAX_MESSAGE_LEN];
  uint8_t len = sizeof(buf);
  uint8_t from;
  int measurements = 5;
  boolean flag_comm = false;

  if (rf22.recvfromAckTimeout(buf, &len, maxFreqTime, &from))
  {
    flag_comm = true;
    
    wtStop = millis();
    Serial.print("Node ");
    Serial.print(SOURCE_ADDRESS);
    Serial.print(" waited for ");
    Serial.print(((float)(wtStop - wtStart)) / 1000.0);
    Serial.println(" seconds");
 //   if (loopCounter > 1)
 //   {
 //     averageWT += (wtStop - wtStart) / 1000;
 //     averageWT /= loopCounter; //Τι νίντζα κίνηση ήταν αυτή ρε, τρελάθηκα!
 //   }
    
    Serial.println((char*)buf);
    Serial.print("got request from : ");
    Serial.println(from, DEC);
    if ((strcmp((char*)buf, initNetwork) == 0))
    {
      //rf22.sendtoWait(buf, sizeof(buf), from);
      Serial.println("I have just responded to sender");
    }
    else
    {
      if ((strcmp((char*)buf, sendData) == 0))
        Serial.println("I am requested to send data");
              
      char data_read[RF22_ROUTER_MAX_MESSAGE_LEN];
	  uint8_t data_send[RF22_ROUTER_MAX_MESSAGE_LEN];
      memset(data_read, '\0', RF22_ROUTER_MAX_MESSAGE_LEN);
      memset(data_send, '\0', RF22_ROUTER_MAX_MESSAGE_LEN);
      sprintf(data_read, "%d", measurements);
      measurements = atoi(data_read);
      Serial.println(measurements);
      data_read[RF22_ROUTER_MAX_MESSAGE_LEN - 1] = '\0';
      memcpy(data_send, data_read, RF22_ROUTER_MAX_MESSAGE_LEN);// αντιγράφω τα data (διεύθυνση μνήμης) στη μεταβλητή που θα στείλω
  
      if ( rf22.sendtoWait(data_send, sizeof(data_send), from) != RF22_ROUTER_ERROR_NONE)
      {
        Serial.println("Send Failed due to RF22_ROUTER_ERROR_NONE");
      }
      else
      {
        Serial.println("Succesfully Sent Size of My Data");
      }
      for (int sz = 0; sz < measurements; sz++)
      {
        delay(sending_interval);
  
        int light = analogRead(sensorPin);
        char data_read[RF22_ROUTER_MAX_MESSAGE_LEN];
        uint8_t data_send[RF22_ROUTER_MAX_MESSAGE_LEN];
        memset(data_read, '\0', RF22_ROUTER_MAX_MESSAGE_LEN);
        memset(data_send, '\0', RF22_ROUTER_MAX_MESSAGE_LEN);
        sprintf(data_read, "%d", measurements);
        measurements = atoi(data_read);
        //Serial.println(measurements);
        data_read[RF22_ROUTER_MAX_MESSAGE_LEN - 1] = '\0';
        //memcpy(data_send, data_read, RF22_ROUTER_MAX_MESSAGE_LEN);
  
        char light2[RF22_ROUTER_MAX_MESSAGE_LEN];
        memset(light2, '\0', RF22_ROUTER_MAX_MESSAGE_LEN);
        sprintf(light2, "%d", light);
  
        memcpy(data_send, light2, RF22_ROUTER_MAX_MESSAGE_LEN);
        if ( rf22.sendtoWait(data_send, sizeof(data_send), from) != RF22_ROUTER_ERROR_NONE)
        {
          Serial.println("Send Failed due to RF22_ROUTER_ERROR_NONE");
        }
        else
        {
          Serial.print("Succesfully Sent packet number ");
          Serial.println(sz);
        }
      }//for
    }
    wtStart = millis();
  }//if 2
  else
  {
    if (current_frequency == frequency1)
    {
      if (  !rf22.setFrequency(frequency2)  )
        Serial.println("rf22 setFrequency failed");
      else
        current_frequency = frequency2;
    }
    else
    {
      if (  !rf22.setFrequency(frequency1)  )
        Serial.println("rf22 setFrequency failed");
      else
        current_frequency = frequency1;
    }
  }

}//loop

