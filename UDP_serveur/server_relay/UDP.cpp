#include "UDP.hpp"
#include <string.h>

UDP::UDP()
{
    if ((fdSocketUDP_ = socket(AF_INET, SOCK_DGRAM, 0)) < 0) // Create UDP socket
    {
        perror("Error - socket creation - udp.cpp");
        exit(EXIT_FAILURE);
    }

    memset(&ServerAddress_, 0, sizeof(ServerAddress_)); // Sets ServerAddress_ to 0
    memset(&ClientAddress_, 0, sizeof(ClientAddress_)); // Sets ClientAddress_ to 0

    ServerAddress_.sin_family = AF_INET;         // Address family, must be AF_INET = IPv4
    ServerAddress_.sin_port = htons(c_PORT);     // PORT number, convert PORT number to network byte order using htons()
    ServerAddress_.sin_addr.s_addr = INADDR_ANY; // IP-Address of host (server IP), INADDR_ANY gets this IP Address

    if (bind(fdSocketUDP_, (const struct sockaddr *)&ServerAddress_, sizeof(ServerAddress_)) < 0) // Bind the socket to ServerAddress_
    {
        perror("Error - socket bind - udp.cpp");
        exit(EXIT_FAILURE);
    }
}

UDP::~UDP()
{
    close(fdSocketUDP_); // Close socket
}

string UDP::readUDP(const int readSize)
{
    char readMsg[readSize] = {0}; // Read buffer
    ClientAddressLength_ = sizeof(ClientAddress_);

    if ((recvfrom(fdSocketUDP_, readMsg, readSize, 0, (struct sockaddr *)&ClientAddress_, (socklen_t *)&ClientAddressLength_)) < 0) // Receive data via UDP protocol
    {
        perror("Error - recvfrom - udp.cpp");
        exit(EXIT_FAILURE);
    }

    string str(readMsg);           // Convert char array to string
    str = str.substr(0, readSize); // Make sure the string is the length of readsize
    return str;
}

void UDP::writeUDP(string message)
{
    // Make char array
    int writeSize = message.size();
    char writeMsg[writeSize + 1] = {'\0'};

    // Convert string message to char array
    for (int i = 0; i < writeSize; i++)
    {
        writeMsg[i] = message[i];
    }

    if ((sendto(fdSocketUDP_, writeMsg, writeSize, 0, (const struct sockaddr *)&ClientAddress_, (socklen_t)ClientAddressLength_)) < 0) // Send data via UDP protocol
    {
        perror("Error - sendto - udp.cpp");
        exit(EXIT_FAILURE);
    }
}

string *UDP::splitString(string str, string delimiter)
{
    int i = 0;
    int start = 0;
    int end = str.find(delimiter);
    string *arg = new string[7];
    while (end != -1)
    {
        arg[i] = str.substr(start, end - start);
        i++;
        start = end + delimiter.size();
        end = str.find(delimiter, start);
    }
    arg[i] = str.substr(start, end - start);

    return arg;
}