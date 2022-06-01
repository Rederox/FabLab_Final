#include "RELAY.hpp"
#include <string.h>

string RELAY::allumer_eteindre(string port, string etat)
{
    wiringPiSetup();
    pinMode(stoi(port), OUTPUT);
    if (etat == "1")
    {
        digitalWrite(stoi(port), HIGH);
        return "allumer";
    }
    else
    {
        digitalWrite(stoi(port), LOW);
        return "etient";
    }
}