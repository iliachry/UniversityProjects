// Base Station 1

#include <SPI.h>
#include <RF22.h>
#include <RF22Router.h>

#define NODE1_ADDRESS 1 //arduino of light level
#define NODE2_ADDRESS 2 //parking space 1
#define NODE3_ADDRESS 3 //parking space 2
#define BASE_ADDRESS 6

#define NN 3 //Nodes Number

RF22Router rf22(BASE_ADDRESS);

boolean flag_neighbors = false;

char sendSize[] = "sendSize";
char sendData[] = "sendData";
char initNetwork[] = "initNetwork";

char data_char1[RF22_ROUTER_MAX_MESSAGE_LEN];
char data_char2[RF22_ROUTER_MAX_MESSAGE_LEN];
char data_char3[RF22_ROUTER_MAX_MESSAGE_LEN];
uint8_t sendSizeuint[RF22_ROUTER_MAX_MESSAGE_LEN];
uint8_t initNetworkuint[RF22_ROUTER_MAX_MESSAGE_LEN];
uint8_t sendDatauint[RF22_ROUTER_MAX_MESSAGE_LEN];

float frequency1 = 868.0;
float frequency2 = 890.0;
float current_frequency = frequency1;

int nodes[NN];  // boolean array for neighbor nodes (1=available, 0=not available)
int dataSize[NN]; // array containing data size each node needs to send
int threshold = 100; //difference between light and darkness

boolean networkCheck;
boolean timeCheck;

float bits_counter = 0;
float troughput = 0.0;

float startTime, currTime;
float networkTime=0.0;
float startFreqTime;

float totalPackagesSent = 0;
float totalPackagesFailed = 0;
float totalPackages = 0;
float grandTotalPackagesSent = 0;
float grandTotalPackagesFailed = 0;
float throughput = 0;


int max_retries = 1;
int max_response_time = 300;
float timeLimit = 120000.0;
float maxFreqTime = 100000;
float measurements_time = 30000.0;
float current_time = 0.0;

void setup()
{
  //our leds are there
  pinMode (3,OUTPUT);
  pinMode (4,OUTPUT);
  digitalWrite(3, LOW);
  digitalWrite(4, LOW);
  memset(data_char1, '\0', RF22_ROUTER_MAX_MESSAGE_LEN);
  memset(data_char2, '\0', RF22_ROUTER_MAX_MESSAGE_LEN);
  memset(data_char3, '\0', RF22_ROUTER_MAX_MESSAGE_LEN);

  memset(sendSizeuint, '\0', RF22_ROUTER_MAX_MESSAGE_LEN);
  memset(initNetworkuint, '\0', RF22_ROUTER_MAX_MESSAGE_LEN);
  memset(sendDatauint, '\0', RF22_ROUTER_MAX_MESSAGE_LEN);

  sprintf(data_char1, "%s", sendSize);
  data_char1[RF22_ROUTER_MAX_MESSAGE_LEN - 1] = '\0';
  memcpy(sendSizeuint, data_char1, RF22_ROUTER_MAX_MESSAGE_LEN);

  sprintf(data_char2, "%s", sendData);
  data_char2[RF22_ROUTER_MAX_MESSAGE_LEN - 1] = '\0';
  memcpy(sendDatauint, data_char2, RF22_ROUTER_MAX_MESSAGE_LEN);

  sprintf(data_char3, "%s", initNetwork);
  data_char3[RF22_ROUTER_MAX_MESSAGE_LEN - 1] = '\0';
  memcpy(initNetworkuint, data_char3, RF22_ROUTER_MAX_MESSAGE_LEN);

  rf22.addRouteTo(NODE1_ADDRESS, NODE1_ADDRESS);
  rf22.addRouteTo(NODE2_ADDRESS, NODE2_ADDRESS);
  rf22.addRouteTo(NODE3_ADDRESS, NODE3_ADDRESS);

  Serial.begin(9600);

  // Addressed rf22 init
  if (  !rf22.init()  )
    Serial.println("rf22 init failed");
  if (  !rf22.setFrequency(frequency1)  )
    Serial.println("rf22 setFrequency failed");
  rf22.setTxPower(RF22_TXPOW_17DBM);
  rf22.setModemConfig(RF22::FSK_Rb125Fd125);
  for (int i = 0; i < NN; i++)
    nodes[i] = 0;

  createNetwork();
  networkTime=millis();
  startTime = millis();

}//setup()

