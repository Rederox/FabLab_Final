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
	string test;

	char *send;
	char *wordchar;
	char *buf;
	int sockfd;
	char buffer[MAXLINE];
	int fd;
    unsigned int decimal;
    int times;
	bool detection = 0;  
	int randomNum;
	char tableau[13]={0};
	int size;

	struct sockaddr_in servaddr, cliaddr;

	cout << "Allumage du serveur UDP en cours ..."<<endl;
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
		cout << "Requête reçu"<<endl;
		if(temp.compare(TestWord) == 0){
			sendto(sockfd,"true", 4,MSG_CONFIRM, (const struct sockaddr *) &cliaddr,len);
		}else if(temp.compare(BadgeWord) == 0){

			cout << "En attente d'un badge ..."<<endl;	
			stringstream val;
			val << "70ee01"<<rand()%99+1<<"aa"<<rand()%99+1;
			test = val.str();
			for(int a=0;a<test.length();a++){
					tableau[a]=test.at(a);
					size=a;
			}
			val.clear();
			cout <<"Test :"<<tableau<<endl;
			sendto(sockfd,tableau, size+1,MSG_CONFIRM, (const struct sockaddr *) &cliaddr,len);
		}
		
		test.clear();
		temp.clear();
		
	}
		return 0;
}

