#include <iostream>

using namespace std;


class cust{
    long kwd,pass;
    char on[30],id[5];
    float cost,maxyp,endeiksi,ofeili;
public:
    void set_ofeili(float );
    void set_ofeili();
    void setall();
    float get_ofeili();
    long get_kwd();
    long get_pass();
    char get_on();
    char get_id(); 
    float get_maxyp();
};

void cust::set_ofeili(){
    cout<<"\n Dwse endeiksi metriti";
    cin>>endeiksi;
    ofeili=endeiksi*cost;
}    

void cust::set_ofeili(float tel_ofeili ){
    ofeili=tel_ofeili;
}

void cust::setall(){
    cout<<"\n Dwse onoma";
    cin>>on;
    cout<<"\n Dwse kwdiko pelati";
    cin>>kwd;
    cout<<"\n Dwse login name kai password pelati";
    cin>>id>>pass;
    cout<<"\n Dwse kostos kilovatoras,megisto ypoloipo";
    cin>>cost>>maxyp;       
}

float cust::get_maxyp(){
    return maxyp;
}    

float cust::get_ofeili(){
    return ofeili;
}
   
long cust::get_kwd(){
    return kwd;
}

long cust::get_pass(){
    return pass;
}

char cust::get_on(){
    return *on;
}

char cust::get_id(){
    return *id;
}         

void eis_pelati(int,cust*);
void diag_pelati(int,cust*);
void diak_pelati(int,cust*);
void stoixeia_ypol(int,cust*);
void plirwmi(int,cust*);

int main(){
    int i,n=0;
    cust *A;
    for(;;){
        cout<<"0.Pelatis \n";
        cout<<"1.Diaxeiristis \n";
        cin>>i;
        if(i){
            cout<<"1.Eisagogi neou pelati \n";
            cout<<"2.Diagrafi pelati \n";
            cout<<"3.Tiposi stoixeiwn pelatwn gia diakopi \n";
            cout<<"4.Tiposi stoixeiwn kai ypoloipwn pelatwn \n";
            cout<<"5.Exodos";
            cin>> i;
            switch (i){
                case 1:
                    eis_pelati(n,A);
                    n++;
                    break;
                case 2:
                    diag_pelati(n,A);
                    n--;
                    break;
                case 3:
                    diak_pelati(n,A);
                    break;
                case 4:
                    stoixeia_ypol(n,A);
                    break;
                case 5:
                    exit(1);
            }    
        }
        else{
            plirwmi(n,A);
        }
    }
}  

void eis_pelati(int n,cust *A){
    if (n==0){
        if ((A=(cust*)malloc(n*sizeof(cust)))==NULL){
            cout<<"Not enough memory";
            exit(2);
        }
   }
   else{
       if((A=(cust*)realloc(A,n*sizeof(cust)))==NULL){
           cout<<"Not enough memory";
           exit(3);
       }
   }
   A[n].setall();
}

void diag_pelati(int n,cust *A){
    long kwd;
    int i;
    cout<<"Dwse kwdiko pelati pou thes na diagrafei";  
    cin>>kwd;
    for (i=0;i<n;i++){
        if(A[i].get_kwd()==kwd){
            A[i]=A[n];
            if ((A=(cust*)realloc(A,(n-1)*sizeof(cust)))==NULL){
                cout<<"Not enough memory";
                exit(4);
            }
            else{
                cout<<"o pelatis diagrafike";
            }    
        }
    }
}

void diak_pelati(int n,cust *A){
    int i;
    for (i=0;i<n;i++){
        A[i].set_ofeili();
        if (A[i].get_ofeili()>A[i].get_maxyp()){
            cout<<"H hlektrodotisi gia ton parakato pelati tha diakopei \n";
            cout<<"Onoma"<<A[i].get_on();
            cout<<"\n Kwdikos"<<A[i].get_kwd();
            cout<<"\n Ofeili"<<A[i].get_ofeili();
        }
    }
}

void stoixeia_ypol(int n,cust *A){
    int i;
    for (i=0;i<n;i++){
        cout<<"\n Onoma"<<A[i].get_on();
        cout<<"\n Kwdikos"<<A[i].get_kwd();
        A[i].set_ofeili();
        cout<<"\n Ofeili"<<A[i].get_ofeili();
    }
}

void plirwmi(int n,cust *A){
    char name[5];
    long password; 
    int i,ar_log;
    float poso,tel_ofeili;   
    cout<<"\n Dwse login name kai password";
    cin>>name>>password;
    for (i=0;i<n;i++){
        if (name[5]==A[i].get_id() && password==A[i].get_pass() ){
            cout<<"\n Dwse arithmo logariasmou kai poso pou tha katavaleis";
            cin>>ar_log>>poso;
            tel_ofeili=A[i].get_ofeili()-poso;
            A[i].set_ofeili(tel_ofeili);
            cout<<"\n O pelatis me onoma"<<A[i].get_on();
            cout<<"\n ofeilei"<<A[i].get_ofeili();
        }
        else{
            cout<<"\n Lathos login name h password";
        }    
    }
}
    

    
        
                              
