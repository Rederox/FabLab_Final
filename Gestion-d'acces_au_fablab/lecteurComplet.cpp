//g++ lecteurComplet.cpp Classes/LCD/lcdDriver.cpp Classes/I2C/i2cControl.cpp Classes/BDD/bdd.cpp functions.h -o output -L/usr/include/mariadb/mysql -lmariadbclient -lwiringPi -w

#include <iostream>
#include <mariadb/mysql.h> 
#include <string.h>
#include <errno.h>
#include <wiringPi.h>
#include <wiringSerial.h>
#include <unistd.h>
#include <sstream>
#include <iomanip>

#include "Classes/I2C/i2cControl.hpp"
#include "Classes/LCD/lcdDriver.hpp"
#include "Classes/BDD/bdd.hpp"
#include "functions.h"

#define lcdAdd 0x27 // I2C device address

using namespace std;

int main(int argc, char const *argv[])
{
    //Déclaration des variables
    int fd=0;
    int decimal=0; 
    int times=0;
    int ID=0;
    int comptabilisation=0;
    int relais=0;

    bool reconnaissance=0;
    bool validation=0;

    int nombrePersonneMax=3; //4    Nombre de personne max a admettre dans le fablab, nombre 3 signifie 4 personne max

    string result;
    string hexaBadge;
    string formatDebutBadge = "70ee01";
    string nom;
    string prenom;
    string presence;
    string presenceTotal;
    string AffichagePrenom;
    
    MYSQL_ROW row;	// Variable contenant les réponses SQL sous forme de tableau
    
    //Initialisation wiring pi et paramètrage du relais
    wiringPiSetup();
    pinMode(relais,OUTPUT);
    
    // Initialisation de l'écran LCD en I2C et affichage démarrage
    I2cControl *i2c = new I2cControl(1); 
    LcdDriver lcd(lcdAdd, i2c);
    lcd.clearDisplayClearMem();
    DemarrageSysteme(lcd);

    //  Instance base de données
    bdd ServeurFablab("192.168.3.83","fablab","Fablab.123admin","fablab");
    ServeurFablab.showInfo();
    ServeurFablab.connexion();
    fd = serialOpen("/dev/ttyUSB0", 57600);

    if (fd < 0){
        cout << "aucun appareil trouver";
        return 1;
    }

    if (wiringPiSetup() == -1){
        cout << "wiringpi n'est pas configurer";
        return 1;
    }

    cout <<"Système démarré"<<endl;

    while(1)
    {
    if(validation == 0){
       // sleep(1);
       lcd.clearDisplayClearMem();
        PresenterBadge(lcd);
        
        while (times < 8){
          //  serialDataAvail(fd);
            decimal = serialGetchar(fd);
            stringstream sstream;
            sstream << hex << decimal;
            result = sstream.str();
            hexaBadge = hexaBadge + result;
            times += 1;
        }
        times = 0;
    }
        if(hexaBadge.length() <= 12 && hexaBadge.substr(0,6).compare(formatDebutBadge) == 0){   //Vérification de la conformité de l'ID du badge reçu

          validation=1;
            cout << "Badge reçu :" << hexaBadge <<endl;
            cout << "Vérification dans la base de données...."<<endl;

           MYSQL_RES *res = ServeurFablab.requete("select * from inscrit;");    // Récupération tableau BDD

                while ((row = mysql_fetch_row(res)) != NULL){
            
                if(hexaBadge.compare(row[3])== 0){ // Comparaison entre la lecture RFID et les tags RFID présent dans la base de données
                    reconnaissance=1;
                    ID = strtol(row[0],NULL,10);
                    nom = row[1];
                    prenom = row[2];
                    presence = row[6];
                }

                //Comptabilisation total des personnes présentes dans le FABLAB
                presenceTotal = row[6];             
                if(presenceTotal.compare("1") == 0){        
                    comptabilisation+=1;
                }}

                cout << "Personne : " << prenom <<endl;
                mysql_free_result(res);// clean up the database result
                    
                // Tests pour aurotisation / refus d'accès au FABLAB    
                if(reconnaissance == 1 && comptabilisation <=3 && presence.compare("0") == 0){
                    ServeurFablab.resetTime(ID);
                    ServeurFablab.presenceUpdate(1,ID);
                    ServeurFablab.setTimeUser(0,ID);
                    ServeurFablab.setDay(ID);
                    AffichageEntreSortie(lcd,0,prenom);
                    digitalWrite(relais,1);
                    sleep(3);
                    digitalWrite(relais,0);
                    lcd.clearDisplayClearMem();
                    comptabilisation++;

                }else if(reconnaissance == 1 && presence.compare("1") == 0){

                    ServeurFablab.presenceUpdate(0,ID);
                    ServeurFablab.setTimeUser(1,ID);
                    ServeurFablab.calculTimeSpend(ID);
                    AffichageEntreSortie(lcd,1,prenom);
                    digitalWrite(relais,1);
                    sleep(3);
                    digitalWrite(relais,0);
                    lcd.clearDisplayClearMem();
                    comptabilisation--;

                }else if(reconnaissance == 1 && comptabilisation>=nombrePersonneMax ){
                        
                    lcd.clearDisplayClearMem();
                    lcd.setCursorPositionRowCol(1,0);
                    lcd.lcdString("FABLAB plein");
                    sleep(2);
                    lcd.clearDisplayClearMem();
                    
                }else if(reconnaissance == 0){
                    lcd.clearDisplayClearMem();
                    lcd.setCursorPositionRowCol(1,0);
                    lcd.lcdString("Entrer refuser");
                    sleep(2);
                    lcd.clearDisplayClearMem();
                }
                cout << "Comptage : "<< comptabilisation << endl;
        }
        //Vidage des données
        reconnaissance = 0;
        hexaBadge.clear();
        serialFlush(fd);
        validation=0;
        comptabilisation = 0;
    }
    delete i2c;
    return 0;
    
}