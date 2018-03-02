#include <stdio.h>
#include <math.h>

void nbco_or(float *p,float *r,float X,float Y,float me);
void ntco_or(float *p,float *r,float me);

void main (){
    int k=1,w;
    float sd,me,x,y,X,Y,a,b,ap;
    printf("Dwse arxikes sintetagmenes thesis vlimatos,stoxou,thn apostash sd kai thn timh me");
    scanf("%f %f %f %f %f %f",&x,&y,&X,&Y,&sd,&me);
    for(;;){
        printf("Oi syntetagmenes tou vlimatos einai:%f %f",x,y);
        ntco_or(&X,&Y,me);
        nbco_or(&x,&y,X,Y,me);
        printf("Dwse syntetagmenes poy pisteueis oti vrisketai to vlima");
        scanf("%f %f",&a,&b);
        ap=sqrt((x-X)*(x-X)+(y-Y)*(y-Y)) ;
        if ( sqrt((x-a)*(x-a)+(y-b)*(y-b))<sd){
            printf("To vlima katastrafike.H apostash toy vlimatos apo ton stoxo einai:%f \n",ap );
            printf("Pata ena noumero gia na termatisei");
            scanf("%d",&w);
            break;
        }
        if (ap<sd){
            printf("O stoxos katastrafike.To vlima ths volhs htan to : %d \n",k);
            printf("Pata ena noumero gia na termatisei");
            scanf("%d",&w);
            break;
        }
        k++;
    }
}

void nbco_or(float *p,float *r,float X,float Y,float me){
    int r1;
    do{
        r1=rand();
        }
    while (r1>me ||( sqrt( (r1-X)*(r1-X)+(r1-Y)*(r1-Y) )> sqrt( (*p-X)*(*p-X)+(*r-Y)*(*r-Y)) ) );
    if(r1%2){
        *p-=r1;
        *r-=r1;
    }
    else{
         *p+=r1;
         *r+=r1; 
    }      
}

void ntco_or(float *p,float *r,float me){
    int r1;
    do{
        r1=rand();
        }
    while (r1>(1/4)*me );
    if(r1%2){
        *p-=r1;
        *r-=r1;
    }
    else{
         *p+=r1;
        *r+=r1; 
    }  
}     
          
        
        
    
     
    
    
    
    
    
                
            
        
