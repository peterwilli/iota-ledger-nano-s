#include "conversion.h"
#include "bigint.h"

#include <stdio.h>

static const int32_t HALF_3[13] = { 0xF16B9C2D,
                                    0xDD01633C,
                                    0x3D8CF0EE,
                                    0xB09A028B,
                                    0x246CD94A,
                                    0xF1C6D805,
                                    0x6CEE5506,
                                    0xDA330AA3,
                                    0xFDE381A1,
                                    0xFE13F810,
                                    0xF97f039E,
                                    0x1B3DC3CE,
                                    0x00000001};

static const char tryte_to_char_mapping[] = "NOPQRSTUVWXYZ9ABCDEFGHIJKLM";


int trits_to_trytes(const trit_t trits_in[], tryte_t trytes_out[], uint32_t trit_len)
{
    if (trit_len % 3 != 0) {
        return -1;
    }
    uint32_t tryte_len = trit_len / 3;

    for (uint32_t i = 0; i < tryte_len; i++) {
        trytes_out[i] = trits_in[i*3+0] + trits_in[i*3+1]*3 + trits_in[i*3+2]*9;
    }
    return 0;
}

int trytes_to_trits(const tryte_t trytes_in[], trit_t trits_out[], uint32_t tryte_len)
{
    for (uint32_t i = 0; i < tryte_len; i++) {
        int8_t idx = (int8_t) trytes_in[i] + 13;
        trits_out[i*3+0] = trits_mapping[idx][0];
        trits_out[i*3+1] = trits_mapping[idx][1];
        trits_out[i*3+2] = trits_mapping[idx][2];
    }
    return 0;
}

int int32_to_trits(const int32_t value, trit_t trits_out[], uint8_t max_len)
{
    int32_t quotient = value / 3;
    int8_t remainder = value % 3;
    if (remainder == 2) {
        quotient++;
        remainder = -1;
    }
    if (remainder == -2) {
        quotient--;
        remainder = 1;
    }
    trits_out[0] = remainder;

    if (quotient == 0) {
        return 0;
    }

    int ret = 0;
    if (max_len > 1) {
        ret = int32_to_trits(quotient, &trits_out[1], max_len-1);
    } else {
        // Not sufficient trits available for representation
        return -1;
    }

    return ret;
}

int trits_to_words(const trit_t trits_in[], int32_t words_out[])
{
    int32_t base[13] = {0};
    int32_t size = 13;
    for (int16_t i = 243; i-- > 0;) {
        // multiply
        {
            int32_t sz = size;
            int32_t carry = 0;

            for (int32_t j = 0; j < sz; j++) {
                int64_t v = ((int64_t)base[j]&0xFFFFFFFF) * ((int64_t)3) + ((int64_t)carry&0xFFFFFFFF);
                carry = (int32_t)((v >> 32) & 0xFFFFFFFF);
                //printf("[%i]carry: %u\n", i, carry);
                base[j] = (int32_t) (v & 0xFFFFFFFF);
            }

            if (carry > 0) {
                printf("ERR");
                //base[sz] = carry;
                //size++;
            }
        }

        // add
        {
            int32_t tmp[12];
            // Ignore the last trit
            if (i == 242) {
                bigint_add_int(base, 1, tmp, 13);
            } else {
                bigint_add_int(base, trits_in[i]+1, tmp, 13);
            }
            memcpy(base, tmp, 52);
            // todo sz>size stuff
        }
    }

    if (bigint_cmp_bigint(HALF_3, base, 13) <= 0 ) {
        int32_t tmp[13];
        bigint_sub_bigint(base, HALF_3, tmp, 13);
        memcpy(base, tmp, 52);
    } else {
        int32_t tmp[13];
        bigint_sub_bigint(HALF_3, base, tmp, 13);
        bigint_not(tmp, 13);
        bigint_add_int(tmp, 1, base, 13);
    }

    memcpy(words_out, base, 48);
    return 0;
}

int words_to_trits(const int32_t words_in[], trit_t trits_out[])
{
    int32_t base[13] = {0};
    int32_t tmp[13] = {0};
    memcpy(tmp, words_in, 48);
    bool flip_trits = false;
    // check if big num is negative
    if (words_in[11] >> 31 != 0) {
        tmp[12] = 0xFFFFFFFF;
        bigint_not(tmp, 13);
        if (bigint_cmp_bigint(tmp, HALF_3, 13) > 0) {
            bigint_sub_bigint(tmp, HALF_3, base, 13);
            flip_trits = true;
        } else {
            bigint_add_int(tmp, 1, base, 13);
            bigint_sub_bigint(HALF_3, base, tmp, 13);
            memcpy(base, tmp, 52);
        }
    } else {
        // Add half_3, make sure words_in is appended with an empty int32
        bigint_add_bigint(tmp, HALF_3, base, 13);
    }


    uint32_t rem = 0;
    for (int16_t i = 0; i < 243; i++) {
        rem = 0;
        for (int8_t j = 13-1; j >= 0 ; j--) {
            uint64_t lhs = (uint64_t)(base[j] & 0xFFFFFFFF) + (uint64_t)(rem != 0 ? ((uint64_t)rem * 0xFFFFFFFF) + rem : 0);
            uint64_t q = (lhs / 3) & 0xFFFFFFFF;
            uint8_t r = lhs % 3;

            base[j] = q;
            rem = r;
        }
        trits_out[i] = rem - 1;
        if (flip_trits) {
            trits_out[i] = -trits_out[i];
        }
    }
    return 0;
}

int chars_to_trytes(const char chars_in[], tryte_t trytes_out[], uint8_t len)
{
    for (uint8_t i = 0; i < len; i++) {
        if (chars_in[i] == '9') {
            trytes_out[i] = 0;
        } else if ((int8_t)chars_in[i] >= 'N') {
            trytes_out[i] = (int8_t)(chars_in[i]) - 64 - 27;
        } else {
            trytes_out[i] = (int8_t)(chars_in[i]) - 64;
        }
    }
    return 0;
}

int trytes_to_chars(const tryte_t trytes_in[], char chars_out[], uint16_t len)
{
    for (uint16_t i = 0; i < len; i++) {
        chars_out[i] = tryte_to_char_mapping[trytes_in[i] + 13];
    }

    return 0;
}

int words_to_bytes(const int32_t words_in[], unsigned char bytes_out[], uint8_t word_len)
{
    for (uint8_t i = 0; i < word_len; i++) {
        bytes_out[i*4+0] = (words_in[word_len-1-i] >> 24);
        bytes_out[i*4+1] = (words_in[word_len-1-i] >> 16);
        bytes_out[i*4+2] = (words_in[word_len-1-i] >> 8);
        bytes_out[i*4+3] = (words_in[word_len-1-i] >> 0);
    }

    return 0;
}

int bytes_to_words(const unsigned char bytes_in[], int32_t words_out[], uint8_t word_len)
{
    for (uint8_t i = 0; i < word_len; i++) {
        words_out[i] = 0;
        words_out[i] |= (bytes_in[(word_len-1-i)*4+0] << 24) & 0xFF000000;
        words_out[i] |= (bytes_in[(word_len-1-i)*4+1] << 16) & 0x00FF0000;
        words_out[i] |= (bytes_in[(word_len-1-i)*4+2] <<  8) & 0x0000FF00;
        words_out[i] |= (bytes_in[(word_len-1-i)*4+3] <<  0) & 0x000000FF;
    }
    return 0;
}
