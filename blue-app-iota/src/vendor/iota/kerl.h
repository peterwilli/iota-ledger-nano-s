#ifndef KERL_H
#define KERL_H

#include "iota_types.h"

int kerl_initialize(void);
int kerl_absorb_bytes(const unsigned char bytes_in[], uint16_t len);
int kerl_absorb_trits(const trit_t trits_in[], uint16_t len);
int kerl_squeeze_trits(trit_t trits_out[], uint16_t len);

#endif // KERL_H
