#include <iostream>
#include <ctime>
#include <stdlib.h>
#include <unistd.h>

using namespace std;
void temps();
void boucle();
int main(){
   // temps();
  boucle();

}

void temps(){
  time_t t1,t2;
    time(&t1);
    cout << asctime(localtime(&t1))<<endl;
    sleep(3);
    time(&t2);
    cout << asctime(localtime(&t2))<<endl;
    cout << "Différence : "<< difftime(t2,t1) << "s"<< endl;
}

void boucle(){
 time_t t1,t2;
 time(&t1);
 double seconds=0;
 double five=5;
 int a =0;
 bool detection = 1;
/*
 for(int a=0;a<9999;a++){
     time(&t2);
     seconds = difftime(t2,t1);
     cout << "boucle..."<<endl;
     cout << "Seconds : " << seconds<<endl;
     cout <<"Temps :" <<asctime(localtime(&t2)) << endl;
 }*/
 
 while(seconds<5 /*&& detection !=0*/){
     time(&t2);
     seconds = difftime(t2,t1);
     cout << "boucle..."<<endl;
     cout << "Seconds : " << seconds<<endl;
    // cout <<"Temps :" <<asctime(localtime(&t2)) << endl;
     sleep(0.1);
 }
 cout << "Boucle fini"<<endl;
}