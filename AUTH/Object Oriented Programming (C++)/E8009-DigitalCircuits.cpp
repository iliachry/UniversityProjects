#include <iostream>
using namespace std;

class circuit{
protected:
    bool a,b,c,d;
public:
    virtual float power(bool,bool)=0;
    virtual void Set_cd(bool,bool)=0;
    bool getc(){return c;}
    bool getd(){return d;}
};

class circuit_A:public circuit{
public:
    virtual float power(bool,bool);
    virtual void Set_cd(bool,bool);
};

float circuit_A::power(bool i,bool j){
    a=i;
    b=j;
    if(a==0 && b==0) return 0;
    else if((a==1 && b==0)||(a==0 && b==1))return 1;
    else return 2;
}

void circuit_A::Set_cd(bool i,bool j){
    a=i;
    b=j;
    if(a==0 && b==0) {
        c=0;
        d=0;
    }
    else if(a==1 && b==0){
        c=0;
        d=1;
    }
    else if (a==0 && b==1){
        c=0;
        d=1;
    }
    else {
        c=1;
        d=1;
    }
}

class circuit_B:public circuit{
public:
    virtual float power(bool,bool);
    virtual void Set_cd(bool,bool);
};

float circuit_B::power(bool i,bool j){
    a=i;
    b=j;
    if(a==0 && b==0) return 0.5;
    else if((a==1 && b==0)||(a==0 && b==1))return 1.5;
    else return 2.5;
}

void circuit_B::Set_cd(bool i,bool j){
    a=i;
    b=j;
    if(a==0 && b==0) {
        c=0;
        d=0;
    }
    else if(a==1 && b==0){
        c=1;
        d=1;
    }
    else if (a==0 && b==1){
        c=0;
        d=1;
    }
    else {
        c=0;
        d=1;
    }
}

float calk_circuit(circuit **p,bool i,bool j,int N){
    int k;
    float power=0;
    p[0]->Set_cd(i,j);
    power+=p[0]->power(i,j);
    for (k=1;k<N;k++){
        i=p[k-1]->getc();
        j=p[k-1]->getd();
        power+=p[k]->power(i,j);
        p[k]->Set_cd(i,j);
    }
    return power;
}

int main(){
    int N,n1,n2,i;
    circuit **p;
    circuit_A A;
    circuit_B B;
    bool t;
    cout<<"Hallo.Give the number of circuit type A and circuit type B\n";
    cin>> n1 >>n2;
    N=n1+n2;
    p=new circuit*[N];
    if(!p) {
        cout << "Not enough memory \n";
        exit (1);
    }
    for(i=0;i<N;i++){
        cout<<"Give 1 if the type of the circuit on the "<<i+1<<" position is A.Else give 0 \n";
        cin>>t;
        if (t==1){
            p[i]=&A;
        }
        if (t==0){
            p[i]=&B;
        }
    }
    for(int a=0;a<2;a++){
        for (int b=0;b<2;b++){
                cout<<"\n For a="<<a<<" and b="<<b<<" :";
                cout<<"\n The power of the complex circuit is: "<< calk_circuit(p,a,b,N)<<"\n";
                cout<<"\n The values at the output terminals are:\n c="<<p[N-1]->getc()<<"\n";
                cout<<"d="<<p[N-1]->getd()<<"\n";
        }
    }
}
