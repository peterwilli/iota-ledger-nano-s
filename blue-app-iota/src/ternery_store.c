#include "ternery_store.h"

#include <string.h>
#include <stdint.h>
#include <stdbool.h>
#include <math.h>

int8_t ternery_store_get_trit(int index, uint8_t in[]) {
  int arrayIndex = ceil(index / 8);

  for(trit_t trit = -1; trit <= 1; trit++) {
    uint8_t bit = pow(2, ((index * 3) + (1 + trit)) % 8);
    if((in[arrayIndex] & bit) != 0) {
      return trit;
    }
  }

  return -2;
}

void ternery_store_set_trit(int index, trit_t trit, uint8_t out[])
{
  // Max 8 values per uint8_t
  double oneBitPos = 0.125f;
  double slice = ((index * 3.0f) / 8.0f);
  double start = slice;
  double end   = start + (oneBitPos * 3);
  printf("range: %f - %f\n\n", start, end);

  uint8_t bits = pow(2, ((index * 3) + (1 + trit)) % 8);

  // First, set the remainder of the previous array (if any)
  if(floor(end) > floor(start)) {
    int spaceLeft = (ceilf(start) - start) * 8;
    printf("spaceLeft: %d\n", spaceLeft);
    int arrayIndex = floor(start);
    int bitsSet = 0;
    for(int i = 0; i < spaceLeft; i++) {
      int bit = (bits >> i) & 1U;
      int currentBit = (8 - spaceLeft) + i;
      printf("currentBit: %d\n", currentBit);
      out[arrayIndex] ^= (-bit ^ out[arrayIndex]) & (1UL << (currentBit));
    }
    bitsSet += spaceLeft
  }

  // out[arrayIndex] += bits;
}

int ternery_store_calculate_array_length(double amountOfTrits) {
  return ceil((amountOfTrits * 3.0f) / 8.0f);
}
