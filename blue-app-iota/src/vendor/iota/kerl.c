#include "kerl.h"
#include "conversion.h"
#include "os.h"
#include "cx.h"

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
    for (uint8_t i = 0; i < (len/243); i++) {
        // Last trit to zero
        trit_t trits[243] = {0};
        memcpy(trits, &trits_in[i*243], 242);

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
    trits_out[242] = 0;

    // TODO: Check if the following is needed. Seems to do nothing.

    // Flip bytes
    for (uint8_t i = 0; i < 48; i++) {
        bytes_out[i] = bytes_out[i] ^ 0xFF;
    }

    kerl_initialize();
    kerl_absorb_bytes(bytes_out,48);

    return 0;
}
