#ifndef IOTA_TYPES_H
#define IOTA_TYPES_H

#include <string.h>
#include <stdint.h>
#include <stdbool.h>

typedef int8_t trit_t;
typedef int8_t tryte_t;

struct int_bool_pair {
	int32_t low;
	bool hi;
};

#endif // IOTA_TYPES_H
