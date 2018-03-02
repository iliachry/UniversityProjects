#include <stdio.h>
#include <math.h>
#define yfaloi 100
int main () {
    int f=0,i,n=0,nai;
    float min_dis,x[100],y[100],sumx=0,sumy=0,max_dis=-1,xkentro,ykentro,R,X,Y;
    printf( "Dwse elaxisti apostasi");
    scanf("%f", &min_dis);
    for (i=0; i<yfaloi;i++){
        printf("Teleiwsan oi ifaloi?apanta me 1 gia nai kai 0 gia oxi");
        scanf("%d",&nai);
        if (nai)
        break; 
        printf("Dwse syntetagmenes yfaloy: x,y");
        scanf("%f %f", &x[i],&y[i]);                
        n+=1;
        sumx +=x[i];
        sumy+=y[i];
    }
    xkentro=sumx/n;
    ykentro=sumy/n;    
    for (i=0;i<n;i++){
        if (sqrt((xkentro-x[i])*(xkentro-x[i])+(ykentro-y[i])*(ykentro-y[i]))>max_dis)
        max_dis=sqrt((xkentro-x[i])*(xkentro-x[i])+(ykentro-y[i])*(ykentro-y[i]));     
    }
    R=max_dis+min_dis;
    for (i=0;;i++){
        printf("dwse sintetagmenes ploiou: X,Y");
        scanf("%f %f",&X,&Y);
        if (sqrt((X-x[i])*(X-x[i])+(Y-y[i])*(Y-y[i]))<=R){
            f=1;
            if (sqrt((X-x[i])*(X-x[i])+(Y-y[i])*(Y-y[i]))< min_dis)
               printf("Eisai se poli epikindini perioxi/n"); 
        }
        else if ((sqrt((X-x[i])*(X-x[i])+(Y-y[i])*(Y-y[i]))>R) && f==1){
            break;
        }
    }        
}            
        
        
        
        
