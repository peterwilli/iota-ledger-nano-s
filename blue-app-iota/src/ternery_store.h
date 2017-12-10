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
int8_t ternery_store_get_trit(int index, uint8_t in[]);
int ternery_store_calculate_array_length(double amountOfTrits);
void ternery_store_get_range(int index, double out[]);
#endif
