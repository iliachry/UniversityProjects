#include <iostream>
#include <stdlib.h>
#include <conio.h>

using namespace std;

//diarkeia=poses meres tha doulepsei o kathe texnikos sinolika
//enarksi=h mera pou tha ksekinisoun to sigekrimeno ergo oi texnikoi
//liksi=h mera pou tha teleiosoun to sigekrimeno ergo oi texnikoi

class specialist; 

class project{
    int *special,*days,*enarksi,*liksi;
    int n;
    public:
        void setall(int);
        friend void program(project A,specialist B,int i);
        friend void prosthiki_eid(project A,specialist C,specialist *B,int &texnikoi);
};

void project::setall(int i){
    int y;
    cout<<"Dwse arithmo texnikwn pou tha xreiastoun gia to "<<i+1<<" ergo\n";
    cin>>n;
    if((special=(int*)malloc(n*sizeof(int)))==NULL){
        cout<<"Den iparxei mnimi";
        exit(1);
    }
    if((days=(int*)malloc(n*sizeof(int)))==NULL){
        cout<<"Den iparxei mnimi";
        exit (1) ;
    }
    if((enarksi=(int*)malloc(n*sizeof(int)))==NULL){
        cout<<"Den iparxei mnimi";
        exit(1);
    }
    if((liksi=(int*)malloc(n*sizeof(int)))==NULL){
        cout<<"Den iparxei mnimi";
        exit(1);
    }
    for (y=0;y<n;y++){
        cout<<"Dwse ton kwdiko tis "<<y+1<<" eidikotitas pou tha xreiastei\n";
        cin>>special[y]; 
        cout<<"\n Dwse tis imeres pou tha ergastei o texnikos me tin"<<y+1<<"eidikotita gia to sigkekrimeno ergo";
        cin>>days[y];
    }
}     
          
class specialist{ 
    int kwd,diarkeia;
    float amoibi;
    public:
        void setall(int i);
        friend void program(project A,specialist B,int i);
        friend void prosthiki_eid(project A,specialist C,specialist *B,int &texnikoi);
};

void specialist::setall(int i){
    cout<<"\n Dwse ton kwdiko tis eidikotitas tou"<<i+1<<"eidikou \n";
    cin>> kwd;
    cout<<"\n Dwse thn hmerisia amoibi gia thn antistoixi eidikotita";
    cin>> amoibi;
    diarkeia=0;
}    

void program(project A,specialist B,int i){
  int z,min,max;
  float cost=0;
  for(z=0;z<A.n;z++){
     if ((A.special[z]==B.kwd) ){
              A.enarksi[z]=B.diarkeia;
              B.diarkeia+=A.days[z];
              A.liksi[z]=B.diarkeia;
              cost+=B.amoibi*A.days[z];
              break; 
          }         
  }
  min=A.enarksi[0];
  max=A.liksi[0];
  for(z=1;z<A.n;z++){
      if (A.enarksi[z]<min){
          min=A.enarksi[z];
      }
      if (A.liksi[z]>max){
          max=A.liksi[z];
      }        
  }       
  cout<<"\n Hmera enarksis tou"<<i<<"ergou einai h hmera"<<min;
  cout<<"\n Hmera peratosi tou"<<i<<"ergou einai h hmera"<<max;
  cout<<"\n To kostos tou sigkekrimenou ergou einai:"<<cost;                 
}
     
void prosthiki_eid(project A,specialist C,specialist *B,int &texnikoi){
    int z,i=0;
    for (z=0;z<A.n;z++){
        if(C.kwd==A.special[z]){
                i++;
                break;
        }    
        if((B=(specialist*)realloc(B,(texnikoi+1)*sizeof(specialist)))==NULL){
                    cout<<"Den iparxei mnimi";
                    exit(4); 
        }            
        B[texnikoi].kwd=A.special[z];
        cout<<"\n Dwse amoibi tou kainouriou texnikoy me kwdiko"<<A.special[z];
        cin>> B[texnikoi].amoibi;  
        texnikoi++; 
    }
}                   

int main(){
    int texnikoi,i,k,erg;
    project *a;
    specialist *b;
    cout<<"Dwse arithmo ergwn kai arithmo texnikwn";
    cin>>erg>>texnikoi;
    if ((a=(project*)malloc(erg*sizeof(project)))==NULL){
        cout<<"Den iparxei mnimi.Sorry";
        exit(1);
    }
    for(i=0;i<erg;i++){
       a[i].setall(i);
    }         
    if ((b=(specialist*)malloc(texnikoi*sizeof(specialist)))==NULL){
        cout<<"Den iparxei mnimi.Sorry";
        exit(1);
    }
    for(i=0;i<texnikoi;i++){
        b[i].setall(i);
    }
    for(i=0;i<erg;i++){
        for(k=0;k<texnikoi;k++){
           prosthiki_eid(a[i],b[k],b,texnikoi);
        }    
    }    
    for(i=0;i<erg;i++){
        for(k=0;k<texnikoi;k++){
           program(a[i],b[k],i);
        }    
    }    
}
                
                                
