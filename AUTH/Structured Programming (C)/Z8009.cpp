
#include <stdio.h>
#include <conio.h>
#include <time.h>
 
void anim(char *p);
void delay(long d);
 
void main()
{
  char name[21];
  printf("G???te ed? t? ???µ? sa? (??? pe??ss?te???? ap? 20 ?a?a?t??e?) = ? ");
  gets(name);
  anim(name);
}
 
void anim(char *p)
{
 int i;
 int posx[5]={3,3,70,70};
 int posy[5]={2,20,2,20};
 clrscr();
 for(i=0;i<4;i++){
   gotoxy(posx[i],posy[i]);
   puts(p);
   delay(2);
 }
 gotoxy(20,10);
 printf("%s ?a??? ???e? st?? ??sµ? t??  C \n",p);
}
 
void delay(long d)
{
 time_t tim1,tim2;
 tim1=time(NULL);
 tim2=time(NULL);
 while(tim2-tim1<d)
   tim2=time(NULL);
}
