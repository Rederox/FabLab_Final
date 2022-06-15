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
#include <ctime>

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

	
	char *wordchar;
	char *buf;
	int sockfd;
	char buffer[MAXLINE];
	int fd;
    unsigned int decimal;
    int times;
	bool detection = 0;  
	int size;

	time_t t1,t2;  
	double seconds=0;
	char tableau[13]={0};

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

		if(temp.compare(TestWord) == 0){			//réception mot pour valider l'initialisation de la communication 
			cout << "------------------------------"<<endl;
			cout << "Demande de badge reçu "<<endl;
			sendto(sockfd,"true",4,MSG_CONFIRM, (const struct sockaddr *) &cliaddr,len);		//envoie donnée de validation 
		}else if(temp.compare(BadgeWord) == 0){			//réception mot pour requête badge 
			cout << "En attente d'un badge ..."<<endl;	
			time(&t1);
			//----------------------Boucle-----------------------//
			while(detection != 1 && seconds<5){			//tant que le badge n'a pas été détecté et que le délai n'est pas dépassé

				if(serialDataAvail(fd) != 0){

					serialFlush(fd);
					while (times < 8){
						decimal = serialGetchar(fd);
						stringstream sstream;
						sstream << hex << decimal;
						result = sstream.str();
						hexaBadge = hexaBadge + result;
						times += 1;
					}
					times = 0;
				}
			/*	stringstream val;
				val << "70ee01"<<rand()%99+1<<"aa"<<rand()%99+1;
				hexaBadge = val.str();
			*/
				if(hexaBadge.length() <= 12 && hexaBadge.substr(0,6).compare(formatDebutBadge) == 0){

					cout << "Badge détecter :" << hexaBadge <<endl;
					cout << "Longueur du message : " << hexaBadge.length()<<endl;
					for(int a=0;a<hexaBadge.length();a++){
						tableau[a]=hexaBadge.at(a);
						size=a;
					}
					detection=1;
				}
				hexaBadge.clear();

				//serialFlush(fd);
				time(&t2);
				seconds = difftime(t2,t1);
				sleep(1);
				cout <<"Seconds : "<<seconds<<endl;
			}
			//--------------------Fin Boucle---------------------//

			if(detection == 0){
				hexaBadge="noTag";
				for(int a=0;a<hexaBadge.length();a++){
						tableau[a]=hexaBadge.at(a);
						size=a;
				}
			}else{
				detection=0;
			}

			seconds = 0;
			sendto(sockfd,tableau, size+1,MSG_CONFIRM, (const struct sockaddr *) &cliaddr,len);
			cout << "Données du badge envoyé"<<endl;
			
		}
		temp.clear();
	}
		return 0;
}

