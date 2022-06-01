// g++ -Wall -o function  function.cpp library/pn532.c library/pn532_rpi.c library/NFC.cpp library/UDP.cpp -lwiringPi -w

#include <iostream>
#include <string>
#include "library/NFC.hpp"
#include "library/UDP.hpp"

using namespace std;

int main()
{

    NFC nfc;

    while (1)
    {
        UDP udp;
        string msg = udp.readUDP(1024);
        cout << msg << endl;
        string *split;
        split = udp.splitString(msg, " ");

        int choix = stoi(split[0]);
        switch (choix)
        {
        case 1:
            cout << "Demande d'écrire" << endl;
            nfc.Delete();
            udp.writeUDP(nfc.Write(split[1]));
            break;

        case 2:
            cout << "Lire" << endl;
            udp.writeUDP(nfc.Read());
            break;

        case 3:
            cout << "Demande de Formater " << endl;
            udp.writeUDP(nfc.Delete());
            break;

        default:
            cout << "Veilleuz ressayer commande inconnue";
            break;
        }
    }
}
