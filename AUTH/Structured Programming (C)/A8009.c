#include <stdio.h>
int main()
{
    printf("Dwse n,r1,r2,r3,r4 kai V");
    int n;
    float r1,r2,r3,r4,V;
    scanf("%d %f %f %f %f %f",&n,&r1,&r2,&r3,&r4,&V);
    int i;
    float seira,parallila;
    int omada1,omada2,k=1;
    for(i=1;i<=n;i++)
    {
        float r,Imax;
        omada1=omada2=seira=parallila=0;
        printf ( "dwse antistash r");
        do
        { 
          scanf ("%f",&r);
        }
        while (r<0);
        printf("Dwse Imax");
        scanf ("%f",&Imax);
        if (V/r <= Imax) 
        {
            if (r>=r1 && r<=r2 && r>=r3 && r<=r4)
            {
                if (k)
                {
                    omada1+=1;
                    k=0;
                    seira=seira+r;
                }    
                else 
                {
                    omada2 +=1;
                    k=1;
                    parallila=parallila +1/r;
                }
            }
            else if (r>=r1 && r<=r2)
            {
                omada1 +=1;
                seira=seira+r;
            }
            else if (r>=r3 && r<=r4)
            {
                omada2 +=1;
                parallila=parallila+1/r;
            }
            else
            {
                printf("H antistash einai ekso apo ta oria");
            }
        }
        else 
        { 
            printf ("H entash einai megalyteri apo th megisth epitrepomenh");
        }
    }
    parallila=1/parallila;
    printf("%d %d %f %f",omada1,omada2,seira,parallila);
    int end;
    printf("Gia eksodo pata arithmo kai enter"); 
    scanf("%d",&end);
}    
                           
                 
            
                    
                 
                           
            
        
