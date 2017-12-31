#include "ternary_store.h"

#include <string.h>
#include <stdint.h>
#include <stdbool.h>
#include <math.h>

void ternary_store_get_position(uint16_t index, uint16_t *arrayIndex, uint8_t *pos) {
  *arrayIndex = (index * 2) / 8;
  *pos = (index % 4) * 2;
  //printf("position: %dx%d\n", out[0], out[1]);
}

trit_t ternary_store_bit_to_trit(uint8_t bit) {
  if(ternary_store_trit_to_bit(-1) == bit) {
    return -1;
  }
  else if(ternary_store_trit_to_bit(0) == bit) {
    return 0;
  }
  else if(ternary_store_trit_to_bit(1) == bit) {
    return 1;
  }

  return -2;
}

uint8_t ternary_store_trit_to_bit(trit_t trit) {
  uint8_t ret = 0;
  if(trit == -1) {
    ret = 0 | 1UL << 0;
  }
  else if(trit == 0) {
    ret = 0;
  }
  else if(trit == 1) {
    ret = 0 | 1UL << 1;
  }

  return ret;
}

void ternary_store_get_trits(uint16_t start, uint16_t len, uint8_t in[], trit_t out[]) {
  // TODO: instead of calling a function for each trit, try to get all 4 trits at once, then move on to the next uint8_t.
  for(uint16_t i = 0; i < len; i++) {
    out[i] = ternary_store_get_trit(start + i, in);
  }
}

int8_t ternary_store_get_trit(uint16_t index, uint8_t in[]) {
  uint16_t arrayIndex;
  uint8_t pos;
  ternary_store_get_position(index, &arrayIndex, &pos);

  uint8_t bits = in[arrayIndex];
  //printf("bits: " BYTE_TO_BINARY_PATTERN, BYTE_TO_BINARY(bits));
  //printf("\n");

  // clean out any crust from other indexes
  bits = bits << (6 - pos);
  bits = bits >> (6);
  //printf("bits after cleaning: " BYTE_TO_BINARY_PATTERN, BYTE_TO_BINARY(bits));
  //printf("\n");
  return ternary_store_bit_to_trit(bits);
}

void ternary_store_set_trit(uint16_t index, trit_t trit, uint8_t out[])
{
  uint16_t arrayIndex;
  uint8_t pos;
  ternary_store_get_position(index, &arrayIndex, &pos);

  uint8_t bits = ternary_store_trit_to_bit(trit);
  //printf("bits: " BYTE_TO_BINARY_PATTERN, BYTE_TO_BINARY(bits));
  //printf("\n");
  bits = bits << pos;
  //printf("aligned bits: " BYTE_TO_BINARY_PATTERN, BYTE_TO_BINARY(bits));
  //printf("\n");

  out[arrayIndex] += bits;
}

int ternary_store_calculate_array_length(uint16_t amountOfTrits) {
  return ceil(amountOfTrits / 4);
}
