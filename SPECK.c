#include <stdint.h>
#include <stdio.h>

#define ROR(x, r) ((x >> r) | (x << (64 - r)))
#define ROL(x, r) ((x << r) | (x >> (64 - r)))
#define ER64(x,y,k) (x=ROR(x,8), x+=y, x^=k, y=ROL(y,3), y^=x)
#define DR64(x,y,k) (y^=x, y=ROR(y,3), x^=k, x-=y, x=ROL(x,8))

#define ROUNDS 32

void Speck128128Encrypt(uint64_t Pt[], uint64_t Ct[], uint64_t rk[])
{
   uint64_t i;
   Ct[0] = Pt[0];
   Ct[1] = Pt[1];

   for(i=0;i<32;) 
   ER64(Ct[1],Ct[0],rk[i++]);
}

void Speck128128KeySchedule(uint64_t K[],uint64_t rk[])
{
   uint64_t i, B = K[1], A = K[0];
   for(i = 0;i < 31;){
   rk[i] = A;
   ER64(B, A, i++);
   }
   rk[i] = A;
}

void Speck128128Decrypt(uint64_t Pt[],uint64_t Ct[],uint64_t rk[])
{
   int i;
   Pt[0] = Ct[0];
   Pt[1] = Ct[1];
   for(i = 31; i >= 0;)
      DR64(Pt[1], Pt[0], rk[i--]);
}


void main()
{

   uint64_t  ct[2] ={0x0, 0x0};
   uint64_t  pt[2] = {0x6c61766975716520, 0x7469206564616d20};
   uint64_t  K[2] = {0x0f0e0d0c0b0a0908, 0x0706050403020100};
   uint64_t rk[32];

   Speck128128EncryptExpandKey(pt, ct, K);
    

   // 1 runda i jest git XD
   // Nie stresuj się misiu

   // printf("%016llx \n",  ROR(pt[0], 8));
   // printf("%016llx \n",  ROR(pt[0], 8) + pt[1]);
   // printf("%016llx \n",  (ROR(pt[0], 8) + pt[1]) ^ K[1]);
   // printf("%016llx \n\n\n",  ((ROR(pt[0], 8) + pt[1]) ^ K[1]) ^ (ROL(pt[1], 3)));


   // printf("%016llx \n",  ROR(K[0], 8));
   // printf("%016llx \n",  ROR(K[0], 8) + K[1]);
   // printf("%016llx \n",  (ROR(K[0], 8) + K[1]) ^ 0);
   // printf("%016llx \n",  ((ROR(K[0], 8) + K[1]) ^ 0) ^ (ROL(K[1], 3)));



    printf("Plaint text : 0x%016llX %016llX\n", pt[0], pt[1]);

    printf("Key: 0x%016llX %016llX\n", K[0], K[1]);
    
    printf("Ciphertext: 0x0%16llX %016llX\n", ct[0], ct[1]);


   // uint64_t a = 0xA65D985179783265;
   // uint64_t b = 0x7860FEDF5C570D18;
   // uint64_t k = 0x2199C870DB8EC93F;
   // uint64_t c = a ^ b;
   // uint64_t d = ROR(c,3);
   // uint64_t e = 0xA65D985179783265 ^ k;
   // uint64_t f = e - d;
   // uint64_t g = ROL(f, 8);

   // printf("%016llx\n", c);
   // printf("%016llx\n\n", d);
   // // printf("%016llx\n", ROR(a^b,3));

   // printf("%016llx\n", e);
   // printf("%016llx\n", f);

   // printf("%016llx\n", g);


}