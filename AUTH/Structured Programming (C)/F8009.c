
#include <stdio.h>
#include <stdlib.h>

struct pelates{
    char onoma[21];
    int kodikos;
    int proion;
    float posotita;
};
struct proionta{
    int code;
    float apothema;
};       

void kat_pelati();
void kat_proion();
void diag_pelati();
void diag_proion();
void kat_parag();
void kat_paral();
void paraggelies();

int main(){    
    int epilogi;    
    struct pelates pel;
    struct proionta pro;
    for(;;){
    printf("Dwse 1 gia kataxorisi neou pelati \n");
    printf("Dwse 2 gia diagrafi pelati\n");
    printf("Dwse 3 gia kataxorisi neou proiontos\n");
    printf("Dwse 4 gia diagrafi proiontos\n");
    printf("Dwse 5 gia kataxorisi newn paraggeliwn\n");
    printf("Dwse 6 gia kataxorisi newn paralavwn\n");
    printf("Dwse 7 gia ektelesi twn paraggeliwn\n");
    printf("Dwse 8 gia eksodo\n");
    scanf("%d",&epilogi);
        switch (epilogi){
        case 1:             
            kat_pelati();
            break;
        case 2:           
            diag_pelati();
            break;
        case 3:
            kat_proion();
            break;
        case 4:
            diag_proion();
            break;
        case 5:
            kat_parag();
            break;
        case 6:
            kat_paral();
            break;
        case 7:
            paraggelies();
        case 8:
            return;
        default:
            return;;
    }}
}                
          
void kat_pelati(){
    int i=0;
    struct pelates pel;
    FILE *fp;
    fp=fopen("pelates","r+b");
    if (fp==NULL){
        fp=fopen("pelates","wb");
        if(fp==NULL){
            printf("LATHOS");
            exit(1);
        }
        else{
            fwrite(&i,sizeof (int),1,fp);
        }        
        printf("LATHOS");
        exit(1);
    }
    fread(&i,sizeof(int),1,fp);
    fseek(fp,i*(sizeof(struct pelates))+2,SEEK_SET);
    printf("Dwse onoma pelati \n");
    scanf("%s",&pel.onoma);
    printf("Dwse kwdiko pelati \n");
    scanf("%d",&pel.kodikos);
    printf("Dwse kwdiko proiontos pou thelei o pelatis \n");
    scanf("%d",&pel.proion );
    pel.posotita=0;
    fwrite(&pel,sizeof (struct pelates),1,fp);
    i++;
    fseek(fp,0,SEEK_SET);
    fwrite(&i,sizeof(int),1,fp);
    fclose(fp);
}    

void kat_proion(){
    struct proionta pro;
    int i=0;
    FILE *fp;
    fp=fopen("proionta","r+b");
    if (fp==NULL){
        fp=fopen("proionta","wb");
        if(fp==NULL){
            printf("LATHOS");
            exit(1);
        }
        else {
            fwrite(&i,sizeof (int),1,fp);
        }        
        printf("LATHOS");
        exit(1);
    }
    fread(&i,sizeof(int),1,fp);
    fseek(fp,i*(sizeof(pro))+2,SEEK_SET);
    printf("Dwse kodiko proiontos");
    scanf("%d",&pro.code);
    pro.apothema=0;
    fwrite(&pro,sizeof(struct proionta),1,fp);
    i++;
    fseek(fp,0,SEEK_SET);
    fwrite(&i,sizeof(int),1,fp);
    fclose(fp);    
}

void diag_pelati(){
    FILE *fp;
    int kod,i,y;
    struct pelates teleutaios,pel;
    fp=fopen("proionta","wb");
    if (fp==NULL){
        printf("LATHOS");
        exit(1);
    }
    printf("Dwse kodiko pelati pou thes na diagrafei");
    scanf("%d",&kod);
    fseek(fp,0,SEEK_SET);
    fread(&y,sizeof(int),1,fp);
    for (i=0;i<y;i++){
       fseek(fp,i*(sizeof(struct pelates))+2,SEEK_SET);
       fread(&pel.kodikos,sizeof(struct pelates),1,fp);
       if (kod==pel.kodikos){
           fseek(fp,-1*sizeof(struct pelates),SEEK_END);
           fread(&teleutaios,sizeof(struct pelates),1,fp);
           fseek(fp,i*sizeof(struct pelates),SEEK_SET);
           fwrite(&teleutaios,sizeof(struct pelates),1,fp);
           y--;
           fseek(fp,0,SEEK_SET);
           fwrite(&y,sizeof(int),1,fp);
           break;
       }   
   }
   fclose(fp);
}

