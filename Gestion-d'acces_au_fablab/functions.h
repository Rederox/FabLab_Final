#include <iostream>

#include <string.h>
#include <iomanip>
#include "Classes/I2C/i2cControl.hpp"
#include "Classes/LCD/lcdDriver.hpp"

/*
#include <wiringPi.h>
#include <wiringSerial.h>
#include <mariadb/mysql.h> 
#include <sstream>
#include <unistd.h>
*/

using namespace std;

void AffichageEntreSortie(LcdDriver lcd, bool etat, string prenom){

    int postStartName=10-(prenom.length()/2);
    lcd.clearDisplayClearMem();
    if(etat == 0){
    lcd.setCursorPositionRowCol(2,5);
    lcd.lcdString("Bonjour");
    lcd.setCursorPositionRowCol(3,postStartName);
    lcd.lcdString(prenom.c_str());
    }else{
    lcd.setCursorPositionRowCol(2,4);
    lcd.lcdString("Au revoir");
    lcd.setCursorPositionRowCol(3,postStartName);
    lcd.lcdString(prenom.c_str());
    }
    
}
void PresenterBadge(LcdDriver lcd){

    lcd.lcdSendCommand(LCD_BEG_LINE_1);
    lcd.setCursorPositionRowCol(1,7);
    lcd.lcdString("Bonjour, ");
    lcd.setCursorPositionRowCol(2,1);
    lcd.lcdString("Veuillez presenter");
    lcd.setCursorPositionRowCol(3,4);
    lcd.lcdString("votre badge");
    
}
void DemarrageSysteme(LcdDriver lcd){

    lcd.lcdSendCommand(LCD_BEG_LINE_1);
    lcd.setCursorPositionRowCol(2,0);
    lcd.lcdString("Demarrage du");
    lcd.setCursorPositionRowCol(3,0);
    lcd.lcdString("systeme en cours...");
    
}
