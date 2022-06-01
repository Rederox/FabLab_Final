#pragma once

#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h>
#include <string>

using namespace std;

/////GLOBAL CONSTANTS/////
const int c_PORT = 26000;

class UDP
{
private:
    int fdSocketUDP_;                  // File descriptor for UDP socket
    int ClientAddressLength_;          // Length of client address
    struct sockaddr_in ServerAddress_; // Struct handling internet address for server
    struct sockaddr_in ClientAddress_; // Struct handling internet address for client

public:
    UDP();                                             // Initialize and bind socket
    ~UDP();                                            // Close socket
    string readUDP(const int readSize);                // Read via UDP protocol
    void writeUDP(string message);                     // Write via UDP protocol
    string *splitString(string str, string delimiter); // Split string into array of strings
};