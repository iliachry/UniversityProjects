#include <iostream>
#include <cmath>

using namespace std;

class Vector;
class Matrix{
    int r,c;
    float **m;
public:
    int get_r(){return r;}
    void operator()(int n,int k);
    bool operator!();
    float* operator[](int i);
    friend Vector operator*(Matrix,Vector);
};

void Matrix::operator()(int n,int k){
    int i,j;
    r=n;
    c=k;
    if((m=(float**)malloc(r*sizeof(float)))==NULL){
       cout<<"Not enough memory";
       exit(1);
       }
    for (i=0;i<r;i++){
       if((m[i]=(float*)malloc(c*sizeof(float)))==NULL){
       cout<<"Not enough memory";
       exit(2);
       }
    }
    for (i=0;i<r;i++){
        for (j=0;j<c;j++){
            cout<<"Give the " << i+1 <<"," <<j+1<<" element of the matrix";
            cin>> m[i][j];
        }
    }
}

bool Matrix::operator!(){
    int k=0;
    float sumr[r],sumc[r];
    for (int i=0;i<r;i++){
        sumr[i]=0,sumc[i]=0;
        for(int j=0;j<r;j++){
            if (i!=j){
               sumr[i] +=m[i][j];
               sumc[i] +=m[j][i];
            }
        }
    }
    for (int i=0;i<r;i++){
        if((abs(m[i][i])>abs(sumr[i]))||(abs(m[i][i])>abs(sumc[i]))){
            k++;
        }
    }
    if(k==r){return 0;}
    else{return 1;}
}

float* Matrix::operator[](int i){
    return m[i];
}


class Vector{
    int n;
    float *v;
public:
    Vector(){}
    Vector(int,int);
    int get_n(){return n;}
    void operator()(int k);
    int operator()(Vector d,float e);
    void operator=(Matrix a);
    Vector operator*(Vector d);
    Vector operator-(Vector d);
    Vector operator+(Vector d);
    Vector operator/(Vector d);
    float operator[](int i){return v[i];}
    friend Vector operator*(Matrix,Vector);
};

Vector::Vector(int siz1,int siz2){
    if (siz1 != siz2){
		cout << "The two vectors should have the same size\n";
		exit(1);
	}
    n=siz1;
    if((v=(float*)malloc(n*sizeof(float)))==NULL){
       cout<<"Not enough memory";
       exit(1);
    }
}

void Vector::operator()(int k){
    n=k;
    if((v=(float*)malloc(n*sizeof(float)))==NULL){
       cout<<"Not enough memory";
       exit(1);
    }
    for(int i=0;i<n;i++){
        cout<<"Give the "<<i+1<<" element of the vector";
        cin>>v[i];
    }
}

int Vector::operator()(Vector d,float e){
    int k=0;
    for(int i=0;i<n;i++){
       if( abs(v[i]-d.v[i])<e) {
            k++;
       }
       if (n==k){return 1;}
       else {return 0;}
    }
}

void Vector::operator=(Matrix a){
    n=a.get_r();
    if((v=(float*)malloc(n*sizeof(float)))==NULL){
       cout<<"Not enough memory";
       exit(1);
    }
    for (int i=0;i<n;i++){
            v[i]=a[i][i];
    }
}

Vector Vector::operator*(Vector d){
    int i;
    Vector k(n,d.get_n());
    for(i=0;i<n;i++){
        k.v[i]=v[i]*d[i];
    }
    return k;
}
Vector Vector::operator-(Vector d){
    int i;
    Vector k(n,d.get_n());
    for(i=0;i<n;i++){
        k.v[i]=v[i]-d[i];
    }
    return k;
}
Vector Vector::operator+(Vector d){
    int i;
    Vector k(n,d.get_n());
    for(i=0;i<n;i++){
        k.v[i]=v[i]+d[i];
    }
    return k;
}
Vector Vector::operator/(Vector d){
    int i;
    Vector k(n,d.get_n());
    for(i=0;i<n;i++){
        k.v[i]=v[i]/d[i];
    }
    return k;
}

Vector operator*(Matrix a,Vector b){
    Vector k(a.r,b.n);
    for(int i=0;i<b.n;i++){
        k.v[i]=0;
        for(int j=0;j<b.n;j++){
            k.v[i]+=a[i][j]*b[j];
        }
    }
    return k;
}

class system_solve{
    Matrix a;
    Vector b;
public:
    void get_vector(int);
    system_solve();
    Vector solve (int k,float e);
};

void system_solve::get_vector(int k){
    for(int i=0;i<k;i++){
        cout<<b[i]<<"\n";
    }
}

system_solve::system_solve(){
    int n;
    cout<<"Give dimension of the vector and the square matrix";
    cin>>n;
    a(n,n);
    b(n);
}

Vector system_solve::solve(int k,float e){
    Vector d,*x,temp;
    int i,j;
    if(!a){
        cout<<"The Matrix is not diagonally surpasser";
        exit(1);
    }
    cout<<"The matrix is diagonally surpasser so we can use the algorithm\n";
    d=a;
    if((x=(Vector*)malloc(k*sizeof(Vector)))==NULL){
       cout<<"Not enough memory";
       exit(1);
    }
    cout<<"Please,give a starting value for the elements of the solution vector\n";
    x[0](b.get_n());
    temp=x[0];
    for(i=0;i<k;i++){
        x[i+1]=(b-a*temp+d*temp)/d;
        if( x[i](x[i+1],e)){
            cout<<"We have verged on the solution.That is the following vector.\n";
            for(j=0;j<b.get_n();j++){
                cout<<temp[j] <<"\n";
            }
            return temp;
        }
        temp=x[i+1];
    }
    return x[i];
}

int main(){
   int k;
   float e;
   system_solve S;
   Vector V;
   cout<<"Give the maximum number of iterations and the number that has defined as accuracy for the solution";
   cin>>k;
   cin>>e;
   V=S.solve(k,e);
   cout<<"Please tell me again the dimension";
   cin>>k;
   cout<<"The elements of the solution vector that the algorithm found are the following";
   for(int i=0;i<k;i++){
      cout<< V[i]<<"\n";
   }
}

