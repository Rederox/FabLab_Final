// g++ ConnexionBDD.cpp -o output -L/usr/include/mariadb/mysql -lmariadbclient
#include <iostream>
#include <mariadb/mysql.h> 


#include <string.h>
#include <errno.h>
//#include <wiringPi.h>
//#include <wiringSerial.h>
#include <iostream>
//#include <unistd.h>
#include <sstream>
#include <iomanip>

using namespace std;

struct connection_details
{
    const char *server, *user, *password, *database;
};

MYSQL* mysql_connection_setup(struct connection_details mysql_details){
    MYSQL *connection = mysql_init(NULL); // mysql instance

    //connect database
    if(!mysql_real_connect(connection, mysql_details.server, mysql_details.user, mysql_details.password, mysql_details.database, 0, NULL, 0)){
        std::cout << "Connection Error: " << mysql_error(connection) << std::endl;
        exit(1); 
    }
    return connection;
}
// mysql_res = mysql result
MYSQL_RES* mysql_perform_query(MYSQL *connection, const char *sql_query){
    //send query to db
    if(mysql_query(connection, sql_query)){
        std::cout << "MySQL Query Error: " << mysql_error(connection) << std::endl;
        exit(1);
    }
    return mysql_use_result(connection);
}

int main(int argc, char const *argv[])
{

    //    -> Création des variables utiles à la connexion

    MYSQL *con;	// the connection
    MYSQL_RES *res;	// the results
    MYSQL_ROW row;	// the results rows (array)
    string badge_test="00aa00aa00";
    bool reconnaissance =0;

    //   -> Génération de la structure des informations pour la connexion

    struct connection_details mysqlD;
    mysqlD.server = "192.168.3.21";  
    mysqlD.user = "admin"; 
    mysqlD.password = "admin"; 
    mysqlD.database = "fablab";	
    con = mysql_connection_setup(mysqlD);

    //  -> Envoi de la commande 

    res = mysql_perform_query(con, "select * from inscrit;");

    //  -> Recueil du resultat

    std::cout << ("Database Output:\n") << std::endl;

    while ((row = mysql_fetch_row(res)) != NULL){

        std::cout << row[0] << " | " << row[1] << " | " << row[2] << " | " << row[3] << std::endl;

      if(badge_test.compare(row[3])== 0){ // Comparaison entre la récupération du badge du lecteur RFID et les tag de la base de données
        reconnaissance=1;
    }}

    if(reconnaissance==1){
        cout<<"Un badge a été reconnu"<<endl;
    }else{
        cout <<"Aucun badge n'a été reconnu"<<endl;
    }

    mysql_free_result(res);// clean up the database result
    mysql_close(con); // close database connection
    return 0;
}