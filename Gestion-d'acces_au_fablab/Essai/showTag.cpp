// g++ showTag.cpp RaspLCDDriver-master/lcdDriver.cpp RaspLCDDriver-master/i2cControl.cpp -o output -lwiringPi -w

#include <iostream>
#include <string.h>
#include <errno.h>
#include <wiringPi.h>
#include <wiringSerial.h>
#include <unistd.h>
#include <sstream>
#include <iomanip>

#include "RaspLCDDriver-master/i2cControl.hpp"
#include "RaspLCDDriver-master/lcdDriver.hpp"
#define lcdAdd 0x27 // I2C device address


using namespace std;


int main(int argc, char const *argv[])
{
    int fd;
    unsigned int nextTime;
    unsigned int decimal; 
    char hexa;
    int times; 
    string result;
    string hexaBadge;
    string temp; 
    string formatDebutBadge = "70ee01";
    char affichage[16];


    //    -> Création des variables utiles à la connexion

    I2cControl *i2c = new I2cControl(1); //Using software i2c
        LcdDriver lcd(lcdAdd, i2c);
    //   -> Génération de la structure des informations pour la connexion

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
        times = 0;
        lcd.clearDisplayClearMem();
        lcd.lcdSendCommand(LCD_BEG_LINE_1);
        lcd.setCursorPositionRowCol(1,7);
        lcd.lcdString("Bonjour, ");
        lcd.setCursorPositionRowCol(2,1);
        lcd.lcdString("Veuillez presenter");
        lcd.setCursorPositionRowCol(3,4);
        lcd.lcdString("votre badge");
        
        while (times < 8){

            serialDataAvail(fd);
            times += 1;
            decimal = serialGetchar(fd);
            stringstream sstream;
            sstream << hex << decimal;
            result = sstream.str();
            hexaBadge = hexaBadge + result;
        }
        if(hexaBadge != temp && hexaBadge.length() <= 12 && hexaBadge.substr(0,6).compare(formatDebutBadge) == 0){

            lcd.clearDisplayClearMem();
            lcd.lcdSendCommand(LCD_BEG_LINE_1);
            lcd.setCursorPositionRowCol(1,0);
            lcd.lcdString("ID du Badge :");
            lcd.setCursorPositionRowCol(3,2);
            strcpy(affichage,hexaBadge.c_str());
            lcd.lcdString(affichage);
            sleep(5);
        }
        
        
        hexaBadge.clear();
        serialFlush(fd);
    }
    lcd.clearDisplayClearMem();
    delete i2c;
    return 0;
    
}