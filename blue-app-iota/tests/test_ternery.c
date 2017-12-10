#include "test_ternery.h"
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

trit_t randomTrit() {
  return (trit_t) ((rand() % 3) - 1);
}

void testTrits(int amount) {
  int arrayLen = ternery_store_calculate_array_length(amount);
  trit_t randomTrits[amount];

  printf("Testing storing %d trits. We need to store %d uint8_t's in a array...\n", amount, arrayLen);
  printf("Filling random trits...\n");
  for(int i = 0; i < amount; i++) {
    randomTrits[i] = randomTrit();
    printf("index %d = %d\n", i, randomTrits[i]);
  }

  printf("Inserting the trits into store\n");
  uint8_t trits[arrayLen];
  memset(trits, 0, sizeof trits);
  for(int i = 0; i < amount; i++) {
    ternery_store_set_trit(i, randomTrits[i], trits);
  }
  printf("Compare the results with our random values...\n");
  for(int i = 0; i < amount; i++) {
    int8_t trit = ternery_store_get_trit(i, trits);
    printf("Trit %d: %d (real trit: %d)\n", i, trit, randomTrits[i]);
  }

  for(int i = 0; i < arrayLen; i++) {
    printf("bits for array %d: " BYTE_TO_BINARY_PATTERN, i, BYTE_TO_BINARY(trits[i]));
    printf("\n");
  }
}

int main() {
  int seed = 2;
  srand(seed);

  //testTrits(2);
  testTrits(10000);
  return 0;
}
