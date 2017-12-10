#ifndef TERNERY_STORE_H
#define TERNERY_STORE_H

#define BYTE_TO_BINARY_PATTERN "%c%c%c%c%c%c%c%c"
#define BYTE_TO_BINARY(byte)  \
  (byte & 0x80 ? '1' : '0'), \
  (byte & 0x40 ? '1' : '0'), \
  (byte & 0x20 ? '1' : '0'), \
  (byte & 0x10 ? '1' : '0'), \
  (byte & 0x08 ? '1' : '0'), \
  (byte & 0x04 ? '1' : '0'), \
  (byte & 0x02 ? '1' : '0'), \
  (byte & 0x01 ? '1' : '0')

#include "../src/vendor/iota/iota_types.h"
void ternery_store_set_trit(int index, trit_t trit, uint8_t out[]);
void ternery_store_get_position(uint16_t index, uint8_t out[]);
int8_t ternery_store_get_trit(int index, uint8_t in[]);
int ternery_store_calculate_array_length(double amountOfTrits);
uint8_t ternery_store_trit_to_bit(trit_t trit);
trit_t ternery_store_bit_to_trit(uint8_t bit);
#endif
