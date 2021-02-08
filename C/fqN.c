#include <stdio.h>
#include <stdlib.h>

#define MAX_LINE_LENGTH 1000

int countchar(char *str,char a){
    int n=0;
    int i = 0;
    while(*(str+i)!='\0'){
        if(*(str+i) == a)
            n++;
        i++;
    }
    return n;
}

int main(int argc, char *argv[])
{
        FILE *fi;
        FILE *fo;

        if ( argc == 2) {
            fi = fopen(argv[1], "r");
        } else if (argc == 3){
            fo = fopen(argv[2], "w");
        } else {
                exit(EXIT_FAILURE);
        }

        char line[MAX_LINE_LENGTH];
        char a = 'A';
        int n;
        int count=0;
        while ( fgets(line, MAX_LINE_LENGTH, fi) != NULL ){
               if (++count == 2 ){
                   n = countchar(line,a);
                   printf("%d\n", n);
        }
      }

        return 0;
}
