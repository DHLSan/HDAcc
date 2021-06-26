#include <stdio.h>
#include <stdlib.h>
struct AM
{
    int key ;
    char* value ;
};

struct model
{
    int D = 10000 ; // dimension of hypervector
	int N ; // size of N-gram
	int noch = 4 ; // number of input channels
   
};
int i = 0;
int main(void)
{
    int number_of_keys = 4;
    struct AM *kv = malloc(sizeof(struct AM) * number_of_keys);
    if (kv == NULL) {
        perror("Malloc");
        exit(EXIT_FAILURE);
    }
for (int i=0;i<5;i++){
    kv[i].key = 0;
    kv[i].value = 10000;


    printf("Key = %d\nKey value = %s\n", kv[i].key, kv[i].value);
}  


    free(kv);
    return 0;
}
