#ifndef TERNERY_STORE_H
#define TERNERY_STORE_H

#include "../src/vendor/iota/iota_types.h"
void ternery_store_set_trit(int index, trit_t trit, uint8_t out[]);
int8_t ternery_store_get_trit(int index, uint8_t in[]);
int ternery_store_calculate_array_length(double amountOfTrits);
void ternery_store_get_range(int index, double out[]);
#endif
