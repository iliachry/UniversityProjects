#include <iostream>
#include <ctime>
#include <stdlib.h>

using namespace std;

class data{
    int zones;//number of zones
    float *plot,*building,*taxf_plot,*taxf_building;//objective values and tax factor for plots and buildings per zone
    float warehouse,treefactor,annualfactor;//reduction factor for warehouses and tax factor for arboriculture and annual crops
    public:
        data();
        float get_obvp(int);
        float get_obvb(int);
        float get_taxp(int);
        float get_taxb(int);
        float get_treefactor();
        float get_annualfactor();
        float get_warehouse();
}D;

float data::get_obvp(int z){
    return plot[z];
}
float data::get_obvb(int z){
    return building[z];
}
float data::get_taxp(int z){
    return taxf_plot[z];
}
float data::get_taxb(int z){
    return taxf_building[z];
}
float data::get_treefactor(){
    return treefactor;
}
float data::get_annualfactor(){
    return annualfactor;
}
float data::get_warehouse(){
    return warehouse;
}                             

data::data(){
    int i;
    cout<<"Give number of zones";
    cin>>zones;
    if((plot=(float*)malloc(zones*sizeof(float)))==NULL){
        cout<<"Not enough memory";
        exit(1);
    }
    if((building=(float*)malloc(zones*sizeof(float)))==NULL){
        cout<<"Not enough memory";
        exit(1);
    }    
    if((taxf_plot=(float*)malloc(zones*sizeof(float)))==NULL){
        cout<<"Not enough memory";
        exit(1);
    }    
    if((taxf_building=(float*)malloc(zones*sizeof(float)))==NULL){
        cout<<"Not enough memory";
        exit(1);
    }        
    for(i=0;i<zones;i++){
        cout<<"Give objectives values of plots and buildings for the "<<i+1<<" zone";
        cin>> plot[i]>> building[i]; 
        cout<<"Give tax factor for plots and buildings for the "<<i+1<<" zone";
        cin>>taxf_plot[i]>>taxf_building[i];
    }
    cout<<"Give reduction factor for warehouses";
    cin>>warehouse;
    cout<<"Give tax factor for arboriculture and annual crops";
    cin>>treefactor>>annualfactor;
}
     
class ground{ 
    float area;//area of plot or land,objective value,tax factor
    int kind,zone;//kind of land,zone of plot or land
    public:
        ground(int,float);
        ground(float,int);
        float tax_plot();
        float tax_land();        
};

ground::ground(int zon,float ar){
    zone=zon;
    area=ar;
} 

ground::ground(float ar,int kin){
    kind=kin;
    area=ar;
    zone=0;
} 

float ground::tax_plot(){
    return area*D.get_obvp(zone)*D.get_taxp(zone);
}

float ground::tax_land(){
    if(kind){
        return area*D.get_treefactor();
    }
    else{
        return area*D.get_annualfactor();
    }        
}                 

class building{
    int floors,zone;//number of floors
    float area;
    public:
        building(int,float,int);
        building(int,float);
        float tax_house();
        float tax_warehouse();
};
float building::tax_house(){
    return area*D.get_obvb(zone)*D.get_taxb(zone)*floors;
}

float building::tax_warehouse(){
    return area*D.get_obvb(zone)*D.get_taxb(zone)*D.get_warehouse();
}        

building::building(int zon,float ar,int n){
    zone=zon;
    area=ar;
    floors=n;
}

building::building(int zon,float ar){
    zone=zon;
    area=ar;
}      
    
class property:private ground,private building{
    public:
        property(int,float, float,int);
        property(int,float,float,int,int);
        property(int,float,float);
        property(int,int,float,float);
        float tax1();//property taxes
        float tax2();
        float tax3();
        float tax4();
};

property::property(int zon,float ar1,float ar2,int kin):ground(ar1,kin),building(zon,ar2){}
property::property(int zon,float ar1,float ar2,int kin,int floor):ground(ar1,kin),building(zon,ar2,floor){}
property::property(int zon,float ar1,float ar2):ground(zon,ar1),building(zon,ar2){}
property::property(int zon,int floor,float ar1,float ar2):ground(zon,ar1),building(zon,ar2,floor){}

float property::tax1(){
    return tax_land()+tax_warehouse();
}
float property::tax2(){
    return tax_land()+tax_house();
}
float property::tax3(){
    return tax_plot()+tax_warehouse();
}
float property::tax4(){
    return tax_plot()+tax_house();                
}    

int main(){
    float sum=0,area1,area2,cost;
    int zone,kind,floors;
    tm *date;
    for(;;){
        if((date->tm_year<2013) && (date->tm_mday<30) && (date->tm_mon<10)){
            exit(1);
        }    
        cout<<"Give the zone that your property belongs\n";
        cin>>zone;
        cout<<"Give the area of the ground that you own\n";
        cin>>area1;
        cout<<"Give the area of the building that you own\n";
        cin>>area2;
        cout<<"If you have a house give the number of floors \n";
        cout<<"If you have a warehouse give 0\n";
        cin>>floors;
        if(zone==0){
            cout<<"If you have arboriculture give 1 \n";
            cout<<"If you have annual crops give 0 \n";
            cin>>kind;
            if(floors==0){                           
                property A(zone,area1,area2,kind);
                cost=A.tax1();
            }
            else{
                property A(zone,area1,area2,kind,floors);
                cost=A.tax2();
            }    
        }
        else{
            if (floors==0){
                property A(zone,area1,area2);
                cost=A.tax3();
            }
            else{
                property A(zone,floors,area1,area2);
                cost=A.tax4();
            }
        }               
        cout<<"The tax that you have to pay is "<<cost;" euros\n";
        sum+=cost;
    }
    cout<<"The total amount of tax that will be collected is "<<sum<<" euros";
}        
        
                                 
