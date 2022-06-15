#include <mariadb/mysql.h>
#include <iostream>
#include <string.h>

using namespace std;

class bdd{
    private :

        char *server;
        char *user;
        char *password;
        char *database;
        MYSQL *con;

    public :
    bdd(char *serveurSaisi,char *userSaisi, char *passwordSaisi,char *databaseSaisi);
    void connexion();
    MYSQL_RES* requete(const char *sql_query);
    void showInfo();
    void close();
    void free_result();
    void presenceUpdate(int etat,int ID);
    void setTimeUser(int etat,int ID);
    void setDay(int ID);
    void calculTimeSpend(int ID);
    void resetTime(int ID);
};