/*******************************************************************************
*   Ledger Blue
*   (c) 2016 Ledger
*
*  Licensed under the Apache License, Version 2.0 (the "License");
*  you may not use this file except in compliance with the License.
*  You may obtain a copy of the License at
*
*      http://www.apache.org/licenses/LICENSE-2.0
*
*  Unless required by applicable law or agreed to in writing, software
*  distributed under the License is distributed on an "AS IS" BASIS,
*  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
*  See the License for the specific language governing permissions and
*  limitations under the License.
********************************************************************************/

#include "os.h"
#include "cx.h"
#include <stdbool.h>

#include "os_io_seproxyhal.h"

unsigned char G_io_seproxyhal_spi_buffer[IO_SEPROXYHAL_BUFFER_SIZE_B];

static const bagl_element_t *io_seproxyhal_touch_exit(const bagl_element_t *e);
static const bagl_element_t *io_seproxyhal_touch_next(const bagl_element_t *e);
static const bagl_element_t *io_seproxyhal_touch_auth(const bagl_element_t *e);
static bool derive(void);
static void ui_idle(void);

static char address[100];
static unsigned int path[5];
ux_state_t ux;

static const char NOT_AVAILABLE[] = "Not available";

// ********************************************************************************
// Ledger Blue specific UI
// ********************************************************************************

#ifdef TARGET_BLUE

static const bagl_element_t const bagl_ui_sample_blue[] = {
    // {
    //     {type, userid, x, y, width, height, stroke, radius, fill, fgcolor,
    //      bgcolor, font_id, icon_id},
    //     text,
    //     touch_area_brim,
    //     overfgcolor,
    //     overbgcolor,
    //     tap,
    //     out,
    //     over,
    // },
    {
        {BAGL_RECTANGLE, 0x00, 0, 60, 320, 420, 0, 0, BAGL_FILL, 0xf9f9f9,
         0xf9f9f9, 0, 0},
        NULL,
        0,
        0,
        0,
        NULL,
        NULL,
        NULL,
    },
    {
        {BAGL_RECTANGLE, 0x00, 0, 0, 320, 60, 0, 0, BAGL_FILL, 0x1d2028,
         0x1d2028, 0, 0},
        NULL,
        0,
        0,
        0,
        NULL,
        NULL,
        NULL,
    },
    {
        {BAGL_LABEL, 0x00, 20, 0, 320, 60, 0, 0, BAGL_FILL, 0xFFFFFF, 0x1d2028,
         BAGL_FONT_OPEN_SANS_LIGHT_14px | BAGL_FONT_ALIGNMENT_MIDDLE, 0},
        "Hello Perso",
        0,
        0,
        0,
        NULL,
        NULL,
        NULL,
    },
    {
        {BAGL_LABEL, 0x00, 20, 100, 320, 60, 0, 0, 0, 0, 0xF9F9F9F9,
         BAGL_FONT_OPEN_SANS_LIGHT_16px | BAGL_FONT_ALIGNMENT_CENTER, 0},
        address,
        0,
        0,
        0,
        NULL,
        NULL,
        NULL,
    },
    {
        {BAGL_BUTTON | BAGL_FLAG_TOUCHABLE, 0x00, 165, 225, 120, 40, 0, 6,
         BAGL_FILL, 0x41ccb4, 0xF9F9F9, BAGL_FONT_OPEN_SANS_LIGHT_14px |
         BAGL_FONT_ALIGNMENT_CENTER | BAGL_FONT_ALIGNMENT_MIDDLE, 0},
        "EXIT",
        0,
        0x37ae99,
        0xF9F9F9,
        io_seproxyhal_touch_exit,
        NULL,
        NULL,
    },
    {
        {BAGL_BUTTON | BAGL_FLAG_TOUCHABLE, 0x00, 165, 280, 120, 40, 0, 6,
         BAGL_FILL, 0x41ccb4, 0xF9F9F9, BAGL_FONT_OPEN_SANS_LIGHT_14px |
         BAGL_FONT_ALIGNMENT_CENTER | BAGL_FONT_ALIGNMENT_MIDDLE, 0},
        "NEXT",
        0,
        0x37ae99,
        0xF9F9F9,
        io_seproxyhal_touch_next,
        NULL,
        NULL,
    },
    {
        {BAGL_BUTTON | BAGL_FLAG_TOUCHABLE, 0x00, 165, 335, 120, 40, 0, 6,
         BAGL_FILL, 0x41ccb4, 0xF9F9F9, BAGL_FONT_OPEN_SANS_LIGHT_14px |
         BAGL_FONT_ALIGNMENT_CENTER | BAGL_FONT_ALIGNMENT_MIDDLE, 0},
        "AUTH",
        0,
        0x37ae99,
        0xF9F9F9,
        io_seproxyhal_touch_auth,
        NULL,
        NULL,
    },
};

