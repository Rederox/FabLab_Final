//g++ LecteurRFIDSimpleConsoleFiltreBug.cpp -lwiringPi

#include <string.h>
#include <errno.h>
#include <wiringPi.h>
#include <wiringSerial.h>
#include <iostream>
#include <unistd.h>
#include <sstream>
#include <iomanip>

using namespace std;

int main()
{

    int fd;
    unsigned int decimal;
    
    int times;
    string result;
    string hexaBadge;
    string temp;
    string formatDebutBadge = "70ee01";

    fd = serialOpen("/dev/ttyUSB0", 57600);

    if (fd < 0)
    {
        cout << "aucun appareil trouver";
        return 1;
    }

    if (wiringPiSetup() == -1)
    {
        cout << "wiringpi n'est pas configurer";
        return 1;
    }

    while(1)
    {

        sleep(1);

        while (times < 8){

            serialDataAvail(fd);
            times += 1;
            decimal = serialGetchar(fd);
            stringstream sstream;
            sstream << hex << decimal;
            result = sstream.str();
            hexaBadge = hexaBadge + result;
        }
        times = 0;
        if(hexaBadge.length() <= 12 && hexaBadge.substr(0,6).compare(formatDebutBadge) == 0){

          cout << "Badge reçu :" << hexaBadge <<endl;
          cout << "Longueur du message : " << hexaBadge.length()<<endl;
        }
        hexaBadge.clear();
    }
    serialFlush(fd);
}