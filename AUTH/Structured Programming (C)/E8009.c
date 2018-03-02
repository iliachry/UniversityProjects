#include <stdio.h>
#include <stdlib.h>

int k=0;

void next_vertex(int ,int **connection,int **weights,int *kostos,int *monopati,int *vathmos,int n);

void main(){
    int n,i,*vathmos,**connection,j,*monopati,**weights,kostos;
    printf("Dwse arithmo twn korifwn toy grafimatos\n");
    scanf("%d",&n);
    if((connection=(int **)malloc(n*sizeof(int)))==NULL){
        printf("Den iparxei mnimi");
        exit(1);
    }
    if((weights=(int **)malloc(n*sizeof(int)))==NULL){
        printf("Den iparxei mnimi");
        exit(1);
    }
    if ((monopati=(int*)malloc(n*sizeof(int)))==NULL){
        printf("Den iparxei mnimi");
        exit(1);
    } 
    if ((vathmos=(int *)malloc(n*sizeof(int)))==NULL){
            printf("Den iparxei mnimi");
            exit(1);
        }   
    for (i=0;i<n;i++){
        printf("Dwse vathmo ths %d korifis\n",++i);
        i--;
        scanf("%d",&vathmos[i]);
        if ((connection[i]=(int *)malloc(vathmos[i]*sizeof(int)))==NULL){
            printf("Den iparxei mnimi");
            exit(1);
        }
        if ((weights[i]=(int *)malloc(vathmos[i]*sizeof(int)))==NULL){
            printf("Den iparxei mnimi");
            exit(1);
        }
        for(j=0;j<vathmos[i];j++){
            printf("Dwse tin %d korifi poy sindeetai me tin korifi %d kathos kai to varos\n",++j,++i);
            i--;
            j--;
            scanf("%d %d",&connection[i][j], &weights[i][j]);
        }
    }
    printf("Dwse ton arithmo tis korifis ekkinisis");
    scanf("%d",&i);
    next_vertex(i,connection,weights,&kostos,monopati,vathmos,n);
    if(k<n){
        printf("To monopati den oloklirothike.kostos=%d Monopati:",kostos);
        for (i=0;i<k;i++){
          printf("%d\n",monopati[i]);
          } 
    }
    else{
        printf("To monopati oloklirothike.kostos=%d Monopati:",kostos); 
        for (i=0;i<k;i++){
          printf("%d\n",monopati[i]);
        }
    } 
    getch();     
}

void next_vertex(int i,int **connection,int **weights,int *kostos,int *monopati,int *vathmos,int n){
    int j,fl,min,l,o=0;
    if(i>n){
        return;
    }   
    monopati[k]=i;
    k++;
    for(j=0;j<vathmos[i];j++){
        if (connection[i][j]==-1){
            o++;
        }    
        else if (j==0){
            min=weights[i][j];
            fl=0;
        }
        else if (weights[i][j]<min){
            min=weights[i][j];
            fl=j;
        }
    }
    if (o==vathmos[i])
      return;
    *kostos +=weights[i][fl];
    i=connection[i][fl];
    for(j=i;j<n-1;j++){
        for (l=0;l<vathmos[j];l++){
            connection[j][l]=connection[++j][l];
            j--;
            weights[j][l]=weights[++j][l];
            j--;
        }
    }
    for(j=0;j<n;j++){
        for (l=0;l<vathmos[j];l++){
            if (i==connection[j][l])
              connection[j][l]=-1;
         }
     }                
    if((connection=(int**)realloc(connection,(n-1)*sizeof(int)))==NULL){
        printf("Den iparxei mnimi");
        exit(1);
    }
    if((weights=(int**)realloc(weights,(n-1)*sizeof(int)))==NULL){
        printf("Den iparxei mnimi");
        exit(1);
    }
    next_vertex(i,connection,weights,kostos,monopati,vathmos,n-1);
}    
    
    
                    
            
            
        