void diag_proion(){ 
    FILE *fp;
    int kod,i,y;
    struct proionta teleutaio,pro;
    fp=fopen("proionta","a+b");
    if (fp==NULL){
        printf("LATHOS");
        exit(1);
    }
    printf("Dwse kodiko proiontos pou thes na diagrafei");
    scanf("%d",&kod);
    fseek(fp,0,SEEK_SET);
    fread(&y,sizeof(int),1,fp);
    for (i=0;i<y;i++){
        fseek(fp,i*(sizeof(struct proionta))+2,SEEK_SET);
        fread(&pro.code,sizeof(struct proionta),1,fp);
        if (kod==pro.code){
            fseek(fp,-1*sizeof(struct proionta),SEEK_END);
           fread(&teleutaio,sizeof(struct proionta),1,fp);
           fseek(fp,i*sizeof(struct proionta)+sizeof(int),SEEK_SET);
           fwrite(&teleutaio,sizeof(struct proionta),1,fp);
           y--;
           fseek(fp,0,SEEK_SET);
           fwrite(&y,sizeof(int),1,fp);          
       }  
        break; 
   }
   fclose(fp);
}

void kat_parag(){
    FILE *fp;
    int i,kod,y,pl=0,poso;    
    struct pelates pel;
    fp=fopen("pelates","r+b");
    if (fp==NULL){
        printf("Lathos");
        exit(1);
    }    
    do{ 
        pl++;            
        printf("Dwse kodiko pelati poy ekane paraggelia.Dwse 0 gia termatismo.");
        scanf("%d",&kod);
        if(kod==0) break;
        printf("Dwse posotita paraggelias");
        scanf("%f",&poso);
        fseek(fp,0,SEEK_SET);
        fread(&y,sizeof(int),1,fp);
        for (i=0;i<y;i++){
            fseek(fp,i*(sizeof(struct pelates))+2,SEEK_SET);
            fread(&pel.kodikos,sizeof(struct pelates),1,fp);
            if (kod==pel.kodikos){
                fread(&pel.posotita,sizeof(struct pelates),1,fp);
                pel.posotita += poso;
                fwrite(&pel.posotita,sizeof(struct pelates),1,fp);
            }
        } 
    }while (pl<=y);    
    fclose(fp);
}

void kat_paral(){
    FILE *fp;
    int i,kod,y,pl=0,poso;    
    struct proionta pro; 
    fp=fopen("proionta","r+b");
    if (fp==NULL){
        printf("Lathos");
        exit(1);
    } 
    do{
        pl++;
        printf("Dwse kodiko proiontos pou exoyme paralavi.Dwse 0 gia termatismo.");
        scanf("%d",&kod);
        if (kod==0) break;
        printf("Dwse posotita paralavis");
        scanf("%f",&pro.apothema);
        fseek(fp,0,SEEK_SET);
        fread(&y,sizeof(int),1,fp);
        for (i=0;i<y;i++){
            fseek(fp,i*(sizeof(pro))+2,SEEK_SET);
            fread(&pro.code,sizeof(pro.code),1,fp);
            if (kod==pro.code){
                fread(&pro.apothema,sizeof(struct proionta),1,fp);
                pro.apothema+=poso;
                fwrite(&pro.apothema,sizeof(struct proionta),1,fp);
            }
        } 
    }
    while (pl<=y);
    fclose(fp);
}

void paraggelies(){
    FILE *fp1,*fp2;
    int i,y,k,z;
    struct pelates pel;
    struct proionta pro;
    fp1=fopen("pelates","r+b");
    if (fp1==NULL){
        printf("LATHOS");
        exit(1);
    }
    fp2=fopen("proionta","r+b");
    if (fp2==NULL){
        printf("LATHOS");
        exit(1);
    }
    fseek(fp1,0,SEEK_SET);
    fread(&y,sizeof(int),1,fp1);
    fseek(fp2,0,SEEK_SET);
    fread(&z,sizeof(int),1,fp2);  
    for(i=0;i<y;i++){
        fseek(fp1,i*sizeof(struct pelates)+sizeof(int),SEEK_SET);
        fread(&pel.posotita,sizeof(struct pelates),1,fp1);
        if(pel.posotita>0){
            fread(&pel.kodikos,sizeof(struct pelates),1,fp1);
            for (k=0;k<z;k++){
                fseek(fp2,k*(sizeof(struct proionta))+sizeof(int),SEEK_SET); 
                fread(&pro.code,sizeof(struct proionta),1,fp2);
                if (pel.kodikos==pro.code){
                    fread(&pro.apothema,sizeof(struct proionta),1,fp2);
                    fread(&pel.onoma,sizeof(struct pelates),1,fp1);
                    if (pel.posotita>=pro.apothema){
                        printf("Tha steiloyme ston %c %f proionta me kodiko %d",pel.onoma,pel.posotita,pel.kodikos);
                        pro.apothema-=pel.posotita;
                        pel.posotita=0;
                        fwrite(&pro.apothema,sizeof(struct proionta),1,fp2);
                        fwrite(&pel.posotita,sizeof(struct pelates),1,fp1);
                    }
                    else{
                        printf("Tha steiloyme ston %c %f proionta me kodiko %d",pel.onoma,pro.apothema,pel.kodikos);
                        pel.posotita-= pro.apothema;
                        pro.apothema=0;
                        fwrite(&pro.apothema,sizeof(struct proionta),1,fp2);
                        fwrite(&pel.posotita,sizeof(struct pelates),1,fp1);
                    }
                }
            }
        }
    }
}                        
                        
                                    
                     
               
        
        
        
        
 
                               
           
           
           
           
    
    
               
        
          
            
                
