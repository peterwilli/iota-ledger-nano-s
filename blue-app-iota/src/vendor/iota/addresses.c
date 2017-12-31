#include "addresses.h"
#include "kerl.h"
#include "ternary_store.h"

// TODO: make sure we can add more index than uint32
int add_index_to_seed(trit_t trits[], uint32_t index)
{
    for (uint32_t i = 0; i < index; i++) {
        // Add one
        uint8_t offset = 0;
        bool carry = true;
        while(carry && offset < 243) {
            trit_t tritOffset = ternary_store_get_trit(offset, trits);
            tritOffset += 1;
            if (tritOffset > 1) {
                tritOffset = -1;
            } else {
                carry = false;
            }
            ternary_store_set_trit(offset, tritOffset, trits);
            if (carry) {
              offset++;
            }
        }
    }
    return 0;
}

int generate_private_key(trit_t seed_trits[], const uint32_t index, trit_t private_key[])
{
    // Add index
    add_index_to_seed(seed_trits, index);

    kerl_initialize();
    kerl_absorb_trits(seed_trits, 243);
    kerl_squeeze_trits(seed_trits, 243);

    kerl_initialize();
    kerl_absorb_trits(seed_trits, 243);

    int8_t level = 2;
    int arrayLen = ternary_store_calculate_array_length(243);
    trit_t tmp_trits[arrayLen];
    for (uint8_t i = 0; i < level; i++) {
        for (uint8_t j = 0; j < 27; j++) {
            memset(tmp_trits, 0, sizeof tmp_trits);
            // kerl_squeeze_trits(&private_key[i*243*27+j*243], 243);
            uint16_t privateKeyStart = i*243*27+j*243;
            for(uint8_t i2 = 0; i2 < 243; i2++) {
              ternary_store_set_trit(i2, ternary_store_get_trit(privateKeyStart + i2, private_key), tmp_trits);
            }
            kerl_squeeze_trits(tmp_trits, 243);
        }
    }
    return 0;
}

int generate_public_address(const trit_t private_key[], trit_t address_out[])
{
    // Get digests
    trit_t digests[243*2];

    for (uint8_t i = 0; i < 2; i++) {
        trit_t key_fragment[243*27];
        memcpy(key_fragment, &private_key[i*243*27], 243*27);

        for (uint8_t j = 0; j < 27; j++) {
			int progress = ((i*27 + j)*18519)/1000;
			//layoutProgress(_("Generating address."), progress);
            for (uint8_t k = 0; k < 26; k++) {
                kerl_initialize();
                kerl_absorb_trits(&key_fragment[j*243], 243);
                kerl_squeeze_trits(&key_fragment[j*243], 243);
            }
        }

        kerl_initialize();
        kerl_absorb_trits(key_fragment, 243*27);
        kerl_squeeze_trits(&digests[i*243], 243);
    }
	//layoutProgress(_("Generating address."), 1000);

    // Get address
    kerl_initialize();
    kerl_absorb_trits(digests, 243*2);
    kerl_squeeze_trits(address_out, 243);
    return 0;
}