static unsigned int
bagl_ui_sample_blue_button(unsigned int button_mask,
                           unsigned int button_mask_counter) {
    return 0;
}

#endif

// ********************************************************************************
// Ledger Nano S specific UI
// ********************************************************************************

#ifdef TARGET_NANOS

static const bagl_element_t bagl_ui_sample_nanos[] = {
    // {
    //     {type, userid, x, y, width, height, stroke, radius, fill, fgcolor,
    //      bgcolor, font_id, icon_id},
    //     text,
    //     touch_area_brim,
    //     overfgcolor,
    //     overbgcolor,
    //     tap,
    //     out,
    //     over,
    // },
    {
        {BAGL_RECTANGLE, 0x00, 0, 0, 128, 32, 0, 0, BAGL_FILL, 0x000000,
         0xFFFFFF, 0, 0},
        NULL,
        0,
        0,
        0,
        NULL,
        NULL,
        NULL,
    },
    {
        {BAGL_LABELINE, 0x02, 0, 12, 128, 11, 0, 0, 0, 0xFFFFFF, 0x000000,
         BAGL_FONT_OPEN_SANS_REGULAR_11px | BAGL_FONT_ALIGNMENT_CENTER, 0},
        "Address",
        0,
        0,
        0,
        NULL,
        NULL,
        NULL,
    },
    {
        {BAGL_LABELINE, 0x02, 23, 26, 82, 11, 0x80 | 10, 0, 0, 0xFFFFFF,
         0x000000, BAGL_FONT_OPEN_SANS_EXTRABOLD_11px |
         BAGL_FONT_ALIGNMENT_CENTER, 26},
        address,
        0,
        0,
        0,
        NULL,
        NULL,
        NULL,
    },
    {
        {BAGL_ICON, 0x00, 3, 12, 7, 7, 0, 0, 0, 0xFFFFFF, 0x000000, 0,
         BAGL_GLYPH_ICON_CROSS},
        NULL,
        0,
        0,
        0,
        NULL,
        NULL,
        NULL,
    },
    {
        {BAGL_ICON, 0x00, 117, 13, 8, 6, 0, 0, 0, 0xFFFFFF, 0x000000, 0,
         BAGL_GLYPH_ICON_CHECK},
        NULL,
        0,
        0,
        0,
        NULL,
        NULL,
        NULL,
    },
};

static const bagl_element_t*
bagl_ui_sample_nanos_prepro(const bagl_element_t *element) {
    switch (element->component.userid) {
    case 2:
        io_seproxyhal_setup_ticker(
            MAX(3000, 1000 + bagl_label_roundtrip_duration_ms(element, 7)));
        break;
    }
    return element;
}

static unsigned int
bagl_ui_sample_nanos_button(unsigned int button_mask,
                            unsigned int button_mask_counter) {
    switch (button_mask) {
    case BUTTON_EVT_RELEASED | BUTTON_LEFT:
        io_seproxyhal_touch_auth(NULL);
        break;

    case BUTTON_EVT_RELEASED | BUTTON_RIGHT:
        io_seproxyhal_touch_next(NULL);
        break;

    case BUTTON_EVT_RELEASED | BUTTON_LEFT | BUTTON_RIGHT: // EXIT
        io_seproxyhal_touch_exit(NULL);
        break;
    }
    return 0;
}

#endif

static const bagl_element_t *io_seproxyhal_touch_exit(const bagl_element_t *e) {
    // Go back to the dashboard
    os_sched_exit(0);
    return NULL;
}

static const bagl_element_t *io_seproxyhal_touch_next(const bagl_element_t *e) {
    path[4]++;
    if (!derive()) {
        path[4]--;
    }
    ui_idle();
    return NULL;
}

