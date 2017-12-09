#include "test_ternery.h"
#include <stdio.h>
#include <stdint.h>

int main() {
  uint8_t trits[1];
  ternery_store_set_trit(2, -1, trits, 2);
  return 0;
}
