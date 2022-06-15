#include <mariadb/mysql.h>
#include <iostream>
#include <string.h>
#include "bdd.hpp"
#include <sstream>
#include <ctime>

using namespace std;

void bdd::connexion(){
    MYSQL *essai = mysql_init(NULL); // mysql instance

    //connect database
    if(!mysql_real_connect(essai, server, user, password, database, 0, NULL, 0)){
        cout << "Connection Error: " << mysql_error(essai) << std::endl;
        exit(1);
    }
    cout << "Connexion effectué : "<<database<<endl;
    con=essai;
}

MYSQL_RES* bdd::requete(const char *sql_query){
    //send query to db
    if(mysql_query(con, sql_query)){
        cout << "MySQL Query Error: " << mysql_error(con) << std::endl;
        exit(1);
    }
    MYSQL_RES *res = mysql_use_result(con);
    return res;
}

bdd::bdd(char *serverSaisi,char *userSaisi, char *passwordSaisi,char *databaseSaisi){
        server = serverSaisi;  
        user = userSaisi; 
        password = passwordSaisi; 
        database = databaseSaisi;	
}

void bdd::showInfo(){
    cout <<"Serveur : " << server << endl;
    cout <<"User : " << user << endl;
    cout <<"Password : " << password << endl;
    cout <<"BDD : " << database << endl;
}

void bdd::close(){
     mysql_close(con);
}

void bdd::free_result(){
   // mysql_free_result(res);
}

void bdd::presenceUpdate(int etat,int ID){

    stringstream commande;
    commande <<"UPDATE `inscrit` SET `PresentAuFablab` = '"<<etat<<"' WHERE `inscrit`.`ID` = "<<ID<<";"<<endl;
    string envoi=commande.str();
    MYSQL_RES *res = requete(envoi.c_str());
    mysql_free_result(res);
    commande.clear();
    envoi.clear();
}

void bdd::setTimeUser(int etat,int ID){
    stringstream commande;
    if(etat == 0){
        commande <<"UPDATE `inscrit` SET `HeureEntree` = CURRENT_TIME  WHERE `inscrit`.`ID` = "<<ID<<";"<<endl;
    }
    else if(etat == 1){
        commande <<"UPDATE `inscrit` SET `HeureSortie` = CURRENT_TIME  WHERE `inscrit`.`ID` = "<<ID<<";"<<endl;
    }
    string envoi=commande.str();
    MYSQL_RES *res = requete(envoi.c_str());
    mysql_free_result(res);
    commande.clear();
    envoi.clear();
}

void bdd::setDay(int ID){
    stringstream commande;
    commande <<"UPDATE `inscrit` SET `Jour` = CURRENT_DATE  WHERE `inscrit`.`ID` = "<<ID<<";"<<endl;
    string envoi=commande.str();
    MYSQL_RES *res = requete(envoi.c_str());
    mysql_free_result(res);
    commande.clear();
    envoi.clear();
}

void bdd::calculTimeSpend(int ID){

    MYSQL_ROW row;
    string heureEntree, heureSortie, jour, envoi, time;
    struct tm heureE, heureS;
    time_t t1, t2;
    int seconds, timeInt[2];
    stringstream commande;
    string nom;
    string prenom;

    commande<<"SELECT * FROM `inscrit` WHERE `inscrit`.`ID`="<<ID<<";"<<endl;
    envoi = commande.str();
    MYSQL_RES *res = requete(envoi.c_str());
    row = mysql_fetch_row(res);
    mysql_free_result(res);
    commande.str("");
    envoi.clear();

    nom = row[1];
    prenom = row[2];
    heureEntree = row[7];
    heureSortie = row[8];
    jour = row[10];

    heureE.tm_sec = strtol(heureEntree.substr(6,2).c_str(),NULL,10);
    heureE.tm_min = strtol(heureEntree.substr(3,2).c_str(),NULL,10);
    heureE.tm_hour = strtol(heureEntree.substr(0,2).c_str(),NULL,10);
    heureS.tm_sec = strtol(heureSortie.substr(6,2).c_str(),NULL,10);
    heureS.tm_min = strtol(heureSortie.substr(3,2).c_str(),NULL,10);
    heureS.tm_hour = strtol(heureSortie.substr(0,2).c_str(),NULL,10);
    
    strptime(jour.c_str(), "%Y-%m-%d", &heureE);
    strptime(jour.c_str(), "%Y-%m-%d", &heureS);
    seconds = difftime(mktime(&heureS),mktime(&heureE));
   //cout << asctime(&heureE)<<asctime(&heureS) ;

    timeInt[0]=seconds%60; //s
    timeInt[1]=(seconds/60)%60; // m
    timeInt[2]=seconds/3600; //h
 //   cout << "Time : "<<timeInt[2]<<":"<<timeInt[1]<<":"<<timeInt[0]<<endl;

    for(int a=0;a<=2;a++){
        if(timeInt[a]<10 && timeInt[a] != 0){
            if(a !=2){
                time=":0"+to_string(timeInt[a])+time;
            }else{
                time="0"+to_string(timeInt[a])+time;
            }
        }else if(timeInt[a]==0){
            if(a !=2){
                time=":00"+time;
            }else{
                time="00"+time;
            }
        }else{
            time=":"+to_string(timeInt[a])+time;
        }
    }
   
    commande<<"UPDATE `inscrit` SET `DureeTotalPresence` = '"<< time.c_str()<<"'  WHERE `inscrit`.`ID` = "<<ID<<";"<<endl;
    envoi = commande.str();
    res = requete(envoi.c_str());
    mysql_free_result(res);
/*
    commande<<"INSERT INTO `inscrit_fablab_log` (`IDUser`, `Nom`, `Prenom`, `HeureEntree`, `HeureSortie`, `DureeTotalPresence`, `Jour`) VALUES ("<<ID<<", '"<<nom<<"', '"<<prenom<<"', '"<<heureEntree<<"', '"<<heureSortie<<"', '"<<time.c_str()<<"', '"<<jour<<"');"<<endl;
    envoi = commande.str();
    res = requete(envoi.c_str());
    mysql_free_result(res);
*/
    time.clear();
    commande.clear();
    heureEntree.clear();
    heureSortie.clear();
    envoi.clear();
    memset(&timeInt,0,sizeof(timeInt));
    // memset(&heureE, 0, sizeof(heureE));
    // memset(&heureS, 0, sizeof(heureS));
}

void bdd::resetTime(int ID){
    stringstream commande;
    commande <<"UPDATE `inscrit` SET `Jour` = '0000-00-00', `HeureEntree` = '00:00:00', `HeureSortie` = '00:00:00' WHERE `inscrit`.`ID` = "<<ID<<";"<<endl;
    string envoi=commande.str();
    MYSQL_RES *res = requete(envoi.c_str());
    mysql_free_result(res);
    commande.clear();
    envoi.clear();
}