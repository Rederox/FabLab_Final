#ifndef NFC_HPP
#define NFC_HPP

#include <string>
#include <cstring>

using namespace std;

class NFC
{
public:
    string uint8_to_hex_string(const uint8_t *v, const size_t s);
    string DecimalToASCII(string dec);
    string Write(string Serv_url);
    string Read();
    string Delete();
};

#endif