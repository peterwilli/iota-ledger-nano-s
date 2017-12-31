#include "kerl.h"
#include "conversion.h"
#include "os.h"
#include "cx.h"
#include "ternary_store.h"

cx_sha3_t sha3;
static unsigned char bytes_out[48] = {0};

int kerl_initialize(void)
{

    cx_keccak_init(&sha3, 384);
    return 0;
}

int kerl_absorb_bytes(unsigned char *bytes_in, uint16_t len)
{
    cx_hash((cx_hash_t *)&sha3, CX_LAST, bytes_in, len, bytes_out);
    return 0;
}

int kerl_absorb_trits(const trit_t trits_in[], uint16_t len)
{
    int arrayLen = ternary_store_calculate_array_length(243);
    trit_t trits[arrayLen];
    for (uint8_t i = 0; i < (len/243); i++) {
        // TODO: remove the copy and use of trits altogether and supply the original trits_in array to trits_to_words along with the range we want to read.
        // Reset to make sure we have a clean slate
        memset(trits, 0, sizeof trits);

        // Last trit to zero
        ternary_store_set_trit(243, 0, trits);

        // Original:
        //  memcpy(trits, &trits_in[i*243], 242);
        for(uint8_t i2 = 0; i2 < 242; i2++) {
          ternary_store_set_trit(i2, trits_in[(i * 243) + i2], trits);
        }

        // First, convert to bytes
        int32_t words[12];
        unsigned char bytes[48];
        trits_to_words(trits, words);
        words_to_bytes(words, bytes, 12);
        kerl_absorb_bytes(bytes, 48);
    }
    return 0;
}

int kerl_squeeze_trits(trit_t trits_out[], uint16_t len)
{
    (void) len;

    // Convert to trits
    int32_t words[12];
    bytes_to_words(bytes_out, words, 12);
    words_to_trits(words, trits_out);

    // Last trit zero
    ternary_store_set_trit(242, 0, trits_out);

    // TODO: Check if the following is needed. Seems to do nothing.

    // Flip bytes
    for (uint8_t i = 0; i < 48; i++) {
        bytes_out[i] = bytes_out[i] ^ 0xFF;
    }

    kerl_initialize();
    kerl_absorb_bytes(bytes_out,48);

    return 0;
}
