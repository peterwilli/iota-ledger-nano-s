#include "transaction.h"
#include "conversion.h"
#include "kerl.h"
#include <string.h>

/* Private function(s) prototype(s) */
void tag_increment(trit_t trits[]);
void get_bundle_essence_trits(const char address[], uint64_t value, const char tag[], uint64_t timestamp, uint32_t current_index, uint32_t last_index, trit_t bundle_essence_trits[]);

void tag_increment(trit_t trits[])
{
    // Add one
    uint8_t offset = 0;
    bool carry = true;
    while(carry && offset < 81) {
        trits[offset] = trits[offset] + 1;
        if (trits[offset] > 1) {
            trits[offset] = -1;
        } else {
            carry = false;
        }
        if (carry) {
            offset++;
        }
    }
}

void get_bundle_essence_trits(const char address[], uint64_t value, const char tag[], uint64_t timestamp, uint32_t current_index, uint32_t last_index, trit_t bundle_essence_trits[])
{
    // Set all to zero
    memset(bundle_essence_trits, 0, 162*3);

    // Address
    {
        trit_t* address_trits = &bundle_essence_trits[0];
        tryte_t address_trytes[81] = {0};
        chars_to_trytes(address, address_trytes, 81);
        trytes_to_trits(address_trytes, address_trits, 81);
    }

    // Value
    {
        trit_t* value_trits = &bundle_essence_trits[3*81];
        int32_to_trits(value, value_trits, 81);
    }

    // Tag
    {
        trit_t* tag_trits = &bundle_essence_trits[3*(81+27)];
        tryte_t tag_trytes[27];
        chars_to_trytes(tag, tag_trytes, 27);
        trytes_to_trits(tag_trytes, tag_trits, 27);
    }

    // Timestamp
    {
        trit_t* timestamp_trits = &bundle_essence_trits[3*(81+27+27)];
        int32_to_trits(timestamp, timestamp_trits, 3*9);
    }

    // Current index
    {
        trit_t* curr_idx_trits = &bundle_essence_trits[3*(81+27+27+9)];
        int32_to_trits(current_index, curr_idx_trits, 3*9);
    }

    // Last index
    {
        trit_t* last_idx_trits = &bundle_essence_trits[3*(81+27+27+9+9)];
        int32_to_trits(last_index, last_idx_trits, 3*9);
    }
}

void calculate_standard_bundle_hash(const char from_addr[], const char to_addr[], const char remainder_addr[], uint64_t balance, uint64_t transaction_amount, const char tag[], uint64_t timestamp, tryte_t bundle_hash_out[])
{
    bool valid_bundle = false;
    char obsolete_tag_char[27];
    memcpy(obsolete_tag_char, tag, 27);

    trit_t obsolete_tag_trits[81];
    {
        tryte_t obsolete_tag_trytes[27];
        chars_to_trytes(obsolete_tag_char, obsolete_tag_trytes, 27);
        trytes_to_trits(obsolete_tag_trytes, obsolete_tag_trits, 27);
    }

    while(!valid_bundle) {
        kerl_initialize();

        // A standard bundle contains 4 transactions and is security level 2
        trit_t bundle_essence_trits[162*3];
        get_bundle_essence_trits(to_addr, transaction_amount, obsolete_tag_char, timestamp, 0, 3, bundle_essence_trits);
        kerl_absorb_trits(bundle_essence_trits, 486);
        get_bundle_essence_trits(from_addr, -balance, tag, timestamp, 1, 3, bundle_essence_trits);
        kerl_absorb_trits(bundle_essence_trits, 486);
        get_bundle_essence_trits(from_addr, 0, tag, timestamp, 2, 3, bundle_essence_trits);
        kerl_absorb_trits(bundle_essence_trits, 486);
        get_bundle_essence_trits(remainder_addr, balance-transaction_amount, tag, timestamp, 3, 3, bundle_essence_trits);
        kerl_absorb_trits(bundle_essence_trits, 486);

        trit_t trits_out[243];
        kerl_squeeze_trits(trits_out, 243);
        trits_to_trytes(trits_out, bundle_hash_out, 243);

        tryte_t normalized_hash[81];
        normalize_hash(bundle_hash_out, normalized_hash);
        bool has_m = false;
        for (uint8_t i = 0; i < 81; i++) {
            if (normalized_hash[i] == 13) {
                has_m = true;
            }
        }

        if (has_m) {
            tag_increment(obsolete_tag_trits);
            tryte_t obsolete_tag_trytes[27];
            trits_to_trytes(obsolete_tag_trits, obsolete_tag_trytes, 81);
            trytes_to_chars(obsolete_tag_trytes, obsolete_tag_char, 27);
        } else {
            valid_bundle = true;
        }
    }
}

void normalize_hash(const tryte_t hash_in[], tryte_t normalized_hash_out[])
{
    for (int8_t i = 0; i < 3; i++) {
        int8_t chunk[27] = {0};
        memcpy(chunk, &hash_in[i*27], 27);

        int32_t sum = 0;
        for (int8_t j = 0; j < 27; j++) {

            sum += chunk[j];
        }

        if (sum >= 0) {
            while (sum-- > 0) {
                for (int8_t j = 0; j < 27; j++) {
                    if (chunk[j] > -13) {

                        chunk[j]--;
                        break;
                    }
                }
            }
        } else {
            while (sum++ < 0) {
                for (int8_t j = 0; j < 27; j++) {
                    if (chunk[j] < 13) {
                        chunk[j]++;
                        break;
                    }
                }
            }
        }
        memcpy(&normalized_hash_out[i*27], chunk, 27);
    }
}

void generate_signature_fragment(tryte_t normalized_bundle_hash_fragment[], trit_t private_key_fragment[], trit_t signature_fragment[])
{
    memcpy(signature_fragment, private_key_fragment, 6561);
    for (int8_t j = 0; j < 27; j++) {
        for (int8_t k = 13 - normalized_bundle_hash_fragment[j]; k-- > 0; ) {
            kerl_initialize();
            kerl_absorb_trits(&signature_fragment[j*243], 243);
            kerl_squeeze_trits(&signature_fragment[j*243], 243);
        }
    }
}
