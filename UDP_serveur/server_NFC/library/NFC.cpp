#include "pn532.h"
#include "pn532_rpi.h"
#include "NFC.hpp"

#include <iostream>
#include <cstring>
#include <string>
#include <iomanip>
using namespace std;
//------------------------------------------------------------------------- Fonctions Uint_8 to string(hexa) -------------------------------------------------------------------------
string NFC::uint8_to_hex_string(const uint8_t *v, const size_t s)
{

    stringstream ss;
    ss << hex << setfill('0');
    for (int i = 0; i < s; i++)
    {
        ss << hex << setw(2) << static_cast<int>(v[i]);
    }
    return ss.str();
}
//-------------------------------------------------------------------------- Fonctions Decimal to ASCII--------------------------------------------------------------------------------
string NFC::DecimalToASCII(string dec)
{
    string ascii = "";
    int decLen = dec.length();

    for (int i = 0; i < decLen; i += 3)
    {
        ascii += (char)std::stoi(dec.substr(i, 3));
    }

    return ascii;
}
//------------------------------------------------------------------------------------ Fonctions Write -----------------------------------------------------------------------------
string NFC::Write(string Serv_url)
{
    string answer = "L'url est ecrit sur le tag NFC";
    uint8_t uid[MIFARE_UID_MAX_LENGTH];

    PN532 pn532;
    // PN532_UART_Init(&pn532);
    PN532_I2C_Init(&pn532);
    PN532_SamConfiguration(&pn532);
    int32_t uid_len;
    while (1) // boucle verifier si il y a un  tag present
    {
        uid_len = PN532_ReadPassiveTarget(&pn532, uid, PN532_MIFARE_ISO14443A, 1000);
        if (uid_len == PN532_STATUS_ERROR)
        {
            answer = "Aucun tag trouvé !!";
            return answer;
        }
        else
        {
            break;
        }
    }

    uint8_t block_number = 3;
    uint8_t DATA[] = {0x00};

    int len_url = Serv_url.length() + 1;
    char URL[len_url];
    strcpy(URL, Serv_url.c_str()); // convertir string en char

    // declaration des variable pour les payload
    uint8_t decimal_url[len_url] = {0};
    uint8_t DATA_final[len_url / 3][4] = {0};

    //########################################################### prefixe url ########################################################################################
    uint8_t https[] = {0};
    uint8_t https_i249[] = {3, 0, 209, 1, 0, 85, 3};
    uint8_t https_s255[] = {3, 255, 1, 0, 193, 1, 0};
    uint8_t https_e250[] = {3, 255, 0, 255, 209, 1, 251}; // special
    uint8_t https_b251_254[] = {3, 255, 1, 0, 209, 1, 252};
    if (len_url <= 249) // prefixe
    {

        https_i249[1] = 5 + len_url - 1;
        https_i249[4] = 1 + len_url - 1;

        for (int i = 0; i < 7; i++)
        {
            https[i] = https_i249[i];
        }
    }
    else if (len_url - 1 > 484)
    {
        answer = "L'URL est trop grande";
        return answer;
    }
    else if (len_url - 1 >= 255)
    {
        https_s255[3] = len_url - 248 - 1;
        for (int i = 0; i < 7; i++)
        {
            https[i] = https_s255[i];
        }
    }
    else if (len_url - 1 == 250)
    {
        for (int i = 0; i < 7; i++)
        {
            https[i] = https_e250[i];
        }
    }
    else
    {
        int quatre = 0;
        quatre = len_url - 251 - 1;
        https_b251_254[3] = quatre;
        https_b251_254[6] = https_b251_254[6] + quatre;
        for (int i = 0; i < 7; i++)
        {
            https[i] = https_b251_254[i];
        }
    }

    //########################################################### prefixe url ########################################################################################

    //########################################################### length pair impair ########################################################################################
    int len = len_url + 1;

    int pair_impair;
    int block;

    pair_impair = len % 2;

    if (pair_impair == 0) // 0 = pair ; 1 = impair
    {
        block = (len / 4) + 2;
    }
    else
    {
        block = ((len - 1) / 4 + 1) + 3;
    }
    //########################################################### length pair impair ########################################################################################
    //########################################################### length  ########################################################################################
    for (int i = 0; i < len_url + 7; i++)
    {
        if (i < 7)
        {
            decimal_url[i] = https[i];
        }
        else
        {
            decimal_url[i] = (int)(URL[i - 7] - 0);
        }

        // printf("%d ",decimal_url[i]);
    }
    decimal_url[len_url + 7 - 1] = 254;

    //########################################################### remettre les reste a 0u  ########################################################################################
    for (int n = 0; n < 20; n++)
    {
        decimal_url[len_url + 7 + n + 1] = 0;
    }
    //########################################################### remettre les reste a 0u  ########################################################################################

    //######################################## passer d'un tableau a une dimension a double dimenseion  ###########################################################################
    int i = 0;

    for (int x = 0; x < block; x++)
    {
        for (int y = 0; y < 4; y++)
        {
            DATA_final[x][y] = decimal_url[i];
            i += 1;
            // printf("%d ",DATA_final[x][y]);
        }
        // printf("\n");
    }

    //######################################## passer d'un tableau a une dimension a double dimenseion  ###########################################################################
    //############################################## Envoyer les informations au tag block par block  #############################################################################
    while (1)
    {

        for (int x = 0; x < block; x++)
        {
            for (int y = 0; y < 4; y++)
            {
                DATA[y] = DATA_final[x][y];
                // printf("block %d : %d \n",x,DATA_final[x][y]);
                // printf("%d ", DATA[y]);
            }
            for (int i = 0; i < 4; i++)
            {
                block_number = block_number + 1;
                PN532_Ntag2xxWriteBlock(&pn532, DATA, block_number);
                break;
            }
            // printf("\n");
        }

        break;
    }
    //############################################## Envoyer les informations au tag block par block  #############################################################################
    return answer;
}

