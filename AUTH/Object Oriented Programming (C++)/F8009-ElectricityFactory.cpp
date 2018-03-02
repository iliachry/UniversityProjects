#include <iostream>
#include <stdlib.h>
using namespace std;

class source{
protected:
    float breakdown;
    char *id;
    static source **M;
    static int n;
    static source **P;
    static int m;
public:
    source();
    source(char *c);
    virtual float power()=0;
    virtual char *ret_id()=0;
    virtual void create_units(int num)=0;
    bool operation();
    char *Cret_id(){return id;}
    static source **get_M(){return M;}
    static int get_n(){return n;}
    static source **get_P(){return P;}
    static int get_m(){return m;}
};

source **source::M;
int source::n;
source **source::P;
int source::m;

source::source(char *k){
  id=k;
  m++;
  if(m==1)
    P=(source **)malloc(m*sizeof(source *));
  else
    P=(source **)realloc(P,m*sizeof(source *));
  if(P==NULL){
    cout <<"Not enough memory \n";
    exit(1);
  }
  P[m-1]=this;
}

source::source(){
  n++;
  if(n==1)
    M=(source **)malloc(n*sizeof(source *));
  else
    M=(source **)realloc(M,n*sizeof(source *));
  M[n-1]=this;
}

bool source::operation(){
    float k;
    k=rand()%10;
    k=k*0.1;
    if(k<breakdown)return 0;
    else return 1;
}

int control(source **M ,int n,float n_pow,float *power){
    int i;
    for(i=0;i<n;i++){
        if( M[i]->operation()==0){
            cout<<"\n The source with id: "<<M[i]->ret_id()<<" is out of order \n";
        }
        else{
           cout<<"\n The source with id: "<<M[i]->ret_id()<<" is OK \n ";
           *power+=M[i]->power();
        }
    }
    if(*power<n_pow){
        return 1;
    }
    else if(*power<=1.1*n_pow){
        return 2;
    }
    else{
        return 3;
    }
}

int main(){
    int i,c,m,num;
    float n_pow,power=0;
    source **P;
    char *id;
    m=source::get_m();
    P=source::get_P();
    cout<<"Hallo.Please give the minimum power\n";
    cin>>n_pow;
    for(i=0;i<m;i++){
        id=P[i]->Cret_id();
        cout<<"\n Input the number of the sources with type: "<<id;
        cin>>num;
        if(num==0) continue;
        P[i]->create_units(num);
    }
    c=control(source::get_M(),source::get_n(),n_pow,&power);
    switch (c){
    case 1:
        cout<<"\n The power is not sufficient.The value of the power is: "<<power;
        break;
    case 2:
        cout<<"\n The power is below the safety limit.The value of the power is: "<<power;
        break;
    case 3:
        cout<<"\n Everything is OK.The value of the power is: "<<power;
        break;
    }
}
//------------------------solar-----------------------------
class solar:public source{
    float surface,flux,S;
    char o_id[31];
public:
    solar();
    solar(char *c);
    virtual float power(){return surface*flux*S;}
    char *ret_id(){return o_id;}
    void create_units(int num);
}sol("solar");

solar::solar(){
    cout<<"\n Solar Panel\n";
    cout<<"\n Input the id (maximum 30) \n";
    cin>>o_id;
    cout<<"\n Input the surface of the collector \n";
    cin>>surface;
    cout<<"\n Input the sun flux \n";
    cin>>flux;
    cout<<"\n Input the S factor";
    cin>>S;
    cout<<"\n Input the possibility of breakdown \n";
    cin>>breakdown;
}

solar::solar(char *c):source(c){}

void solar::create_units(int num){
  solar *p;
  p=new solar[num];
  if(p==0){
    cout <<"Not enough memory \n";
    exit(1);
  }
}

//--------------------turbine--------------------
class turbine:public source{
    float velocity,A;
    char o_id[31];
public:
    turbine();
    turbine(char *c);
    virtual float power(){return velocity*A;}
    char *ret_id(){return o_id;}
    void create_units(int num);
}tur("turbine");

turbine::turbine(){
    cout<<"\n Turbine \n";
    cout<<"\n Input the id (maximum 30) \n";
    cin>>o_id;
    cout<<"\n Input the velocity of the wind \n";
    cin>>velocity;
    cout<<"\n Input the A factor";
    cin>>A;
    cout<<"\n Input the possibility of breakdown \n";
    cin>>breakdown;
}

turbine::turbine(char *c):source(c){}

void turbine::create_units(int num){
  turbine *p;
  p=new turbine[num];
  if(p==0){
    cout <<"Not enough memory \n";
    exit(1);
  }
}