void loop()
{
  startFreqTime = millis();
  // Apart from controlling whether I have any neighbors, I also count for how long none responds to my messages. If that
  // happens for a very long time I must change frequency and seek for my nodes there
  while (!flag_neighbors)
  {
    createNetwork();
    networkTime=millis();
    startTime = millis();
    currTime = millis();
    if ((currTime - startFreqTime) > maxFreqTime)
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
  }

  uint8_t buf[RF22_ROUTER_MAX_MESSAGE_LEN];
  uint8_t len = sizeof(buf);
  uint8_t from;
  char incoming[RF22_ROUTER_MAX_MESSAGE_LEN];
  memset(buf, '\0', RF22_ROUTER_MAX_MESSAGE_LEN);
  memset(incoming, '\0', RF22_ROUTER_MAX_MESSAGE_LEN);
  int light[3];
  int temp = 0;
  

  //arxikopoihsh pinaka me stoixeia ton arithmo twn paketωn tou pinaka pou tha steilei o komvos
  for  (  int i = 0;  i < NN; i++  )
  {
    if ( nodes[i] )
    {
      light[i]=0;
      if ( rf22.sendtoWait(sendDatauint, sizeof(sendDatauint), i) != RF22_ROUTER_ERROR_NONE)
      {
        Serial.println("Send Failed due to RF22_ROUTER_ERROR_NONE");
      }
      else
      {
        Serial.println((char*)sendDatauint);

        boolean flag_comm = true;
        int comm_counter = 0;
        while (flag_comm)
        {
          comm_counter++;
          // Whatever is received is stored in the variable "incoming"
          if (rf22.recvfromAckTimeout(buf, &len, max_response_time, &from))
          {
            bits_counter = bits_counter + 8 * sizeof(buf);
            memcpy(incoming, buf, RF22_ROUTER_MAX_MESSAGE_LEN);
          }
          // If nothins is received, it means that communications is over the stream is transmitted
          else
          {
            if (abs(dataSize[i] + 2 - comm_counter) > 0)
              totalPackagesFailed += 1;

            flag_comm = false;
            Serial.print("No more data from Node: ");
            Serial.println(i);
            light[i]=light[i]/5; //mean value
          }
          // if it is the first data that is received, I know it's ths number of packets
          if (comm_counter == 1)
          {
            dataSize[i] = atoi((char*)incoming);
            Serial.print("Starting receiving ");
            Serial.print(dataSize[i]);
            Serial.print(" packages from Node ");
            Serial.println(i);
          }
          // Time to receive the actual data and plot them...
          else
          {
        	temp = atoi((char*)incoming); //similar to line 185 to get value from received data, maybe useless conversion as already char
			light[i]=light[i]+temp; //summing
            Serial.println((float)atoi(incoming), 2);
//            totalPackagesSent += 1;
          }

        }//while
      }

    }
  }
  
  
  //Leds open-close process - IMPORTANT: CHECK PROPER IF STATEMENTS
  if (light[2]-light[1]>threshold){
  	digitalWrite(3, HIGH);
  }
  else
  {
  	digitalWrite(3, LOW);
  }
  
  if (light[3]-light[1]>threshold){
  	digitalWrite(4, HIGH);
  }
  else
  {
  	digitalWrite(4, LOW);
  }

//  totalPackages += totalPackagesSent + totalPackagesFailed;


  current_time = millis() - startTime;
  if (current_time > measurements_time) {
    throughput = bits_counter * 1000.0 / (float)current_time;
    Serial.println("Measurements...........................");
    Serial.print("Total Data Throughput: ");
    Serial.print(throughput);
    Serial.println(" bits per second");
    float failed_pack = totalPackagesFailed * 1000.0 / (float)current_time;
    Serial.print("Failed packages per second: ");
    Serial.println(failed_pack);
    bits_counter = 0 ;
    totalPackagesFailed = 0;
    startTime = millis();
    //   throughput=0;
    //   failed_pack=0;

  }




  timeCheck = (millis() - networkTime) >= timeLimit;
  if (  timeCheck) {
    Serial.println("TIME LIMIT REACHED FOR NEW NETWORK...");
//    Serial.print("Packages Sent = ");
//    Serial.println(totalPackagesSent);
//    Serial.print("Packages Failed = ");
//    Serial.println(totalPackagesFailed);
 //   Serial.print("Total Packages = ");
//    Serial.println(totalPackages);

//    throughput = (float)totalPackagesSent / ((millis() - (float)startTime) / 1000.0); // Packages / Second
//    Serial.print("Throughput: ");
//    Serial.print(throughput, 4);
//    Serial.println(" Packages/Second");

    Serial.println("RESET...");
    for (int i = 0; i < NN; i++)
      nodes[i] = 0;
 //   throughput = 0;
 //   grandTotalPackagesSent += totalPackagesSent;
 //   grandTotalPackagesFailed += totalPackagesFailed;
 //   totalPackagesSent = 0;
 //   totalPackagesFailed = 0;

    Serial.println("RECREATING NETWORK...");
    createNetwork();
    networkTime=millis();
    startTime = millis();
  }
}//loop

void createNetwork() {
  flag_neighbors = false;
  for (int i = 0; i < NN; i++)
    nodes[i] = 0;

  // Checks which neighbors can communicate with current BS
  for (int i = 0; i < NN; i++)
  {
    for (int counter = 0; counter < max_retries; counter++)
    {
      if (nodes[i] == 1)
        continue;

      if ( rf22.sendtoWait(initNetworkuint, sizeof(initNetworkuint), i) != RF22_ROUTER_ERROR_NONE)
      {
        Serial.println("Send Failed due to RF22_ROUTER_ERROR_NONE");
      }
      else
      {
        Serial.println((char*)initNetworkuint);
        flag_neighbors = true;
        Serial.print("BS ");
        Serial.print(BASE_ADDRESS);
        Serial.print(" successfully connected with Node ");
        Serial.print(i);
        Serial.print(" @ ");
        Serial.print(current_frequency);
        Serial.println(" MHz");
        nodes[i] = 1;


        /*
                uint8_t buf[RF22_ROUTER_MAX_MESSAGE_LEN];
                uint8_t len = sizeof(buf);
                uint8_t from;
                if (rf22.recvfromAckTimeout(buf, &len, max_response_time, &from))
                {
                  flag_neighbors = true;
                  Serial.print("BS ");
                  Serial.print(BASE_ADDRESS);
                  Serial.print(" successfully connected with Node ");
                  Serial.print(i);
                  Serial.print(" @ ");
                  Serial.print(current_frequency);
                  Serial.println(" MHz");
                  nodes[i] = 1;
                }
                else
                {
                  Serial.print("BS");
                  Serial.print(BASE_ADDRESS);
                  Serial.print("failed to connect with Node: ");
                  Serial.println(i);
                }
                */
      }
    }
  }
  Serial.println("Network Created!");
} //createNetwork()
















