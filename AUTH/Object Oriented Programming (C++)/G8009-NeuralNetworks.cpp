#include <iostream>
using namespace std;

int n;

class neuron{
    int *id,state,num,ID;
    float *weights,threshold;
public:
    void set_ID(int i){ID=i;}
    void set_num(int n){num=n;}
    void set_id(int);
    void set_weights(int);
    void set_state(int s){state=s;}
    int get_num(){return num;}
    int get_id(int i){return id[i];}
    float get_weights(int i){return weights[i];}
    float get_threshold(){return threshold;}
    int get_state(){return state;}
    int get_ID(){return ID;}
    friend istream &operator>(istream &s,neuron &obj);
    void *operator new(size_t size);
    void operator delete(void *p);
};
void neuron::set_id(int num){
    if ((id=(int*)malloc(num*sizeof(int)))==NULL){
            cout<<" Not enough memory";
            exit(1);
        }
}
void neuron::set_weights(int num){
    if ((weights=(float*)malloc(num*sizeof(float)))==NULL){
            cout<<" Not enough memory";
            exit(1);
        }
}

istream &operator>(istream &s,neuron &obj){
    int i;
    for(i=0;i<obj.get_num();i++){
        cout<<"\n The id of the "<<i+1<<" neuron connected \n";
        s>>obj.id[i];
        cout<<"\n The weight of the "<<i+1<<" neuron connected \n";
        s>>obj.weights[i];
    }
    cout<<" \n Threshold= ";
    s>>obj.threshold;
    cout<<" \n State= ";
    s>>obj.state;
    return s;
}

void* neuron::operator new(size_t size){
    neuron *A;
    int i,num;
    A=(neuron *)malloc(n*size);
    if(A==NULL){
    cout <<"Not enough memory \n";
    exit(1);
    }
    for (i=0;i<n;i++){
        cout<<"\n "<<i+1<<"NEURON \n";
        A[i].set_ID(i);
        cout<<"\n Give the number of the neuron that are connected";
        cin>>num;
        A[i].set_num(num);
        A[i].set_id(num);
        A[i].set_weights(num);
        cin>A[i];
    }
    return A;
}

void neuron::operator delete(void *p){
    free(p);
}

class network{
    neuron *B;
    bool S;
public:
    void *operator new(size_t size);
    friend ostream &operator<(ostream &s,network obj);
    void calk_state();
    void operator delete(void *p);
};

void* network::operator new(size_t size){
    network *A;
    if((A=(network*)malloc(size))==NULL){
        cout<<" Not enough memory";
        exit(1);
    }
    cout<<"\n Give the number of the neurons of the neural network \n";
    cin>>n;
    A->B=new neuron;
    return A;
}
void network::operator delete(void *p){
    free(p);
}

void network::calk_state(){
    int i,j,k,MAX,s,c;
    float sum;
    bool f=0,g;
    cout<<"\n Give the maximum number of iteration \n";
    cin>>MAX;
    for (k=0;k<MAX;k++){
        c=0;
        for(i=0;i<n;i++){
            sum=0;
            for(j=0;j<B[i].get_num();j++){
                sum+=B[j].get_state()*B[i].get_weights(j);
            }
            if (sum>B[i].get_threshold())s=1;
            else s=-1;
            if(s!=B[i].get_state())f=0;
            else f=1;
            B[i].set_state(s);
            if (f==1) c+=1;
        }
        if (c==n){
            S=1;
            break;
        }
        else S=0;
    }
}

ostream &operator<(ostream &s,network obj){
    if (obj.S)s<<"\n The network is on stable state \n";
    else s<<"\n The network is on unstable state\n ";
    for(int i=0;i<n;i++){
        s<<"\n The state of the "<<i+1<<" neuron is "<<obj.B[i].get_state()<<" \n";
    }
    return s;
}

int main(){
   network *P;
   P=new network;
   P->calk_state();
   cout<*P;
   delete(P);
}
