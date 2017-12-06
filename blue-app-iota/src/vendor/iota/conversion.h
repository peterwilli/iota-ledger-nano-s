#ifndef CONVERSION_H
#define CONVERSION_H

#include "iota_types.h"

static const trit_t trits_mapping[27][3] =
       {{-1, -1, -1}, { 0, -1, -1}, {1, -1, -1},
        {-1,  0, -1}, { 0,  0, -1}, {1,  0, -1},
        {-1,  1, -1}, { 0,  1, -1}, {1,  1, -1},
        {-1, -1,  0}, { 0, -1,  0}, {1, -1,  0},
        {-1,  0,  0}, { 0,  0,  0}, {1,  0,  0},
        {-1,  1,  0}, { 0,  1,  0}, {1,  1,  0},
        {-1, -1,  1}, { 0, -1,  1}, {1, -1,  1},
        {-1,  0,  1}, { 0,  0,  1}, {1,  0,  1},
        {-1,  1,  1}, { 0,  1,  1}, {1,  1,  1}};

int trits_to_trytes(const trit_t trits_in[], tryte_t trytes_out[], uint32_t trit_len);
int trytes_to_trits(const tryte_t trytes_in[], trit_t trits_out[], uint32_t tryte_len);

int int32_to_trits(const int32_t value, trit_t trits_out[], uint8_t max_len);
int tryte_to_trits(const tryte_t tryte, trit_t trits_out[]);

int trits_to_words(const trit_t trits_in[], int32_t words_out[]);
int words_to_trits(const int32_t words_in[], trit_t trits_out[]);

int words_to_bytes(const int32_t words_in[], unsigned char bytes_out[], uint8_t word_len);
int bytes_to_words(const unsigned char bytes_in[], int32_t words_out[], uint8_t word_len);

int chars_to_trytes(const char chars_in[], tryte_t trytes_out[], uint8_t len);
int trytes_to_chars(const tryte_t trytes_in[], char chars_out[], uint16_t len);

#endif // CONVERSION_H
