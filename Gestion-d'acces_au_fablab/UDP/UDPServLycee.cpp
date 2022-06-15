// Server side implementation of UDP client-server model
// g++ UDPServ.cpp -lwiringPi -w -fpermissive
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <iostream>
#include <errno.h>
#include <wiringPi.h>
#include <wiringSerial.h>
#include <sstream>
#include <iomanip>

using namespace std;


#define PORT 25000
#define MAXLINE 1024

// Driver code
int main() {

	string TestWord = "test";
	string BadgeWord = "badgeRequest";
	string result;
    string hexaBadge;
    string formatDebutBadge = "70ee01";
	string temp;

	char *send;
	char *wordchar;
	char *buf;
	int sockfd;
	char buffer[MAXLINE];
	int fd;
    unsigned int decimal;
    int times;
	bool detection = 0;    

	struct sockaddr_in servaddr, cliaddr;

	cout << "Allumage du serveur UDP en cours ..."<<endl;
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
	// Creating socket file descriptor
	if ( (sockfd = socket(AF_INET, SOCK_DGRAM, 0)) < 0 ) {
		perror("socket creation failed");
		exit(EXIT_FAILURE);
	}
	
	memset(&servaddr, 0, sizeof(servaddr));
	memset(&cliaddr, 0, sizeof(cliaddr));
	
	// Filling server information
	servaddr.sin_family = AF_INET; // IPv4
	servaddr.sin_addr.s_addr = INADDR_ANY;
	servaddr.sin_port = htons(PORT);
	
	// Bind the socket with the server address
	if ( bind(sockfd, (const struct sockaddr *)&servaddr,
			sizeof(servaddr)) < 0 )
	{
		perror("bind failed");
		exit(EXIT_FAILURE);
	}

	int len, n;
	len = sizeof(cliaddr); //len is value/resuslt
	cout << "Serveur démarré"<<endl;
	while(1){

		//réception bloquant du client UDP
		n = recvfrom(sockfd, (char *)buffer, MAXLINE,MSG_WAITALL, ( struct sockaddr *) &cliaddr,&len);
		for(int t=0;t<n;t++){
			temp += buffer[t];
		}
		if(temp.compare(TestWord) == 0){
			send="true";
		}else if(temp.compare(BadgeWord) == 0){

			cout << "En attente d'un badge ..."<<endl;	
			while(detection != 1){

				while (times < 8){
					times += 1;
					decimal = serialGetchar(fd);
					stringstream sstream;
					sstream << hex << decimal;
					result = sstream.str();
					hexaBadge = hexaBadge + result;
				}
				times = 0;
				if(hexaBadge.length() <= 12 && hexaBadge.substr(0,6).compare(formatDebutBadge) == 0){

					cout << "Badge détecter :" << hexaBadge <<endl;
					cout << "Longueur du message : " << hexaBadge.length()<<endl;
					send=&hexaBadge[0];
					detection = 1;
				}
				serialFlush(fd);
			}
			detection = 0;
		}

		sendto(sockfd, (char *)send, strlen(send),MSG_CONFIRM, (const struct sockaddr *) &cliaddr,len);
		if(temp.compare(BadgeWord) == 0){
			cout << "Réponse envoyé : "<< send <<endl;
			hexaBadge.clear();
		}
		temp.clear();
		
	}
		return 0;
}

