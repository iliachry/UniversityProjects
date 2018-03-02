#include <iostream>
using namespace std;

/****************circuitA*************/
class circuit_A{
    bool a,b,c,d;
    float R;
public:
    circuit_A();
    float getR(){return R;}
    float power(bool,bool);
    void Set_cd(bool,bool);
    bool getc(){return c;}
    bool getd(){return d;}
};
circuit_A::circuit_A(){
    cout<<"Input the value of the Resistance for type A";
    cin>>R;
}
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

/*****************circuitB********/
class circuit_B{
    bool a,b,c,d;
    float R;
public:
    circuit_B();
    float getR(){return R;}
    float power(bool,bool);
    void Set_cd(bool,bool);
    bool getc(){return c;}
    bool getd(){return d;}
};
circuit_B::circuit_B(){
    cout<<"Input the value of the Resistance for type B";
    cin>>R;
}
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

/********make circuit****/
template<class Ta,class Tb>
class make_circuit{
    int nCA,nCB,*pos,*cir;
    Ta *pA;
    Tb *pB;
    float *R;
public:
    make_circuit();
    void cir_sort();
    Ta* get_pA(){return pA;}
    Tb* get_pB(){return pB;}
    int* get_cir(){return cir;}
    int* get_pos(){return pos;}
    int get_nCA() {return nCA;}
    int get_nCB() {return nCB;}
};
template<class Ta,class Tb>
make_circuit<Ta,Tb>::make_circuit(){
    cout<<"Input the quantity of the circuits for the first and second type";
    cin>>nCA>>nCB;
    pA=new Ta[nCA];
    pB=new Tb[nCB];
    if(!pA) {
        cout << "Not enough memory \n";
        exit (1);
    }
    if(!pB) {
        cout << "Not enough memory \n";
        exit (1);
    }
    pos=new int[nCA+nCB];
    cir=new int[nCA+nCB];
    if(!pos) {
        cout << "Not enough memory \n";
        exit (1);
    }
    if(!cir) {
        cout << "Not enough memory \n";
        exit (1);
    }
}
template<class Ta,class Tb>
void make_circuit<Ta,Tb>::cir_sort(){
    int i,j,temp2;
    float temp1;
    R=new float[nCA+nCB];
    if(!R) {
        cout << "Not enough memory \n";
        exit (1);
    }
    for(i=0;i<nCA;i++){
        R[i]=pA[i].getR();
        pos[i]=i;
        cir[i]=0;
    }
    for(i=nCA;i<nCA+nCB;i++){
        R[i]=pB[i].getR();
        pos[i]=i;
        cir[i]=1;
    }
    for (i=1; i<=nCA+nCB-1; i++){
        for (j=nCA+nCB-1; j>=i; j--){
            if (R[j-1] > R[j]){
                temp1 = R[j-1];
                R[j-1] = R[j];
                R[j] = temp1;
                temp2=pos[j-1];
                pos[j-1]=pos[j];
                pos[j]=temp2;
                temp2=cir[j-1];
                cir[j-1]=cir[j];
                cir[j]=temp2;
                }
        }
    }
}

template <class Ta,class Tb>
float calc_circuit(Ta *pA,Tb *pB,int *p,int *ci,bool &a,bool &b,int n){
    int i;
    float res,pow=0;
    bool c,d;
    cout<<"\n The composite circuit \n";
    for(i=0;i<n;i++){
        cout<<"\n The "<<i+1<<" element of the circuit \n";
        if (ci[p[i]]==0){
            cout<<"\n Type A \n";
            pA[p[i]].Set_cd(a,b);
            pow+=pA[p[i]].power(a,b);
            c=pA[p[i]].getc();
            d=pA[p[i]].getd();
            if(c==d){
                cout<<"\n The resistance does not consume power \n";
            }
            else{
                res=pA[p[i]].getR();
                cout<<"\n The resistance consumes power \n";
                pow+=25/res;
            }
        }
        else{
            cout<<"\n Type B \n";
            pB[p[i]].Set_cd(a,b);
            pow+=pB[p[i]].power(a,b);
            c=pB[p[i]].getc();
            d=pB[p[i]].getd();
            if(c==d){
                cout<<"\n The resistance does not consume power \n";
            }
            else{
                res=pB[p[i]].getR();
                cout<<"\n The resistance consumes power \n";
                pow+=25/res;
            }
        }
    }
    if (ci[n-1]==0){
        a=pA[p[n-1]].getc();
        b=pA[p[n-1]].getd();
    }
    else{
       a=pB[p[n-1]].getc();
       b=pB[p[n-1]].getd();
    }
    return pow;
}

int main(){
    make_circuit<circuit_A,circuit_B> C;
    bool a,b;
    int n;
    float power;
    C.cir_sort();
    cout<<"\n Input the values of the input terminals \n";
    cin>>a>>b;
    n=C.get_nCA()+C.get_nCB();
    power=calc_circuit(C.get_pA(),C.get_pB(),C.get_cir(),C.get_pos(),a,b,n);
    cout<<"\n The power that is consumed is "<<power<<" m^2V";
    cout<<"\n c="<<a<<" d="<<b;
}
