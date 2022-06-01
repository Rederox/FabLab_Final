// g++ -Wall -o main  main.cpp UDP.cpp RELAY.cpp -w -lwiringPi

#include "UDP.hpp"
#include "RELAY.hpp"
#include <string>
#include <iostream>
using namespace std;

int main()
{
    RELAY relay;
    while (1)
    {
        UDP udp;
        string msg = udp.readUDP(1024);
        cout << msg << endl;
        string *split;
        split = udp.splitString(msg, " ");

        udp.writeUDP(relay.allumer_eteindre(split[0], split[1]));
    }
}