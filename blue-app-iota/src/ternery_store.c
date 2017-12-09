#include "ternery_store.h"

#include <string.h>
#include <stdint.h>
#include <stdbool.h>
#include <math.h>

void ternery_store_set_trit(int index, trit_t trit, uint8_t out[], int trits_length)
{
  // Max 8 values per uint8_t
  int arrayIndex = ceil(index / 8);
  uint8_t bit = pow((index * 3) % 8, 2);
  out[arrayIndex] += bit;
  // 1
  // 1:0
  // 1:-1
  // 1:1
  // 2:0
  // 2:-1
  // 2:1
  // 3:0
  // 3:-1

  // 2
  // 3:1
  // 4:1
  // 4:0
  // 4:-1
  // 5:1
  // 5:0
  // 5:-1
  // 6:1
}