//------------------------------------------------------------------------------------ Fonctions Read -----------------------------------------------------------------------------
string NFC::Read()
{
    uint8_t buff[255];
    uint8_t uid[MIFARE_UID_MAX_LENGTH];
    uint32_t pn532_error = PN532_ERROR_NONE;
    int32_t uid_len = 0;

    string s_uid = "";

    PN532 pn532;
    PN532_I2C_Init(&pn532);
    // PN532_UART_Init(&pn532);
    PN532_SamConfiguration(&pn532);

    while (1) // boucle verifier si il y a un  tag present
    {
        uid_len = PN532_ReadPassiveTarget(&pn532, uid, PN532_MIFARE_ISO14443A, 1000);
        if (uid_len == PN532_STATUS_ERROR)
        {
            s_uid = "Aucun tag trouvé !!";
            return s_uid;
        }
        else
        {
            s_uid = uint8_to_hex_string(uid, uid_len);
            break;
        }
    }

    // lire les données
    int n = 0;
    uint8_t data[1000] = {0};
    string url_dec;
    for (uint8_t block_number = 0; block_number < 134; block_number++)
    {
        PN532_Ntag2xxReadBlock(&pn532, buff, block_number);

        // printf("%d: ", block_number);
        for (int i = 0; i < 4; i++)
        {
            data[n] = buff[i];
            n += 1;

            // printf("%02x ", buff[i]);
            //  cout << n << endl;
        }
        // printf("\r\n");
    }
    string url_ascii = "";
    // cout << "Uid de la tag est : " << s_uid << endl;
    for (int i = 23; i < 134; i++)
    {
        if (data[i] != 254 && data[i + 1] != 0)
        {
            // printf("%d ", data[i]);
            url_dec = to_string(data[i]);
            url_ascii = url_ascii + DecimalToASCII(url_dec);
        }
    }
    // string url_ascii = url_ascii + DecimalToASCII(data[i]);
    // return "UID : " + s_uid + "\n URL : " + url_ascii;
    return "<a>UID : " + s_uid + "</a> <br> <a> URL : " + url_ascii + "</a>";
}
//------------------------------------------------------------------------------------ Fonctions Delete ----------------------------------------------------------------------------
string NFC::Delete()
{

    uint8_t uid[MIFARE_UID_MAX_LENGTH];
    int32_t uid_len = 7;
    PN532 pn532;
    PN532_I2C_Init(&pn532);
    // PN532_UART_Init(&pn532);
    PN532_SamConfiguration(&pn532);
    uid_len = PN532_ReadPassiveTarget(&pn532, uid, PN532_MIFARE_ISO14443A, 1000);

    uint8_t block_number = 3;
    uint8_t DATA[] = {0x00};

    // int len_url = strlen(URL);

    uint8_t DATA_final[125][4] = {0};
    uint8_t vide[4] = {3, 0, 254, 0};

    for (int i = 0; i < 4; i++)
    {
        DATA_final[0][i] = vide[i];
        // printf("%d ", DATA_final[0][i]);
    }

    while (1)
    {

        for (int x = 0; x < 125; x++)
        {
            for (int y = 0; y < 4; y++)
            {
                DATA[y] = DATA_final[x][y];
            }
            for (int i = 0; i < 4; i++)
            {
                block_number = block_number + 1;
                PN532_Ntag2xxWriteBlock(&pn532, DATA, block_number);
                break;
            }
        }

        break;
    }
    string answer = "TagNFC est Formaté";
    return answer;
}