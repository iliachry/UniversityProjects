#include <stdio.h>
#define MAX 10
void main()
{
    float weight[MAX][MAX],cost=0,min;
    int i,j,adj[MAX][MAX],korifi,k,N,end,pl=0;
    printf("Dwse ton arithmo twn korifwn");
    scanf("%d",&N);
    for (i=0;i<N;i++)
    {
        for (j=0;j<N;j++)
        {
            if (i==j) 
            {
                adj[i][j]=0 ;
                break;
            }  
            printf("Dwse 1 an iparxei akmi poy na sindeei thn %d me thn %d korifi.An den iparxei dwse 0",++i,++j);
            i--;
            j--;
            scanf("%d",&adj[i][j]);
            adj[j][i]=adj[i][j];            
            if (adj[i][j]==1)
            { 
                printf("Dwse varos akmis metaksi twn korifwn");
                scanf("%f",&weight[i][j]);
                weight[j][i]=weight[i][j];
            }
         }
    }
    printf("Dwse arithmo korifis ekkinisis");
    scanf("%d",&korifi);
    printf("To monopati apoteleitai apo tis korifes \n");
    do
    {
        k=0;
        for (j=0;j<N;j++)
        {
            if (adj[korifi][j]==1)
            {
                if (k==0)
                {
                    min=weight[korifi][j];
                    k=1;
                }
                if (weight[korifi][j]<min) min=weight[korifi][j];
            }
        }
        if (k==0) break;
        for (j=0;j<N;j++)
        {
            if (min=weight[korifi][j])
            {
                adj[korifi][j]=0;
                cost += weight[korifi][j];
                pl++;
                printf("%d \n",korifi);
                korifi=j;
                break;
            }
        } 
    }
    while (pl<N);
    if (pl==N)
    {
        printf("To kostos einai %f \n" ,cost);
    }
    else 
    {
        printf("H diadromh den oloklhrothike\n");
    }    
    printf("dwse ena arithmo gia na kleisei");
    scanf("%d",&end);
}
    
                       
                
                    
        
