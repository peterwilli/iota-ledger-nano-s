#include "test_ternery.h"
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

trit_t randomTrit() {
  return (trit_t) ((rand() % 3) - 1);
}

void testSingleTrit() {
  printf("Testing a single-int trit\n");
  uint8_t trits[1];
  printf("Setting index 0 to 1 and index 1 to -1...\n");
  ternery_store_set_trit(0, 1, trits);
  ternery_store_set_trit(1, -1, trits);
  int8_t trit = ternery_store_get_trit(0, trits);
  printf("trit at index 0: %d\n", trit);
  trit = ternery_store_get_trit(1, trits);
  printf("trit at index 1: %d\n", trit);

}

void testLargeTrit(int amount) {
  int arrayLen = ternery_store_calculate_array_length(amount);
  trit_t randomTrits[amount];
  printf("Testing a larger trit amount. We need to store %d uint8_t's in a array for %d trits....\n", arrayLen, amount);
  printf("Filling random trits...\n");
  for(int i = 0; i < amount; i++) {
    randomTrits[i] = randomTrit();
    printf("index %d = %d\n", i, randomTrits[i]);
  }

  printf("Inserting the trits into store\n");
  uint8_t trits[arrayLen];
  for(int i = 0; i < amount; i++) {
    ternery_store_set_trit(i, randomTrits[i], trits);
  }

  printf("Compare the results with our random values...\n");
  for(int i = 0; i < amount; i++) {
    int8_t trit = ternery_store_get_trit(i, trits);
    printf("Trit %d: %d\n", i, trit);
  }
}

int main() {
  int seed = 3;
  srand(seed);

  testSingleTrit();
  testLargeTrit(6);
  return 0;
}
