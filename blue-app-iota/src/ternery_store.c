#include "ternery_store.h"

#include <string.h>
#include <stdint.h>
#include <stdbool.h>
#include <math.h>

#define RANGE_START 0
#define RANGE_END 1

void ternery_store_get_position(uint16_t index, uint8_t out[]) {
  out[0] = floor(((index * 2) / 8.0f));
  out[1] = (index % 4) * 2;
  //printf("position: %dx%d\n", out[0], out[1]);
}

trit_t ternery_store_bit_to_trit(uint8_t bit) {
  if(ternery_store_trit_to_bit(-1) == bit) {
    return -1;
  }
  else if(ternery_store_trit_to_bit(0) == bit) {
    return 0;
  }
  else if(ternery_store_trit_to_bit(1) == bit) {
    return 1;
  }

  return -2;
}

uint8_t ternery_store_trit_to_bit(trit_t trit) {
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

int8_t ternery_store_get_trit(int index, uint8_t in[]) {
  uint8_t position[2];
  ternery_store_get_position(index, position);

  uint8_t bits = in[position[0]];
  //printf("bits: " BYTE_TO_BINARY_PATTERN, BYTE_TO_BINARY(bits));
  //printf("\n");

  // clean out any crust from other indexes
  bits = bits << 6 - (position[1] * 1);
  bits = bits >> 6;
  //printf("bits after cleaning: " BYTE_TO_BINARY_PATTERN, BYTE_TO_BINARY(bits));
  //printf("\n");
  return ternery_store_bit_to_trit(bits);
}

void ternery_store_set_trit(int index, trit_t trit, uint8_t out[])
{
  uint8_t position[2];
  ternery_store_get_position(index, position);

  uint8_t bits = ternery_store_trit_to_bit(trit);
  //printf("bits: " BYTE_TO_BINARY_PATTERN, BYTE_TO_BINARY(bits));
  //printf("\n");
  bits = bits << position[1];
  //printf("aligned bits: " BYTE_TO_BINARY_PATTERN, BYTE_TO_BINARY(bits));
  //printf("\n");

  out[position[0]] += bits;
}

int ternery_store_calculate_array_length(double amountOfTrits) {
  return ceil(amountOfTrits / 4);
}
