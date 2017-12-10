#include "ternery_store.h"

#include <string.h>
#include <stdint.h>
#include <stdbool.h>
#include <math.h>

#define RANGE_START 0
#define RANGE_END 1

void ternery_store_get_range(int index, double out[]) {
  double oneBitPos = 0.125f;
  double slice = ((index * 3.0f) / 8.0f);
  out[0] = slice;
  out[1] = out[0] + (oneBitPos * 3);

  printf("range: %f - %f\n\n", out[0], out[1]);
}

int8_t test_bits_for_trit(int index, uint8_t bitsIn) {
  for(trit_t trit = -1; trit <= 1; trit++) {
    uint8_t bits = pow(2, ((index * 3) + (1 + trit)) % 8);

    if((bitsIn & bits) != 0) {
      return trit;
    }
  }
  return -2;
}

int8_t ternery_store_get_trit(int index, uint8_t in[]) {
  double range[2];
  ternery_store_get_range(index, range);

  if(floor(range[RANGE_END]) > floor(range[RANGE_START])) {
    int spaceLeft = (ceilf(range[RANGE_START]) - range[RANGE_START]) * 8;
    printf("get spaceLeft: %d\n", spaceLeft);
    int arrayIndex = floor(range[RANGE_START]);
    uint8_t out_bit = 0;

    for(int i = 8 - spaceLeft; i < 8; i++) {
      int bit = (in[arrayIndex] >> i) & 1U;
      printf("get bit %d: %d\n", i, bit);
      if(bit == 1) {
        out_bit |= 1UL << i;
      }
    }

    for(int i = 0; i < 8 - spaceLeft; i++) {
      int bit = (in[arrayIndex + 1] >> i) & 1U;
      printf("fill get bit %d: %d\n", i, bit);

      // We now have shifted arrays, so array index + 1
      if(bit == 1) {
        out_bit |= 1UL << i;
      }
    }
    printf("out_bit: " BYTE_TO_BINARY_PATTERN, BYTE_TO_BINARY(out_bit));
    printf("\n");
    test_bits_for_trit(index, out_bit);
  } else {
    int arrayIndex = ceil(index / 8);
    return test_bits_for_trit(index, in[arrayIndex]);
  }

  return -2;
}

void ternery_store_set_trit(int index, trit_t trit, uint8_t out[])
{
  double range[2];
  ternery_store_get_range(index, range);

  uint8_t bits = pow(2, ((index * 3) + (1 + trit)) % 8);
  printf("bits: " BYTE_TO_BINARY_PATTERN, BYTE_TO_BINARY(bits));
  printf("\n");

  // First, set the remainder of the previous array (if any)
  if(floor(range[RANGE_END]) > floor(range[RANGE_START])) {
    int spaceLeft = (ceilf(range[RANGE_START]) - range[RANGE_START]) * 8;
    printf("spaceLeft: %d\n", spaceLeft);
    int arrayIndex = floor(range[RANGE_START]);
    int bitsSet = 0;

    printf("out before: %d\n", out[arrayIndex]);
    for(int i = 0; i < spaceLeft; i++) {
      int bit = (bits >> i) & 1U;
      printf("spaceFill bit %d: %d\n", i, bit);
      int currentBit = (8 - spaceLeft) + i;
      //printf("currentBit: %d\n", currentBit);
      if(bit == 1) {
        out[arrayIndex] |= 1UL << currentBit;
      }
    }
    printf("out: %d\n", out[arrayIndex]);

    bitsSet += spaceLeft;

    for(int i = bitsSet; i < 8; i++) {
      int bit = (bits >> i) & 1U;
      int currentBit = (i - bitsSet);
      printf("newFill bit   %d: %d (actual place in array %d is %d)\n", i, bit, arrayIndex + 1, currentBit);

      // We now have shifted arrays, so array index + 1
      if(bit == 1) {
        out[arrayIndex + 1] |= 1UL << currentBit;
      }
    }
  }
  else {
    printf("Setting directly\n");
    out[(int) floor(range[RANGE_START])] += bits;
  }

}

int ternery_store_calculate_array_length(double amountOfTrits) {
  return ceil((amountOfTrits * 3.0f) / 8.0f);
}