static const bagl_element_t *io_seproxyhal_touch_auth(const bagl_element_t *e) {
    if (!os_global_pin_is_validated()) {
        bolos_ux_params_t params;
        os_memset(&params, 0, sizeof(params));
        params.ux_id = BOLOS_UX_VALIDATE_PIN;
        os_ux_blocking(&params);
        derive();
        ui_idle();
    }
    return NULL;
}

unsigned short io_exchange_al(unsigned char channel, unsigned short tx_len) {
    switch (channel & ~(IO_FLAGS)) {
    case CHANNEL_KEYBOARD:
        break;

    // multiplexed io exchange over a SPI channel and TLV encapsulated protocol
    case CHANNEL_SPI:
        if (tx_len) {
            io_seproxyhal_spi_send(G_io_apdu_buffer, tx_len);

            if (channel & IO_RESET_AFTER_REPLIED) {
                reset();
            }
            return 0; // nothing received from the master so far (it's a tx
                      // transaction)
        } else {
            return io_seproxyhal_spi_recv(G_io_apdu_buffer,
                                          sizeof(G_io_apdu_buffer), 0);
        }

    default:
        THROW(INVALID_PARAMETER);
    }
    return 0;
}

static void ui_idle(void) {
#ifdef TARGET_BLUE
    UX_DISPLAY(bagl_ui_sample_blue, NULL);
#else
    UX_DISPLAY(bagl_ui_sample_nanos, bagl_ui_sample_nanos_prepro);
#endif
}

static void sample_main(void) {
    volatile unsigned int rx = 0;
    volatile unsigned int tx = 0;
    volatile unsigned int flags = 0;

    // DESIGN NOTE: the bootloader ignores the way APDU are fetched. The only
    // goal is to retrieve APDU.
    // When APDU are to be fetched from multiple IOs, like NFC+USB+BLE, make
    // sure the io_event is called with a
    // switch event, before the apdu is replied to the bootloader. This avoid
    // APDU injection faults.
    for (;;) {
        volatile unsigned short sw = 0;

        BEGIN_TRY {
            TRY {
                rx = tx;
                tx = 0; // ensure no race in catch_other if io_exchange throws
                        // an error
                rx = io_exchange(CHANNEL_APDU | flags, rx);
                flags = 0;

                // no apdu received, well, reset the session, and reset the
                // bootloader configuration
                if (rx == 0) {
                    THROW(0x6982);
                }

                if (G_io_apdu_buffer[0] != 0x80) {
                    THROW(0x6E00);
                }

                // unauthenticated instruction
                switch (G_io_apdu_buffer[1]) {
                case 0x00: // reset
                    flags |= IO_RESET_AFTER_REPLIED;
                    THROW(0x9000);
                    break;

                case 0x01: // case 1
                    THROW(0x9000);
                    break;

                case 0x02: // echo
                    tx = rx;
                    THROW(0x9000);
                    break;

                case 0xFF: // return to dashboard
                    goto return_to_dashboard;

                default:
                    THROW(0x6D00);
                    break;
                }
            }
            CATCH_OTHER(e) {
                switch (e & 0xF000) {
                case 0x6000:
                case 0x9000:
                    sw = e;
                    break;
                default:
                    sw = 0x6800 | (e & 0x7FF);
                    break;
                }
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
                G_io_apdu_buffer[tx + 1] = sw;
                tx += 2;
            }
            FINALLY {
            }
        }
        END_TRY;
    }

return_to_dashboard:
    return;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
}

unsigned char io_event(unsigned char channel) {
    // nothing done with the event, throw an error on the transport layer if
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
        break;

    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
        }
        break;

    case SEPROXYHAL_TAG_TICKER_EVENT:
        UX_REDISPLAY();
        break;

    // unknown events are acknowledged
    default:
        break;
    }

    // close the event if not done previously (by a display or whatever)
    if (!io_seproxyhal_spi_is_status_sent()) {
        io_seproxyhal_general_status();
    }

    // command has been processed, DO NOT reset the current APDU transport
    return 1;
}

static const char BASE58ALPHABET[] = {
    '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F',
    'G', 'H', 'J', 'K', 'L', 'M', 'N', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W',
    'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'm',
    'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'};

static unsigned int encode_base58(const void *in, unsigned int length,
                                  char *out, unsigned int maxoutlen) {
    char tmp[164];
    char buffer[164];
    unsigned char j;
    unsigned char startAt;
    unsigned char zeroCount = 0;
    if (length > sizeof(tmp)) {
        THROW(INVALID_PARAMETER);
    }
    os_memmove(tmp, in, length);
    while ((zeroCount < length) && (tmp[zeroCount] == 0)) {
        ++zeroCount;
    }
    j = 2 * length;
    startAt = zeroCount;
    while (startAt < length) {
        unsigned short remainder = 0;
        unsigned char divLoop;
        for (divLoop = startAt; divLoop < length; divLoop++) {
            unsigned short digit256 = (unsigned short)(tmp[divLoop] & 0xff);
            unsigned short tmpDiv = remainder * 256 + digit256;
            tmp[divLoop] = (unsigned char)(tmpDiv / 58);
            remainder = (tmpDiv % 58);
        }
        if (tmp[startAt] == 0) {
            ++startAt;
        }
        buffer[--j] = BASE58ALPHABET[remainder];
    }
    while ((j < (2 * length)) && (buffer[j] == BASE58ALPHABET[0])) {
        ++j;
    }
    while (zeroCount-- > 0) {
        buffer[--j] = BASE58ALPHABET[0];
    }
    length = 2 * length - j;
    if (maxoutlen < length) {
        THROW(EXCEPTION_OVERFLOW);
    }
    os_memmove(out, (buffer + j), length);
    return length;
}

static bool derive() {
    cx_ecfp_private_key_t privateKey;
    cx_ecfp_public_key_t publicKey;
    union {
        cx_sha256_t shasha;
        cx_ripemd160_t riprip;
    } u;
    unsigned char privateKeyData[32];
    unsigned char tmp[25];
    unsigned int length;

    if (!os_global_pin_is_validated()) {
        os_memmove(address, NOT_AVAILABLE, sizeof(NOT_AVAILABLE));
        return false;
    }

    os_perso_derive_node_bip32(CX_CURVE_256K1, path, 5, privateKeyData, NULL);

    cx_ecdsa_init_private_key(CX_CURVE_256K1, privateKeyData, 32, &privateKey);
    cx_ecfp_generate_pair(CX_CURVE_256K1, &publicKey, &privateKey, 1);
    publicKey.W[0] = ((publicKey.W[64] & 1) ? 0x03 : 0x02);
    cx_sha256_init(&u.shasha);
    cx_hash(&u.shasha.header, CX_LAST, publicKey.W, 33, privateKeyData);
    cx_ripemd160_init(&u.riprip);
    cx_hash(&u.riprip.header, CX_LAST, privateKeyData, 32, tmp + 1);
    tmp[0] = 0;
    cx_sha256_init(&u.shasha);
    cx_hash(&u.shasha.header, CX_LAST, tmp, 21, privateKeyData);
    cx_sha256_init(&u.shasha);
    cx_hash(&u.shasha.header, CX_LAST, privateKeyData, 32, privateKeyData);
    os_memmove(tmp + 21, privateKeyData, 4);
    length = encode_base58(tmp, sizeof(tmp), address, sizeof(address));
    address[length] = '\0';
    return true;
}

__attribute__((section(".boot"))) int main(void) {
    // exit critical section
    __asm volatile("cpsie i");

    // ensure exception will work as planned
    os_boot();

    UX_INIT();

    BEGIN_TRY {
        TRY {
            io_seproxyhal_init();

            // Invalidate the current authentication to demonstrate
            // reauthentication
            // Reauthenticate with "Auth" (Blue) or left button (Nano S)
            os_global_pin_invalidate();

#ifdef LISTEN_BLE
            if (os_seph_features() &
                SEPROXYHAL_TAG_SESSION_START_EVENT_FEATURE_BLE) {
                BLE_power(0, NULL);
                // restart IOs
                BLE_power(1, NULL);
            }
#endif

            USB_power(0);
            USB_power(1);

            path[0] = 44 | 0x80000000;
            path[1] = 0 | 0x80000000;
            path[2] = 0 | 0x80000000;
            path[3] = 0;
            path[4] = 0;

            derive();
            ui_idle();

            sample_main();
        }
        CATCH_OTHER(e) {
        }
        FINALLY {
        }
    }
    END_TRY;
}
