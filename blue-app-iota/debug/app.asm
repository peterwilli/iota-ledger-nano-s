
bin/app.elf:     file format elf32-littlearm


Disassembly of section .text:

c0d00000 <main>:
    length = encode_base58(privateKeyData, sizeof(privateKeyData), address, sizeof(address));
    address[length] = '\0';
    return true;
}

__attribute__((section(".boot"))) int main(void) {
c0d00000:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00002:	af03      	add	r7, sp, #12
c0d00004:	b08d      	sub	sp, #52	; 0x34
    // exit critical section
    __asm volatile("cpsie i");
c0d00006:	b662      	cpsie	i

    // ensure exception will work as planned
    os_boot();
c0d00008:	f000 fc26 	bl	c0d00858 <os_boot>

    UX_INIT();
c0d0000c:	481e      	ldr	r0, [pc, #120]	; (c0d00088 <main+0x88>)
c0d0000e:	2400      	movs	r4, #0
c0d00010:	22b0      	movs	r2, #176	; 0xb0
c0d00012:	4621      	mov	r1, r4
c0d00014:	f000 fcd2 	bl	c0d009bc <os_memset>

    BEGIN_TRY {
        TRY {
c0d00018:	4e1c      	ldr	r6, [pc, #112]	; (c0d0008c <main+0x8c>)
c0d0001a:	6830      	ldr	r0, [r6, #0]
c0d0001c:	900b      	str	r0, [sp, #44]	; 0x2c
c0d0001e:	ad01      	add	r5, sp, #4
c0d00020:	4628      	mov	r0, r5
c0d00022:	f002 fa49 	bl	c0d024b8 <setjmp>
c0d00026:	85a8      	strh	r0, [r5, #44]	; 0x2c
c0d00028:	6035      	str	r5, [r6, #0]
c0d0002a:	4919      	ldr	r1, [pc, #100]	; (c0d00090 <main+0x90>)
c0d0002c:	4208      	tst	r0, r1
c0d0002e:	d005      	beq.n	c0d0003c <main+0x3c>
c0d00030:	a801      	add	r0, sp, #4
            derive();
            ui_idle();

            sample_main();
        }
        CATCH_OTHER(e) {
c0d00032:	2100      	movs	r1, #0
c0d00034:	8581      	strh	r1, [r0, #44]	; 0x2c
c0d00036:	980b      	ldr	r0, [sp, #44]	; 0x2c
        }
        FINALLY {
c0d00038:	6030      	str	r0, [r6, #0]
c0d0003a:	e01f      	b.n	c0d0007c <main+0x7c>

    UX_INIT();

    BEGIN_TRY {
        TRY {
            io_seproxyhal_init();
c0d0003c:	f000 fe64 	bl	c0d00d08 <io_seproxyhal_init>

            // Invalidate the current authentication to demonstrate
            // reauthentication
            // Reauthenticate with "Auth" (Blue) or left button (Nano S)
            os_global_pin_invalidate();
c0d00040:	f001 fa18 	bl	c0d01474 <os_global_pin_invalidate>
                // restart IOs
                BLE_power(1, NULL);
            }
#endif

            USB_power(0);
c0d00044:	4620      	mov	r0, r4
c0d00046:	f002 f899 	bl	c0d0217c <USB_power>
            USB_power(1);
c0d0004a:	2501      	movs	r5, #1
c0d0004c:	4628      	mov	r0, r5
c0d0004e:	f002 f895 	bl	c0d0217c <USB_power>

            path[0] = 44 | 0x80000000;
c0d00052:	07e8      	lsls	r0, r5, #31
c0d00054:	4601      	mov	r1, r0
c0d00056:	312c      	adds	r1, #44	; 0x2c
c0d00058:	4a0e      	ldr	r2, [pc, #56]	; (c0d00094 <main+0x94>)
c0d0005a:	6011      	str	r1, [r2, #0]
            path[1] = 0 | 0x80000000;
c0d0005c:	6050      	str	r0, [r2, #4]
            path[2] = 0 | 0x80000000;
c0d0005e:	6090      	str	r0, [r2, #8]
            path[3] = 0;
c0d00060:	60d4      	str	r4, [r2, #12]
            path[4] = 0;
c0d00062:	6114      	str	r4, [r2, #16]

            derive();
c0d00064:	f000 fa00 	bl	c0d00468 <derive>
            ui_idle();
c0d00068:	f000 fabe 	bl	c0d005e8 <ui_idle>

            sample_main();
c0d0006c:	f000 fb0e 	bl	c0d0068c <sample_main>
c0d00070:	a801      	add	r0, sp, #4
c0d00072:	8d81      	ldrh	r1, [r0, #44]	; 0x2c
c0d00074:	980b      	ldr	r0, [sp, #44]	; 0x2c
        }
        CATCH_OTHER(e) {
        }
        FINALLY {
c0d00076:	6030      	str	r0, [r6, #0]
        }
    }
    END_TRY;
c0d00078:	2900      	cmp	r1, #0
c0d0007a:	d102      	bne.n	c0d00082 <main+0x82>
}
c0d0007c:	2000      	movs	r0, #0
c0d0007e:	b00d      	add	sp, #52	; 0x34
c0d00080:	bdf0      	pop	{r4, r5, r6, r7, pc}
        CATCH_OTHER(e) {
        }
        FINALLY {
        }
    }
    END_TRY;
c0d00082:	f002 fa25 	bl	c0d024d0 <longjmp>
c0d00086:	46c0      	nop			; (mov r8, r8)
c0d00088:	20001880 	.word	0x20001880
c0d0008c:	200019a8 	.word	0x200019a8
c0d00090:	0000ffff 	.word	0x0000ffff
c0d00094:	20001930 	.word	0x20001930

c0d00098 <io_exchange_al>:
        ui_idle();
    }
    return NULL;
}

unsigned short io_exchange_al(unsigned char channel, unsigned short tx_len) {
c0d00098:	b5b0      	push	{r4, r5, r7, lr}
c0d0009a:	af02      	add	r7, sp, #8
c0d0009c:	4605      	mov	r5, r0
c0d0009e:	200f      	movs	r0, #15
    switch (channel & ~(IO_FLAGS)) {
c0d000a0:	4028      	ands	r0, r5
c0d000a2:	2400      	movs	r4, #0
c0d000a4:	2801      	cmp	r0, #1
c0d000a6:	d013      	beq.n	c0d000d0 <io_exchange_al+0x38>
c0d000a8:	2802      	cmp	r0, #2
c0d000aa:	d113      	bne.n	c0d000d4 <io_exchange_al+0x3c>
    case CHANNEL_KEYBOARD:
        break;

    // multiplexed io exchange over a SPI channel and TLV encapsulated protocol
    case CHANNEL_SPI:
        if (tx_len) {
c0d000ac:	2900      	cmp	r1, #0
c0d000ae:	d008      	beq.n	c0d000c2 <io_exchange_al+0x2a>
            io_seproxyhal_spi_send(G_io_apdu_buffer, tx_len);
c0d000b0:	480b      	ldr	r0, [pc, #44]	; (c0d000e0 <io_exchange_al+0x48>)
c0d000b2:	f001 fa37 	bl	c0d01524 <io_seproxyhal_spi_send>

            if (channel & IO_RESET_AFTER_REPLIED) {
c0d000b6:	b268      	sxtb	r0, r5
c0d000b8:	2800      	cmp	r0, #0
c0d000ba:	da09      	bge.n	c0d000d0 <io_exchange_al+0x38>
                reset();
c0d000bc:	f001 f964 	bl	c0d01388 <reset>
c0d000c0:	e006      	b.n	c0d000d0 <io_exchange_al+0x38>
            }
            return 0; // nothing received from the master so far (it's a tx
                      // transaction)
        } else {
            return io_seproxyhal_spi_recv(G_io_apdu_buffer,
c0d000c2:	2041      	movs	r0, #65	; 0x41
c0d000c4:	0081      	lsls	r1, r0, #2
c0d000c6:	4806      	ldr	r0, [pc, #24]	; (c0d000e0 <io_exchange_al+0x48>)
c0d000c8:	2200      	movs	r2, #0
c0d000ca:	f001 fa65 	bl	c0d01598 <io_seproxyhal_spi_recv>
c0d000ce:	4604      	mov	r4, r0

    default:
        THROW(INVALID_PARAMETER);
    }
    return 0;
}
c0d000d0:	4620      	mov	r0, r4
c0d000d2:	bdb0      	pop	{r4, r5, r7, pc}
            return io_seproxyhal_spi_recv(G_io_apdu_buffer,
                                          sizeof(G_io_apdu_buffer), 0);
        }

    default:
        THROW(INVALID_PARAMETER);
c0d000d4:	4803      	ldr	r0, [pc, #12]	; (c0d000e4 <io_exchange_al+0x4c>)
c0d000d6:	6800      	ldr	r0, [r0, #0]
c0d000d8:	2102      	movs	r1, #2
c0d000da:	f002 f9f9 	bl	c0d024d0 <longjmp>
c0d000de:	46c0      	nop			; (mov r8, r8)
c0d000e0:	200019f8 	.word	0x200019f8
c0d000e4:	200019a8 	.word	0x200019a8

c0d000e8 <io_seproxyhal_display>:

return_to_dashboard:
    return;
}

void io_seproxyhal_display(const bagl_element_t *element) {
c0d000e8:	b580      	push	{r7, lr}
c0d000ea:	af00      	add	r7, sp, #0
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d000ec:	f000 ff80 	bl	c0d00ff0 <io_seproxyhal_display_default>
}
c0d000f0:	bd80      	pop	{r7, pc}
	...

c0d000f4 <io_event>:

unsigned char io_event(unsigned char channel) {
c0d000f4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d000f6:	af03      	add	r7, sp, #12
c0d000f8:	b085      	sub	sp, #20
    // nothing done with the event, throw an error on the transport layer if
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
c0d000fa:	4ed7      	ldr	r6, [pc, #860]	; (c0d00458 <io_event+0x364>)
c0d000fc:	7830      	ldrb	r0, [r6, #0]
c0d000fe:	1f40      	subs	r0, r0, #5
c0d00100:	2809      	cmp	r0, #9
c0d00102:	d900      	bls.n	c0d00106 <io_event+0x12>
c0d00104:	e19f      	b.n	c0d00446 <io_event+0x352>
c0d00106:	0040      	lsls	r0, r0, #1
c0d00108:	4478      	add	r0, pc
c0d0010a:	8880      	ldrh	r0, [r0, #4]
c0d0010c:	0040      	lsls	r0, r0, #1
c0d0010e:	4487      	add	pc, r0
c0d00110:	019a0009 	.word	0x019a0009
c0d00114:	019a019a 	.word	0x019a019a
c0d00118:	019a019a 	.word	0x019a019a
c0d0011c:	002d019a 	.word	0x002d019a
c0d00120:	008b005c 	.word	0x008b005c
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d00124:	4ecd      	ldr	r6, [pc, #820]	; (c0d0045c <io_event+0x368>)
c0d00126:	2001      	movs	r0, #1
c0d00128:	7630      	strb	r0, [r6, #24]
c0d0012a:	2500      	movs	r5, #0
c0d0012c:	61f5      	str	r5, [r6, #28]
c0d0012e:	4634      	mov	r4, r6
c0d00130:	3418      	adds	r4, #24
c0d00132:	4620      	mov	r0, r4
c0d00134:	f001 f9d8 	bl	c0d014e8 <os_ux>
c0d00138:	4601      	mov	r1, r0
c0d0013a:	61f1      	str	r1, [r6, #28]
c0d0013c:	48c9      	ldr	r0, [pc, #804]	; (c0d00464 <io_event+0x370>)
c0d0013e:	4281      	cmp	r1, r0
c0d00140:	d000      	beq.n	c0d00144 <io_event+0x50>
c0d00142:	e0b9      	b.n	c0d002b8 <io_event+0x1c4>
c0d00144:	2003      	movs	r0, #3
c0d00146:	7630      	strb	r0, [r6, #24]
c0d00148:	61f5      	str	r5, [r6, #28]
c0d0014a:	4620      	mov	r0, r4
c0d0014c:	f001 f9cc 	bl	c0d014e8 <os_ux>
c0d00150:	61f0      	str	r0, [r6, #28]
c0d00152:	f000 fe03 	bl	c0d00d5c <io_seproxyhal_init_ux>
c0d00156:	60b5      	str	r5, [r6, #8]
c0d00158:	6830      	ldr	r0, [r6, #0]
c0d0015a:	2800      	cmp	r0, #0
c0d0015c:	d100      	bne.n	c0d00160 <io_event+0x6c>
c0d0015e:	e172      	b.n	c0d00446 <io_event+0x352>
c0d00160:	69f0      	ldr	r0, [r6, #28]
c0d00162:	49bf      	ldr	r1, [pc, #764]	; (c0d00460 <io_event+0x36c>)
c0d00164:	4288      	cmp	r0, r1
c0d00166:	d000      	beq.n	c0d0016a <io_event+0x76>
c0d00168:	e0a3      	b.n	c0d002b2 <io_event+0x1be>
c0d0016a:	e16c      	b.n	c0d00446 <io_event+0x352>
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d0016c:	4dbb      	ldr	r5, [pc, #748]	; (c0d0045c <io_event+0x368>)
c0d0016e:	2001      	movs	r0, #1
c0d00170:	7628      	strb	r0, [r5, #24]
c0d00172:	2000      	movs	r0, #0
c0d00174:	9004      	str	r0, [sp, #16]
c0d00176:	61e8      	str	r0, [r5, #28]
c0d00178:	462c      	mov	r4, r5
c0d0017a:	3418      	adds	r4, #24
c0d0017c:	4620      	mov	r0, r4
c0d0017e:	f001 f9b3 	bl	c0d014e8 <os_ux>
c0d00182:	61e8      	str	r0, [r5, #28]
c0d00184:	49b6      	ldr	r1, [pc, #728]	; (c0d00460 <io_event+0x36c>)
c0d00186:	4288      	cmp	r0, r1
c0d00188:	d100      	bne.n	c0d0018c <io_event+0x98>
c0d0018a:	e15c      	b.n	c0d00446 <io_event+0x352>
c0d0018c:	2800      	cmp	r0, #0
c0d0018e:	d100      	bne.n	c0d00192 <io_event+0x9e>
c0d00190:	e159      	b.n	c0d00446 <io_event+0x352>
c0d00192:	49b4      	ldr	r1, [pc, #720]	; (c0d00464 <io_event+0x370>)
c0d00194:	4288      	cmp	r0, r1
c0d00196:	d000      	beq.n	c0d0019a <io_event+0xa6>
c0d00198:	e0c3      	b.n	c0d00322 <io_event+0x22e>
c0d0019a:	2003      	movs	r0, #3
c0d0019c:	49af      	ldr	r1, [pc, #700]	; (c0d0045c <io_event+0x368>)
c0d0019e:	460d      	mov	r5, r1
c0d001a0:	7628      	strb	r0, [r5, #24]
c0d001a2:	9e04      	ldr	r6, [sp, #16]
c0d001a4:	61ee      	str	r6, [r5, #28]
c0d001a6:	4620      	mov	r0, r4
c0d001a8:	f001 f99e 	bl	c0d014e8 <os_ux>
c0d001ac:	61e8      	str	r0, [r5, #28]
c0d001ae:	f000 fdd5 	bl	c0d00d5c <io_seproxyhal_init_ux>
c0d001b2:	60ae      	str	r6, [r5, #8]
c0d001b4:	6828      	ldr	r0, [r5, #0]
c0d001b6:	2800      	cmp	r0, #0
c0d001b8:	d100      	bne.n	c0d001bc <io_event+0xc8>
c0d001ba:	e144      	b.n	c0d00446 <io_event+0x352>
c0d001bc:	48a7      	ldr	r0, [pc, #668]	; (c0d0045c <io_event+0x368>)
c0d001be:	69c0      	ldr	r0, [r0, #28]
c0d001c0:	49a7      	ldr	r1, [pc, #668]	; (c0d00460 <io_event+0x36c>)
c0d001c2:	4288      	cmp	r0, r1
c0d001c4:	d000      	beq.n	c0d001c8 <io_event+0xd4>
c0d001c6:	e0a9      	b.n	c0d0031c <io_event+0x228>
c0d001c8:	e13d      	b.n	c0d00446 <io_event+0x352>
    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
        break;

    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
c0d001ca:	4da4      	ldr	r5, [pc, #656]	; (c0d0045c <io_event+0x368>)
c0d001cc:	6868      	ldr	r0, [r5, #4]
c0d001ce:	68a9      	ldr	r1, [r5, #8]
c0d001d0:	4281      	cmp	r1, r0
c0d001d2:	d300      	bcc.n	c0d001d6 <io_event+0xe2>
c0d001d4:	e137      	b.n	c0d00446 <io_event+0x352>
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d001d6:	2001      	movs	r0, #1
c0d001d8:	7628      	strb	r0, [r5, #24]
c0d001da:	2600      	movs	r6, #0
c0d001dc:	61ee      	str	r6, [r5, #28]
c0d001de:	462c      	mov	r4, r5
c0d001e0:	3418      	adds	r4, #24
c0d001e2:	4620      	mov	r0, r4
c0d001e4:	f001 f980 	bl	c0d014e8 <os_ux>
c0d001e8:	61e8      	str	r0, [r5, #28]
c0d001ea:	499d      	ldr	r1, [pc, #628]	; (c0d00460 <io_event+0x36c>)
c0d001ec:	4288      	cmp	r0, r1
c0d001ee:	d100      	bne.n	c0d001f2 <io_event+0xfe>
c0d001f0:	e129      	b.n	c0d00446 <io_event+0x352>
c0d001f2:	2800      	cmp	r0, #0
c0d001f4:	d100      	bne.n	c0d001f8 <io_event+0x104>
c0d001f6:	e126      	b.n	c0d00446 <io_event+0x352>
c0d001f8:	499a      	ldr	r1, [pc, #616]	; (c0d00464 <io_event+0x370>)
c0d001fa:	4288      	cmp	r0, r1
c0d001fc:	d000      	beq.n	c0d00200 <io_event+0x10c>
c0d001fe:	e0c0      	b.n	c0d00382 <io_event+0x28e>
c0d00200:	2003      	movs	r0, #3
c0d00202:	7628      	strb	r0, [r5, #24]
c0d00204:	61ee      	str	r6, [r5, #28]
c0d00206:	4620      	mov	r0, r4
c0d00208:	f001 f96e 	bl	c0d014e8 <os_ux>
c0d0020c:	61e8      	str	r0, [r5, #28]
c0d0020e:	f000 fda5 	bl	c0d00d5c <io_seproxyhal_init_ux>
c0d00212:	60ae      	str	r6, [r5, #8]
c0d00214:	6828      	ldr	r0, [r5, #0]
c0d00216:	2800      	cmp	r0, #0
c0d00218:	d100      	bne.n	c0d0021c <io_event+0x128>
c0d0021a:	e114      	b.n	c0d00446 <io_event+0x352>
c0d0021c:	69e8      	ldr	r0, [r5, #28]
c0d0021e:	4990      	ldr	r1, [pc, #576]	; (c0d00460 <io_event+0x36c>)
c0d00220:	4288      	cmp	r0, r1
c0d00222:	d000      	beq.n	c0d00226 <io_event+0x132>
c0d00224:	e0aa      	b.n	c0d0037c <io_event+0x288>
c0d00226:	e10e      	b.n	c0d00446 <io_event+0x352>
        }
        break;

    case SEPROXYHAL_TAG_TICKER_EVENT:
        UX_REDISPLAY();
c0d00228:	f000 fd98 	bl	c0d00d5c <io_seproxyhal_init_ux>
c0d0022c:	4c8b      	ldr	r4, [pc, #556]	; (c0d0045c <io_event+0x368>)
c0d0022e:	2000      	movs	r0, #0
c0d00230:	60a0      	str	r0, [r4, #8]
c0d00232:	6821      	ldr	r1, [r4, #0]
c0d00234:	2900      	cmp	r1, #0
c0d00236:	d100      	bne.n	c0d0023a <io_event+0x146>
c0d00238:	e105      	b.n	c0d00446 <io_event+0x352>
c0d0023a:	69e1      	ldr	r1, [r4, #28]
c0d0023c:	4a88      	ldr	r2, [pc, #544]	; (c0d00460 <io_event+0x36c>)
c0d0023e:	4291      	cmp	r1, r2
c0d00240:	d11a      	bne.n	c0d00278 <io_event+0x184>
c0d00242:	e100      	b.n	c0d00446 <io_event+0x352>
c0d00244:	6861      	ldr	r1, [r4, #4]
c0d00246:	4288      	cmp	r0, r1
c0d00248:	d300      	bcc.n	c0d0024c <io_event+0x158>
c0d0024a:	e0fc      	b.n	c0d00446 <io_event+0x352>
c0d0024c:	f001 f988 	bl	c0d01560 <io_seproxyhal_spi_is_status_sent>
c0d00250:	2800      	cmp	r0, #0
c0d00252:	d000      	beq.n	c0d00256 <io_event+0x162>
c0d00254:	e0f7      	b.n	c0d00446 <io_event+0x352>
c0d00256:	68a0      	ldr	r0, [r4, #8]
c0d00258:	68e1      	ldr	r1, [r4, #12]
c0d0025a:	2538      	movs	r5, #56	; 0x38
c0d0025c:	4368      	muls	r0, r5
c0d0025e:	6822      	ldr	r2, [r4, #0]
c0d00260:	1810      	adds	r0, r2, r0
c0d00262:	2900      	cmp	r1, #0
c0d00264:	d100      	bne.n	c0d00268 <io_event+0x174>
c0d00266:	e0a9      	b.n	c0d003bc <io_event+0x2c8>
c0d00268:	4788      	blx	r1
c0d0026a:	2800      	cmp	r0, #0
c0d0026c:	d000      	beq.n	c0d00270 <io_event+0x17c>
c0d0026e:	e0a5      	b.n	c0d003bc <io_event+0x2c8>
c0d00270:	68a0      	ldr	r0, [r4, #8]
c0d00272:	1c40      	adds	r0, r0, #1
c0d00274:	60a0      	str	r0, [r4, #8]
c0d00276:	6821      	ldr	r1, [r4, #0]
c0d00278:	2900      	cmp	r1, #0
c0d0027a:	d1e3      	bne.n	c0d00244 <io_event+0x150>
c0d0027c:	e0e3      	b.n	c0d00446 <io_event+0x352>
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d0027e:	6870      	ldr	r0, [r6, #4]
c0d00280:	4285      	cmp	r5, r0
c0d00282:	d300      	bcc.n	c0d00286 <io_event+0x192>
c0d00284:	e0df      	b.n	c0d00446 <io_event+0x352>
c0d00286:	f001 f96b 	bl	c0d01560 <io_seproxyhal_spi_is_status_sent>
c0d0028a:	2800      	cmp	r0, #0
c0d0028c:	d000      	beq.n	c0d00290 <io_event+0x19c>
c0d0028e:	e0da      	b.n	c0d00446 <io_event+0x352>
c0d00290:	68b0      	ldr	r0, [r6, #8]
c0d00292:	68f1      	ldr	r1, [r6, #12]
c0d00294:	2438      	movs	r4, #56	; 0x38
c0d00296:	4360      	muls	r0, r4
c0d00298:	6832      	ldr	r2, [r6, #0]
c0d0029a:	1810      	adds	r0, r2, r0
c0d0029c:	2900      	cmp	r1, #0
c0d0029e:	d100      	bne.n	c0d002a2 <io_event+0x1ae>
c0d002a0:	e098      	b.n	c0d003d4 <io_event+0x2e0>
c0d002a2:	4788      	blx	r1
c0d002a4:	2800      	cmp	r0, #0
c0d002a6:	d000      	beq.n	c0d002aa <io_event+0x1b6>
c0d002a8:	e094      	b.n	c0d003d4 <io_event+0x2e0>
c0d002aa:	68b0      	ldr	r0, [r6, #8]
c0d002ac:	1c45      	adds	r5, r0, #1
c0d002ae:	60b5      	str	r5, [r6, #8]
c0d002b0:	6830      	ldr	r0, [r6, #0]
c0d002b2:	2800      	cmp	r0, #0
c0d002b4:	d1e3      	bne.n	c0d0027e <io_event+0x18a>
c0d002b6:	e0c6      	b.n	c0d00446 <io_event+0x352>
c0d002b8:	6930      	ldr	r0, [r6, #16]
c0d002ba:	2800      	cmp	r0, #0
c0d002bc:	4b66      	ldr	r3, [pc, #408]	; (c0d00458 <io_event+0x364>)
c0d002be:	d100      	bne.n	c0d002c2 <io_event+0x1ce>
c0d002c0:	e0c1      	b.n	c0d00446 <io_event+0x352>
c0d002c2:	4a67      	ldr	r2, [pc, #412]	; (c0d00460 <io_event+0x36c>)
c0d002c4:	4291      	cmp	r1, r2
c0d002c6:	d100      	bne.n	c0d002ca <io_event+0x1d6>
c0d002c8:	e0bd      	b.n	c0d00446 <io_event+0x352>
c0d002ca:	2900      	cmp	r1, #0
c0d002cc:	d100      	bne.n	c0d002d0 <io_event+0x1dc>
c0d002ce:	e0ba      	b.n	c0d00446 <io_event+0x352>
c0d002d0:	78d9      	ldrb	r1, [r3, #3]
c0d002d2:	0849      	lsrs	r1, r1, #1
c0d002d4:	f000 ff12 	bl	c0d010fc <io_seproxyhal_button_push>
c0d002d8:	e0b5      	b.n	c0d00446 <io_event+0x352>
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d002da:	4860      	ldr	r0, [pc, #384]	; (c0d0045c <io_event+0x368>)
c0d002dc:	6840      	ldr	r0, [r0, #4]
c0d002de:	9904      	ldr	r1, [sp, #16]
c0d002e0:	4281      	cmp	r1, r0
c0d002e2:	d300      	bcc.n	c0d002e6 <io_event+0x1f2>
c0d002e4:	e0af      	b.n	c0d00446 <io_event+0x352>
c0d002e6:	f001 f93b 	bl	c0d01560 <io_seproxyhal_spi_is_status_sent>
c0d002ea:	2800      	cmp	r0, #0
c0d002ec:	d000      	beq.n	c0d002f0 <io_event+0x1fc>
c0d002ee:	e0aa      	b.n	c0d00446 <io_event+0x352>
c0d002f0:	485a      	ldr	r0, [pc, #360]	; (c0d0045c <io_event+0x368>)
c0d002f2:	4602      	mov	r2, r0
c0d002f4:	6890      	ldr	r0, [r2, #8]
c0d002f6:	68d1      	ldr	r1, [r2, #12]
c0d002f8:	2438      	movs	r4, #56	; 0x38
c0d002fa:	4360      	muls	r0, r4
c0d002fc:	6812      	ldr	r2, [r2, #0]
c0d002fe:	1810      	adds	r0, r2, r0
c0d00300:	2900      	cmp	r1, #0
c0d00302:	d100      	bne.n	c0d00306 <io_event+0x212>
c0d00304:	e084      	b.n	c0d00410 <io_event+0x31c>
c0d00306:	4788      	blx	r1
c0d00308:	2800      	cmp	r0, #0
c0d0030a:	d000      	beq.n	c0d0030e <io_event+0x21a>
c0d0030c:	e080      	b.n	c0d00410 <io_event+0x31c>
c0d0030e:	4853      	ldr	r0, [pc, #332]	; (c0d0045c <io_event+0x368>)
c0d00310:	4601      	mov	r1, r0
c0d00312:	6888      	ldr	r0, [r1, #8]
c0d00314:	1c40      	adds	r0, r0, #1
c0d00316:	9004      	str	r0, [sp, #16]
c0d00318:	6088      	str	r0, [r1, #8]
c0d0031a:	6808      	ldr	r0, [r1, #0]
c0d0031c:	2800      	cmp	r0, #0
c0d0031e:	d1dc      	bne.n	c0d002da <io_event+0x1e6>
c0d00320:	e091      	b.n	c0d00446 <io_event+0x352>
c0d00322:	484e      	ldr	r0, [pc, #312]	; (c0d0045c <io_event+0x368>)
c0d00324:	8881      	ldrh	r1, [r0, #4]
c0d00326:	9104      	str	r1, [sp, #16]
c0d00328:	6801      	ldr	r1, [r0, #0]
c0d0032a:	9103      	str	r1, [sp, #12]
c0d0032c:	79f4      	ldrb	r4, [r6, #7]
c0d0032e:	79b3      	ldrb	r3, [r6, #6]
c0d00330:	7975      	ldrb	r5, [r6, #5]
c0d00332:	7932      	ldrb	r2, [r6, #4]
c0d00334:	78f6      	ldrb	r6, [r6, #3]
c0d00336:	68c1      	ldr	r1, [r0, #12]
c0d00338:	4668      	mov	r0, sp
c0d0033a:	6006      	str	r6, [r0, #0]
c0d0033c:	6041      	str	r1, [r0, #4]
c0d0033e:	0212      	lsls	r2, r2, #8
c0d00340:	432a      	orrs	r2, r5
c0d00342:	021b      	lsls	r3, r3, #8
c0d00344:	4323      	orrs	r3, r4
c0d00346:	9803      	ldr	r0, [sp, #12]
c0d00348:	9904      	ldr	r1, [sp, #16]
c0d0034a:	f000 fd81 	bl	c0d00e50 <io_seproxyhal_touch_element_callback>
c0d0034e:	e07a      	b.n	c0d00446 <io_event+0x352>
    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d00350:	6868      	ldr	r0, [r5, #4]
c0d00352:	4286      	cmp	r6, r0
c0d00354:	d277      	bcs.n	c0d00446 <io_event+0x352>
c0d00356:	f001 f903 	bl	c0d01560 <io_seproxyhal_spi_is_status_sent>
c0d0035a:	2800      	cmp	r0, #0
c0d0035c:	d173      	bne.n	c0d00446 <io_event+0x352>
c0d0035e:	68a8      	ldr	r0, [r5, #8]
c0d00360:	68e9      	ldr	r1, [r5, #12]
c0d00362:	2438      	movs	r4, #56	; 0x38
c0d00364:	4360      	muls	r0, r4
c0d00366:	682a      	ldr	r2, [r5, #0]
c0d00368:	1810      	adds	r0, r2, r0
c0d0036a:	2900      	cmp	r1, #0
c0d0036c:	d060      	beq.n	c0d00430 <io_event+0x33c>
c0d0036e:	4788      	blx	r1
c0d00370:	2800      	cmp	r0, #0
c0d00372:	d15d      	bne.n	c0d00430 <io_event+0x33c>
c0d00374:	68a8      	ldr	r0, [r5, #8]
c0d00376:	1c46      	adds	r6, r0, #1
c0d00378:	60ae      	str	r6, [r5, #8]
c0d0037a:	6828      	ldr	r0, [r5, #0]
c0d0037c:	2800      	cmp	r0, #0
c0d0037e:	d1e7      	bne.n	c0d00350 <io_event+0x25c>
c0d00380:	e061      	b.n	c0d00446 <io_event+0x352>
c0d00382:	6828      	ldr	r0, [r5, #0]
c0d00384:	2800      	cmp	r0, #0
c0d00386:	d03c      	beq.n	c0d00402 <io_event+0x30e>
c0d00388:	68a8      	ldr	r0, [r5, #8]
c0d0038a:	6869      	ldr	r1, [r5, #4]
c0d0038c:	4288      	cmp	r0, r1
c0d0038e:	d238      	bcs.n	c0d00402 <io_event+0x30e>
c0d00390:	f001 f8e6 	bl	c0d01560 <io_seproxyhal_spi_is_status_sent>
c0d00394:	2800      	cmp	r0, #0
c0d00396:	d134      	bne.n	c0d00402 <io_event+0x30e>
c0d00398:	68a8      	ldr	r0, [r5, #8]
c0d0039a:	68e9      	ldr	r1, [r5, #12]
c0d0039c:	2438      	movs	r4, #56	; 0x38
c0d0039e:	4360      	muls	r0, r4
c0d003a0:	682a      	ldr	r2, [r5, #0]
c0d003a2:	1810      	adds	r0, r2, r0
c0d003a4:	2900      	cmp	r1, #0
c0d003a6:	d021      	beq.n	c0d003ec <io_event+0x2f8>
c0d003a8:	4788      	blx	r1
c0d003aa:	2800      	cmp	r0, #0
c0d003ac:	d11e      	bne.n	c0d003ec <io_event+0x2f8>
c0d003ae:	68a8      	ldr	r0, [r5, #8]
c0d003b0:	1c40      	adds	r0, r0, #1
c0d003b2:	60a8      	str	r0, [r5, #8]
c0d003b4:	6829      	ldr	r1, [r5, #0]
c0d003b6:	2900      	cmp	r1, #0
c0d003b8:	d1e7      	bne.n	c0d0038a <io_event+0x296>
c0d003ba:	e022      	b.n	c0d00402 <io_event+0x30e>
        }
        break;

    case SEPROXYHAL_TAG_TICKER_EVENT:
        UX_REDISPLAY();
c0d003bc:	2801      	cmp	r0, #1
c0d003be:	d103      	bne.n	c0d003c8 <io_event+0x2d4>
c0d003c0:	68a0      	ldr	r0, [r4, #8]
c0d003c2:	4345      	muls	r5, r0
c0d003c4:	6820      	ldr	r0, [r4, #0]
c0d003c6:	1940      	adds	r0, r0, r5
return_to_dashboard:
    return;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d003c8:	f000 fe12 	bl	c0d00ff0 <io_seproxyhal_display_default>
c0d003cc:	68a0      	ldr	r0, [r4, #8]
c0d003ce:	1c40      	adds	r0, r0, #1
            UX_DISPLAYED_EVENT();
        }
        break;

    case SEPROXYHAL_TAG_TICKER_EVENT:
        UX_REDISPLAY();
c0d003d0:	60a0      	str	r0, [r4, #8]
c0d003d2:	e038      	b.n	c0d00446 <io_event+0x352>
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d003d4:	2801      	cmp	r0, #1
c0d003d6:	d103      	bne.n	c0d003e0 <io_event+0x2ec>
c0d003d8:	68b0      	ldr	r0, [r6, #8]
c0d003da:	4344      	muls	r4, r0
c0d003dc:	6830      	ldr	r0, [r6, #0]
c0d003de:	1900      	adds	r0, r0, r4
return_to_dashboard:
    return;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d003e0:	f000 fe06 	bl	c0d00ff0 <io_seproxyhal_display_default>
c0d003e4:	68b0      	ldr	r0, [r6, #8]
c0d003e6:	1c40      	adds	r0, r0, #1
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
        break;

    case SEPROXYHAL_TAG_BUTTON_PUSH_EVENT: // for Nano S
        UX_BUTTON_PUSH_EVENT(G_io_seproxyhal_spi_buffer);
c0d003e8:	60b0      	str	r0, [r6, #8]
c0d003ea:	e02c      	b.n	c0d00446 <io_event+0x352>
    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d003ec:	2801      	cmp	r0, #1
c0d003ee:	d103      	bne.n	c0d003f8 <io_event+0x304>
c0d003f0:	68a8      	ldr	r0, [r5, #8]
c0d003f2:	4344      	muls	r4, r0
c0d003f4:	6828      	ldr	r0, [r5, #0]
c0d003f6:	1900      	adds	r0, r0, r4
return_to_dashboard:
    return;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d003f8:	f000 fdfa 	bl	c0d00ff0 <io_seproxyhal_display_default>
c0d003fc:	68a8      	ldr	r0, [r5, #8]
c0d003fe:	1c40      	adds	r0, r0, #1
    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d00400:	60a8      	str	r0, [r5, #8]
c0d00402:	6868      	ldr	r0, [r5, #4]
c0d00404:	68a9      	ldr	r1, [r5, #8]
c0d00406:	4281      	cmp	r1, r0
c0d00408:	d31d      	bcc.n	c0d00446 <io_event+0x352>
c0d0040a:	f001 f8a9 	bl	c0d01560 <io_seproxyhal_spi_is_status_sent>
c0d0040e:	e01a      	b.n	c0d00446 <io_event+0x352>
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d00410:	2801      	cmp	r0, #1
c0d00412:	d105      	bne.n	c0d00420 <io_event+0x32c>
c0d00414:	4811      	ldr	r0, [pc, #68]	; (c0d0045c <io_event+0x368>)
c0d00416:	4601      	mov	r1, r0
c0d00418:	6888      	ldr	r0, [r1, #8]
c0d0041a:	4344      	muls	r4, r0
c0d0041c:	6808      	ldr	r0, [r1, #0]
c0d0041e:	1900      	adds	r0, r0, r4
return_to_dashboard:
    return;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d00420:	f000 fde6 	bl	c0d00ff0 <io_seproxyhal_display_default>
c0d00424:	480d      	ldr	r0, [pc, #52]	; (c0d0045c <io_event+0x368>)
c0d00426:	4601      	mov	r1, r0
c0d00428:	6888      	ldr	r0, [r1, #8]
c0d0042a:	1c40      	adds	r0, r0, #1
    // needed

    // can't have more than one tag in the reply, not supported yet.
    switch (G_io_seproxyhal_spi_buffer[0]) {
    case SEPROXYHAL_TAG_FINGER_EVENT:
        UX_FINGER_EVENT(G_io_seproxyhal_spi_buffer);
c0d0042c:	6088      	str	r0, [r1, #8]
c0d0042e:	e00a      	b.n	c0d00446 <io_event+0x352>
    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d00430:	2801      	cmp	r0, #1
c0d00432:	d103      	bne.n	c0d0043c <io_event+0x348>
c0d00434:	68a8      	ldr	r0, [r5, #8]
c0d00436:	4344      	muls	r4, r0
c0d00438:	6828      	ldr	r0, [r5, #0]
c0d0043a:	1900      	adds	r0, r0, r4
return_to_dashboard:
    return;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d0043c:	f000 fdd8 	bl	c0d00ff0 <io_seproxyhal_display_default>
c0d00440:	68a8      	ldr	r0, [r5, #8]
c0d00442:	1c40      	adds	r0, r0, #1
    case SEPROXYHAL_TAG_DISPLAY_PROCESSED_EVENT:
        if (UX_DISPLAYED()) {
            // TODO perform actions after all screen elements have been
            // displayed
        } else {
            UX_DISPLAYED_EVENT();
c0d00444:	60a8      	str	r0, [r5, #8]
    default:
        break;
    }

    // close the event if not done previously (by a display or whatever)
    if (!io_seproxyhal_spi_is_status_sent()) {
c0d00446:	f001 f88b 	bl	c0d01560 <io_seproxyhal_spi_is_status_sent>
c0d0044a:	2800      	cmp	r0, #0
c0d0044c:	d101      	bne.n	c0d00452 <io_event+0x35e>
        io_seproxyhal_general_status();
c0d0044e:	f000 fb59 	bl	c0d00b04 <io_seproxyhal_general_status>
    }

    // command has been processed, DO NOT reset the current APDU transport
    return 1;
c0d00452:	2001      	movs	r0, #1
c0d00454:	b005      	add	sp, #20
c0d00456:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00458:	20001800 	.word	0x20001800
c0d0045c:	20001880 	.word	0x20001880
c0d00460:	b0105044 	.word	0xb0105044
c0d00464:	b0105055 	.word	0xb0105055

c0d00468 <derive>:
    }
    os_memmove(out, (buffer + j), length);
    return length;
}

static bool derive() {
c0d00468:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0046a:	af03      	add	r7, sp, #12
c0d0046c:	b0e3      	sub	sp, #396	; 0x18c
    } u;
    unsigned char privateKeyData[32];
    unsigned char tmp[25];
    unsigned int length;

    if (!os_global_pin_is_validated()) {
c0d0046e:	f000 ffe5 	bl	c0d0143c <os_global_pin_is_validated>
c0d00472:	2800      	cmp	r0, #0
c0d00474:	d019      	beq.n	c0d004aa <derive+0x42>
c0d00476:	2600      	movs	r6, #0
        os_memmove(address, NOT_AVAILABLE, sizeof(NOT_AVAILABLE));
        return false;
    }

    os_perso_derive_node_bip32(CX_CURVE_256K1, path, 5, privateKeyData, NULL);
c0d00478:	4668      	mov	r0, sp
c0d0047a:	6006      	str	r6, [r0, #0]
c0d0047c:	2021      	movs	r0, #33	; 0x21
c0d0047e:	4947      	ldr	r1, [pc, #284]	; (c0d0059c <derive+0x134>)
c0d00480:	2205      	movs	r2, #5
c0d00482:	ad09      	add	r5, sp, #36	; 0x24
c0d00484:	462b      	mov	r3, r5
c0d00486:	f000 ffb9 	bl	c0d013fc <os_perso_derive_node_bip32>
c0d0048a:	a83a      	add	r0, sp, #232	; 0xe8
    unsigned char startAt;
    unsigned char zeroCount = 0;
    if (length > sizeof(tmp)) {
        THROW(INVALID_PARAMETER);
    }
    os_memmove(tmp, in, length);
c0d0048c:	2420      	movs	r4, #32
c0d0048e:	4629      	mov	r1, r5
c0d00490:	4622      	mov	r2, r4
c0d00492:	f000 fa9d 	bl	c0d009d0 <os_memmove>
c0d00496:	a83a      	add	r0, sp, #232	; 0xe8
    while ((zeroCount < length) && (tmp[zeroCount] == 0)) {
c0d00498:	5d80      	ldrb	r0, [r0, r6]
c0d0049a:	2800      	cmp	r0, #0
c0d0049c:	d10d      	bne.n	c0d004ba <derive+0x52>
        ++zeroCount;
c0d0049e:	1c76      	adds	r6, r6, #1
c0d004a0:	2240      	movs	r2, #64	; 0x40
    unsigned char zeroCount = 0;
    if (length > sizeof(tmp)) {
        THROW(INVALID_PARAMETER);
    }
    os_memmove(tmp, in, length);
    while ((zeroCount < length) && (tmp[zeroCount] == 0)) {
c0d004a2:	2e20      	cmp	r6, #32
c0d004a4:	d3f7      	bcc.n	c0d00496 <derive+0x2e>
c0d004a6:	4625      	mov	r5, r4
c0d004a8:	e053      	b.n	c0d00552 <derive+0xea>
    unsigned char privateKeyData[32];
    unsigned char tmp[25];
    unsigned int length;

    if (!os_global_pin_is_validated()) {
        os_memmove(address, NOT_AVAILABLE, sizeof(NOT_AVAILABLE));
c0d004aa:	484c      	ldr	r0, [pc, #304]	; (c0d005dc <BASE58ALPHABET+0x3c>)
c0d004ac:	494d      	ldr	r1, [pc, #308]	; (c0d005e4 <BASE58ALPHABET+0x44>)
c0d004ae:	4479      	add	r1, pc
c0d004b0:	220e      	movs	r2, #14
c0d004b2:	f000 fa8d 	bl	c0d009d0 <os_memmove>
c0d004b6:	2000      	movs	r0, #0
c0d004b8:	e068      	b.n	c0d0058c <derive+0x124>
c0d004ba:	2000      	movs	r0, #0
c0d004bc:	9003      	str	r0, [sp, #12]
c0d004be:	43c1      	mvns	r1, r0
c0d004c0:	2040      	movs	r0, #64	; 0x40
c0d004c2:	9007      	str	r0, [sp, #28]
c0d004c4:	223f      	movs	r2, #63	; 0x3f
c0d004c6:	4635      	mov	r5, r6
c0d004c8:	9602      	str	r6, [sp, #8]
c0d004ca:	4633      	mov	r3, r6
c0d004cc:	460e      	mov	r6, r1
    }
    j = 2 * length;
    startAt = zeroCount;
    while (startAt < length) {
        unsigned short remainder = 0;
        unsigned char divLoop;
c0d004ce:	9608      	str	r6, [sp, #32]
c0d004d0:	9505      	str	r5, [sp, #20]
c0d004d2:	9206      	str	r2, [sp, #24]
c0d004d4:	9304      	str	r3, [sp, #16]
        for (divLoop = startAt; divLoop < length; divLoop++) {
c0d004d6:	b2dd      	uxtb	r5, r3
c0d004d8:	4375      	muls	r5, r6
c0d004da:	9903      	ldr	r1, [sp, #12]
            unsigned short digit256 = (unsigned short)(tmp[divLoop] & 0xff);
c0d004dc:	4634      	mov	r4, r6
c0d004de:	436c      	muls	r4, r5
c0d004e0:	ae3a      	add	r6, sp, #232	; 0xe8
            unsigned short tmpDiv = remainder * 256 + digit256;
c0d004e2:	5d32      	ldrb	r2, [r6, r4]
c0d004e4:	0208      	lsls	r0, r1, #8
            tmp[divLoop] = (unsigned char)(tmpDiv / 58);
c0d004e6:	4310      	orrs	r0, r2
c0d004e8:	213a      	movs	r1, #58	; 0x3a
            remainder = (tmpDiv % 58);
c0d004ea:	f001 ff8b 	bl	c0d02404 <__aeabi_uidivmod>
        unsigned short remainder = 0;
        unsigned char divLoop;
        for (divLoop = startAt; divLoop < length; divLoop++) {
            unsigned short digit256 = (unsigned short)(tmp[divLoop] & 0xff);
            unsigned short tmpDiv = remainder * 256 + digit256;
            tmp[divLoop] = (unsigned char)(tmpDiv / 58);
c0d004ee:	5530      	strb	r0, [r6, r4]
c0d004f0:	9e08      	ldr	r6, [sp, #32]
    j = 2 * length;
    startAt = zeroCount;
    while (startAt < length) {
        unsigned short remainder = 0;
        unsigned char divLoop;
        for (divLoop = startAt; divLoop < length; divLoop++) {
c0d004f2:	1e6d      	subs	r5, r5, #1
c0d004f4:	4628      	mov	r0, r5
c0d004f6:	3020      	adds	r0, #32
c0d004f8:	d1f0      	bne.n	c0d004dc <derive+0x74>
c0d004fa:	a83a      	add	r0, sp, #232	; 0xe8
            unsigned short digit256 = (unsigned short)(tmp[divLoop] & 0xff);
            unsigned short tmpDiv = remainder * 256 + digit256;
            tmp[divLoop] = (unsigned char)(tmpDiv / 58);
            remainder = (tmpDiv % 58);
        }
        if (tmp[startAt] == 0) {
c0d004fc:	9a05      	ldr	r2, [sp, #20]
c0d004fe:	5c82      	ldrb	r2, [r0, r2]
            ++startAt;
        }
        buffer[--j] = BASE58ALPHABET[remainder];
c0d00500:	a027      	add	r0, pc, #156	; (adr r0, c0d005a0 <BASE58ALPHABET>)
c0d00502:	5c43      	ldrb	r3, [r0, r1]
c0d00504:	9807      	ldr	r0, [sp, #28]
c0d00506:	1e40      	subs	r0, r0, #1
c0d00508:	9007      	str	r0, [sp, #28]
c0d0050a:	b2c0      	uxtb	r0, r0
c0d0050c:	ac11      	add	r4, sp, #68	; 0x44
c0d0050e:	5423      	strb	r3, [r4, r0]
c0d00510:	9c04      	ldr	r4, [sp, #16]
            unsigned short digit256 = (unsigned short)(tmp[divLoop] & 0xff);
            unsigned short tmpDiv = remainder * 256 + digit256;
            tmp[divLoop] = (unsigned char)(tmpDiv / 58);
            remainder = (tmpDiv % 58);
        }
        if (tmp[startAt] == 0) {
c0d00512:	1c63      	adds	r3, r4, #1
c0d00514:	2a00      	cmp	r2, #0
c0d00516:	d000      	beq.n	c0d0051a <derive+0xb2>
c0d00518:	4623      	mov	r3, r4
c0d0051a:	b2dd      	uxtb	r5, r3
c0d0051c:	9c06      	ldr	r4, [sp, #24]
    while ((zeroCount < length) && (tmp[zeroCount] == 0)) {
        ++zeroCount;
    }
    j = 2 * length;
    startAt = zeroCount;
    while (startAt < length) {
c0d0051e:	1e62      	subs	r2, r4, #1
c0d00520:	2d20      	cmp	r5, #32
c0d00522:	d3d5      	bcc.n	c0d004d0 <derive+0x68>
        if (tmp[startAt] == 0) {
            ++startAt;
        }
        buffer[--j] = BASE58ALPHABET[remainder];
    }
    while ((j < (2 * length)) && (buffer[j] == BASE58ALPHABET[0])) {
c0d00524:	283f      	cmp	r0, #63	; 0x3f
c0d00526:	d80f      	bhi.n	c0d00548 <derive+0xe0>
c0d00528:	2900      	cmp	r1, #0
c0d0052a:	9d02      	ldr	r5, [sp, #8]
c0d0052c:	9a07      	ldr	r2, [sp, #28]
c0d0052e:	d10d      	bne.n	c0d0054c <derive+0xe4>
        ++j;
c0d00530:	b2e0      	uxtb	r0, r4
c0d00532:	1c40      	adds	r0, r0, #1
c0d00534:	1c52      	adds	r2, r2, #1
        if (tmp[startAt] == 0) {
            ++startAt;
        }
        buffer[--j] = BASE58ALPHABET[remainder];
    }
    while ((j < (2 * length)) && (buffer[j] == BASE58ALPHABET[0])) {
c0d00536:	283f      	cmp	r0, #63	; 0x3f
c0d00538:	d808      	bhi.n	c0d0054c <derive+0xe4>
c0d0053a:	a911      	add	r1, sp, #68	; 0x44
c0d0053c:	5c09      	ldrb	r1, [r1, r0]
c0d0053e:	1c40      	adds	r0, r0, #1
c0d00540:	2931      	cmp	r1, #49	; 0x31
c0d00542:	d0f7      	beq.n	c0d00534 <derive+0xcc>
c0d00544:	1e42      	subs	r2, r0, #1
c0d00546:	e001      	b.n	c0d0054c <derive+0xe4>
c0d00548:	9d02      	ldr	r5, [sp, #8]
c0d0054a:	9a07      	ldr	r2, [sp, #28]
c0d0054c:	20ff      	movs	r0, #255	; 0xff
        ++j;
    }
    while (zeroCount-- > 0) {
c0d0054e:	4205      	tst	r5, r0
c0d00550:	d00d      	beq.n	c0d0056e <derive+0x106>
c0d00552:	4616      	mov	r6, r2
c0d00554:	4610      	mov	r0, r2
c0d00556:	4629      	mov	r1, r5
        buffer[--j] = BASE58ALPHABET[0];
c0d00558:	1e40      	subs	r0, r0, #1
c0d0055a:	b2c2      	uxtb	r2, r0
c0d0055c:	ab11      	add	r3, sp, #68	; 0x44
c0d0055e:	2431      	movs	r4, #49	; 0x31
c0d00560:	549c      	strb	r4, [r3, r2]
        buffer[--j] = BASE58ALPHABET[remainder];
    }
    while ((j < (2 * length)) && (buffer[j] == BASE58ALPHABET[0])) {
        ++j;
    }
    while (zeroCount-- > 0) {
c0d00562:	1e49      	subs	r1, r1, #1
c0d00564:	22ff      	movs	r2, #255	; 0xff
c0d00566:	4211      	tst	r1, r2
c0d00568:	d1f6      	bne.n	c0d00558 <derive+0xf0>
c0d0056a:	4632      	mov	r2, r6
c0d0056c:	1b52      	subs	r2, r2, r5
        buffer[--j] = BASE58ALPHABET[0];
    }
    length = 2 * length - j;
c0d0056e:	b2d0      	uxtb	r0, r2
c0d00570:	2140      	movs	r1, #64	; 0x40
c0d00572:	1a0c      	subs	r4, r1, r0
    if (maxoutlen < length) {
c0d00574:	2c65      	cmp	r4, #101	; 0x65
c0d00576:	d20b      	bcs.n	c0d00590 <derive+0x128>
c0d00578:	a911      	add	r1, sp, #68	; 0x44
        THROW(EXCEPTION_OVERFLOW);
    }
    os_memmove(out, (buffer + j), length);
c0d0057a:	1809      	adds	r1, r1, r0
c0d0057c:	4d17      	ldr	r5, [pc, #92]	; (c0d005dc <BASE58ALPHABET+0x3c>)
c0d0057e:	4628      	mov	r0, r5
c0d00580:	4622      	mov	r2, r4
c0d00582:	f000 fa25 	bl	c0d009d0 <os_memmove>
        return false;
    }

    os_perso_derive_node_bip32(CX_CURVE_256K1, path, 5, privateKeyData, NULL);
    length = encode_base58(privateKeyData, sizeof(privateKeyData), address, sizeof(address));
    address[length] = '\0';
c0d00586:	2000      	movs	r0, #0
c0d00588:	5528      	strb	r0, [r5, r4]
c0d0058a:	2001      	movs	r0, #1
    return true;
}
c0d0058c:	b063      	add	sp, #396	; 0x18c
c0d0058e:	bdf0      	pop	{r4, r5, r6, r7, pc}
    while (zeroCount-- > 0) {
        buffer[--j] = BASE58ALPHABET[0];
    }
    length = 2 * length - j;
    if (maxoutlen < length) {
        THROW(EXCEPTION_OVERFLOW);
c0d00590:	4813      	ldr	r0, [pc, #76]	; (c0d005e0 <BASE58ALPHABET+0x40>)
c0d00592:	6800      	ldr	r0, [r0, #0]
c0d00594:	2103      	movs	r1, #3
c0d00596:	f001 ff9b 	bl	c0d024d0 <longjmp>
c0d0059a:	46c0      	nop			; (mov r8, r8)
c0d0059c:	20001930 	.word	0x20001930

c0d005a0 <BASE58ALPHABET>:
c0d005a0:	34333231 	.word	0x34333231
c0d005a4:	38373635 	.word	0x38373635
c0d005a8:	43424139 	.word	0x43424139
c0d005ac:	47464544 	.word	0x47464544
c0d005b0:	4c4b4a48 	.word	0x4c4b4a48
c0d005b4:	51504e4d 	.word	0x51504e4d
c0d005b8:	55545352 	.word	0x55545352
c0d005bc:	59585756 	.word	0x59585756
c0d005c0:	6362615a 	.word	0x6362615a
c0d005c4:	67666564 	.word	0x67666564
c0d005c8:	6b6a6968 	.word	0x6b6a6968
c0d005cc:	706f6e6d 	.word	0x706f6e6d
c0d005d0:	74737271 	.word	0x74737271
c0d005d4:	78777675 	.word	0x78777675
c0d005d8:	00007a79 	.word	0x00007a79
c0d005dc:	20001944 	.word	0x20001944
c0d005e0:	200019a8 	.word	0x200019a8
c0d005e4:	000022b8 	.word	0x000022b8

c0d005e8 <ui_idle>:
        THROW(INVALID_PARAMETER);
    }
    return 0;
}

static void ui_idle(void) {
c0d005e8:	b5b0      	push	{r4, r5, r7, lr}
c0d005ea:	af02      	add	r7, sp, #8
#ifdef TARGET_BLUE
    UX_DISPLAY(bagl_ui_sample_blue, NULL);
#else
    UX_DISPLAY(bagl_ui_sample_nanos, bagl_ui_sample_nanos_prepro);
c0d005ec:	4c22      	ldr	r4, [pc, #136]	; (c0d00678 <ui_idle+0x90>)
c0d005ee:	4824      	ldr	r0, [pc, #144]	; (c0d00680 <ui_idle+0x98>)
c0d005f0:	4478      	add	r0, pc
c0d005f2:	6020      	str	r0, [r4, #0]
c0d005f4:	2005      	movs	r0, #5
c0d005f6:	6060      	str	r0, [r4, #4]
c0d005f8:	4822      	ldr	r0, [pc, #136]	; (c0d00684 <ui_idle+0x9c>)
c0d005fa:	4478      	add	r0, pc
c0d005fc:	6120      	str	r0, [r4, #16]
c0d005fe:	4822      	ldr	r0, [pc, #136]	; (c0d00688 <ui_idle+0xa0>)
c0d00600:	4478      	add	r0, pc
c0d00602:	60e0      	str	r0, [r4, #12]
c0d00604:	2003      	movs	r0, #3
c0d00606:	7620      	strb	r0, [r4, #24]
c0d00608:	2500      	movs	r5, #0
c0d0060a:	61e5      	str	r5, [r4, #28]
c0d0060c:	4620      	mov	r0, r4
c0d0060e:	3018      	adds	r0, #24
c0d00610:	f000 ff6a 	bl	c0d014e8 <os_ux>
c0d00614:	61e0      	str	r0, [r4, #28]
c0d00616:	f000 fba1 	bl	c0d00d5c <io_seproxyhal_init_ux>
c0d0061a:	60a5      	str	r5, [r4, #8]
c0d0061c:	6820      	ldr	r0, [r4, #0]
c0d0061e:	2800      	cmp	r0, #0
c0d00620:	d028      	beq.n	c0d00674 <ui_idle+0x8c>
c0d00622:	69e0      	ldr	r0, [r4, #28]
c0d00624:	4915      	ldr	r1, [pc, #84]	; (c0d0067c <ui_idle+0x94>)
c0d00626:	4288      	cmp	r0, r1
c0d00628:	d116      	bne.n	c0d00658 <ui_idle+0x70>
c0d0062a:	e023      	b.n	c0d00674 <ui_idle+0x8c>
c0d0062c:	6860      	ldr	r0, [r4, #4]
c0d0062e:	4285      	cmp	r5, r0
c0d00630:	d220      	bcs.n	c0d00674 <ui_idle+0x8c>
c0d00632:	f000 ff95 	bl	c0d01560 <io_seproxyhal_spi_is_status_sent>
c0d00636:	2800      	cmp	r0, #0
c0d00638:	d11c      	bne.n	c0d00674 <ui_idle+0x8c>
c0d0063a:	68a0      	ldr	r0, [r4, #8]
c0d0063c:	68e1      	ldr	r1, [r4, #12]
c0d0063e:	2538      	movs	r5, #56	; 0x38
c0d00640:	4368      	muls	r0, r5
c0d00642:	6822      	ldr	r2, [r4, #0]
c0d00644:	1810      	adds	r0, r2, r0
c0d00646:	2900      	cmp	r1, #0
c0d00648:	d009      	beq.n	c0d0065e <ui_idle+0x76>
c0d0064a:	4788      	blx	r1
c0d0064c:	2800      	cmp	r0, #0
c0d0064e:	d106      	bne.n	c0d0065e <ui_idle+0x76>
c0d00650:	68a0      	ldr	r0, [r4, #8]
c0d00652:	1c45      	adds	r5, r0, #1
c0d00654:	60a5      	str	r5, [r4, #8]
c0d00656:	6820      	ldr	r0, [r4, #0]
c0d00658:	2800      	cmp	r0, #0
c0d0065a:	d1e7      	bne.n	c0d0062c <ui_idle+0x44>
c0d0065c:	e00a      	b.n	c0d00674 <ui_idle+0x8c>
c0d0065e:	2801      	cmp	r0, #1
c0d00660:	d103      	bne.n	c0d0066a <ui_idle+0x82>
c0d00662:	68a0      	ldr	r0, [r4, #8]
c0d00664:	4345      	muls	r5, r0
c0d00666:	6820      	ldr	r0, [r4, #0]
c0d00668:	1940      	adds	r0, r0, r5
return_to_dashboard:
    return;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d0066a:	f000 fcc1 	bl	c0d00ff0 <io_seproxyhal_display_default>
c0d0066e:	68a0      	ldr	r0, [r4, #8]
c0d00670:	1c40      	adds	r0, r0, #1

static void ui_idle(void) {
#ifdef TARGET_BLUE
    UX_DISPLAY(bagl_ui_sample_blue, NULL);
#else
    UX_DISPLAY(bagl_ui_sample_nanos, bagl_ui_sample_nanos_prepro);
c0d00672:	60a0      	str	r0, [r4, #8]
#endif
}
c0d00674:	bdb0      	pop	{r4, r5, r7, pc}
c0d00676:	46c0      	nop			; (mov r8, r8)
c0d00678:	20001880 	.word	0x20001880
c0d0067c:	b0105044 	.word	0xb0105044
c0d00680:	00001f60 	.word	0x00001f60
c0d00684:	000001af 	.word	0x000001af
c0d00688:	0000021d 	.word	0x0000021d

c0d0068c <sample_main>:

static void sample_main(void) {
c0d0068c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0068e:	af03      	add	r7, sp, #12
c0d00690:	b091      	sub	sp, #68	; 0x44
c0d00692:	2600      	movs	r6, #0
    volatile unsigned int rx = 0;
c0d00694:	9610      	str	r6, [sp, #64]	; 0x40
    volatile unsigned int tx = 0;
c0d00696:	960f      	str	r6, [sp, #60]	; 0x3c
    volatile unsigned int flags = 0;
c0d00698:	960e      	str	r6, [sp, #56]	; 0x38
c0d0069a:	a80d      	add	r0, sp, #52	; 0x34
    // When APDU are to be fetched from multiple IOs, like NFC+USB+BLE, make
    // sure the io_event is called with a
    // switch event, before the apdu is replied to the bootloader. This avoid
    // APDU injection faults.
    for (;;) {
        volatile unsigned short sw = 0;
c0d0069c:	8006      	strh	r6, [r0, #0]

        BEGIN_TRY {
            TRY {
c0d0069e:	4d3e      	ldr	r5, [pc, #248]	; (c0d00798 <sample_main+0x10c>)
c0d006a0:	6828      	ldr	r0, [r5, #0]
c0d006a2:	900b      	str	r0, [sp, #44]	; 0x2c
c0d006a4:	ac01      	add	r4, sp, #4
c0d006a6:	4620      	mov	r0, r4
c0d006a8:	f001 ff06 	bl	c0d024b8 <setjmp>
c0d006ac:	85a0      	strh	r0, [r4, #44]	; 0x2c
c0d006ae:	602c      	str	r4, [r5, #0]
c0d006b0:	462c      	mov	r4, r5
c0d006b2:	4d3a      	ldr	r5, [pc, #232]	; (c0d0079c <sample_main+0x110>)
c0d006b4:	e030      	b.n	c0d00718 <sample_main+0x8c>
c0d006b6:	a901      	add	r1, sp, #4
                default:
                    THROW(0x6D00);
                    break;
                }
            }
            CATCH_OTHER(e) {
c0d006b8:	858e      	strh	r6, [r1, #44]	; 0x2c
c0d006ba:	990b      	ldr	r1, [sp, #44]	; 0x2c
c0d006bc:	6021      	str	r1, [r4, #0]
c0d006be:	220f      	movs	r2, #15
c0d006c0:	0312      	lsls	r2, r2, #12
                switch (e & 0xF000) {
c0d006c2:	4002      	ands	r2, r0
c0d006c4:	2309      	movs	r3, #9
c0d006c6:	031b      	lsls	r3, r3, #12
c0d006c8:	429a      	cmp	r2, r3
c0d006ca:	d003      	beq.n	c0d006d4 <sample_main+0x48>
c0d006cc:	2303      	movs	r3, #3
c0d006ce:	035b      	lsls	r3, r3, #13
c0d006d0:	429a      	cmp	r2, r3
c0d006d2:	d102      	bne.n	c0d006da <sample_main+0x4e>
c0d006d4:	aa0d      	add	r2, sp, #52	; 0x34
                case 0x6000:
                case 0x9000:
                    sw = e;
c0d006d6:	8010      	strh	r0, [r2, #0]
c0d006d8:	e006      	b.n	c0d006e8 <sample_main+0x5c>
                    break;
                default:
                    sw = 0x6800 | (e & 0x7FF);
c0d006da:	4a31      	ldr	r2, [pc, #196]	; (c0d007a0 <sample_main+0x114>)
c0d006dc:	4010      	ands	r0, r2
c0d006de:	220d      	movs	r2, #13
c0d006e0:	02d2      	lsls	r2, r2, #11
c0d006e2:	4302      	orrs	r2, r0
c0d006e4:	a80d      	add	r0, sp, #52	; 0x34
c0d006e6:	8002      	strh	r2, [r0, #0]
                    break;
                }
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
c0d006e8:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d006ea:	0a00      	lsrs	r0, r0, #8
c0d006ec:	9a0f      	ldr	r2, [sp, #60]	; 0x3c
c0d006ee:	4b2d      	ldr	r3, [pc, #180]	; (c0d007a4 <sample_main+0x118>)
c0d006f0:	5498      	strb	r0, [r3, r2]
                G_io_apdu_buffer[tx + 1] = sw;
c0d006f2:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d006f4:	9a0f      	ldr	r2, [sp, #60]	; 0x3c
                default:
                    sw = 0x6800 | (e & 0x7FF);
                    break;
                }
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
c0d006f6:	189a      	adds	r2, r3, r2
                G_io_apdu_buffer[tx + 1] = sw;
c0d006f8:	7050      	strb	r0, [r2, #1]
                tx += 2;
c0d006fa:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d006fc:	1c80      	adds	r0, r0, #2
c0d006fe:	900f      	str	r0, [sp, #60]	; 0x3c
            }
            FINALLY {
c0d00700:	6021      	str	r1, [r4, #0]
c0d00702:	a80d      	add	r0, sp, #52	; 0x34
    // When APDU are to be fetched from multiple IOs, like NFC+USB+BLE, make
    // sure the io_event is called with a
    // switch event, before the apdu is replied to the bootloader. This avoid
    // APDU injection faults.
    for (;;) {
        volatile unsigned short sw = 0;
c0d00704:	8006      	strh	r6, [r0, #0]

        BEGIN_TRY {
            TRY {
c0d00706:	910b      	str	r1, [sp, #44]	; 0x2c
c0d00708:	ac01      	add	r4, sp, #4
c0d0070a:	4620      	mov	r0, r4
c0d0070c:	f001 fed4 	bl	c0d024b8 <setjmp>
c0d00710:	85a0      	strh	r0, [r4, #44]	; 0x2c
c0d00712:	4921      	ldr	r1, [pc, #132]	; (c0d00798 <sample_main+0x10c>)
c0d00714:	600c      	str	r4, [r1, #0]
c0d00716:	4c20      	ldr	r4, [pc, #128]	; (c0d00798 <sample_main+0x10c>)
c0d00718:	4228      	tst	r0, r5
c0d0071a:	d1cc      	bne.n	c0d006b6 <sample_main+0x2a>
                rx = tx;
c0d0071c:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d0071e:	9010      	str	r0, [sp, #64]	; 0x40
c0d00720:	2400      	movs	r4, #0
                tx = 0; // ensure no race in catch_other if io_exchange throws
c0d00722:	940f      	str	r4, [sp, #60]	; 0x3c
                        // an error
                rx = io_exchange(CHANNEL_APDU | flags, rx);
c0d00724:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d00726:	9910      	ldr	r1, [sp, #64]	; 0x40
c0d00728:	b2c0      	uxtb	r0, r0
c0d0072a:	b289      	uxth	r1, r1
c0d0072c:	f000 fd22 	bl	c0d01174 <io_exchange>
c0d00730:	9010      	str	r0, [sp, #64]	; 0x40
                flags = 0;
c0d00732:	940e      	str	r4, [sp, #56]	; 0x38

                // no apdu received, well, reset the session, and reset the
                // bootloader configuration
                if (rx == 0) {
c0d00734:	9810      	ldr	r0, [sp, #64]	; 0x40
c0d00736:	2800      	cmp	r0, #0
c0d00738:	d00c      	beq.n	c0d00754 <sample_main+0xc8>
                    THROW(0x6982);
                }

                if (G_io_apdu_buffer[0] != 0x80) {
c0d0073a:	481a      	ldr	r0, [pc, #104]	; (c0d007a4 <sample_main+0x118>)
c0d0073c:	7801      	ldrb	r1, [r0, #0]
c0d0073e:	2980      	cmp	r1, #128	; 0x80
c0d00740:	d10d      	bne.n	c0d0075e <sample_main+0xd2>
c0d00742:	7840      	ldrb	r0, [r0, #1]
c0d00744:	2109      	movs	r1, #9
c0d00746:	0309      	lsls	r1, r1, #12
                    THROW(0x6E00);
                }

                // unauthenticated instruction
                switch (G_io_apdu_buffer[1]) {
c0d00748:	28fe      	cmp	r0, #254	; 0xfe
c0d0074a:	dd0e      	ble.n	c0d0076a <sample_main+0xde>
c0d0074c:	28ff      	cmp	r0, #255	; 0xff
c0d0074e:	d11d      	bne.n	c0d0078c <sample_main+0x100>
        END_TRY;
    }

return_to_dashboard:
    return;
}
c0d00750:	b011      	add	sp, #68	; 0x44
c0d00752:	bdf0      	pop	{r4, r5, r6, r7, pc}
                flags = 0;

                // no apdu received, well, reset the session, and reset the
                // bootloader configuration
                if (rx == 0) {
                    THROW(0x6982);
c0d00754:	4810      	ldr	r0, [pc, #64]	; (c0d00798 <sample_main+0x10c>)
c0d00756:	6800      	ldr	r0, [r0, #0]
c0d00758:	4913      	ldr	r1, [pc, #76]	; (c0d007a8 <sample_main+0x11c>)
c0d0075a:	f001 feb9 	bl	c0d024d0 <longjmp>
                }

                if (G_io_apdu_buffer[0] != 0x80) {
                    THROW(0x6E00);
c0d0075e:	480e      	ldr	r0, [pc, #56]	; (c0d00798 <sample_main+0x10c>)
c0d00760:	6800      	ldr	r0, [r0, #0]
c0d00762:	2137      	movs	r1, #55	; 0x37
c0d00764:	0249      	lsls	r1, r1, #9
c0d00766:	f001 feb3 	bl	c0d024d0 <longjmp>
c0d0076a:	2800      	cmp	r0, #0
c0d0076c:	d006      	beq.n	c0d0077c <sample_main+0xf0>
c0d0076e:	2801      	cmp	r0, #1
c0d00770:	d008      	beq.n	c0d00784 <sample_main+0xf8>
c0d00772:	2802      	cmp	r0, #2
c0d00774:	d10a      	bne.n	c0d0078c <sample_main+0x100>
                case 0x01: // case 1
                    THROW(0x9000);
                    break;

                case 0x02: // echo
                    tx = rx;
c0d00776:	9810      	ldr	r0, [sp, #64]	; 0x40
c0d00778:	900f      	str	r0, [sp, #60]	; 0x3c
c0d0077a:	e003      	b.n	c0d00784 <sample_main+0xf8>
                }

                // unauthenticated instruction
                switch (G_io_apdu_buffer[1]) {
                case 0x00: // reset
                    flags |= IO_RESET_AFTER_REPLIED;
c0d0077c:	2080      	movs	r0, #128	; 0x80
c0d0077e:	9a0e      	ldr	r2, [sp, #56]	; 0x38
c0d00780:	4302      	orrs	r2, r0
c0d00782:	920e      	str	r2, [sp, #56]	; 0x38
c0d00784:	4804      	ldr	r0, [pc, #16]	; (c0d00798 <sample_main+0x10c>)
c0d00786:	6800      	ldr	r0, [r0, #0]
c0d00788:	f001 fea2 	bl	c0d024d0 <longjmp>

                case 0xFF: // return to dashboard
                    goto return_to_dashboard;

                default:
                    THROW(0x6D00);
c0d0078c:	4802      	ldr	r0, [pc, #8]	; (c0d00798 <sample_main+0x10c>)
c0d0078e:	6800      	ldr	r0, [r0, #0]
c0d00790:	216d      	movs	r1, #109	; 0x6d
c0d00792:	0209      	lsls	r1, r1, #8
c0d00794:	f001 fe9c 	bl	c0d024d0 <longjmp>
c0d00798:	200019a8 	.word	0x200019a8
c0d0079c:	0000ffff 	.word	0x0000ffff
c0d007a0:	000007ff 	.word	0x000007ff
c0d007a4:	200019f8 	.word	0x200019f8
c0d007a8:	00006982 	.word	0x00006982

c0d007ac <bagl_ui_sample_nanos_button>:
    return element;
}

static unsigned int
bagl_ui_sample_nanos_button(unsigned int button_mask,
                            unsigned int button_mask_counter) {
c0d007ac:	b5d0      	push	{r4, r6, r7, lr}
c0d007ae:	af02      	add	r7, sp, #8
c0d007b0:	b0a6      	sub	sp, #152	; 0x98
    switch (button_mask) {
c0d007b2:	4917      	ldr	r1, [pc, #92]	; (c0d00810 <bagl_ui_sample_nanos_button+0x64>)
c0d007b4:	4288      	cmp	r0, r1
c0d007b6:	d017      	beq.n	c0d007e8 <bagl_ui_sample_nanos_button+0x3c>
c0d007b8:	4916      	ldr	r1, [pc, #88]	; (c0d00814 <bagl_ui_sample_nanos_button+0x68>)
c0d007ba:	4288      	cmp	r0, r1
c0d007bc:	d018      	beq.n	c0d007f0 <bagl_ui_sample_nanos_button+0x44>
c0d007be:	4916      	ldr	r1, [pc, #88]	; (c0d00818 <bagl_ui_sample_nanos_button+0x6c>)
c0d007c0:	4288      	cmp	r0, r1
c0d007c2:	d122      	bne.n	c0d0080a <bagl_ui_sample_nanos_button+0x5e>
    ui_idle();
    return NULL;
}

static const bagl_element_t *io_seproxyhal_touch_auth(const bagl_element_t *e) {
    if (!os_global_pin_is_validated()) {
c0d007c4:	f000 fe3a 	bl	c0d0143c <os_global_pin_is_validated>
c0d007c8:	2800      	cmp	r0, #0
c0d007ca:	d11e      	bne.n	c0d0080a <bagl_ui_sample_nanos_button+0x5e>
c0d007cc:	466c      	mov	r4, sp
c0d007ce:	2100      	movs	r1, #0
        bolos_ux_params_t params;
        os_memset(&params, 0, sizeof(params));
c0d007d0:	2298      	movs	r2, #152	; 0x98
c0d007d2:	4620      	mov	r0, r4
c0d007d4:	f000 f8f2 	bl	c0d009bc <os_memset>
        params.ux_id = BOLOS_UX_VALIDATE_PIN;
c0d007d8:	200f      	movs	r0, #15
c0d007da:	7020      	strb	r0, [r4, #0]
        os_ux_blocking(&params);
c0d007dc:	4620      	mov	r0, r4
c0d007de:	f000 fd6b 	bl	c0d012b8 <os_ux_blocking>
        derive();
c0d007e2:	f7ff fe41 	bl	c0d00468 <derive>
c0d007e6:	e00e      	b.n	c0d00806 <bagl_ui_sample_nanos_button+0x5a>

#endif

static const bagl_element_t *io_seproxyhal_touch_exit(const bagl_element_t *e) {
    // Go back to the dashboard
    os_sched_exit(0);
c0d007e8:	2000      	movs	r0, #0
c0d007ea:	f000 fe5f 	bl	c0d014ac <os_sched_exit>
c0d007ee:	e00c      	b.n	c0d0080a <bagl_ui_sample_nanos_button+0x5e>
    return NULL;
}

static const bagl_element_t *io_seproxyhal_touch_next(const bagl_element_t *e) {
    path[4]++;
c0d007f0:	4c0a      	ldr	r4, [pc, #40]	; (c0d0081c <bagl_ui_sample_nanos_button+0x70>)
c0d007f2:	6920      	ldr	r0, [r4, #16]
c0d007f4:	1c40      	adds	r0, r0, #1
c0d007f6:	6120      	str	r0, [r4, #16]
    if (!derive()) {
c0d007f8:	f7ff fe36 	bl	c0d00468 <derive>
c0d007fc:	2800      	cmp	r0, #0
c0d007fe:	d102      	bne.n	c0d00806 <bagl_ui_sample_nanos_button+0x5a>
        path[4]--;
c0d00800:	6920      	ldr	r0, [r4, #16]
c0d00802:	1e40      	subs	r0, r0, #1
c0d00804:	6120      	str	r0, [r4, #16]
c0d00806:	f7ff feef 	bl	c0d005e8 <ui_idle>

    case BUTTON_EVT_RELEASED | BUTTON_LEFT | BUTTON_RIGHT: // EXIT
        io_seproxyhal_touch_exit(NULL);
        break;
    }
    return 0;
c0d0080a:	2000      	movs	r0, #0
c0d0080c:	b026      	add	sp, #152	; 0x98
c0d0080e:	bdd0      	pop	{r4, r6, r7, pc}
c0d00810:	80000003 	.word	0x80000003
c0d00814:	80000002 	.word	0x80000002
c0d00818:	80000001 	.word	0x80000001
c0d0081c:	20001930 	.word	0x20001930

c0d00820 <bagl_ui_sample_nanos_prepro>:
        NULL,
    },
};

static const bagl_element_t*
bagl_ui_sample_nanos_prepro(const bagl_element_t *element) {
c0d00820:	b5b0      	push	{r4, r5, r7, lr}
c0d00822:	af02      	add	r7, sp, #8
c0d00824:	4604      	mov	r4, r0
    switch (element->component.userid) {
c0d00826:	7860      	ldrb	r0, [r4, #1]
c0d00828:	2802      	cmp	r0, #2
c0d0082a:	d110      	bne.n	c0d0084e <bagl_ui_sample_nanos_prepro+0x2e>
    case 2:
        io_seproxyhal_setup_ticker(
            MAX(3000, 1000 + bagl_label_roundtrip_duration_ms(element, 7)));
c0d0082c:	2107      	movs	r1, #7
c0d0082e:	4620      	mov	r0, r4
c0d00830:	f000 fc20 	bl	c0d01074 <bagl_label_roundtrip_duration_ms>
c0d00834:	217d      	movs	r1, #125	; 0x7d
c0d00836:	00cd      	lsls	r5, r1, #3
c0d00838:	1941      	adds	r1, r0, r5
c0d0083a:	4806      	ldr	r0, [pc, #24]	; (c0d00854 <bagl_ui_sample_nanos_prepro+0x34>)
c0d0083c:	4281      	cmp	r1, r0
c0d0083e:	d304      	bcc.n	c0d0084a <bagl_ui_sample_nanos_prepro+0x2a>
c0d00840:	2107      	movs	r1, #7
c0d00842:	4620      	mov	r0, r4
c0d00844:	f000 fc16 	bl	c0d01074 <bagl_label_roundtrip_duration_ms>
c0d00848:	1940      	adds	r0, r0, r5

static const bagl_element_t*
bagl_ui_sample_nanos_prepro(const bagl_element_t *element) {
    switch (element->component.userid) {
    case 2:
        io_seproxyhal_setup_ticker(
c0d0084a:	f000 fc43 	bl	c0d010d4 <io_seproxyhal_setup_ticker>
            MAX(3000, 1000 + bagl_label_roundtrip_duration_ms(element, 7)));
        break;
    }
    return element;
c0d0084e:	4620      	mov	r0, r4
c0d00850:	bdb0      	pop	{r4, r5, r7, pc}
c0d00852:	46c0      	nop			; (mov r8, r8)
c0d00854:	00000bb8 	.word	0x00000bb8

c0d00858 <os_boot>:

void os_boot(void) {
  // TODO patch entry point when romming (f)

  // at startup no exception context in use
  G_try_last_open_context = NULL;
c0d00858:	4801      	ldr	r0, [pc, #4]	; (c0d00860 <os_boot+0x8>)
c0d0085a:	2100      	movs	r1, #0
c0d0085c:	6001      	str	r1, [r0, #0]
}
c0d0085e:	4770      	bx	lr
c0d00860:	200019a8 	.word	0x200019a8

c0d00864 <io_usb_hid_receive>:
volatile unsigned int   G_io_usb_hid_total_length;
volatile unsigned int   G_io_usb_hid_remaining_length;
volatile unsigned int   G_io_usb_hid_sequence_number;
volatile unsigned char* G_io_usb_hid_current_buffer;

io_usb_hid_receive_status_t io_usb_hid_receive (io_send_t sndfct, unsigned char* buffer, unsigned short l) {
c0d00864:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00866:	af03      	add	r7, sp, #12
c0d00868:	b083      	sub	sp, #12
c0d0086a:	9202      	str	r2, [sp, #8]
c0d0086c:	460c      	mov	r4, r1
c0d0086e:	9001      	str	r0, [sp, #4]
  // avoid over/under flows
  if (buffer != G_io_hid_chunk) {
c0d00870:	4d4a      	ldr	r5, [pc, #296]	; (c0d0099c <io_usb_hid_receive+0x138>)
c0d00872:	42ac      	cmp	r4, r5
c0d00874:	d00f      	beq.n	c0d00896 <io_usb_hid_receive+0x32>
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d00876:	4e49      	ldr	r6, [pc, #292]	; (c0d0099c <io_usb_hid_receive+0x138>)
c0d00878:	2540      	movs	r5, #64	; 0x40
c0d0087a:	4630      	mov	r0, r6
c0d0087c:	4629      	mov	r1, r5
c0d0087e:	f001 fdc7 	bl	c0d02410 <__aeabi_memclr>
c0d00882:	9802      	ldr	r0, [sp, #8]

io_usb_hid_receive_status_t io_usb_hid_receive (io_send_t sndfct, unsigned char* buffer, unsigned short l) {
  // avoid over/under flows
  if (buffer != G_io_hid_chunk) {
    os_memset(G_io_hid_chunk, 0, sizeof(G_io_hid_chunk));
    os_memmove(G_io_hid_chunk, buffer, MIN(l, sizeof(G_io_hid_chunk)));
c0d00884:	2840      	cmp	r0, #64	; 0x40
c0d00886:	4602      	mov	r2, r0
c0d00888:	d300      	bcc.n	c0d0088c <io_usb_hid_receive+0x28>
c0d0088a:	462a      	mov	r2, r5
c0d0088c:	4630      	mov	r0, r6
c0d0088e:	4621      	mov	r1, r4
c0d00890:	f000 f89e 	bl	c0d009d0 <os_memmove>
c0d00894:	4d41      	ldr	r5, [pc, #260]	; (c0d0099c <io_usb_hid_receive+0x138>)
  }

  // process the chunk content
  switch(G_io_hid_chunk[2]) {
c0d00896:	78a8      	ldrb	r0, [r5, #2]
c0d00898:	2805      	cmp	r0, #5
c0d0089a:	d900      	bls.n	c0d0089e <io_usb_hid_receive+0x3a>
c0d0089c:	e076      	b.n	c0d0098c <io_usb_hid_receive+0x128>
c0d0089e:	46c0      	nop			; (mov r8, r8)
c0d008a0:	4478      	add	r0, pc
c0d008a2:	7900      	ldrb	r0, [r0, #4]
c0d008a4:	0040      	lsls	r0, r0, #1
c0d008a6:	4487      	add	pc, r0
c0d008a8:	71130c02 	.word	0x71130c02
c0d008ac:	1f71      	.short	0x1f71
c0d008ae:	2600      	movs	r6, #0
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d008b0:	71ae      	strb	r6, [r5, #6]
c0d008b2:	716e      	strb	r6, [r5, #5]
c0d008b4:	712e      	strb	r6, [r5, #4]
c0d008b6:	70ee      	strb	r6, [r5, #3]

  case 0x00: // get version ID
    // do not reset the current apdu reception if any
    os_memset(G_io_hid_chunk+3, 0, 4); // PROTOCOL VERSION is 0
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d008b8:	2140      	movs	r1, #64	; 0x40
c0d008ba:	4628      	mov	r0, r5
c0d008bc:	9a01      	ldr	r2, [sp, #4]
c0d008be:	4790      	blx	r2
c0d008c0:	e00b      	b.n	c0d008da <io_usb_hid_receive+0x76>
    // await for the next chunk
    goto apdu_reset;

  case 0x01: // ALLOCATE CHANNEL
    // do not reset the current apdu reception if any
    cx_rng(G_io_hid_chunk+3, 4);
c0d008c2:	1ce8      	adds	r0, r5, #3
c0d008c4:	2104      	movs	r1, #4
c0d008c6:	f000 fd7b 	bl	c0d013c0 <cx_rng>
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d008ca:	2140      	movs	r1, #64	; 0x40
c0d008cc:	4628      	mov	r0, r5
c0d008ce:	e001      	b.n	c0d008d4 <io_usb_hid_receive+0x70>
    goto apdu_reset;

  case 0x02: // ECHO|PING
    // do not reset the current apdu reception if any
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d008d0:	4832      	ldr	r0, [pc, #200]	; (c0d0099c <io_usb_hid_receive+0x138>)
c0d008d2:	2140      	movs	r1, #64	; 0x40
c0d008d4:	9a01      	ldr	r2, [sp, #4]
c0d008d6:	4790      	blx	r2
c0d008d8:	2600      	movs	r6, #0
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d008da:	4831      	ldr	r0, [pc, #196]	; (c0d009a0 <io_usb_hid_receive+0x13c>)
c0d008dc:	2100      	movs	r1, #0
c0d008de:	6001      	str	r1, [r0, #0]
c0d008e0:	4630      	mov	r0, r6
  return IO_USB_APDU_RECEIVED;

apdu_reset:
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}
c0d008e2:	b2c0      	uxtb	r0, r0
c0d008e4:	b003      	add	sp, #12
c0d008e6:	bdf0      	pop	{r4, r5, r6, r7, pc}

  // process the chunk content
  switch(G_io_hid_chunk[2]) {
  case 0x05:
    // ensure sequence idx is 0 for the first chunk ! 
    if (G_io_hid_chunk[3] != (G_io_usb_hid_sequence_number>>8) || G_io_hid_chunk[4] != (G_io_usb_hid_sequence_number&0xFF)) {
c0d008e8:	78e8      	ldrb	r0, [r5, #3]
c0d008ea:	4c2d      	ldr	r4, [pc, #180]	; (c0d009a0 <io_usb_hid_receive+0x13c>)
c0d008ec:	6821      	ldr	r1, [r4, #0]
c0d008ee:	0a09      	lsrs	r1, r1, #8
c0d008f0:	2600      	movs	r6, #0
c0d008f2:	4288      	cmp	r0, r1
c0d008f4:	d1f1      	bne.n	c0d008da <io_usb_hid_receive+0x76>
c0d008f6:	7928      	ldrb	r0, [r5, #4]
c0d008f8:	6821      	ldr	r1, [r4, #0]
c0d008fa:	b2c9      	uxtb	r1, r1
c0d008fc:	4288      	cmp	r0, r1
c0d008fe:	d1ec      	bne.n	c0d008da <io_usb_hid_receive+0x76>
c0d00900:	4b28      	ldr	r3, [pc, #160]	; (c0d009a4 <io_usb_hid_receive+0x140>)
      // ignore packet
      goto apdu_reset;
    }
    // cid, tag, seq
    l -= 2+1+2;
c0d00902:	9802      	ldr	r0, [sp, #8]
c0d00904:	18c0      	adds	r0, r0, r3
c0d00906:	1f05      	subs	r5, r0, #4
    
    // append the received chunk to the current command apdu
    if (G_io_usb_hid_sequence_number == 0) {
c0d00908:	6820      	ldr	r0, [r4, #0]
c0d0090a:	2800      	cmp	r0, #0
c0d0090c:	d00e      	beq.n	c0d0092c <io_usb_hid_receive+0xc8>
      // copy data
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+7, l);
    }
    else {
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (l > G_io_usb_hid_remaining_length) {
c0d0090e:	4629      	mov	r1, r5
c0d00910:	4019      	ands	r1, r3
c0d00912:	4825      	ldr	r0, [pc, #148]	; (c0d009a8 <io_usb_hid_receive+0x144>)
c0d00914:	6802      	ldr	r2, [r0, #0]
c0d00916:	4291      	cmp	r1, r2
c0d00918:	461e      	mov	r6, r3
c0d0091a:	d900      	bls.n	c0d0091e <io_usb_hid_receive+0xba>
        l = G_io_usb_hid_remaining_length;
c0d0091c:	6805      	ldr	r5, [r0, #0]
      }

      /// This is a following chunk
      // append content
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+5, l);
c0d0091e:	462a      	mov	r2, r5
c0d00920:	4032      	ands	r2, r6
c0d00922:	4822      	ldr	r0, [pc, #136]	; (c0d009ac <io_usb_hid_receive+0x148>)
c0d00924:	6800      	ldr	r0, [r0, #0]
c0d00926:	491d      	ldr	r1, [pc, #116]	; (c0d0099c <io_usb_hid_receive+0x138>)
c0d00928:	1d49      	adds	r1, r1, #5
c0d0092a:	e021      	b.n	c0d00970 <io_usb_hid_receive+0x10c>
c0d0092c:	9301      	str	r3, [sp, #4]
c0d0092e:	491b      	ldr	r1, [pc, #108]	; (c0d0099c <io_usb_hid_receive+0x138>)
    
    // append the received chunk to the current command apdu
    if (G_io_usb_hid_sequence_number == 0) {
      /// This is the apdu first chunk
      // total apdu size to receive
      G_io_usb_hid_total_length = (G_io_hid_chunk[5]<<8)+(G_io_hid_chunk[6]&0xFF);
c0d00930:	7988      	ldrb	r0, [r1, #6]
c0d00932:	7949      	ldrb	r1, [r1, #5]
c0d00934:	0209      	lsls	r1, r1, #8
c0d00936:	4301      	orrs	r1, r0
c0d00938:	481d      	ldr	r0, [pc, #116]	; (c0d009b0 <io_usb_hid_receive+0x14c>)
c0d0093a:	6001      	str	r1, [r0, #0]
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (G_io_usb_hid_total_length > sizeof(G_io_apdu_buffer)) {
c0d0093c:	6801      	ldr	r1, [r0, #0]
c0d0093e:	2241      	movs	r2, #65	; 0x41
c0d00940:	0092      	lsls	r2, r2, #2
c0d00942:	4291      	cmp	r1, r2
c0d00944:	d8c9      	bhi.n	c0d008da <io_usb_hid_receive+0x76>
        goto apdu_reset;
      }
      // seq and total length
      l -= 2;
      // compute remaining size to receive
      G_io_usb_hid_remaining_length = G_io_usb_hid_total_length;
c0d00946:	6801      	ldr	r1, [r0, #0]
c0d00948:	4817      	ldr	r0, [pc, #92]	; (c0d009a8 <io_usb_hid_receive+0x144>)
c0d0094a:	6001      	str	r1, [r0, #0]
      G_io_usb_hid_current_buffer = G_io_apdu_buffer;
c0d0094c:	4917      	ldr	r1, [pc, #92]	; (c0d009ac <io_usb_hid_receive+0x148>)
c0d0094e:	4a19      	ldr	r2, [pc, #100]	; (c0d009b4 <io_usb_hid_receive+0x150>)
c0d00950:	600a      	str	r2, [r1, #0]
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (G_io_usb_hid_total_length > sizeof(G_io_apdu_buffer)) {
        goto apdu_reset;
      }
      // seq and total length
      l -= 2;
c0d00952:	4919      	ldr	r1, [pc, #100]	; (c0d009b8 <io_usb_hid_receive+0x154>)
c0d00954:	9a02      	ldr	r2, [sp, #8]
c0d00956:	1855      	adds	r5, r2, r1
      // compute remaining size to receive
      G_io_usb_hid_remaining_length = G_io_usb_hid_total_length;
      G_io_usb_hid_current_buffer = G_io_apdu_buffer;

      if (l > G_io_usb_hid_remaining_length) {
c0d00958:	4629      	mov	r1, r5
c0d0095a:	9e01      	ldr	r6, [sp, #4]
c0d0095c:	4031      	ands	r1, r6
c0d0095e:	6802      	ldr	r2, [r0, #0]
c0d00960:	4291      	cmp	r1, r2
c0d00962:	d900      	bls.n	c0d00966 <io_usb_hid_receive+0x102>
        l = G_io_usb_hid_remaining_length;
c0d00964:	6805      	ldr	r5, [r0, #0]
      }
      // copy data
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+7, l);
c0d00966:	462a      	mov	r2, r5
c0d00968:	4032      	ands	r2, r6
c0d0096a:	480c      	ldr	r0, [pc, #48]	; (c0d0099c <io_usb_hid_receive+0x138>)
c0d0096c:	1dc1      	adds	r1, r0, #7
c0d0096e:	4811      	ldr	r0, [pc, #68]	; (c0d009b4 <io_usb_hid_receive+0x150>)
c0d00970:	f000 f82e 	bl	c0d009d0 <os_memmove>
      /// This is a following chunk
      // append content
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+5, l);
    }
    // factorize (f)
    G_io_usb_hid_current_buffer += l;
c0d00974:	4035      	ands	r5, r6
c0d00976:	480d      	ldr	r0, [pc, #52]	; (c0d009ac <io_usb_hid_receive+0x148>)
c0d00978:	6801      	ldr	r1, [r0, #0]
c0d0097a:	1949      	adds	r1, r1, r5
c0d0097c:	6001      	str	r1, [r0, #0]
    G_io_usb_hid_remaining_length -= l;
c0d0097e:	480a      	ldr	r0, [pc, #40]	; (c0d009a8 <io_usb_hid_receive+0x144>)
c0d00980:	6801      	ldr	r1, [r0, #0]
c0d00982:	1b49      	subs	r1, r1, r5
c0d00984:	6001      	str	r1, [r0, #0]
    G_io_usb_hid_sequence_number++;
c0d00986:	6820      	ldr	r0, [r4, #0]
c0d00988:	1c40      	adds	r0, r0, #1
c0d0098a:	6020      	str	r0, [r4, #0]
    // await for the next chunk
    goto apdu_reset;
  }

  // if more data to be received, notify it
  if (G_io_usb_hid_remaining_length) {
c0d0098c:	4806      	ldr	r0, [pc, #24]	; (c0d009a8 <io_usb_hid_receive+0x144>)
c0d0098e:	6801      	ldr	r1, [r0, #0]
c0d00990:	2001      	movs	r0, #1
c0d00992:	2602      	movs	r6, #2
c0d00994:	2900      	cmp	r1, #0
c0d00996:	d1a4      	bne.n	c0d008e2 <io_usb_hid_receive+0x7e>
c0d00998:	e79f      	b.n	c0d008da <io_usb_hid_receive+0x76>
c0d0099a:	46c0      	nop			; (mov r8, r8)
c0d0099c:	200019ac 	.word	0x200019ac
c0d009a0:	200019ec 	.word	0x200019ec
c0d009a4:	0000ffff 	.word	0x0000ffff
c0d009a8:	200019f4 	.word	0x200019f4
c0d009ac:	20001afc 	.word	0x20001afc
c0d009b0:	200019f0 	.word	0x200019f0
c0d009b4:	200019f8 	.word	0x200019f8
c0d009b8:	0001fff9 	.word	0x0001fff9

c0d009bc <os_memset>:
    }
  }
#undef DSTCHAR
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
c0d009bc:	b580      	push	{r7, lr}
c0d009be:	af00      	add	r7, sp, #0
c0d009c0:	460b      	mov	r3, r1
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
c0d009c2:	2a00      	cmp	r2, #0
c0d009c4:	d003      	beq.n	c0d009ce <os_memset+0x12>
    DSTCHAR[length] = c;
c0d009c6:	4611      	mov	r1, r2
c0d009c8:	461a      	mov	r2, r3
c0d009ca:	f001 fd27 	bl	c0d0241c <__aeabi_memset>
  }
#undef DSTCHAR
}
c0d009ce:	bd80      	pop	{r7, pc}

c0d009d0 <os_memmove>:
    }
  }
}
#endif // HAVE_USB_APDU

REENTRANT(void os_memmove(void * dst, const void WIDE * src, unsigned int length)) {
c0d009d0:	b5b0      	push	{r4, r5, r7, lr}
c0d009d2:	af02      	add	r7, sp, #8
#define DSTCHAR ((unsigned char *)dst)
#define SRCCHAR ((unsigned char WIDE *)src)
  if (dst > src) {
c0d009d4:	4288      	cmp	r0, r1
c0d009d6:	d90d      	bls.n	c0d009f4 <os_memmove+0x24>
    while(length--) {
c0d009d8:	2a00      	cmp	r2, #0
c0d009da:	d014      	beq.n	c0d00a06 <os_memmove+0x36>
c0d009dc:	1e49      	subs	r1, r1, #1
c0d009de:	4252      	negs	r2, r2
c0d009e0:	1e40      	subs	r0, r0, #1
c0d009e2:	2300      	movs	r3, #0
c0d009e4:	43db      	mvns	r3, r3
      DSTCHAR[length] = SRCCHAR[length];
c0d009e6:	461c      	mov	r4, r3
c0d009e8:	4354      	muls	r4, r2
c0d009ea:	5d0d      	ldrb	r5, [r1, r4]
c0d009ec:	5505      	strb	r5, [r0, r4]

REENTRANT(void os_memmove(void * dst, const void WIDE * src, unsigned int length)) {
#define DSTCHAR ((unsigned char *)dst)
#define SRCCHAR ((unsigned char WIDE *)src)
  if (dst > src) {
    while(length--) {
c0d009ee:	1c52      	adds	r2, r2, #1
c0d009f0:	d1f9      	bne.n	c0d009e6 <os_memmove+0x16>
c0d009f2:	e008      	b.n	c0d00a06 <os_memmove+0x36>
      DSTCHAR[length] = SRCCHAR[length];
    }
  }
  else {
    unsigned short l = 0;
    while (length--) {
c0d009f4:	2a00      	cmp	r2, #0
c0d009f6:	d006      	beq.n	c0d00a06 <os_memmove+0x36>
c0d009f8:	2300      	movs	r3, #0
      DSTCHAR[l] = SRCCHAR[l];
c0d009fa:	b29c      	uxth	r4, r3
c0d009fc:	5d0d      	ldrb	r5, [r1, r4]
c0d009fe:	5505      	strb	r5, [r0, r4]
      l++;
c0d00a00:	1c5b      	adds	r3, r3, #1
      DSTCHAR[length] = SRCCHAR[length];
    }
  }
  else {
    unsigned short l = 0;
    while (length--) {
c0d00a02:	1e52      	subs	r2, r2, #1
c0d00a04:	d1f9      	bne.n	c0d009fa <os_memmove+0x2a>
      DSTCHAR[l] = SRCCHAR[l];
      l++;
    }
  }
#undef DSTCHAR
}
c0d00a06:	bdb0      	pop	{r4, r5, r7, pc}

c0d00a08 <io_usb_hid_init>:
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d00a08:	4801      	ldr	r0, [pc, #4]	; (c0d00a10 <io_usb_hid_init+0x8>)
c0d00a0a:	2100      	movs	r1, #0
c0d00a0c:	6001      	str	r1, [r0, #0]
  //G_io_usb_hid_remaining_length = 0; // not really needed
  //G_io_usb_hid_total_length = 0; // not really needed
  //G_io_usb_hid_current_buffer = G_io_apdu_buffer; // not really needed
}
c0d00a0e:	4770      	bx	lr
c0d00a10:	200019ec 	.word	0x200019ec

c0d00a14 <io_usb_hid_exchange>:

unsigned short io_usb_hid_exchange(io_send_t sndfct, unsigned short sndlength,
                                   io_recv_t rcvfct,
                                   unsigned char flags) {
c0d00a14:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00a16:	af03      	add	r7, sp, #12
c0d00a18:	b087      	sub	sp, #28
c0d00a1a:	9301      	str	r3, [sp, #4]
c0d00a1c:	9203      	str	r2, [sp, #12]
c0d00a1e:	460e      	mov	r6, r1
c0d00a20:	9004      	str	r0, [sp, #16]
  unsigned char l;

  // perform send
  if (sndlength) {
c0d00a22:	2e00      	cmp	r6, #0
c0d00a24:	d042      	beq.n	c0d00aac <io_usb_hid_exchange+0x98>
    G_io_usb_hid_sequence_number = 0; 
c0d00a26:	4d31      	ldr	r5, [pc, #196]	; (c0d00aec <io_usb_hid_exchange+0xd8>)
c0d00a28:	2000      	movs	r0, #0
c0d00a2a:	6028      	str	r0, [r5, #0]
    G_io_usb_hid_current_buffer = G_io_apdu_buffer;
c0d00a2c:	4930      	ldr	r1, [pc, #192]	; (c0d00af0 <io_usb_hid_exchange+0xdc>)
c0d00a2e:	4831      	ldr	r0, [pc, #196]	; (c0d00af4 <io_usb_hid_exchange+0xe0>)
c0d00a30:	6008      	str	r0, [r1, #0]
c0d00a32:	4c31      	ldr	r4, [pc, #196]	; (c0d00af8 <io_usb_hid_exchange+0xe4>)
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d00a34:	1d60      	adds	r0, r4, #5
c0d00a36:	213b      	movs	r1, #59	; 0x3b
c0d00a38:	9005      	str	r0, [sp, #20]
c0d00a3a:	9102      	str	r1, [sp, #8]
c0d00a3c:	f001 fce8 	bl	c0d02410 <__aeabi_memclr>
c0d00a40:	2005      	movs	r0, #5

    // fill the chunk
    os_memset(G_io_hid_chunk+2, 0, IO_HID_EP_LENGTH-2);

    // keep the channel identifier
    G_io_hid_chunk[2] = 0x05;
c0d00a42:	70a0      	strb	r0, [r4, #2]
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
c0d00a44:	6828      	ldr	r0, [r5, #0]
c0d00a46:	0a00      	lsrs	r0, r0, #8
c0d00a48:	70e0      	strb	r0, [r4, #3]
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;
c0d00a4a:	6828      	ldr	r0, [r5, #0]
c0d00a4c:	7120      	strb	r0, [r4, #4]
c0d00a4e:	b2b1      	uxth	r1, r6

    if (G_io_usb_hid_sequence_number == 0) {
c0d00a50:	6828      	ldr	r0, [r5, #0]
c0d00a52:	2800      	cmp	r0, #0
c0d00a54:	9106      	str	r1, [sp, #24]
c0d00a56:	d009      	beq.n	c0d00a6c <io_usb_hid_exchange+0x58>
      G_io_usb_hid_current_buffer += l;
      sndlength -= l;
      l += 7;
    }
    else {
      l = ((sndlength>IO_HID_EP_LENGTH-5) ? IO_HID_EP_LENGTH-5 : sndlength);
c0d00a58:	293b      	cmp	r1, #59	; 0x3b
c0d00a5a:	460a      	mov	r2, r1
c0d00a5c:	d300      	bcc.n	c0d00a60 <io_usb_hid_exchange+0x4c>
c0d00a5e:	9a02      	ldr	r2, [sp, #8]
c0d00a60:	4823      	ldr	r0, [pc, #140]	; (c0d00af0 <io_usb_hid_exchange+0xdc>)
c0d00a62:	4603      	mov	r3, r0
      os_memmove(G_io_hid_chunk+5, (const void*)G_io_usb_hid_current_buffer, l);
c0d00a64:	6819      	ldr	r1, [r3, #0]
c0d00a66:	9805      	ldr	r0, [sp, #20]
c0d00a68:	461e      	mov	r6, r3
c0d00a6a:	e00a      	b.n	c0d00a82 <io_usb_hid_exchange+0x6e>
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;

    if (G_io_usb_hid_sequence_number == 0) {
      l = ((sndlength>IO_HID_EP_LENGTH-7) ? IO_HID_EP_LENGTH-7 : sndlength);
      G_io_hid_chunk[5] = sndlength>>8;
c0d00a6c:	0a30      	lsrs	r0, r6, #8
c0d00a6e:	7160      	strb	r0, [r4, #5]
      G_io_hid_chunk[6] = sndlength;
c0d00a70:	71a6      	strb	r6, [r4, #6]
    G_io_hid_chunk[2] = 0x05;
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;

    if (G_io_usb_hid_sequence_number == 0) {
      l = ((sndlength>IO_HID_EP_LENGTH-7) ? IO_HID_EP_LENGTH-7 : sndlength);
c0d00a72:	2039      	movs	r0, #57	; 0x39
c0d00a74:	2939      	cmp	r1, #57	; 0x39
c0d00a76:	460a      	mov	r2, r1
c0d00a78:	d300      	bcc.n	c0d00a7c <io_usb_hid_exchange+0x68>
c0d00a7a:	4602      	mov	r2, r0
c0d00a7c:	4e1c      	ldr	r6, [pc, #112]	; (c0d00af0 <io_usb_hid_exchange+0xdc>)
      G_io_hid_chunk[5] = sndlength>>8;
      G_io_hid_chunk[6] = sndlength;
      os_memmove(G_io_hid_chunk+7, (const void*)G_io_usb_hid_current_buffer, l);
c0d00a7e:	6831      	ldr	r1, [r6, #0]
c0d00a80:	1de0      	adds	r0, r4, #7
c0d00a82:	9205      	str	r2, [sp, #20]
c0d00a84:	f7ff ffa4 	bl	c0d009d0 <os_memmove>
c0d00a88:	4d18      	ldr	r5, [pc, #96]	; (c0d00aec <io_usb_hid_exchange+0xd8>)
c0d00a8a:	6830      	ldr	r0, [r6, #0]
c0d00a8c:	4631      	mov	r1, r6
c0d00a8e:	9e05      	ldr	r6, [sp, #20]
c0d00a90:	1980      	adds	r0, r0, r6
      G_io_usb_hid_current_buffer += l;
c0d00a92:	6008      	str	r0, [r1, #0]
      G_io_usb_hid_current_buffer += l;
      sndlength -= l;
      l += 5;
    }
    // prepare next chunk numbering
    G_io_usb_hid_sequence_number++;
c0d00a94:	6828      	ldr	r0, [r5, #0]
c0d00a96:	1c40      	adds	r0, r0, #1
c0d00a98:	6028      	str	r0, [r5, #0]
    // send the chunk
    // always pad :)
    sndfct(G_io_hid_chunk, sizeof(G_io_hid_chunk));
c0d00a9a:	2140      	movs	r1, #64	; 0x40
c0d00a9c:	4620      	mov	r0, r4
c0d00a9e:	9a04      	ldr	r2, [sp, #16]
c0d00aa0:	4790      	blx	r2
c0d00aa2:	9806      	ldr	r0, [sp, #24]
c0d00aa4:	1b86      	subs	r6, r0, r6
c0d00aa6:	4815      	ldr	r0, [pc, #84]	; (c0d00afc <io_usb_hid_exchange+0xe8>)
  // perform send
  if (sndlength) {
    G_io_usb_hid_sequence_number = 0; 
    G_io_usb_hid_current_buffer = G_io_apdu_buffer;
  }
  while(sndlength) {
c0d00aa8:	4206      	tst	r6, r0
c0d00aaa:	d1c3      	bne.n	c0d00a34 <io_usb_hid_exchange+0x20>
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d00aac:	480f      	ldr	r0, [pc, #60]	; (c0d00aec <io_usb_hid_exchange+0xd8>)
c0d00aae:	2400      	movs	r4, #0
c0d00ab0:	6004      	str	r4, [r0, #0]
  }

  // prepare for next apdu
  io_usb_hid_init();

  if (flags & IO_RESET_AFTER_REPLIED) {
c0d00ab2:	2080      	movs	r0, #128	; 0x80
c0d00ab4:	9901      	ldr	r1, [sp, #4]
c0d00ab6:	4201      	tst	r1, r0
c0d00ab8:	d001      	beq.n	c0d00abe <io_usb_hid_exchange+0xaa>
    reset();
c0d00aba:	f000 fc65 	bl	c0d01388 <reset>
  }

  if (flags & IO_RETURN_AFTER_TX ) {
c0d00abe:	9801      	ldr	r0, [sp, #4]
c0d00ac0:	0680      	lsls	r0, r0, #26
c0d00ac2:	d40f      	bmi.n	c0d00ae4 <io_usb_hid_exchange+0xd0>
c0d00ac4:	4c0c      	ldr	r4, [pc, #48]	; (c0d00af8 <io_usb_hid_exchange+0xe4>)
  }

  // receive the next command
  for(;;) {
    // receive a hid chunk
    l = rcvfct(G_io_hid_chunk, sizeof(G_io_hid_chunk));
c0d00ac6:	2140      	movs	r1, #64	; 0x40
c0d00ac8:	4620      	mov	r0, r4
c0d00aca:	9a03      	ldr	r2, [sp, #12]
c0d00acc:	4790      	blx	r2
    // check for wrongly sized tlvs
    if (l > sizeof(G_io_hid_chunk)) {
c0d00ace:	b2c2      	uxtb	r2, r0
c0d00ad0:	2a40      	cmp	r2, #64	; 0x40
c0d00ad2:	d8f8      	bhi.n	c0d00ac6 <io_usb_hid_exchange+0xb2>
      continue;
    }

    // call the chunk reception
    switch(io_usb_hid_receive(sndfct, G_io_hid_chunk, l)) {
c0d00ad4:	9804      	ldr	r0, [sp, #16]
c0d00ad6:	4621      	mov	r1, r4
c0d00ad8:	f7ff fec4 	bl	c0d00864 <io_usb_hid_receive>
c0d00adc:	2802      	cmp	r0, #2
c0d00ade:	d1f2      	bne.n	c0d00ac6 <io_usb_hid_exchange+0xb2>
      default:
        continue;

      case IO_USB_APDU_RECEIVED:

        return G_io_usb_hid_total_length;
c0d00ae0:	4807      	ldr	r0, [pc, #28]	; (c0d00b00 <io_usb_hid_exchange+0xec>)
c0d00ae2:	6804      	ldr	r4, [r0, #0]
    }
  }
}
c0d00ae4:	b2a0      	uxth	r0, r4
c0d00ae6:	b007      	add	sp, #28
c0d00ae8:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00aea:	46c0      	nop			; (mov r8, r8)
c0d00aec:	200019ec 	.word	0x200019ec
c0d00af0:	20001afc 	.word	0x20001afc
c0d00af4:	200019f8 	.word	0x200019f8
c0d00af8:	200019ac 	.word	0x200019ac
c0d00afc:	0000ffff 	.word	0x0000ffff
c0d00b00:	200019f0 	.word	0x200019f0

c0d00b04 <io_seproxyhal_general_status>:
volatile unsigned short G_io_apdu_seq;
volatile io_apdu_media_t G_io_apdu_media;
volatile unsigned int G_button_mask;
volatile unsigned int G_button_same_mask_counter;

void io_seproxyhal_general_status(void) {
c0d00b04:	b580      	push	{r7, lr}
c0d00b06:	af00      	add	r7, sp, #0
  // avoid troubles
  if (io_seproxyhal_spi_is_status_sent()) {
c0d00b08:	f000 fd2a 	bl	c0d01560 <io_seproxyhal_spi_is_status_sent>
c0d00b0c:	2800      	cmp	r0, #0
c0d00b0e:	d10b      	bne.n	c0d00b28 <io_seproxyhal_general_status+0x24>
    return;
  }
  // send the general status
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_GENERAL_STATUS;
c0d00b10:	4806      	ldr	r0, [pc, #24]	; (c0d00b2c <io_seproxyhal_general_status+0x28>)
c0d00b12:	2160      	movs	r1, #96	; 0x60
c0d00b14:	7001      	strb	r1, [r0, #0]
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d00b16:	2100      	movs	r1, #0
c0d00b18:	7041      	strb	r1, [r0, #1]
  G_io_seproxyhal_spi_buffer[2] = 2;
c0d00b1a:	2202      	movs	r2, #2
c0d00b1c:	7082      	strb	r2, [r0, #2]
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND>>8;
c0d00b1e:	70c1      	strb	r1, [r0, #3]
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND;
c0d00b20:	7101      	strb	r1, [r0, #4]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 5);
c0d00b22:	2105      	movs	r1, #5
c0d00b24:	f000 fcfe 	bl	c0d01524 <io_seproxyhal_spi_send>
}
c0d00b28:	bd80      	pop	{r7, pc}
c0d00b2a:	46c0      	nop			; (mov r8, r8)
c0d00b2c:	20001800 	.word	0x20001800

c0d00b30 <io_seproxyhal_handle_usb_event>:
static volatile unsigned char G_io_usb_ep_xfer_len[IO_USB_MAX_ENDPOINTS];
#include "usbd_def.h"
#include "usbd_core.h"
extern USBD_HandleTypeDef USBD_Device;

void io_seproxyhal_handle_usb_event(void) {
c0d00b30:	b5d0      	push	{r4, r6, r7, lr}
c0d00b32:	af02      	add	r7, sp, #8
  switch(G_io_seproxyhal_spi_buffer[3]) {
c0d00b34:	4815      	ldr	r0, [pc, #84]	; (c0d00b8c <io_seproxyhal_handle_usb_event+0x5c>)
c0d00b36:	78c0      	ldrb	r0, [r0, #3]
c0d00b38:	1e40      	subs	r0, r0, #1
c0d00b3a:	2807      	cmp	r0, #7
c0d00b3c:	d824      	bhi.n	c0d00b88 <io_seproxyhal_handle_usb_event+0x58>
c0d00b3e:	46c0      	nop			; (mov r8, r8)
c0d00b40:	4478      	add	r0, pc
c0d00b42:	7900      	ldrb	r0, [r0, #4]
c0d00b44:	0040      	lsls	r0, r0, #1
c0d00b46:	4487      	add	pc, r0
c0d00b48:	141f1803 	.word	0x141f1803
c0d00b4c:	1c1f1f1f 	.word	0x1c1f1f1f
    case SEPROXYHAL_TAG_USB_EVENT_RESET:
      // ongoing APDU detected, throw a reset
      USBD_LL_SetSpeed(&USBD_Device, USBD_SPEED_FULL);  
c0d00b50:	4c0f      	ldr	r4, [pc, #60]	; (c0d00b90 <io_seproxyhal_handle_usb_event+0x60>)
c0d00b52:	2101      	movs	r1, #1
c0d00b54:	4620      	mov	r0, r4
c0d00b56:	f000 ffcf 	bl	c0d01af8 <USBD_LL_SetSpeed>
      USBD_LL_Reset(&USBD_Device);
c0d00b5a:	4620      	mov	r0, r4
c0d00b5c:	f000 ffb4 	bl	c0d01ac8 <USBD_LL_Reset>
      if (G_io_apdu_media == IO_APDU_MEDIA_USB_HID) {
c0d00b60:	480c      	ldr	r0, [pc, #48]	; (c0d00b94 <io_seproxyhal_handle_usb_event+0x64>)
c0d00b62:	7800      	ldrb	r0, [r0, #0]
c0d00b64:	2801      	cmp	r0, #1
c0d00b66:	d10f      	bne.n	c0d00b88 <io_seproxyhal_handle_usb_event+0x58>
        THROW(EXCEPTION_IO_RESET);
c0d00b68:	480b      	ldr	r0, [pc, #44]	; (c0d00b98 <io_seproxyhal_handle_usb_event+0x68>)
c0d00b6a:	6800      	ldr	r0, [r0, #0]
c0d00b6c:	2110      	movs	r1, #16
c0d00b6e:	f001 fcaf 	bl	c0d024d0 <longjmp>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SOF:
      USBD_LL_SOF(&USBD_Device);
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SUSPENDED:
      USBD_LL_Suspend(&USBD_Device);
c0d00b72:	4807      	ldr	r0, [pc, #28]	; (c0d00b90 <io_seproxyhal_handle_usb_event+0x60>)
c0d00b74:	f000 ffc3 	bl	c0d01afe <USBD_LL_Suspend>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d00b78:	bdd0      	pop	{r4, r6, r7, pc}
      if (G_io_apdu_media == IO_APDU_MEDIA_USB_HID) {
        THROW(EXCEPTION_IO_RESET);
      }
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SOF:
      USBD_LL_SOF(&USBD_Device);
c0d00b7a:	4805      	ldr	r0, [pc, #20]	; (c0d00b90 <io_seproxyhal_handle_usb_event+0x60>)
c0d00b7c:	f000 ffc3 	bl	c0d01b06 <USBD_LL_SOF>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d00b80:	bdd0      	pop	{r4, r6, r7, pc}
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SUSPENDED:
      USBD_LL_Suspend(&USBD_Device);
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
c0d00b82:	4803      	ldr	r0, [pc, #12]	; (c0d00b90 <io_seproxyhal_handle_usb_event+0x60>)
c0d00b84:	f000 ffbd 	bl	c0d01b02 <USBD_LL_Resume>
      break;
  }
}
c0d00b88:	bdd0      	pop	{r4, r6, r7, pc}
c0d00b8a:	46c0      	nop			; (mov r8, r8)
c0d00b8c:	20001800 	.word	0x20001800
c0d00b90:	20001b24 	.word	0x20001b24
c0d00b94:	20001b00 	.word	0x20001b00
c0d00b98:	200019a8 	.word	0x200019a8

c0d00b9c <io_seproxyhal_get_ep_rx_size>:

uint16_t io_seproxyhal_get_ep_rx_size(uint8_t epnum) {
  return G_io_usb_ep_xfer_len[epnum&0x7F];
c0d00b9c:	217f      	movs	r1, #127	; 0x7f
c0d00b9e:	4001      	ands	r1, r0
c0d00ba0:	4801      	ldr	r0, [pc, #4]	; (c0d00ba8 <io_seproxyhal_get_ep_rx_size+0xc>)
c0d00ba2:	5c40      	ldrb	r0, [r0, r1]
c0d00ba4:	4770      	bx	lr
c0d00ba6:	46c0      	nop			; (mov r8, r8)
c0d00ba8:	20001b01 	.word	0x20001b01

c0d00bac <io_seproxyhal_handle_usb_ep_xfer_event>:
}

void io_seproxyhal_handle_usb_ep_xfer_event(void) {
c0d00bac:	b580      	push	{r7, lr}
c0d00bae:	af00      	add	r7, sp, #0
  switch(G_io_seproxyhal_spi_buffer[4]) {
c0d00bb0:	480f      	ldr	r0, [pc, #60]	; (c0d00bf0 <io_seproxyhal_handle_usb_ep_xfer_event+0x44>)
c0d00bb2:	7901      	ldrb	r1, [r0, #4]
c0d00bb4:	2904      	cmp	r1, #4
c0d00bb6:	d008      	beq.n	c0d00bca <io_seproxyhal_handle_usb_ep_xfer_event+0x1e>
c0d00bb8:	2902      	cmp	r1, #2
c0d00bba:	d011      	beq.n	c0d00be0 <io_seproxyhal_handle_usb_ep_xfer_event+0x34>
c0d00bbc:	2901      	cmp	r1, #1
c0d00bbe:	d10e      	bne.n	c0d00bde <io_seproxyhal_handle_usb_ep_xfer_event+0x32>
    case SEPROXYHAL_TAG_USB_EP_XFER_SETUP:
      // assume length of setup packet, and that it is on endpoint 0
      USBD_LL_SetupStage(&USBD_Device, &G_io_seproxyhal_spi_buffer[6]);
c0d00bc0:	1d81      	adds	r1, r0, #6
c0d00bc2:	480d      	ldr	r0, [pc, #52]	; (c0d00bf8 <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d00bc4:	f000 fea4 	bl	c0d01910 <USBD_LL_SetupStage>
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;
  }
}
c0d00bc8:	bd80      	pop	{r7, pc}
      USBD_LL_DataInStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;

    case SEPROXYHAL_TAG_USB_EP_XFER_OUT:
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
c0d00bca:	78c2      	ldrb	r2, [r0, #3]
c0d00bcc:	217f      	movs	r1, #127	; 0x7f
c0d00bce:	4011      	ands	r1, r2
c0d00bd0:	7942      	ldrb	r2, [r0, #5]
c0d00bd2:	4b08      	ldr	r3, [pc, #32]	; (c0d00bf4 <io_seproxyhal_handle_usb_ep_xfer_event+0x48>)
c0d00bd4:	545a      	strb	r2, [r3, r1]
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
c0d00bd6:	1d82      	adds	r2, r0, #6
c0d00bd8:	4807      	ldr	r0, [pc, #28]	; (c0d00bf8 <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d00bda:	f000 fecb 	bl	c0d01974 <USBD_LL_DataOutStage>
      break;
  }
}
c0d00bde:	bd80      	pop	{r7, pc}
      // assume length of setup packet, and that it is on endpoint 0
      USBD_LL_SetupStage(&USBD_Device, &G_io_seproxyhal_spi_buffer[6]);
      break;

    case SEPROXYHAL_TAG_USB_EP_XFER_IN:
      USBD_LL_DataInStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
c0d00be0:	78c2      	ldrb	r2, [r0, #3]
c0d00be2:	217f      	movs	r1, #127	; 0x7f
c0d00be4:	4011      	ands	r1, r2
c0d00be6:	1d82      	adds	r2, r0, #6
c0d00be8:	4803      	ldr	r0, [pc, #12]	; (c0d00bf8 <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d00bea:	f000 ff09 	bl	c0d01a00 <USBD_LL_DataInStage>
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;
  }
}
c0d00bee:	bd80      	pop	{r7, pc}
c0d00bf0:	20001800 	.word	0x20001800
c0d00bf4:	20001b01 	.word	0x20001b01
c0d00bf8:	20001b24 	.word	0x20001b24

c0d00bfc <io_usb_send_ep>:
void io_seproxyhal_handle_usb_ep_xfer_event(void) { 
}

#endif // HAVE_L4_USBLIB

void io_usb_send_ep(unsigned int ep, unsigned char* buffer, unsigned short length, unsigned int timeout) {
c0d00bfc:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00bfe:	af03      	add	r7, sp, #12
c0d00c00:	b083      	sub	sp, #12
c0d00c02:	9201      	str	r2, [sp, #4]
c0d00c04:	4602      	mov	r2, r0
  unsigned int rx_len;

  // don't spoil the timeout :)
  if (timeout) {
    timeout++;
c0d00c06:	1c5d      	adds	r5, r3, #1

void io_usb_send_ep(unsigned int ep, unsigned char* buffer, unsigned short length, unsigned int timeout) {
  unsigned int rx_len;

  // don't spoil the timeout :)
  if (timeout) {
c0d00c08:	2b00      	cmp	r3, #0
c0d00c0a:	d100      	bne.n	c0d00c0e <io_usb_send_ep+0x12>
c0d00c0c:	461d      	mov	r5, r3
    timeout++;
  }

  // won't send if overflowing seproxyhal buffer format
  if (length > 255) {
c0d00c0e:	9801      	ldr	r0, [sp, #4]
c0d00c10:	28ff      	cmp	r0, #255	; 0xff
c0d00c12:	d843      	bhi.n	c0d00c9c <io_usb_send_ep+0xa0>
    return;
  }
  
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d00c14:	4e25      	ldr	r6, [pc, #148]	; (c0d00cac <io_usb_send_ep+0xb0>)
c0d00c16:	2050      	movs	r0, #80	; 0x50
c0d00c18:	7030      	strb	r0, [r6, #0]
c0d00c1a:	9c01      	ldr	r4, [sp, #4]
  G_io_seproxyhal_spi_buffer[1] = (3+length)>>8;
c0d00c1c:	1ce0      	adds	r0, r4, #3
c0d00c1e:	9100      	str	r1, [sp, #0]
c0d00c20:	0a01      	lsrs	r1, r0, #8
c0d00c22:	7071      	strb	r1, [r6, #1]
  G_io_seproxyhal_spi_buffer[2] = (3+length);
c0d00c24:	70b0      	strb	r0, [r6, #2]
  G_io_seproxyhal_spi_buffer[3] = ep|0x80;
c0d00c26:	2080      	movs	r0, #128	; 0x80
c0d00c28:	4302      	orrs	r2, r0
c0d00c2a:	9202      	str	r2, [sp, #8]
c0d00c2c:	70f2      	strb	r2, [r6, #3]
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d00c2e:	2020      	movs	r0, #32
c0d00c30:	7130      	strb	r0, [r6, #4]
  G_io_seproxyhal_spi_buffer[5] = length;
c0d00c32:	7174      	strb	r4, [r6, #5]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 6);
c0d00c34:	2106      	movs	r1, #6
c0d00c36:	4630      	mov	r0, r6
c0d00c38:	f000 fc74 	bl	c0d01524 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send(buffer, length);
c0d00c3c:	9800      	ldr	r0, [sp, #0]
c0d00c3e:	4621      	mov	r1, r4
c0d00c40:	f000 fc70 	bl	c0d01524 <io_seproxyhal_spi_send>

  // if timeout is requested
  if(timeout) {
c0d00c44:	2d00      	cmp	r5, #0
c0d00c46:	d10d      	bne.n	c0d00c64 <io_usb_send_ep+0x68>
c0d00c48:	e028      	b.n	c0d00c9c <io_usb_send_ep+0xa0>
        || G_io_seproxyhal_spi_buffer[3] != (ep|0x80)
        || G_io_seproxyhal_spi_buffer[4] != SEPROXYHAL_TAG_USB_EP_XFER_IN
        || G_io_seproxyhal_spi_buffer[5] != length) {
        
        // handle loss of communication with the host
        if (timeout && timeout--==1) {
c0d00c4a:	2d00      	cmp	r5, #0
c0d00c4c:	d002      	beq.n	c0d00c54 <io_usb_send_ep+0x58>
c0d00c4e:	1e6c      	subs	r4, r5, #1
c0d00c50:	2d01      	cmp	r5, #1
c0d00c52:	d025      	beq.n	c0d00ca0 <io_usb_send_ep+0xa4>
          THROW(EXCEPTION_IO_RESET);
        }

        // link disconnected ?
        if(G_io_seproxyhal_spi_buffer[0] == SEPROXYHAL_TAG_STATUS_EVENT) {
c0d00c54:	2915      	cmp	r1, #21
c0d00c56:	d102      	bne.n	c0d00c5e <io_usb_send_ep+0x62>
          if (!(U4BE(G_io_seproxyhal_spi_buffer, 3) & SEPROXYHAL_TAG_STATUS_EVENT_FLAG_USB_POWERED)) {
c0d00c58:	79b0      	ldrb	r0, [r6, #6]
c0d00c5a:	0700      	lsls	r0, r0, #28
c0d00c5c:	d520      	bpl.n	c0d00ca0 <io_usb_send_ep+0xa4>
        }
        
        // usb reset ?
        //io_seproxyhal_handle_usb_event();
        // also process other transfer requests if any (useful for HID keyboard while playing with CAPS lock key, side effect on LED status)
        io_seproxyhal_handle_event();
c0d00c5e:	f000 f829 	bl	c0d00cb4 <io_seproxyhal_handle_event>
c0d00c62:	4625      	mov	r5, r4
  io_seproxyhal_spi_send(buffer, length);

  // if timeout is requested
  if(timeout) {
    for (;;) {
      if (!io_seproxyhal_spi_is_status_sent()) {
c0d00c64:	f000 fc7c 	bl	c0d01560 <io_seproxyhal_spi_is_status_sent>
c0d00c68:	2800      	cmp	r0, #0
c0d00c6a:	d101      	bne.n	c0d00c70 <io_usb_send_ep+0x74>
        io_seproxyhal_general_status();
c0d00c6c:	f7ff ff4a 	bl	c0d00b04 <io_seproxyhal_general_status>
      }

      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d00c70:	2180      	movs	r1, #128	; 0x80
c0d00c72:	2400      	movs	r4, #0
c0d00c74:	4630      	mov	r0, r6
c0d00c76:	4622      	mov	r2, r4
c0d00c78:	f000 fc8e 	bl	c0d01598 <io_seproxyhal_spi_recv>

      // wait for ack of the seproxyhal
      // discard if not an acknowledgment
      if (G_io_seproxyhal_spi_buffer[0] != SEPROXYHAL_TAG_USB_EP_XFER_EVENT
c0d00c7c:	7831      	ldrb	r1, [r6, #0]
        || rx_len != 6 
c0d00c7e:	2806      	cmp	r0, #6
c0d00c80:	d1e3      	bne.n	c0d00c4a <io_usb_send_ep+0x4e>
c0d00c82:	2910      	cmp	r1, #16
c0d00c84:	d1e1      	bne.n	c0d00c4a <io_usb_send_ep+0x4e>
        || G_io_seproxyhal_spi_buffer[3] != (ep|0x80)
c0d00c86:	78f0      	ldrb	r0, [r6, #3]
        || G_io_seproxyhal_spi_buffer[4] != SEPROXYHAL_TAG_USB_EP_XFER_IN
c0d00c88:	9a02      	ldr	r2, [sp, #8]
c0d00c8a:	4290      	cmp	r0, r2
c0d00c8c:	d1dd      	bne.n	c0d00c4a <io_usb_send_ep+0x4e>
c0d00c8e:	7930      	ldrb	r0, [r6, #4]
c0d00c90:	2802      	cmp	r0, #2
c0d00c92:	d1da      	bne.n	c0d00c4a <io_usb_send_ep+0x4e>
        || G_io_seproxyhal_spi_buffer[5] != length) {
c0d00c94:	7970      	ldrb	r0, [r6, #5]

      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);

      // wait for ack of the seproxyhal
      // discard if not an acknowledgment
      if (G_io_seproxyhal_spi_buffer[0] != SEPROXYHAL_TAG_USB_EP_XFER_EVENT
c0d00c96:	9a01      	ldr	r2, [sp, #4]
c0d00c98:	4290      	cmp	r0, r2
c0d00c9a:	d1d6      	bne.n	c0d00c4a <io_usb_send_ep+0x4e>

      // chunk sending succeeded
      break;
    }
  }
}
c0d00c9c:	b003      	add	sp, #12
c0d00c9e:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00ca0:	4803      	ldr	r0, [pc, #12]	; (c0d00cb0 <io_usb_send_ep+0xb4>)
c0d00ca2:	6800      	ldr	r0, [r0, #0]
c0d00ca4:	2110      	movs	r1, #16
c0d00ca6:	f001 fc13 	bl	c0d024d0 <longjmp>
c0d00caa:	46c0      	nop			; (mov r8, r8)
c0d00cac:	20001800 	.word	0x20001800
c0d00cb0:	200019a8 	.word	0x200019a8

c0d00cb4 <io_seproxyhal_handle_event>:
void io_seproxyhal_handle_bluenrg_event(void) {

}
#endif

unsigned int io_seproxyhal_handle_event(void) {
c0d00cb4:	b580      	push	{r7, lr}
c0d00cb6:	af00      	add	r7, sp, #0
  unsigned int rx_len = U2BE(G_io_seproxyhal_spi_buffer, 1);
c0d00cb8:	480d      	ldr	r0, [pc, #52]	; (c0d00cf0 <io_seproxyhal_handle_event+0x3c>)
c0d00cba:	7882      	ldrb	r2, [r0, #2]
c0d00cbc:	7841      	ldrb	r1, [r0, #1]
c0d00cbe:	0209      	lsls	r1, r1, #8
c0d00cc0:	4311      	orrs	r1, r2

  switch(G_io_seproxyhal_spi_buffer[0]) {
c0d00cc2:	7800      	ldrb	r0, [r0, #0]
c0d00cc4:	2810      	cmp	r0, #16
c0d00cc6:	d008      	beq.n	c0d00cda <io_seproxyhal_handle_event+0x26>
c0d00cc8:	280f      	cmp	r0, #15
c0d00cca:	d10d      	bne.n	c0d00ce8 <io_seproxyhal_handle_event+0x34>
c0d00ccc:	2000      	movs	r0, #0
  #ifdef HAVE_IO_USB
    case SEPROXYHAL_TAG_USB_EVENT:
      if (rx_len != 3+1) {
c0d00cce:	2904      	cmp	r1, #4
c0d00cd0:	d10d      	bne.n	c0d00cee <io_seproxyhal_handle_event+0x3a>
        return 0;
      }
      io_seproxyhal_handle_usb_event();
c0d00cd2:	f7ff ff2d 	bl	c0d00b30 <io_seproxyhal_handle_usb_event>
c0d00cd6:	2001      	movs	r0, #1
    default:
      return io_event(CHANNEL_SPI);
  }
  // defaulty return as not processed
  return 0;
}
c0d00cd8:	bd80      	pop	{r7, pc}
c0d00cda:	2000      	movs	r0, #0
      }
      io_seproxyhal_handle_usb_event();
      return 1;

    case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
      if (rx_len < 3+3) {
c0d00cdc:	2906      	cmp	r1, #6
c0d00cde:	d306      	bcc.n	c0d00cee <io_seproxyhal_handle_event+0x3a>
        // error !
        return 0;
      }
      io_seproxyhal_handle_usb_ep_xfer_event();
c0d00ce0:	f7ff ff64 	bl	c0d00bac <io_seproxyhal_handle_usb_ep_xfer_event>
c0d00ce4:	2001      	movs	r0, #1
    default:
      return io_event(CHANNEL_SPI);
  }
  // defaulty return as not processed
  return 0;
}
c0d00ce6:	bd80      	pop	{r7, pc}
      return 1;
  #endif // HAVE_BLE

      // ask the user if not processed here
    default:
      return io_event(CHANNEL_SPI);
c0d00ce8:	2002      	movs	r0, #2
c0d00cea:	f7ff fa03 	bl	c0d000f4 <io_event>
  }
  // defaulty return as not processed
  return 0;
}
c0d00cee:	bd80      	pop	{r7, pc}
c0d00cf0:	20001800 	.word	0x20001800

c0d00cf4 <io_usb_send_apdu_data>:
      break;
    }
  }
}

void io_usb_send_apdu_data(unsigned char* buffer, unsigned short length) {
c0d00cf4:	b580      	push	{r7, lr}
c0d00cf6:	af00      	add	r7, sp, #0
c0d00cf8:	460a      	mov	r2, r1
c0d00cfa:	4601      	mov	r1, r0
  // wait for 20 events before hanging up and timeout (~2 seconds of timeout)
  io_usb_send_ep(0x82, buffer, length, 20);
c0d00cfc:	2082      	movs	r0, #130	; 0x82
c0d00cfe:	2314      	movs	r3, #20
c0d00d00:	f7ff ff7c 	bl	c0d00bfc <io_usb_send_ep>
}
c0d00d04:	bd80      	pop	{r7, pc}
	...

c0d00d08 <io_seproxyhal_init>:
const char debug_apdus[] = {
  9, 0xe0, 0x22, 0x00, 0x00, 0x04, 0x31, 0x32, 0x33, 0x34,
};
#endif // DEBUG_APDU

void io_seproxyhal_init(void) {
c0d00d08:	b5d0      	push	{r4, r6, r7, lr}
c0d00d0a:	af02      	add	r7, sp, #8
  // Enforce OS compatibility
  check_api_level(CX_COMPAT_APILEVEL);
c0d00d0c:	2007      	movs	r0, #7
c0d00d0e:	f000 fb1d 	bl	c0d0134c <check_api_level>

  G_io_apdu_state = APDU_IDLE;
c0d00d12:	480a      	ldr	r0, [pc, #40]	; (c0d00d3c <io_seproxyhal_init+0x34>)
c0d00d14:	2400      	movs	r4, #0
c0d00d16:	7004      	strb	r4, [r0, #0]
  G_io_apdu_offset = 0;
c0d00d18:	4809      	ldr	r0, [pc, #36]	; (c0d00d40 <io_seproxyhal_init+0x38>)
c0d00d1a:	8004      	strh	r4, [r0, #0]
  G_io_apdu_length = 0;
c0d00d1c:	4809      	ldr	r0, [pc, #36]	; (c0d00d44 <io_seproxyhal_init+0x3c>)
c0d00d1e:	8004      	strh	r4, [r0, #0]
  G_io_apdu_seq = 0;
c0d00d20:	4809      	ldr	r0, [pc, #36]	; (c0d00d48 <io_seproxyhal_init+0x40>)
c0d00d22:	8004      	strh	r4, [r0, #0]
  G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d00d24:	4809      	ldr	r0, [pc, #36]	; (c0d00d4c <io_seproxyhal_init+0x44>)
c0d00d26:	7004      	strb	r4, [r0, #0]
  debug_apdus_offset = 0;
  #endif // DEBUG_APDU


  #ifdef HAVE_USB_APDU
  io_usb_hid_init();
c0d00d28:	f7ff fe6e 	bl	c0d00a08 <io_usb_hid_init>
  io_seproxyhal_init_button();
}

void io_seproxyhal_init_ux(void) {
  // initialize the touch part
  G_bagl_last_touched_not_released_component = NULL;
c0d00d2c:	4808      	ldr	r0, [pc, #32]	; (c0d00d50 <io_seproxyhal_init+0x48>)
c0d00d2e:	6004      	str	r4, [r0, #0]

}

void io_seproxyhal_init_button(void) {
  // no button push so far
  G_button_mask = 0;
c0d00d30:	4808      	ldr	r0, [pc, #32]	; (c0d00d54 <io_seproxyhal_init+0x4c>)
c0d00d32:	6004      	str	r4, [r0, #0]
  G_button_same_mask_counter = 0;
c0d00d34:	4808      	ldr	r0, [pc, #32]	; (c0d00d58 <io_seproxyhal_init+0x50>)
c0d00d36:	6004      	str	r4, [r0, #0]
  io_usb_hid_init();
  #endif // HAVE_USB_APDU

  io_seproxyhal_init_ux();
  io_seproxyhal_init_button();
}
c0d00d38:	bdd0      	pop	{r4, r6, r7, pc}
c0d00d3a:	46c0      	nop			; (mov r8, r8)
c0d00d3c:	20001b08 	.word	0x20001b08
c0d00d40:	20001b0a 	.word	0x20001b0a
c0d00d44:	20001b0c 	.word	0x20001b0c
c0d00d48:	20001b0e 	.word	0x20001b0e
c0d00d4c:	20001b00 	.word	0x20001b00
c0d00d50:	20001b10 	.word	0x20001b10
c0d00d54:	20001b14 	.word	0x20001b14
c0d00d58:	20001b18 	.word	0x20001b18

c0d00d5c <io_seproxyhal_init_ux>:

void io_seproxyhal_init_ux(void) {
  // initialize the touch part
  G_bagl_last_touched_not_released_component = NULL;
c0d00d5c:	4801      	ldr	r0, [pc, #4]	; (c0d00d64 <io_seproxyhal_init_ux+0x8>)
c0d00d5e:	2100      	movs	r1, #0
c0d00d60:	6001      	str	r1, [r0, #0]

}
c0d00d62:	4770      	bx	lr
c0d00d64:	20001b10 	.word	0x20001b10

c0d00d68 <io_seproxyhal_touch_out>:
  G_button_same_mask_counter = 0;
}

#ifdef HAVE_BAGL

unsigned int io_seproxyhal_touch_out(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d00d68:	b5b0      	push	{r4, r5, r7, lr}
c0d00d6a:	af02      	add	r7, sp, #8
c0d00d6c:	460d      	mov	r5, r1
c0d00d6e:	4604      	mov	r4, r0
  const bagl_element_t* el;
  if (element->out != NULL) {
c0d00d70:	6b20      	ldr	r0, [r4, #48]	; 0x30
c0d00d72:	2800      	cmp	r0, #0
c0d00d74:	d00c      	beq.n	c0d00d90 <io_seproxyhal_touch_out+0x28>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->out))(element));
c0d00d76:	f000 fad1 	bl	c0d0131c <pic>
c0d00d7a:	4601      	mov	r1, r0
c0d00d7c:	4620      	mov	r0, r4
c0d00d7e:	4788      	blx	r1
c0d00d80:	f000 facc 	bl	c0d0131c <pic>
c0d00d84:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (! el) {
c0d00d86:	2800      	cmp	r0, #0
c0d00d88:	d010      	beq.n	c0d00dac <io_seproxyhal_touch_out+0x44>
c0d00d8a:	2801      	cmp	r0, #1
c0d00d8c:	d000      	beq.n	c0d00d90 <io_seproxyhal_touch_out+0x28>
c0d00d8e:	4604      	mov	r4, r0
      element = el;
    }
  }

  // out function might have triggered a draw of its own during a display callback
  if (before_display) {
c0d00d90:	2d00      	cmp	r5, #0
c0d00d92:	d007      	beq.n	c0d00da4 <io_seproxyhal_touch_out+0x3c>
    el = before_display(element);
c0d00d94:	4620      	mov	r0, r4
c0d00d96:	47a8      	blx	r5
c0d00d98:	2100      	movs	r1, #0
    if (!el) {
c0d00d9a:	2800      	cmp	r0, #0
c0d00d9c:	d006      	beq.n	c0d00dac <io_seproxyhal_touch_out+0x44>
c0d00d9e:	2801      	cmp	r0, #1
c0d00da0:	d000      	beq.n	c0d00da4 <io_seproxyhal_touch_out+0x3c>
c0d00da2:	4604      	mov	r4, r0
    if ((unsigned int)el != 1) {
      element = el;
    }
  }

  io_seproxyhal_display(element);
c0d00da4:	4620      	mov	r0, r4
c0d00da6:	f7ff f99f 	bl	c0d000e8 <io_seproxyhal_display>
c0d00daa:	2101      	movs	r1, #1
  return 1;
}
c0d00dac:	4608      	mov	r0, r1
c0d00dae:	bdb0      	pop	{r4, r5, r7, pc}

c0d00db0 <io_seproxyhal_touch_over>:

unsigned int io_seproxyhal_touch_over(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d00db0:	b5b0      	push	{r4, r5, r7, lr}
c0d00db2:	af02      	add	r7, sp, #8
c0d00db4:	b08e      	sub	sp, #56	; 0x38
c0d00db6:	460c      	mov	r4, r1
c0d00db8:	4605      	mov	r5, r0
  bagl_element_t e;
  const bagl_element_t* el;
  if (element->over != NULL) {
c0d00dba:	6b68      	ldr	r0, [r5, #52]	; 0x34
c0d00dbc:	2800      	cmp	r0, #0
c0d00dbe:	d00c      	beq.n	c0d00dda <io_seproxyhal_touch_over+0x2a>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->over))(element));
c0d00dc0:	f000 faac 	bl	c0d0131c <pic>
c0d00dc4:	4601      	mov	r1, r0
c0d00dc6:	4628      	mov	r0, r5
c0d00dc8:	4788      	blx	r1
c0d00dca:	f000 faa7 	bl	c0d0131c <pic>
c0d00dce:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (!el) {
c0d00dd0:	2800      	cmp	r0, #0
c0d00dd2:	d016      	beq.n	c0d00e02 <io_seproxyhal_touch_over+0x52>
c0d00dd4:	2801      	cmp	r0, #1
c0d00dd6:	d000      	beq.n	c0d00dda <io_seproxyhal_touch_over+0x2a>
c0d00dd8:	4605      	mov	r5, r0
c0d00dda:	4668      	mov	r0, sp
      element = el;
    }
  }

  // over function might have triggered a draw of its own during a display callback
  os_memmove(&e, (void*)element, sizeof(bagl_element_t));
c0d00ddc:	2238      	movs	r2, #56	; 0x38
c0d00dde:	4629      	mov	r1, r5
c0d00de0:	f7ff fdf6 	bl	c0d009d0 <os_memmove>
  e.component.fgcolor = element->overfgcolor;
c0d00de4:	6a68      	ldr	r0, [r5, #36]	; 0x24
c0d00de6:	9004      	str	r0, [sp, #16]
  e.component.bgcolor = element->overbgcolor;
c0d00de8:	6aa8      	ldr	r0, [r5, #40]	; 0x28
c0d00dea:	9005      	str	r0, [sp, #20]

  //element = &e; // for INARRAY checks, it disturbs a bit. avoid it

  if (before_display) {
c0d00dec:	2c00      	cmp	r4, #0
c0d00dee:	d004      	beq.n	c0d00dfa <io_seproxyhal_touch_over+0x4a>
    el = before_display(element);
c0d00df0:	4628      	mov	r0, r5
c0d00df2:	47a0      	blx	r4
c0d00df4:	2100      	movs	r1, #0
    element = &e;
    if (!el) {
c0d00df6:	2800      	cmp	r0, #0
c0d00df8:	d003      	beq.n	c0d00e02 <io_seproxyhal_touch_over+0x52>
c0d00dfa:	4668      	mov	r0, sp
  //else 
  {
    element = &e;
  }

  io_seproxyhal_display(element);
c0d00dfc:	f7ff f974 	bl	c0d000e8 <io_seproxyhal_display>
c0d00e00:	2101      	movs	r1, #1
  return 1;
}
c0d00e02:	4608      	mov	r0, r1
c0d00e04:	b00e      	add	sp, #56	; 0x38
c0d00e06:	bdb0      	pop	{r4, r5, r7, pc}

c0d00e08 <io_seproxyhal_touch_tap>:

unsigned int io_seproxyhal_touch_tap(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d00e08:	b5b0      	push	{r4, r5, r7, lr}
c0d00e0a:	af02      	add	r7, sp, #8
c0d00e0c:	460d      	mov	r5, r1
c0d00e0e:	4604      	mov	r4, r0
  const bagl_element_t* el;
  if (element->tap != NULL) {
c0d00e10:	6ae0      	ldr	r0, [r4, #44]	; 0x2c
c0d00e12:	2800      	cmp	r0, #0
c0d00e14:	d00c      	beq.n	c0d00e30 <io_seproxyhal_touch_tap+0x28>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->tap))(element));
c0d00e16:	f000 fa81 	bl	c0d0131c <pic>
c0d00e1a:	4601      	mov	r1, r0
c0d00e1c:	4620      	mov	r0, r4
c0d00e1e:	4788      	blx	r1
c0d00e20:	f000 fa7c 	bl	c0d0131c <pic>
c0d00e24:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (!el) {
c0d00e26:	2800      	cmp	r0, #0
c0d00e28:	d010      	beq.n	c0d00e4c <io_seproxyhal_touch_tap+0x44>
c0d00e2a:	2801      	cmp	r0, #1
c0d00e2c:	d000      	beq.n	c0d00e30 <io_seproxyhal_touch_tap+0x28>
c0d00e2e:	4604      	mov	r4, r0
      element = el;
    }
  }

  // tap function might have triggered a draw of its own during a display callback
  if (before_display) {
c0d00e30:	2d00      	cmp	r5, #0
c0d00e32:	d007      	beq.n	c0d00e44 <io_seproxyhal_touch_tap+0x3c>
    el = before_display(element);
c0d00e34:	4620      	mov	r0, r4
c0d00e36:	47a8      	blx	r5
c0d00e38:	2100      	movs	r1, #0
    if (!el) {
c0d00e3a:	2800      	cmp	r0, #0
c0d00e3c:	d006      	beq.n	c0d00e4c <io_seproxyhal_touch_tap+0x44>
c0d00e3e:	2801      	cmp	r0, #1
c0d00e40:	d000      	beq.n	c0d00e44 <io_seproxyhal_touch_tap+0x3c>
c0d00e42:	4604      	mov	r4, r0
    }
    if ((unsigned int)el != 1) {
      element = el;
    }
  }
  io_seproxyhal_display(element);
c0d00e44:	4620      	mov	r0, r4
c0d00e46:	f7ff f94f 	bl	c0d000e8 <io_seproxyhal_display>
c0d00e4a:	2101      	movs	r1, #1
  return 1;
}
c0d00e4c:	4608      	mov	r0, r1
c0d00e4e:	bdb0      	pop	{r4, r5, r7, pc}

c0d00e50 <io_seproxyhal_touch_element_callback>:
  io_seproxyhal_touch_element_callback(elements, element_count, x, y, event_kind, NULL);  
}

// browse all elements and until an element has changed state, continue browsing
// return if processed or not
void io_seproxyhal_touch_element_callback(const bagl_element_t* elements, unsigned short element_count, unsigned short x, unsigned short y, unsigned char event_kind, bagl_element_callback_t before_display) {
c0d00e50:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00e52:	af03      	add	r7, sp, #12
c0d00e54:	b087      	sub	sp, #28
c0d00e56:	9302      	str	r3, [sp, #8]
c0d00e58:	9203      	str	r2, [sp, #12]
c0d00e5a:	9105      	str	r1, [sp, #20]
  unsigned char comp_idx;
  unsigned char last_touched_not_released_component_was_in_current_array = 0;

  // find the first empty entry
  for (comp_idx=0; comp_idx < element_count; comp_idx++) {
c0d00e5c:	2900      	cmp	r1, #0
c0d00e5e:	d076      	beq.n	c0d00f4e <io_seproxyhal_touch_element_callback+0xfe>
c0d00e60:	9004      	str	r0, [sp, #16]
c0d00e62:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d00e64:	9001      	str	r0, [sp, #4]
c0d00e66:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d00e68:	9000      	str	r0, [sp, #0]
c0d00e6a:	2600      	movs	r6, #0
c0d00e6c:	9606      	str	r6, [sp, #24]
c0d00e6e:	4634      	mov	r4, r6
    // process all components matching the x/y/w/h (no break) => fishy for the released out of zone
    // continue processing only if a status has not been sent
    if (io_seproxyhal_spi_is_status_sent()) {
c0d00e70:	f000 fb76 	bl	c0d01560 <io_seproxyhal_spi_is_status_sent>
c0d00e74:	2800      	cmp	r0, #0
c0d00e76:	d155      	bne.n	c0d00f24 <io_seproxyhal_touch_element_callback+0xd4>
      // continue instead of return to process all elemnts and therefore discard last touched element
      break;
    }

    // only perform out callback when element was in the current array, else, leave it be
    if (&elements[comp_idx] == G_bagl_last_touched_not_released_component) {
c0d00e78:	2038      	movs	r0, #56	; 0x38
c0d00e7a:	4370      	muls	r0, r6
c0d00e7c:	9d04      	ldr	r5, [sp, #16]
c0d00e7e:	182e      	adds	r6, r5, r0
c0d00e80:	4b36      	ldr	r3, [pc, #216]	; (c0d00f5c <io_seproxyhal_touch_element_callback+0x10c>)
c0d00e82:	681a      	ldr	r2, [r3, #0]
c0d00e84:	2101      	movs	r1, #1
c0d00e86:	4296      	cmp	r6, r2
c0d00e88:	d000      	beq.n	c0d00e8c <io_seproxyhal_touch_element_callback+0x3c>
c0d00e8a:	9906      	ldr	r1, [sp, #24]
c0d00e8c:	9106      	str	r1, [sp, #24]
      last_touched_not_released_component_was_in_current_array = 1;
    }

    // the first component drawn with a 
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
c0d00e8e:	5628      	ldrsb	r0, [r5, r0]
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
c0d00e90:	2800      	cmp	r0, #0
c0d00e92:	da41      	bge.n	c0d00f18 <io_seproxyhal_touch_element_callback+0xc8>
c0d00e94:	2020      	movs	r0, #32
c0d00e96:	5c35      	ldrb	r5, [r6, r0]
c0d00e98:	2102      	movs	r1, #2
c0d00e9a:	5e71      	ldrsh	r1, [r6, r1]
c0d00e9c:	1b4a      	subs	r2, r1, r5
c0d00e9e:	9803      	ldr	r0, [sp, #12]
c0d00ea0:	4282      	cmp	r2, r0
c0d00ea2:	dc39      	bgt.n	c0d00f18 <io_seproxyhal_touch_element_callback+0xc8>
c0d00ea4:	1869      	adds	r1, r5, r1
c0d00ea6:	88f2      	ldrh	r2, [r6, #6]
c0d00ea8:	1889      	adds	r1, r1, r2
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {
c0d00eaa:	9803      	ldr	r0, [sp, #12]
c0d00eac:	4288      	cmp	r0, r1
c0d00eae:	da33      	bge.n	c0d00f18 <io_seproxyhal_touch_element_callback+0xc8>
c0d00eb0:	2104      	movs	r1, #4
c0d00eb2:	5e70      	ldrsh	r0, [r6, r1]
c0d00eb4:	1b42      	subs	r2, r0, r5
c0d00eb6:	9902      	ldr	r1, [sp, #8]
c0d00eb8:	428a      	cmp	r2, r1
c0d00eba:	dc2d      	bgt.n	c0d00f18 <io_seproxyhal_touch_element_callback+0xc8>
c0d00ebc:	1940      	adds	r0, r0, r5
c0d00ebe:	8931      	ldrh	r1, [r6, #8]
c0d00ec0:	1840      	adds	r0, r0, r1
    if (&elements[comp_idx] == G_bagl_last_touched_not_released_component) {
      last_touched_not_released_component_was_in_current_array = 1;
    }

    // the first component drawn with a 
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
c0d00ec2:	9902      	ldr	r1, [sp, #8]
c0d00ec4:	4281      	cmp	r1, r0
c0d00ec6:	da27      	bge.n	c0d00f18 <io_seproxyhal_touch_element_callback+0xc8>
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {

      // outing the previous over'ed component
      if (&elements[comp_idx] != G_bagl_last_touched_not_released_component 
c0d00ec8:	6818      	ldr	r0, [r3, #0]
              && G_bagl_last_touched_not_released_component != NULL) {
c0d00eca:	4286      	cmp	r6, r0
c0d00ecc:	d010      	beq.n	c0d00ef0 <io_seproxyhal_touch_element_callback+0xa0>
c0d00ece:	6818      	ldr	r0, [r3, #0]
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {

      // outing the previous over'ed component
      if (&elements[comp_idx] != G_bagl_last_touched_not_released_component 
c0d00ed0:	2800      	cmp	r0, #0
c0d00ed2:	d00d      	beq.n	c0d00ef0 <io_seproxyhal_touch_element_callback+0xa0>
              && G_bagl_last_touched_not_released_component != NULL) {
        // only out the previous element if the newly matching will be displayed 
        if (!before_display || before_display(&elements[comp_idx])) {
c0d00ed4:	9801      	ldr	r0, [sp, #4]
c0d00ed6:	2800      	cmp	r0, #0
c0d00ed8:	d005      	beq.n	c0d00ee6 <io_seproxyhal_touch_element_callback+0x96>
c0d00eda:	4630      	mov	r0, r6
c0d00edc:	9901      	ldr	r1, [sp, #4]
c0d00ede:	4788      	blx	r1
c0d00ee0:	4b1e      	ldr	r3, [pc, #120]	; (c0d00f5c <io_seproxyhal_touch_element_callback+0x10c>)
c0d00ee2:	2800      	cmp	r0, #0
c0d00ee4:	d018      	beq.n	c0d00f18 <io_seproxyhal_touch_element_callback+0xc8>
          if (io_seproxyhal_touch_out(G_bagl_last_touched_not_released_component, before_display)) {
c0d00ee6:	6818      	ldr	r0, [r3, #0]
c0d00ee8:	9901      	ldr	r1, [sp, #4]
c0d00eea:	f7ff ff3d 	bl	c0d00d68 <io_seproxyhal_touch_out>
c0d00eee:	e008      	b.n	c0d00f02 <io_seproxyhal_touch_element_callback+0xb2>
c0d00ef0:	9800      	ldr	r0, [sp, #0]
        continue;
      }
      */
      
      // callback the hal to notify the component impacted by the user input
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_RELEASE) {
c0d00ef2:	2801      	cmp	r0, #1
c0d00ef4:	d009      	beq.n	c0d00f0a <io_seproxyhal_touch_element_callback+0xba>
c0d00ef6:	2802      	cmp	r0, #2
c0d00ef8:	d10e      	bne.n	c0d00f18 <io_seproxyhal_touch_element_callback+0xc8>
        if (io_seproxyhal_touch_tap(&elements[comp_idx], before_display)) {
c0d00efa:	4630      	mov	r0, r6
c0d00efc:	9901      	ldr	r1, [sp, #4]
c0d00efe:	f7ff ff83 	bl	c0d00e08 <io_seproxyhal_touch_tap>
c0d00f02:	4b16      	ldr	r3, [pc, #88]	; (c0d00f5c <io_seproxyhal_touch_element_callback+0x10c>)
c0d00f04:	2800      	cmp	r0, #0
c0d00f06:	d007      	beq.n	c0d00f18 <io_seproxyhal_touch_element_callback+0xc8>
c0d00f08:	e023      	b.n	c0d00f52 <io_seproxyhal_touch_element_callback+0x102>
          return;
        }
      }
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_TOUCH) {
        // ask for overing
        if (io_seproxyhal_touch_over(&elements[comp_idx], before_display)) {
c0d00f0a:	4630      	mov	r0, r6
c0d00f0c:	9901      	ldr	r1, [sp, #4]
c0d00f0e:	f7ff ff4f 	bl	c0d00db0 <io_seproxyhal_touch_over>
c0d00f12:	4b12      	ldr	r3, [pc, #72]	; (c0d00f5c <io_seproxyhal_touch_element_callback+0x10c>)
c0d00f14:	2800      	cmp	r0, #0
c0d00f16:	d11f      	bne.n	c0d00f58 <io_seproxyhal_touch_element_callback+0x108>
void io_seproxyhal_touch_element_callback(const bagl_element_t* elements, unsigned short element_count, unsigned short x, unsigned short y, unsigned char event_kind, bagl_element_callback_t before_display) {
  unsigned char comp_idx;
  unsigned char last_touched_not_released_component_was_in_current_array = 0;

  // find the first empty entry
  for (comp_idx=0; comp_idx < element_count; comp_idx++) {
c0d00f18:	1c64      	adds	r4, r4, #1
c0d00f1a:	b2e6      	uxtb	r6, r4
c0d00f1c:	9805      	ldr	r0, [sp, #20]
c0d00f1e:	4286      	cmp	r6, r0
c0d00f20:	d3a6      	bcc.n	c0d00e70 <io_seproxyhal_touch_element_callback+0x20>
c0d00f22:	e000      	b.n	c0d00f26 <io_seproxyhal_touch_element_callback+0xd6>
c0d00f24:	4b0d      	ldr	r3, [pc, #52]	; (c0d00f5c <io_seproxyhal_touch_element_callback+0x10c>)
    }
  }

  // if overing out of component or over another component, the out event is sent after the over event of the previous component
  if(last_touched_not_released_component_was_in_current_array 
    && G_bagl_last_touched_not_released_component != NULL) {
c0d00f26:	9806      	ldr	r0, [sp, #24]
c0d00f28:	0600      	lsls	r0, r0, #24
c0d00f2a:	d010      	beq.n	c0d00f4e <io_seproxyhal_touch_element_callback+0xfe>
c0d00f2c:	6818      	ldr	r0, [r3, #0]
      }
    }
  }

  // if overing out of component or over another component, the out event is sent after the over event of the previous component
  if(last_touched_not_released_component_was_in_current_array 
c0d00f2e:	2800      	cmp	r0, #0
c0d00f30:	d00d      	beq.n	c0d00f4e <io_seproxyhal_touch_element_callback+0xfe>
    && G_bagl_last_touched_not_released_component != NULL) {

    // we won't be able to notify the out, don't do it, in case a diplay refused the dra of the relased element and the position matched another element of the array (in autocomplete for example)
    if (io_seproxyhal_spi_is_status_sent()) {
c0d00f32:	f000 fb15 	bl	c0d01560 <io_seproxyhal_spi_is_status_sent>
c0d00f36:	4909      	ldr	r1, [pc, #36]	; (c0d00f5c <io_seproxyhal_touch_element_callback+0x10c>)
c0d00f38:	2800      	cmp	r0, #0
c0d00f3a:	d108      	bne.n	c0d00f4e <io_seproxyhal_touch_element_callback+0xfe>
      return;
    }
    
    if (io_seproxyhal_touch_out(G_bagl_last_touched_not_released_component, before_display)) {
c0d00f3c:	6808      	ldr	r0, [r1, #0]
c0d00f3e:	9901      	ldr	r1, [sp, #4]
c0d00f40:	f7ff ff12 	bl	c0d00d68 <io_seproxyhal_touch_out>
c0d00f44:	4d05      	ldr	r5, [pc, #20]	; (c0d00f5c <io_seproxyhal_touch_element_callback+0x10c>)
c0d00f46:	2800      	cmp	r0, #0
c0d00f48:	d001      	beq.n	c0d00f4e <io_seproxyhal_touch_element_callback+0xfe>
      // ok component out has been emitted
      G_bagl_last_touched_not_released_component = NULL;
c0d00f4a:	2000      	movs	r0, #0
c0d00f4c:	6028      	str	r0, [r5, #0]
    }
  }

  // not processed
}
c0d00f4e:	b007      	add	sp, #28
c0d00f50:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00f52:	2000      	movs	r0, #0
c0d00f54:	6018      	str	r0, [r3, #0]
c0d00f56:	e7fa      	b.n	c0d00f4e <io_seproxyhal_touch_element_callback+0xfe>
      }
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_TOUCH) {
        // ask for overing
        if (io_seproxyhal_touch_over(&elements[comp_idx], before_display)) {
          // remember the last touched component
          G_bagl_last_touched_not_released_component = (bagl_element_t*)&elements[comp_idx];
c0d00f58:	601e      	str	r6, [r3, #0]
c0d00f5a:	e7f8      	b.n	c0d00f4e <io_seproxyhal_touch_element_callback+0xfe>
c0d00f5c:	20001b10 	.word	0x20001b10

c0d00f60 <io_seproxyhal_display_icon>:
  io_seproxyhal_spi_send((unsigned char*)color_index, h);
  io_seproxyhal_spi_send(bitmap, w);
  */
}

void io_seproxyhal_display_icon(bagl_component_t* icon_component, bagl_icon_details_t* icon_details) {
c0d00f60:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00f62:	af03      	add	r7, sp, #12
c0d00f64:	b08b      	sub	sp, #44	; 0x2c
c0d00f66:	460c      	mov	r4, r1
c0d00f68:	4601      	mov	r1, r0
c0d00f6a:	ad04      	add	r5, sp, #16
c0d00f6c:	221c      	movs	r2, #28
  bagl_component_t icon_component_mod;
  // ensure not being out of bounds in the icon component agianst the declared icon real size
  os_memmove(&icon_component_mod, icon_component, sizeof(bagl_component_t));
c0d00f6e:	4628      	mov	r0, r5
c0d00f70:	9203      	str	r2, [sp, #12]
c0d00f72:	f7ff fd2d 	bl	c0d009d0 <os_memmove>
  icon_component_mod.width = icon_details->width;
c0d00f76:	6821      	ldr	r1, [r4, #0]
c0d00f78:	80e9      	strh	r1, [r5, #6]
  icon_component_mod.height = icon_details->height;
c0d00f7a:	6862      	ldr	r2, [r4, #4]
c0d00f7c:	9502      	str	r5, [sp, #8]
c0d00f7e:	812a      	strh	r2, [r5, #8]
  // component type = ICON, provided bitmap
  // => bitmap transmitted


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
c0d00f80:	68a0      	ldr	r0, [r4, #8]
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
  unsigned short length = sizeof(bagl_component_t)
                          +1 /* bpp */
                          +h /* color index */
                          +w; /* image bitmap size */
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d00f82:	4e1a      	ldr	r6, [pc, #104]	; (c0d00fec <io_seproxyhal_display_icon+0x8c>)
c0d00f84:	2365      	movs	r3, #101	; 0x65
c0d00f86:	4635      	mov	r5, r6
c0d00f88:	7033      	strb	r3, [r6, #0]


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
  // bitmap size
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
c0d00f8a:	b292      	uxth	r2, r2
c0d00f8c:	4342      	muls	r2, r0
c0d00f8e:	b28b      	uxth	r3, r1
c0d00f90:	4353      	muls	r3, r2
c0d00f92:	08d9      	lsrs	r1, r3, #3
c0d00f94:	1c4e      	adds	r6, r1, #1
c0d00f96:	2207      	movs	r2, #7
c0d00f98:	4213      	tst	r3, r2
c0d00f9a:	d100      	bne.n	c0d00f9e <io_seproxyhal_display_icon+0x3e>
c0d00f9c:	460e      	mov	r6, r1
c0d00f9e:	4631      	mov	r1, r6
c0d00fa0:	9101      	str	r1, [sp, #4]
c0d00fa2:	2604      	movs	r6, #4
  // component type = ICON, provided bitmap
  // => bitmap transmitted


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
c0d00fa4:	4086      	lsls	r6, r0
  // bitmap size
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
  unsigned short length = sizeof(bagl_component_t)
                          +1 /* bpp */
                          +h /* color index */
c0d00fa6:	1870      	adds	r0, r6, r1
                          +w; /* image bitmap size */
c0d00fa8:	301d      	adds	r0, #29
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
  G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d00faa:	0a01      	lsrs	r1, r0, #8
c0d00fac:	7069      	strb	r1, [r5, #1]
  G_io_seproxyhal_spi_buffer[2] = length;
c0d00fae:	70a8      	strb	r0, [r5, #2]
c0d00fb0:	2103      	movs	r1, #3
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d00fb2:	4628      	mov	r0, r5
c0d00fb4:	f000 fab6 	bl	c0d01524 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)icon_component, sizeof(bagl_component_t));
c0d00fb8:	9802      	ldr	r0, [sp, #8]
c0d00fba:	9903      	ldr	r1, [sp, #12]
c0d00fbc:	f000 fab2 	bl	c0d01524 <io_seproxyhal_spi_send>
  G_io_seproxyhal_spi_buffer[0] = icon_details->bpp;
c0d00fc0:	68a0      	ldr	r0, [r4, #8]
c0d00fc2:	7028      	strb	r0, [r5, #0]
c0d00fc4:	2101      	movs	r1, #1
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 1);
c0d00fc6:	4628      	mov	r0, r5
c0d00fc8:	f000 faac 	bl	c0d01524 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->colors), h);
c0d00fcc:	68e0      	ldr	r0, [r4, #12]
c0d00fce:	f000 f9a5 	bl	c0d0131c <pic>
c0d00fd2:	b2b1      	uxth	r1, r6
c0d00fd4:	f000 faa6 	bl	c0d01524 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->bitmap), w);
c0d00fd8:	9801      	ldr	r0, [sp, #4]
c0d00fda:	b285      	uxth	r5, r0
c0d00fdc:	6920      	ldr	r0, [r4, #16]
c0d00fde:	f000 f99d 	bl	c0d0131c <pic>
c0d00fe2:	4629      	mov	r1, r5
c0d00fe4:	f000 fa9e 	bl	c0d01524 <io_seproxyhal_spi_send>
#endif // !SEPROXYHAL_TAG_SCREEN_DISPLAY_RAW_STATUS
}
c0d00fe8:	b00b      	add	sp, #44	; 0x2c
c0d00fea:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00fec:	20001800 	.word	0x20001800

c0d00ff0 <io_seproxyhal_display_default>:

void io_seproxyhal_display_default(bagl_element_t * element) {
c0d00ff0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00ff2:	af03      	add	r7, sp, #12
c0d00ff4:	b081      	sub	sp, #4
c0d00ff6:	4604      	mov	r4, r0
  // process automagically address from rom and from ram
  unsigned int type = (element->component.type & ~(BAGL_FLAG_TOUCHABLE));
c0d00ff8:	7820      	ldrb	r0, [r4, #0]
c0d00ffa:	267f      	movs	r6, #127	; 0x7f
c0d00ffc:	4006      	ands	r6, r0

  if (type != BAGL_NONE) {
c0d00ffe:	2e00      	cmp	r6, #0
c0d01000:	d02e      	beq.n	c0d01060 <io_seproxyhal_display_default+0x70>
    if (element->text != NULL) {
c0d01002:	69e0      	ldr	r0, [r4, #28]
c0d01004:	2800      	cmp	r0, #0
c0d01006:	d01d      	beq.n	c0d01044 <io_seproxyhal_display_default+0x54>
      unsigned int text_adr = PIC((unsigned int)element->text);
c0d01008:	f000 f988 	bl	c0d0131c <pic>
c0d0100c:	4605      	mov	r5, r0
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
c0d0100e:	2e05      	cmp	r6, #5
c0d01010:	d102      	bne.n	c0d01018 <io_seproxyhal_display_default+0x28>
c0d01012:	7ea0      	ldrb	r0, [r4, #26]
c0d01014:	2800      	cmp	r0, #0
c0d01016:	d025      	beq.n	c0d01064 <io_seproxyhal_display_default+0x74>
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
c0d01018:	4628      	mov	r0, r5
c0d0101a:	f001 fa67 	bl	c0d024ec <strlen>
c0d0101e:	4606      	mov	r6, r0
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d01020:	4813      	ldr	r0, [pc, #76]	; (c0d01070 <io_seproxyhal_display_default+0x80>)
c0d01022:	2165      	movs	r1, #101	; 0x65
c0d01024:	7001      	strb	r1, [r0, #0]
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
c0d01026:	4631      	mov	r1, r6
c0d01028:	311c      	adds	r1, #28
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
        G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d0102a:	0a0a      	lsrs	r2, r1, #8
c0d0102c:	7042      	strb	r2, [r0, #1]
        G_io_seproxyhal_spi_buffer[2] = length;
c0d0102e:	7081      	strb	r1, [r0, #2]
        io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d01030:	2103      	movs	r1, #3
c0d01032:	f000 fa77 	bl	c0d01524 <io_seproxyhal_spi_send>
c0d01036:	211c      	movs	r1, #28
        io_seproxyhal_spi_send((const void*)&element->component, sizeof(bagl_component_t));
c0d01038:	4620      	mov	r0, r4
c0d0103a:	f000 fa73 	bl	c0d01524 <io_seproxyhal_spi_send>
        io_seproxyhal_spi_send((const void*)text_adr, length-sizeof(bagl_component_t));
c0d0103e:	b2b1      	uxth	r1, r6
c0d01040:	4628      	mov	r0, r5
c0d01042:	e00b      	b.n	c0d0105c <io_seproxyhal_display_default+0x6c>
      }
    }
    else {
      unsigned short length = sizeof(bagl_component_t);
      G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d01044:	480a      	ldr	r0, [pc, #40]	; (c0d01070 <io_seproxyhal_display_default+0x80>)
c0d01046:	2165      	movs	r1, #101	; 0x65
c0d01048:	7001      	strb	r1, [r0, #0]
      G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d0104a:	2100      	movs	r1, #0
c0d0104c:	7041      	strb	r1, [r0, #1]
c0d0104e:	251c      	movs	r5, #28
      G_io_seproxyhal_spi_buffer[2] = length;
c0d01050:	7085      	strb	r5, [r0, #2]
      io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d01052:	2103      	movs	r1, #3
c0d01054:	f000 fa66 	bl	c0d01524 <io_seproxyhal_spi_send>
      io_seproxyhal_spi_send((const void*)&element->component, sizeof(bagl_component_t));
c0d01058:	4620      	mov	r0, r4
c0d0105a:	4629      	mov	r1, r5
c0d0105c:	f000 fa62 	bl	c0d01524 <io_seproxyhal_spi_send>
    }
  }
}
c0d01060:	b001      	add	sp, #4
c0d01062:	bdf0      	pop	{r4, r5, r6, r7, pc}
  if (type != BAGL_NONE) {
    if (element->text != NULL) {
      unsigned int text_adr = PIC((unsigned int)element->text);
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
c0d01064:	4620      	mov	r0, r4
c0d01066:	4629      	mov	r1, r5
c0d01068:	f7ff ff7a 	bl	c0d00f60 <io_seproxyhal_display_icon>
c0d0106c:	e7f8      	b.n	c0d01060 <io_seproxyhal_display_default+0x70>
c0d0106e:	46c0      	nop			; (mov r8, r8)
c0d01070:	20001800 	.word	0x20001800

c0d01074 <bagl_label_roundtrip_duration_ms>:
      io_seproxyhal_spi_send((const void*)&element->component, sizeof(bagl_component_t));
    }
  }
}

unsigned int bagl_label_roundtrip_duration_ms(const bagl_element_t* e, unsigned int average_char_width) {
c0d01074:	b580      	push	{r7, lr}
c0d01076:	af00      	add	r7, sp, #0
c0d01078:	460a      	mov	r2, r1
  return bagl_label_roundtrip_duration_ms_buf(e, e->text, average_char_width);
c0d0107a:	69c1      	ldr	r1, [r0, #28]
c0d0107c:	f000 f801 	bl	c0d01082 <bagl_label_roundtrip_duration_ms_buf>
c0d01080:	bd80      	pop	{r7, pc}

c0d01082 <bagl_label_roundtrip_duration_ms_buf>:
}

unsigned int bagl_label_roundtrip_duration_ms_buf(const bagl_element_t* e, const char* str, unsigned int average_char_width) {
c0d01082:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01084:	af03      	add	r7, sp, #12
c0d01086:	b081      	sub	sp, #4
c0d01088:	4616      	mov	r6, r2
c0d0108a:	4604      	mov	r4, r0
c0d0108c:	2500      	movs	r5, #0
  // not a scrollable label
  if (e == NULL || (e->component.type != BAGL_LABEL && e->component.type != BAGL_LABELINE)) {
c0d0108e:	2c00      	cmp	r4, #0
c0d01090:	d01c      	beq.n	c0d010cc <bagl_label_roundtrip_duration_ms_buf+0x4a>
c0d01092:	7820      	ldrb	r0, [r4, #0]
c0d01094:	2807      	cmp	r0, #7
c0d01096:	d001      	beq.n	c0d0109c <bagl_label_roundtrip_duration_ms_buf+0x1a>
c0d01098:	2802      	cmp	r0, #2
c0d0109a:	d117      	bne.n	c0d010cc <bagl_label_roundtrip_duration_ms_buf+0x4a>
    return 0;
  }
  
  unsigned int text_adr = PIC((unsigned int)str);
c0d0109c:	4608      	mov	r0, r1
c0d0109e:	f000 f93d 	bl	c0d0131c <pic>
  unsigned int textlen = 0;
  
  // no delay, no text to display
  if (!text_adr) {
c0d010a2:	2800      	cmp	r0, #0
c0d010a4:	d012      	beq.n	c0d010cc <bagl_label_roundtrip_duration_ms_buf+0x4a>
    return 0;
  }
  textlen = strlen((const char*)text_adr);
c0d010a6:	f001 fa21 	bl	c0d024ec <strlen>
  
  // no delay, all text fits
  textlen = textlen * average_char_width;
c0d010aa:	4346      	muls	r6, r0
  if (textlen <= e->component.width) {
c0d010ac:	88e0      	ldrh	r0, [r4, #6]
c0d010ae:	4286      	cmp	r6, r0
c0d010b0:	d90c      	bls.n	c0d010cc <bagl_label_roundtrip_duration_ms_buf+0x4a>
    return 0; 
  }
  
  // compute scrolled text length
  return 2*(textlen - e->component.width)*1000/e->component.icon_id + 2*(e->component.stroke & ~(0x80))*100;
c0d010b2:	1a31      	subs	r1, r6, r0
c0d010b4:	207d      	movs	r0, #125	; 0x7d
c0d010b6:	0100      	lsls	r0, r0, #4
c0d010b8:	4348      	muls	r0, r1
c0d010ba:	7ea1      	ldrb	r1, [r4, #26]
c0d010bc:	f001 f91c 	bl	c0d022f8 <__aeabi_uidiv>
c0d010c0:	7aa1      	ldrb	r1, [r4, #10]
c0d010c2:	0049      	lsls	r1, r1, #1
c0d010c4:	b2c9      	uxtb	r1, r1
c0d010c6:	2264      	movs	r2, #100	; 0x64
c0d010c8:	434a      	muls	r2, r1
c0d010ca:	1815      	adds	r5, r2, r0
}
c0d010cc:	4628      	mov	r0, r5
c0d010ce:	b001      	add	sp, #4
c0d010d0:	bdf0      	pop	{r4, r5, r6, r7, pc}
	...

c0d010d4 <io_seproxyhal_setup_ticker>:

void io_seproxyhal_setup_ticker(unsigned int interval_ms) {
c0d010d4:	b580      	push	{r7, lr}
c0d010d6:	af00      	add	r7, sp, #0
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SET_TICKER_INTERVAL;
c0d010d8:	4a07      	ldr	r2, [pc, #28]	; (c0d010f8 <io_seproxyhal_setup_ticker+0x24>)
c0d010da:	214e      	movs	r1, #78	; 0x4e
c0d010dc:	7011      	strb	r1, [r2, #0]
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d010de:	2100      	movs	r1, #0
c0d010e0:	7051      	strb	r1, [r2, #1]
  G_io_seproxyhal_spi_buffer[2] = 2;
c0d010e2:	2102      	movs	r1, #2
c0d010e4:	7091      	strb	r1, [r2, #2]
  G_io_seproxyhal_spi_buffer[3] = (interval_ms>>8)&0xff;
c0d010e6:	0a01      	lsrs	r1, r0, #8
c0d010e8:	70d1      	strb	r1, [r2, #3]
  G_io_seproxyhal_spi_buffer[4] = (interval_ms)&0xff;
c0d010ea:	7110      	strb	r0, [r2, #4]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 5);
c0d010ec:	2105      	movs	r1, #5
c0d010ee:	4610      	mov	r0, r2
c0d010f0:	f000 fa18 	bl	c0d01524 <io_seproxyhal_spi_send>
}
c0d010f4:	bd80      	pop	{r7, pc}
c0d010f6:	46c0      	nop			; (mov r8, r8)
c0d010f8:	20001800 	.word	0x20001800

c0d010fc <io_seproxyhal_button_push>:
  G_io_seproxyhal_spi_buffer[3] = (backlight_percentage?0x80:0)|(flags & 0x7F); // power on
  G_io_seproxyhal_spi_buffer[4] = backlight_percentage;
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 5);
}

void io_seproxyhal_button_push(button_push_callback_t button_callback, unsigned int new_button_mask) {
c0d010fc:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d010fe:	af03      	add	r7, sp, #12
c0d01100:	b081      	sub	sp, #4
c0d01102:	4604      	mov	r4, r0
  if (button_callback) {
c0d01104:	2c00      	cmp	r4, #0
c0d01106:	d02e      	beq.n	c0d01166 <io_seproxyhal_button_push+0x6a>
    unsigned int button_mask;
    unsigned int button_same_mask_counter;
    // enable speeded up long push
    if (new_button_mask == G_button_mask) {
c0d01108:	4818      	ldr	r0, [pc, #96]	; (c0d0116c <io_seproxyhal_button_push+0x70>)
c0d0110a:	6802      	ldr	r2, [r0, #0]
c0d0110c:	428a      	cmp	r2, r1
c0d0110e:	d103      	bne.n	c0d01118 <io_seproxyhal_button_push+0x1c>
      // each 100ms ~
      G_button_same_mask_counter++;
c0d01110:	4a17      	ldr	r2, [pc, #92]	; (c0d01170 <io_seproxyhal_button_push+0x74>)
c0d01112:	6813      	ldr	r3, [r2, #0]
c0d01114:	1c5b      	adds	r3, r3, #1
c0d01116:	6013      	str	r3, [r2, #0]
    }

    // append the button mask
    button_mask = G_button_mask | new_button_mask;
c0d01118:	6806      	ldr	r6, [r0, #0]
c0d0111a:	430e      	orrs	r6, r1

    // pre reset variable due to os_sched_exit
    button_same_mask_counter = G_button_same_mask_counter;
c0d0111c:	4a14      	ldr	r2, [pc, #80]	; (c0d01170 <io_seproxyhal_button_push+0x74>)
c0d0111e:	6815      	ldr	r5, [r2, #0]

    // reset button mask
    if (new_button_mask == 0) {
c0d01120:	2900      	cmp	r1, #0
c0d01122:	d001      	beq.n	c0d01128 <io_seproxyhal_button_push+0x2c>

      // notify button released event
      button_mask |= BUTTON_EVT_RELEASED;
    }
    else {
      G_button_mask = button_mask;
c0d01124:	6006      	str	r6, [r0, #0]
c0d01126:	e005      	b.n	c0d01134 <io_seproxyhal_button_push+0x38>
c0d01128:	2300      	movs	r3, #0
    button_same_mask_counter = G_button_same_mask_counter;

    // reset button mask
    if (new_button_mask == 0) {
      // reset next state when button are released
      G_button_mask = 0;
c0d0112a:	6003      	str	r3, [r0, #0]
      G_button_same_mask_counter=0;
c0d0112c:	6013      	str	r3, [r2, #0]

      // notify button released event
      button_mask |= BUTTON_EVT_RELEASED;
c0d0112e:	2301      	movs	r3, #1
c0d01130:	07db      	lsls	r3, r3, #31
c0d01132:	431e      	orrs	r6, r3
    else {
      G_button_mask = button_mask;
    }

    // reset counter when button mask changes
    if (new_button_mask != G_button_mask) {
c0d01134:	6800      	ldr	r0, [r0, #0]
c0d01136:	4288      	cmp	r0, r1
c0d01138:	d001      	beq.n	c0d0113e <io_seproxyhal_button_push+0x42>
      G_button_same_mask_counter=0;
c0d0113a:	2000      	movs	r0, #0
c0d0113c:	6010      	str	r0, [r2, #0]
    }

    if (button_same_mask_counter >= BUTTON_FAST_THRESHOLD_CS) {
c0d0113e:	2d08      	cmp	r5, #8
c0d01140:	d30e      	bcc.n	c0d01160 <io_seproxyhal_button_push+0x64>
      // fast bit when pressing and timing is right
      if ((button_same_mask_counter%BUTTON_FAST_ACTION_CS) == 0) {
c0d01142:	2103      	movs	r1, #3
c0d01144:	4628      	mov	r0, r5
c0d01146:	f001 f95d 	bl	c0d02404 <__aeabi_uidivmod>
        button_mask |= BUTTON_EVT_FAST;
c0d0114a:	2001      	movs	r0, #1
c0d0114c:	0780      	lsls	r0, r0, #30
c0d0114e:	4330      	orrs	r0, r6
      G_button_same_mask_counter=0;
    }

    if (button_same_mask_counter >= BUTTON_FAST_THRESHOLD_CS) {
      // fast bit when pressing and timing is right
      if ((button_same_mask_counter%BUTTON_FAST_ACTION_CS) == 0) {
c0d01150:	2900      	cmp	r1, #0
c0d01152:	4601      	mov	r1, r0
c0d01154:	d000      	beq.n	c0d01158 <io_seproxyhal_button_push+0x5c>
c0d01156:	4631      	mov	r1, r6
        button_mask |= BUTTON_EVT_FAST;
      }
      // fast bit when releasing and threshold has been exceeded
      if ((button_mask & BUTTON_EVT_RELEASED)) {
c0d01158:	2900      	cmp	r1, #0
c0d0115a:	db02      	blt.n	c0d01162 <io_seproxyhal_button_push+0x66>
c0d0115c:	4608      	mov	r0, r1
c0d0115e:	e000      	b.n	c0d01162 <io_seproxyhal_button_push+0x66>
c0d01160:	4630      	mov	r0, r6
        button_mask |= BUTTON_EVT_FAST;
      }
    }

    // indicate if button have been released
    button_callback(button_mask, button_same_mask_counter);
c0d01162:	4629      	mov	r1, r5
c0d01164:	47a0      	blx	r4
  }
}
c0d01166:	b001      	add	sp, #4
c0d01168:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0116a:	46c0      	nop			; (mov r8, r8)
c0d0116c:	20001b14 	.word	0x20001b14
c0d01170:	20001b18 	.word	0x20001b18

c0d01174 <io_exchange>:

#endif // HAVE_BAGL

unsigned short io_exchange(unsigned char channel, unsigned short tx_len) {
c0d01174:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01176:	af03      	add	r7, sp, #12
c0d01178:	b081      	sub	sp, #4
c0d0117a:	4604      	mov	r4, r0
    }
  }
  after_debug:
#endif // DEBUG_APDU

  switch(channel&~(IO_FLAGS)) {
c0d0117c:	200f      	movs	r0, #15
c0d0117e:	4204      	tst	r4, r0
c0d01180:	d006      	beq.n	c0d01190 <io_exchange+0x1c>
      }
    }
    break;

  default:
    return io_exchange_al(channel, tx_len);
c0d01182:	4620      	mov	r0, r4
c0d01184:	f7fe ff88 	bl	c0d00098 <io_exchange_al>
c0d01188:	4605      	mov	r5, r0
  }
}
c0d0118a:	b2a8      	uxth	r0, r5
c0d0118c:	b001      	add	sp, #4
c0d0118e:	bdf0      	pop	{r4, r5, r6, r7, pc}

  switch(channel&~(IO_FLAGS)) {
  case CHANNEL_APDU:
    // TODO work up the spi state machine over the HAL proxy until an APDU is available

    if (tx_len && !(channel&IO_ASYNCH_REPLY)) {
c0d01190:	2610      	movs	r6, #16
c0d01192:	4026      	ands	r6, r4
c0d01194:	2900      	cmp	r1, #0
c0d01196:	d02a      	beq.n	c0d011ee <io_exchange+0x7a>
c0d01198:	2e00      	cmp	r6, #0
c0d0119a:	d128      	bne.n	c0d011ee <io_exchange+0x7a>

      // until the whole RAPDU is transmitted, send chunks using the current mode for communication
      for (;;) {
        switch(G_io_apdu_state) {
c0d0119c:	483d      	ldr	r0, [pc, #244]	; (c0d01294 <io_exchange+0x120>)
c0d0119e:	7800      	ldrb	r0, [r0, #0]
c0d011a0:	2807      	cmp	r0, #7
c0d011a2:	d00b      	beq.n	c0d011bc <io_exchange+0x48>
c0d011a4:	2800      	cmp	r0, #0
c0d011a6:	d004      	beq.n	c0d011b2 <io_exchange+0x3e>
          default: 
            // delegate to the hal in case of not generic transport mode (or asynch)
            if (io_exchange_al(channel, tx_len) == 0) {
c0d011a8:	4620      	mov	r0, r4
c0d011aa:	f7fe ff75 	bl	c0d00098 <io_exchange_al>
c0d011ae:	2800      	cmp	r0, #0
c0d011b0:	d00a      	beq.n	c0d011c8 <io_exchange+0x54>
              goto break_send;
            }
          case APDU_IDLE:
            LOG("invalid state for APDU reply\n");
            THROW(INVALID_STATE);
c0d011b2:	4839      	ldr	r0, [pc, #228]	; (c0d01298 <io_exchange+0x124>)
c0d011b4:	6800      	ldr	r0, [r0, #0]
c0d011b6:	2109      	movs	r1, #9
c0d011b8:	f001 f98a 	bl	c0d024d0 <longjmp>
            break;

#ifdef HAVE_USB_APDU
          case APDU_USB_HID:
            // only send, don't perform synchronous reception of the next command (will be done later by the seproxyhal packet processing)
            io_usb_hid_exchange(io_usb_send_apdu_data, tx_len, NULL, IO_RETURN_AFTER_TX);
c0d011bc:	483d      	ldr	r0, [pc, #244]	; (c0d012b4 <io_exchange+0x140>)
c0d011be:	4478      	add	r0, pc
c0d011c0:	2200      	movs	r2, #0
c0d011c2:	2320      	movs	r3, #32
c0d011c4:	f7ff fc26 	bl	c0d00a14 <io_usb_hid_exchange>
c0d011c8:	2500      	movs	r5, #0
        }
        continue;

      break_send:
        // reset apdu state
        G_io_apdu_state = APDU_IDLE;
c0d011ca:	4832      	ldr	r0, [pc, #200]	; (c0d01294 <io_exchange+0x120>)
c0d011cc:	7005      	strb	r5, [r0, #0]
        G_io_apdu_offset = 0;
c0d011ce:	4833      	ldr	r0, [pc, #204]	; (c0d0129c <io_exchange+0x128>)
c0d011d0:	8005      	strh	r5, [r0, #0]
        G_io_apdu_length = 0;
c0d011d2:	4833      	ldr	r0, [pc, #204]	; (c0d012a0 <io_exchange+0x12c>)
c0d011d4:	8005      	strh	r5, [r0, #0]
        G_io_apdu_seq = 0;
c0d011d6:	4833      	ldr	r0, [pc, #204]	; (c0d012a4 <io_exchange+0x130>)
c0d011d8:	8005      	strh	r5, [r0, #0]
        G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d011da:	4833      	ldr	r0, [pc, #204]	; (c0d012a8 <io_exchange+0x134>)
c0d011dc:	7005      	strb	r5, [r0, #0]

        // continue sending commands, don't issue status yet
        if (channel & IO_RETURN_AFTER_TX) {
c0d011de:	06a0      	lsls	r0, r4, #26
c0d011e0:	d4d3      	bmi.n	c0d0118a <io_exchange+0x16>
          return 0;
        }
        // acknowledge the write request (general status OK) and no more command to follow (wait until another APDU container is received to continue unwrapping)
        io_seproxyhal_general_status();
c0d011e2:	f7ff fc8f 	bl	c0d00b04 <io_seproxyhal_general_status>
        break;
      }

      // perform reset after io exchange
      if (channel & IO_RESET_AFTER_REPLIED) {
c0d011e6:	0620      	lsls	r0, r4, #24
c0d011e8:	d501      	bpl.n	c0d011ee <io_exchange+0x7a>
        reset();
c0d011ea:	f000 f8cd 	bl	c0d01388 <reset>
      }
    }

    if (!(channel&IO_ASYNCH_REPLY)) {
c0d011ee:	2e00      	cmp	r6, #0
c0d011f0:	d10c      	bne.n	c0d0120c <io_exchange+0x98>
      
      // already received the data of the apdu when received the whole apdu
      if ((channel & (CHANNEL_APDU|IO_RECEIVE_DATA)) == (CHANNEL_APDU|IO_RECEIVE_DATA)) {
c0d011f2:	0660      	lsls	r0, r4, #25
c0d011f4:	d448      	bmi.n	c0d01288 <io_exchange+0x114>
        // return apdu data - header
        return G_io_apdu_length-5;
      }

      // reply has ended, proceed to next apdu reception (reset status only after asynch reply)
      G_io_apdu_state = APDU_IDLE;
c0d011f6:	4827      	ldr	r0, [pc, #156]	; (c0d01294 <io_exchange+0x120>)
c0d011f8:	2100      	movs	r1, #0
c0d011fa:	7001      	strb	r1, [r0, #0]
      G_io_apdu_offset = 0;
c0d011fc:	4827      	ldr	r0, [pc, #156]	; (c0d0129c <io_exchange+0x128>)
c0d011fe:	8001      	strh	r1, [r0, #0]
      G_io_apdu_length = 0;
c0d01200:	4827      	ldr	r0, [pc, #156]	; (c0d012a0 <io_exchange+0x12c>)
c0d01202:	8001      	strh	r1, [r0, #0]
      G_io_apdu_seq = 0;
c0d01204:	4827      	ldr	r0, [pc, #156]	; (c0d012a4 <io_exchange+0x130>)
c0d01206:	8001      	strh	r1, [r0, #0]
      G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d01208:	4827      	ldr	r0, [pc, #156]	; (c0d012a8 <io_exchange+0x134>)
c0d0120a:	7001      	strb	r1, [r0, #0]
c0d0120c:	4c28      	ldr	r4, [pc, #160]	; (c0d012b0 <io_exchange+0x13c>)
c0d0120e:	4e24      	ldr	r6, [pc, #144]	; (c0d012a0 <io_exchange+0x12c>)
c0d01210:	e008      	b.n	c0d01224 <io_exchange+0xb0>
        case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
          if (rx_len < 3+3) {
            // error !
            return 0;
          }
          io_seproxyhal_handle_usb_ep_xfer_event();
c0d01212:	f7ff fccb 	bl	c0d00bac <io_seproxyhal_handle_usb_ep_xfer_event>

          // an apdu has been received, ack with mode commands (the reply at least)
          if (G_io_apdu_length > 0) {
c0d01216:	8830      	ldrh	r0, [r6, #0]
c0d01218:	2800      	cmp	r0, #0
c0d0121a:	d003      	beq.n	c0d01224 <io_exchange+0xb0>
c0d0121c:	e032      	b.n	c0d01284 <io_exchange+0x110>
          break;
#endif // HAVE_IO_USB

        default:
          // tell the application that a non-apdu packet has been received
          io_event(CHANNEL_SPI);
c0d0121e:	2002      	movs	r0, #2
c0d01220:	f7fe ff68 	bl	c0d000f4 <io_event>

    // ensure ready to receive an event (after an apdu processing with asynch flag, it may occur if the channel is not correctly managed)

    // until a new whole CAPDU is received
    for (;;) {
      if (!io_seproxyhal_spi_is_status_sent()) {
c0d01224:	f000 f99c 	bl	c0d01560 <io_seproxyhal_spi_is_status_sent>
c0d01228:	2800      	cmp	r0, #0
c0d0122a:	d101      	bne.n	c0d01230 <io_exchange+0xbc>
        io_seproxyhal_general_status();
c0d0122c:	f7ff fc6a 	bl	c0d00b04 <io_seproxyhal_general_status>
      }

      // wait until a SPI packet is available
      // NOTE: on ST31, dual wait ISO & RF (ISO instead of SPI)
      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d01230:	2180      	movs	r1, #128	; 0x80
c0d01232:	2500      	movs	r5, #0
c0d01234:	4620      	mov	r0, r4
c0d01236:	462a      	mov	r2, r5
c0d01238:	f000 f9ae 	bl	c0d01598 <io_seproxyhal_spi_recv>

      // can't process split TLV, continue
      if (rx_len-3 != U2(G_io_seproxyhal_spi_buffer[1],G_io_seproxyhal_spi_buffer[2])) {
c0d0123c:	1ec1      	subs	r1, r0, #3
c0d0123e:	78a2      	ldrb	r2, [r4, #2]
c0d01240:	7863      	ldrb	r3, [r4, #1]
c0d01242:	021b      	lsls	r3, r3, #8
c0d01244:	4313      	orrs	r3, r2
c0d01246:	4299      	cmp	r1, r3
c0d01248:	d110      	bne.n	c0d0126c <io_exchange+0xf8>
      send_last_command:
        continue;
      }

      // if an apdu is already ongoing, then discard packet as a new packet
      if (G_io_apdu_media != IO_APDU_MEDIA_NONE) {
c0d0124a:	4917      	ldr	r1, [pc, #92]	; (c0d012a8 <io_exchange+0x134>)
c0d0124c:	7809      	ldrb	r1, [r1, #0]
c0d0124e:	2900      	cmp	r1, #0
c0d01250:	d002      	beq.n	c0d01258 <io_exchange+0xe4>
        io_seproxyhal_handle_event();
c0d01252:	f7ff fd2f 	bl	c0d00cb4 <io_seproxyhal_handle_event>
c0d01256:	e7e5      	b.n	c0d01224 <io_exchange+0xb0>
        continue;
      }

      // depending on received TAG
      switch(G_io_seproxyhal_spi_buffer[0]) {
c0d01258:	7821      	ldrb	r1, [r4, #0]
c0d0125a:	2910      	cmp	r1, #16
c0d0125c:	d00f      	beq.n	c0d0127e <io_exchange+0x10a>
c0d0125e:	290f      	cmp	r1, #15
c0d01260:	d1dd      	bne.n	c0d0121e <io_exchange+0xaa>
          goto send_last_command;
#endif // HAVE_BLE

#ifdef HAVE_IO_USB
        case SEPROXYHAL_TAG_USB_EVENT:
          if (rx_len != 3+1) {
c0d01262:	2804      	cmp	r0, #4
c0d01264:	d102      	bne.n	c0d0126c <io_exchange+0xf8>
            // invalid length, not processable
            goto invalid_apdu_packet;
          }
          io_seproxyhal_handle_usb_event();
c0d01266:	f7ff fc63 	bl	c0d00b30 <io_seproxyhal_handle_usb_event>
c0d0126a:	e7db      	b.n	c0d01224 <io_exchange+0xb0>
c0d0126c:	2000      	movs	r0, #0

      // can't process split TLV, continue
      if (rx_len-3 != U2(G_io_seproxyhal_spi_buffer[1],G_io_seproxyhal_spi_buffer[2])) {
        LOG("invalid TLV format\n");
      invalid_apdu_packet:
        G_io_apdu_state = APDU_IDLE;
c0d0126e:	4909      	ldr	r1, [pc, #36]	; (c0d01294 <io_exchange+0x120>)
c0d01270:	7008      	strb	r0, [r1, #0]
        G_io_apdu_offset = 0;
c0d01272:	490a      	ldr	r1, [pc, #40]	; (c0d0129c <io_exchange+0x128>)
c0d01274:	8008      	strh	r0, [r1, #0]
        G_io_apdu_length = 0;
c0d01276:	8030      	strh	r0, [r6, #0]
        G_io_apdu_seq = 0;
c0d01278:	490a      	ldr	r1, [pc, #40]	; (c0d012a4 <io_exchange+0x130>)
c0d0127a:	8008      	strh	r0, [r1, #0]
c0d0127c:	e7d2      	b.n	c0d01224 <io_exchange+0xb0>

          // no state change, we're not dealing with an apdu yet
          goto send_last_command;

        case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
          if (rx_len < 3+3) {
c0d0127e:	2806      	cmp	r0, #6
c0d01280:	d2c7      	bcs.n	c0d01212 <io_exchange+0x9e>
c0d01282:	e782      	b.n	c0d0118a <io_exchange+0x16>
          io_seproxyhal_handle_usb_ep_xfer_event();

          // an apdu has been received, ack with mode commands (the reply at least)
          if (G_io_apdu_length > 0) {
            // invalid return when reentered and an apdu is already under processing
            return G_io_apdu_length;
c0d01284:	8835      	ldrh	r5, [r6, #0]
c0d01286:	e780      	b.n	c0d0118a <io_exchange+0x16>
    if (!(channel&IO_ASYNCH_REPLY)) {
      
      // already received the data of the apdu when received the whole apdu
      if ((channel & (CHANNEL_APDU|IO_RECEIVE_DATA)) == (CHANNEL_APDU|IO_RECEIVE_DATA)) {
        // return apdu data - header
        return G_io_apdu_length-5;
c0d01288:	4805      	ldr	r0, [pc, #20]	; (c0d012a0 <io_exchange+0x12c>)
c0d0128a:	8800      	ldrh	r0, [r0, #0]
c0d0128c:	4907      	ldr	r1, [pc, #28]	; (c0d012ac <io_exchange+0x138>)
c0d0128e:	1845      	adds	r5, r0, r1
c0d01290:	e77b      	b.n	c0d0118a <io_exchange+0x16>
c0d01292:	46c0      	nop			; (mov r8, r8)
c0d01294:	20001b08 	.word	0x20001b08
c0d01298:	200019a8 	.word	0x200019a8
c0d0129c:	20001b0a 	.word	0x20001b0a
c0d012a0:	20001b0c 	.word	0x20001b0c
c0d012a4:	20001b0e 	.word	0x20001b0e
c0d012a8:	20001b00 	.word	0x20001b00
c0d012ac:	0000fffb 	.word	0x0000fffb
c0d012b0:	20001800 	.word	0x20001800
c0d012b4:	fffffb33 	.word	0xfffffb33

c0d012b8 <os_ux_blocking>:
  default:
    return io_exchange_al(channel, tx_len);
  }
}

unsigned int os_ux_blocking(bolos_ux_params_t* params) {
c0d012b8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d012ba:	af03      	add	r7, sp, #12
c0d012bc:	b081      	sub	sp, #4
c0d012be:	4604      	mov	r4, r0
c0d012c0:	4d14      	ldr	r5, [pc, #80]	; (c0d01314 <os_ux_blocking+0x5c>)
c0d012c2:	e01a      	b.n	c0d012fa <os_ux_blocking+0x42>


    // process events
    for (;;) {
      // send general status before receiving next event
      if (!io_seproxyhal_spi_is_status_sent()) {
c0d012c4:	f000 f94c 	bl	c0d01560 <io_seproxyhal_spi_is_status_sent>
c0d012c8:	2800      	cmp	r0, #0
c0d012ca:	d101      	bne.n	c0d012d0 <os_ux_blocking+0x18>
        io_seproxyhal_general_status();
c0d012cc:	f7ff fc1a 	bl	c0d00b04 <io_seproxyhal_general_status>
      }

      /*unsigned int rx_len = */io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d012d0:	2180      	movs	r1, #128	; 0x80
c0d012d2:	2600      	movs	r6, #0
c0d012d4:	4628      	mov	r0, r5
c0d012d6:	4632      	mov	r2, r6
c0d012d8:	f000 f95e 	bl	c0d01598 <io_seproxyhal_spi_recv>

      switch (G_io_seproxyhal_spi_buffer[0]) {
c0d012dc:	7828      	ldrb	r0, [r5, #0]
c0d012de:	2815      	cmp	r0, #21
c0d012e0:	d804      	bhi.n	c0d012ec <os_ux_blocking+0x34>
c0d012e2:	2101      	movs	r1, #1
c0d012e4:	4081      	lsls	r1, r0
c0d012e6:	480c      	ldr	r0, [pc, #48]	; (c0d01318 <os_ux_blocking+0x60>)
c0d012e8:	4201      	tst	r1, r0
c0d012ea:	d103      	bne.n	c0d012f4 <os_ux_blocking+0x3c>
          // perform UX event on these ones, don't process as an IO event
          break;

        default:
          // if malformed, then a stall is likely to occur
          if (io_seproxyhal_handle_event()) {
c0d012ec:	f7ff fce2 	bl	c0d00cb4 <io_seproxyhal_handle_event>
c0d012f0:	2800      	cmp	r0, #0
c0d012f2:	d1e7      	bne.n	c0d012c4 <os_ux_blocking+0xc>

      // pass the packet to the ux
      break;
    }
    // prepare processing of the packet by the ux
    params->ux_id = BOLOS_UX_EVENT;
c0d012f4:	2001      	movs	r0, #1
c0d012f6:	7020      	strb	r0, [r4, #0]
    params->len = 0;
c0d012f8:	6066      	str	r6, [r4, #4]
    ret = os_ux(params);
c0d012fa:	4620      	mov	r0, r4
c0d012fc:	f000 f8f4 	bl	c0d014e8 <os_ux>

unsigned int os_ux_blocking(bolos_ux_params_t* params) {
  unsigned int ret;
  // until a real status is returned
  ret = os_ux(params);
  while(ret == BOLOS_UX_IGNORE 
c0d01300:	2800      	cmp	r0, #0
c0d01302:	d0df      	beq.n	c0d012c4 <os_ux_blocking+0xc>
c0d01304:	4902      	ldr	r1, [pc, #8]	; (c0d01310 <os_ux_blocking+0x58>)
c0d01306:	4288      	cmp	r0, r1
c0d01308:	d0dc      	beq.n	c0d012c4 <os_ux_blocking+0xc>
    params->ux_id = BOLOS_UX_EVENT;
    params->len = 0;
    ret = os_ux(params);
  }

  return ret;
c0d0130a:	b001      	add	sp, #4
c0d0130c:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0130e:	46c0      	nop			; (mov r8, r8)
c0d01310:	b0105044 	.word	0xb0105044
c0d01314:	20001800 	.word	0x20001800
c0d01318:	00207020 	.word	0x00207020

c0d0131c <pic>:

// only apply PIC conversion if link_address is in linked code (over 0xC0D00000 in our example)
// this way, PIC call are armless if the address is not meant to be converted
extern unsigned int _nvram;
extern unsigned int _envram;
unsigned int pic(unsigned int link_address) {
c0d0131c:	b580      	push	{r7, lr}
c0d0131e:	af00      	add	r7, sp, #0
//  screen_printf(" %08X", link_address);
	if (link_address >= ((unsigned int)&_nvram) && link_address < ((unsigned int)&_envram)) {
c0d01320:	4904      	ldr	r1, [pc, #16]	; (c0d01334 <pic+0x18>)
c0d01322:	4288      	cmp	r0, r1
c0d01324:	d304      	bcc.n	c0d01330 <pic+0x14>
c0d01326:	4904      	ldr	r1, [pc, #16]	; (c0d01338 <pic+0x1c>)
c0d01328:	4288      	cmp	r0, r1
c0d0132a:	d201      	bcs.n	c0d01330 <pic+0x14>
		link_address = pic_internal(link_address);
c0d0132c:	f000 f806 	bl	c0d0133c <pic_internal>
//    screen_printf(" -> %08X\n", link_address);
  }
	return link_address;
c0d01330:	bd80      	pop	{r7, pc}
c0d01332:	46c0      	nop			; (mov r8, r8)
c0d01334:	c0d00000 	.word	0xc0d00000
c0d01338:	c0d02780 	.word	0xc0d02780

c0d0133c <pic_internal>:

unsigned int pic_internal(unsigned int link_address) __attribute__((naked));
unsigned int pic_internal(unsigned int link_address) 
{
  // compute the delta offset between LinkMemAddr & ExecMemAddr
  __asm volatile ("mov r2, pc\n");          // r2 = 0x109004
c0d0133c:	467a      	mov	r2, pc
  __asm volatile ("ldr r1, =pic_internal\n");        // r1 = 0xC0D00001
c0d0133e:	4902      	ldr	r1, [pc, #8]	; (c0d01348 <pic_internal+0xc>)
  __asm volatile ("adds r1, r1, #3\n");     // r1 = 0xC0D00004
c0d01340:	1cc9      	adds	r1, r1, #3
  __asm volatile ("subs r1, r1, r2\n");     // r1 = 0xC0BF7000 (delta between load and exec address)
c0d01342:	1a89      	subs	r1, r1, r2

  // adjust value of the given parameter
  __asm volatile ("subs r0, r0, r1\n");     // r0 = 0xC0D0C244 => r0 = 0x115244
c0d01344:	1a40      	subs	r0, r0, r1
  __asm volatile ("bx lr\n");
c0d01346:	4770      	bx	lr
c0d01348:	c0d0133d 	.word	0xc0d0133d

c0d0134c <check_api_level>:
/* MACHINE GENERATED: DO NOT MODIFY */
#include "os.h"
#include "syscalls.h"

void check_api_level ( unsigned int apiLevel ) 
{
c0d0134c:	b580      	push	{r7, lr}
c0d0134e:	af00      	add	r7, sp, #0
c0d01350:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_check_api_level_ID_IN;
c0d01352:	490a      	ldr	r1, [pc, #40]	; (c0d0137c <check_api_level+0x30>)
c0d01354:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01356:	490a      	ldr	r1, [pc, #40]	; (c0d01380 <check_api_level+0x34>)
c0d01358:	680a      	ldr	r2, [r1, #0]
c0d0135a:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)apiLevel;
c0d0135c:	9003      	str	r0, [sp, #12]
c0d0135e:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01360:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01362:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01364:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_check_api_level_ID_OUT)
c0d01366:	4807      	ldr	r0, [pc, #28]	; (c0d01384 <check_api_level+0x38>)
c0d01368:	9a01      	ldr	r2, [sp, #4]
c0d0136a:	4282      	cmp	r2, r0
c0d0136c:	d101      	bne.n	c0d01372 <check_api_level+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d0136e:	b004      	add	sp, #16
c0d01370:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_check_api_level_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01372:	6808      	ldr	r0, [r1, #0]
c0d01374:	2104      	movs	r1, #4
c0d01376:	f001 f8ab 	bl	c0d024d0 <longjmp>
c0d0137a:	46c0      	nop			; (mov r8, r8)
c0d0137c:	60000137 	.word	0x60000137
c0d01380:	200019a8 	.word	0x200019a8
c0d01384:	900001c6 	.word	0x900001c6

c0d01388 <reset>:
  }
}

void reset ( void ) 
{
c0d01388:	b580      	push	{r7, lr}
c0d0138a:	af00      	add	r7, sp, #0
c0d0138c:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_reset_ID_IN;
c0d0138e:	4809      	ldr	r0, [pc, #36]	; (c0d013b4 <reset+0x2c>)
c0d01390:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01392:	4809      	ldr	r0, [pc, #36]	; (c0d013b8 <reset+0x30>)
c0d01394:	6801      	ldr	r1, [r0, #0]
c0d01396:	9101      	str	r1, [sp, #4]
c0d01398:	4669      	mov	r1, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0139a:	4608      	mov	r0, r1
                              asm volatile("svc #1");
c0d0139c:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d0139e:	4601      	mov	r1, r0
                                if (parameters[0] != SYSCALL_reset_ID_OUT)
c0d013a0:	4906      	ldr	r1, [pc, #24]	; (c0d013bc <reset+0x34>)
c0d013a2:	9a00      	ldr	r2, [sp, #0]
c0d013a4:	428a      	cmp	r2, r1
c0d013a6:	d101      	bne.n	c0d013ac <reset+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d013a8:	b002      	add	sp, #8
c0d013aa:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_reset_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d013ac:	6800      	ldr	r0, [r0, #0]
c0d013ae:	2104      	movs	r1, #4
c0d013b0:	f001 f88e 	bl	c0d024d0 <longjmp>
c0d013b4:	60000200 	.word	0x60000200
c0d013b8:	200019a8 	.word	0x200019a8
c0d013bc:	900002f1 	.word	0x900002f1

c0d013c0 <cx_rng>:
  }
  return (unsigned char)ret;
}

unsigned char * cx_rng ( unsigned char * buffer, unsigned int len ) 
{
c0d013c0:	b580      	push	{r7, lr}
c0d013c2:	af00      	add	r7, sp, #0
c0d013c4:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_cx_rng_ID_IN;
c0d013c6:	4a0a      	ldr	r2, [pc, #40]	; (c0d013f0 <cx_rng+0x30>)
c0d013c8:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d013ca:	4a0a      	ldr	r2, [pc, #40]	; (c0d013f4 <cx_rng+0x34>)
c0d013cc:	6813      	ldr	r3, [r2, #0]
c0d013ce:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)buffer;
c0d013d0:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)len;
c0d013d2:	9103      	str	r1, [sp, #12]
c0d013d4:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d013d6:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d013d8:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d013da:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_rng_ID_OUT)
c0d013dc:	4906      	ldr	r1, [pc, #24]	; (c0d013f8 <cx_rng+0x38>)
c0d013de:	9b00      	ldr	r3, [sp, #0]
c0d013e0:	428b      	cmp	r3, r1
c0d013e2:	d101      	bne.n	c0d013e8 <cx_rng+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned char *)ret;
c0d013e4:	b004      	add	sp, #16
c0d013e6:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_rng_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d013e8:	6810      	ldr	r0, [r2, #0]
c0d013ea:	2104      	movs	r1, #4
c0d013ec:	f001 f870 	bl	c0d024d0 <longjmp>
c0d013f0:	6000052c 	.word	0x6000052c
c0d013f4:	200019a8 	.word	0x200019a8
c0d013f8:	90000567 	.word	0x90000567

c0d013fc <os_perso_derive_node_bip32>:
  }
  return (unsigned int)ret;
}

void os_perso_derive_node_bip32 ( cx_curve_t curve, unsigned int * path, unsigned int pathLength, unsigned char * privateKey, unsigned char * chain ) 
{
c0d013fc:	b5b0      	push	{r4, r5, r7, lr}
c0d013fe:	af02      	add	r7, sp, #8
c0d01400:	b088      	sub	sp, #32
  unsigned int ret;
  unsigned int parameters [2+5];
  parameters[0] = (unsigned int)SYSCALL_os_perso_derive_node_bip32_ID_IN;
c0d01402:	4c0b      	ldr	r4, [pc, #44]	; (c0d01430 <os_perso_derive_node_bip32+0x34>)
c0d01404:	9401      	str	r4, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01406:	4c0b      	ldr	r4, [pc, #44]	; (c0d01434 <os_perso_derive_node_bip32+0x38>)
c0d01408:	6825      	ldr	r5, [r4, #0]
c0d0140a:	9502      	str	r5, [sp, #8]
  parameters[2] = (unsigned int)curve;
c0d0140c:	ad03      	add	r5, sp, #12
c0d0140e:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d01410:	980c      	ldr	r0, [sp, #48]	; 0x30
  parameters[3] = (unsigned int)path;
  parameters[4] = (unsigned int)pathLength;
  parameters[5] = (unsigned int)privateKey;
  parameters[6] = (unsigned int)chain;
c0d01412:	9007      	str	r0, [sp, #28]
c0d01414:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01416:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01418:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d0141a:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_perso_derive_node_bip32_ID_OUT)
c0d0141c:	4806      	ldr	r0, [pc, #24]	; (c0d01438 <os_perso_derive_node_bip32+0x3c>)
c0d0141e:	9901      	ldr	r1, [sp, #4]
c0d01420:	4281      	cmp	r1, r0
c0d01422:	d101      	bne.n	c0d01428 <os_perso_derive_node_bip32+0x2c>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01424:	b008      	add	sp, #32
c0d01426:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_perso_derive_node_bip32_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01428:	6820      	ldr	r0, [r4, #0]
c0d0142a:	2104      	movs	r1, #4
c0d0142c:	f001 f850 	bl	c0d024d0 <longjmp>
c0d01430:	6000512b 	.word	0x6000512b
c0d01434:	200019a8 	.word	0x200019a8
c0d01438:	9000517f 	.word	0x9000517f

c0d0143c <os_global_pin_is_validated>:
  }
  return (unsigned int)ret;
}

unsigned int os_global_pin_is_validated ( void ) 
{
c0d0143c:	b580      	push	{r7, lr}
c0d0143e:	af00      	add	r7, sp, #0
c0d01440:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_os_global_pin_is_validated_ID_IN;
c0d01442:	4809      	ldr	r0, [pc, #36]	; (c0d01468 <os_global_pin_is_validated+0x2c>)
c0d01444:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01446:	4909      	ldr	r1, [pc, #36]	; (c0d0146c <os_global_pin_is_validated+0x30>)
c0d01448:	6808      	ldr	r0, [r1, #0]
c0d0144a:	9001      	str	r0, [sp, #4]
c0d0144c:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0144e:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01450:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01452:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_global_pin_is_validated_ID_OUT)
c0d01454:	4a06      	ldr	r2, [pc, #24]	; (c0d01470 <os_global_pin_is_validated+0x34>)
c0d01456:	9b00      	ldr	r3, [sp, #0]
c0d01458:	4293      	cmp	r3, r2
c0d0145a:	d101      	bne.n	c0d01460 <os_global_pin_is_validated+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d0145c:	b002      	add	sp, #8
c0d0145e:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_global_pin_is_validated_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01460:	6808      	ldr	r0, [r1, #0]
c0d01462:	2104      	movs	r1, #4
c0d01464:	f001 f834 	bl	c0d024d0 <longjmp>
c0d01468:	60005889 	.word	0x60005889
c0d0146c:	200019a8 	.word	0x200019a8
c0d01470:	90005845 	.word	0x90005845

c0d01474 <os_global_pin_invalidate>:
  }
  return (unsigned int)ret;
}

void os_global_pin_invalidate ( void ) 
{
c0d01474:	b580      	push	{r7, lr}
c0d01476:	af00      	add	r7, sp, #0
c0d01478:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_os_global_pin_invalidate_ID_IN;
c0d0147a:	4809      	ldr	r0, [pc, #36]	; (c0d014a0 <os_global_pin_invalidate+0x2c>)
c0d0147c:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0147e:	4809      	ldr	r0, [pc, #36]	; (c0d014a4 <os_global_pin_invalidate+0x30>)
c0d01480:	6801      	ldr	r1, [r0, #0]
c0d01482:	9101      	str	r1, [sp, #4]
c0d01484:	4669      	mov	r1, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01486:	4608      	mov	r0, r1
                              asm volatile("svc #1");
c0d01488:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d0148a:	4601      	mov	r1, r0
                                if (parameters[0] != SYSCALL_os_global_pin_invalidate_ID_OUT)
c0d0148c:	4906      	ldr	r1, [pc, #24]	; (c0d014a8 <os_global_pin_invalidate+0x34>)
c0d0148e:	9a00      	ldr	r2, [sp, #0]
c0d01490:	428a      	cmp	r2, r1
c0d01492:	d101      	bne.n	c0d01498 <os_global_pin_invalidate+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01494:	b002      	add	sp, #8
c0d01496:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_global_pin_invalidate_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01498:	6800      	ldr	r0, [r0, #0]
c0d0149a:	2104      	movs	r1, #4
c0d0149c:	f001 f818 	bl	c0d024d0 <longjmp>
c0d014a0:	60005ad0 	.word	0x60005ad0
c0d014a4:	200019a8 	.word	0x200019a8
c0d014a8:	90005afb 	.word	0x90005afb

c0d014ac <os_sched_exit>:
  }
  return (unsigned int)ret;
}

void os_sched_exit ( unsigned int exit_code ) 
{
c0d014ac:	b580      	push	{r7, lr}
c0d014ae:	af00      	add	r7, sp, #0
c0d014b0:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_os_sched_exit_ID_IN;
c0d014b2:	490a      	ldr	r1, [pc, #40]	; (c0d014dc <os_sched_exit+0x30>)
c0d014b4:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d014b6:	490a      	ldr	r1, [pc, #40]	; (c0d014e0 <os_sched_exit+0x34>)
c0d014b8:	680a      	ldr	r2, [r1, #0]
c0d014ba:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)exit_code;
c0d014bc:	9003      	str	r0, [sp, #12]
c0d014be:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d014c0:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d014c2:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d014c4:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_sched_exit_ID_OUT)
c0d014c6:	4807      	ldr	r0, [pc, #28]	; (c0d014e4 <os_sched_exit+0x38>)
c0d014c8:	9a01      	ldr	r2, [sp, #4]
c0d014ca:	4282      	cmp	r2, r0
c0d014cc:	d101      	bne.n	c0d014d2 <os_sched_exit+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d014ce:	b004      	add	sp, #16
c0d014d0:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_sched_exit_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d014d2:	6808      	ldr	r0, [r1, #0]
c0d014d4:	2104      	movs	r1, #4
c0d014d6:	f000 fffb 	bl	c0d024d0 <longjmp>
c0d014da:	46c0      	nop			; (mov r8, r8)
c0d014dc:	60005fe1 	.word	0x60005fe1
c0d014e0:	200019a8 	.word	0x200019a8
c0d014e4:	90005f6f 	.word	0x90005f6f

c0d014e8 <os_ux>:
    THROW(EXCEPTION_SECURITY);
  }
}

unsigned int os_ux ( bolos_ux_params_t * params ) 
{
c0d014e8:	b580      	push	{r7, lr}
c0d014ea:	af00      	add	r7, sp, #0
c0d014ec:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_os_ux_ID_IN;
c0d014ee:	490a      	ldr	r1, [pc, #40]	; (c0d01518 <os_ux+0x30>)
c0d014f0:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d014f2:	490a      	ldr	r1, [pc, #40]	; (c0d0151c <os_ux+0x34>)
c0d014f4:	680a      	ldr	r2, [r1, #0]
c0d014f6:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)params;
c0d014f8:	9003      	str	r0, [sp, #12]
c0d014fa:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d014fc:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d014fe:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01500:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_ux_ID_OUT)
c0d01502:	4a07      	ldr	r2, [pc, #28]	; (c0d01520 <os_ux+0x38>)
c0d01504:	9b01      	ldr	r3, [sp, #4]
c0d01506:	4293      	cmp	r3, r2
c0d01508:	d101      	bne.n	c0d0150e <os_ux+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d0150a:	b004      	add	sp, #16
c0d0150c:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_ux_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d0150e:	6808      	ldr	r0, [r1, #0]
c0d01510:	2104      	movs	r1, #4
c0d01512:	f000 ffdd 	bl	c0d024d0 <longjmp>
c0d01516:	46c0      	nop			; (mov r8, r8)
c0d01518:	60006158 	.word	0x60006158
c0d0151c:	200019a8 	.word	0x200019a8
c0d01520:	9000611f 	.word	0x9000611f

c0d01524 <io_seproxyhal_spi_send>:
  }
  return (unsigned int)ret;
}

void io_seproxyhal_spi_send ( const unsigned char * buffer, unsigned short length ) 
{
c0d01524:	b580      	push	{r7, lr}
c0d01526:	af00      	add	r7, sp, #0
c0d01528:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_send_ID_IN;
c0d0152a:	4a0a      	ldr	r2, [pc, #40]	; (c0d01554 <io_seproxyhal_spi_send+0x30>)
c0d0152c:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0152e:	4a0a      	ldr	r2, [pc, #40]	; (c0d01558 <io_seproxyhal_spi_send+0x34>)
c0d01530:	6813      	ldr	r3, [r2, #0]
c0d01532:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)buffer;
c0d01534:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)length;
c0d01536:	9103      	str	r1, [sp, #12]
c0d01538:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0153a:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d0153c:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d0153e:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_send_ID_OUT)
c0d01540:	4806      	ldr	r0, [pc, #24]	; (c0d0155c <io_seproxyhal_spi_send+0x38>)
c0d01542:	9900      	ldr	r1, [sp, #0]
c0d01544:	4281      	cmp	r1, r0
c0d01546:	d101      	bne.n	c0d0154c <io_seproxyhal_spi_send+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01548:	b004      	add	sp, #16
c0d0154a:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_send_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d0154c:	6810      	ldr	r0, [r2, #0]
c0d0154e:	2104      	movs	r1, #4
c0d01550:	f000 ffbe 	bl	c0d024d0 <longjmp>
c0d01554:	60006a1c 	.word	0x60006a1c
c0d01558:	200019a8 	.word	0x200019a8
c0d0155c:	90006af3 	.word	0x90006af3

c0d01560 <io_seproxyhal_spi_is_status_sent>:
  }
}

unsigned int io_seproxyhal_spi_is_status_sent ( void ) 
{
c0d01560:	b580      	push	{r7, lr}
c0d01562:	af00      	add	r7, sp, #0
c0d01564:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_is_status_sent_ID_IN;
c0d01566:	4809      	ldr	r0, [pc, #36]	; (c0d0158c <io_seproxyhal_spi_is_status_sent+0x2c>)
c0d01568:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0156a:	4909      	ldr	r1, [pc, #36]	; (c0d01590 <io_seproxyhal_spi_is_status_sent+0x30>)
c0d0156c:	6808      	ldr	r0, [r1, #0]
c0d0156e:	9001      	str	r0, [sp, #4]
c0d01570:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01572:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01574:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01576:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_is_status_sent_ID_OUT)
c0d01578:	4a06      	ldr	r2, [pc, #24]	; (c0d01594 <io_seproxyhal_spi_is_status_sent+0x34>)
c0d0157a:	9b00      	ldr	r3, [sp, #0]
c0d0157c:	4293      	cmp	r3, r2
c0d0157e:	d101      	bne.n	c0d01584 <io_seproxyhal_spi_is_status_sent+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d01580:	b002      	add	sp, #8
c0d01582:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_is_status_sent_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01584:	6808      	ldr	r0, [r1, #0]
c0d01586:	2104      	movs	r1, #4
c0d01588:	f000 ffa2 	bl	c0d024d0 <longjmp>
c0d0158c:	60006bcf 	.word	0x60006bcf
c0d01590:	200019a8 	.word	0x200019a8
c0d01594:	90006b7f 	.word	0x90006b7f

c0d01598 <io_seproxyhal_spi_recv>:
  }
  return (unsigned int)ret;
}

unsigned short io_seproxyhal_spi_recv ( unsigned char * buffer, unsigned short maxlength, unsigned int flags ) 
{
c0d01598:	b5d0      	push	{r4, r6, r7, lr}
c0d0159a:	af02      	add	r7, sp, #8
c0d0159c:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+3];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_recv_ID_IN;
c0d0159e:	4b0b      	ldr	r3, [pc, #44]	; (c0d015cc <io_seproxyhal_spi_recv+0x34>)
c0d015a0:	9301      	str	r3, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d015a2:	4b0b      	ldr	r3, [pc, #44]	; (c0d015d0 <io_seproxyhal_spi_recv+0x38>)
c0d015a4:	681c      	ldr	r4, [r3, #0]
c0d015a6:	9402      	str	r4, [sp, #8]
  parameters[2] = (unsigned int)buffer;
c0d015a8:	ac03      	add	r4, sp, #12
c0d015aa:	c407      	stmia	r4!, {r0, r1, r2}
c0d015ac:	a801      	add	r0, sp, #4
  parameters[3] = (unsigned int)maxlength;
  parameters[4] = (unsigned int)flags;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d015ae:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d015b0:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d015b2:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_recv_ID_OUT)
c0d015b4:	4907      	ldr	r1, [pc, #28]	; (c0d015d4 <io_seproxyhal_spi_recv+0x3c>)
c0d015b6:	9a01      	ldr	r2, [sp, #4]
c0d015b8:	428a      	cmp	r2, r1
c0d015ba:	d102      	bne.n	c0d015c2 <io_seproxyhal_spi_recv+0x2a>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned short)ret;
c0d015bc:	b280      	uxth	r0, r0
c0d015be:	b006      	add	sp, #24
c0d015c0:	bdd0      	pop	{r4, r6, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_recv_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d015c2:	6818      	ldr	r0, [r3, #0]
c0d015c4:	2104      	movs	r1, #4
c0d015c6:	f000 ff83 	bl	c0d024d0 <longjmp>
c0d015ca:	46c0      	nop			; (mov r8, r8)
c0d015cc:	60006cd1 	.word	0x60006cd1
c0d015d0:	200019a8 	.word	0x200019a8
c0d015d4:	90006c2b 	.word	0x90006c2b

c0d015d8 <USBD_LL_Init>:
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Init (USBD_HandleTypeDef *pdev)
{ 
  UNUSED(pdev);
  ep_in_stall = 0;
c0d015d8:	4902      	ldr	r1, [pc, #8]	; (c0d015e4 <USBD_LL_Init+0xc>)
c0d015da:	2000      	movs	r0, #0
c0d015dc:	6008      	str	r0, [r1, #0]
  ep_out_stall = 0;
c0d015de:	4902      	ldr	r1, [pc, #8]	; (c0d015e8 <USBD_LL_Init+0x10>)
c0d015e0:	6008      	str	r0, [r1, #0]
  return USBD_OK;
c0d015e2:	4770      	bx	lr
c0d015e4:	20001b1c 	.word	0x20001b1c
c0d015e8:	20001b20 	.word	0x20001b20

c0d015ec <USBD_LL_DeInit>:
  * @brief  De-Initializes the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_DeInit (USBD_HandleTypeDef *pdev)
{
c0d015ec:	b5d0      	push	{r4, r6, r7, lr}
c0d015ee:	af02      	add	r7, sp, #8
  UNUSED(pdev);
  // usb off
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d015f0:	4806      	ldr	r0, [pc, #24]	; (c0d0160c <USBD_LL_DeInit+0x20>)
c0d015f2:	214f      	movs	r1, #79	; 0x4f
c0d015f4:	7001      	strb	r1, [r0, #0]
c0d015f6:	2400      	movs	r4, #0
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d015f8:	7044      	strb	r4, [r0, #1]
c0d015fa:	2101      	movs	r1, #1
  G_io_seproxyhal_spi_buffer[2] = 1;
c0d015fc:	7081      	strb	r1, [r0, #2]
c0d015fe:	2102      	movs	r1, #2
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d01600:	70c1      	strb	r1, [r0, #3]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 4);
c0d01602:	2104      	movs	r1, #4
c0d01604:	f7ff ff8e 	bl	c0d01524 <io_seproxyhal_spi_send>

  return USBD_OK; 
c0d01608:	4620      	mov	r0, r4
c0d0160a:	bdd0      	pop	{r4, r6, r7, pc}
c0d0160c:	20001800 	.word	0x20001800

c0d01610 <USBD_LL_Start>:
  * @brief  Starts the Low Level portion of the Device driver. 
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Start(USBD_HandleTypeDef *pdev)
{
c0d01610:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01612:	af03      	add	r7, sp, #12
c0d01614:	b083      	sub	sp, #12
c0d01616:	ad01      	add	r5, sp, #4
  uint8_t buffer[5];
  UNUSED(pdev);

  // reset address
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d01618:	264f      	movs	r6, #79	; 0x4f
c0d0161a:	702e      	strb	r6, [r5, #0]
c0d0161c:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d0161e:	706c      	strb	r4, [r5, #1]
c0d01620:	2002      	movs	r0, #2
  buffer[2] = 2;
c0d01622:	70a8      	strb	r0, [r5, #2]
c0d01624:	2003      	movs	r0, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d01626:	70e8      	strb	r0, [r5, #3]
  buffer[4] = 0;
c0d01628:	712c      	strb	r4, [r5, #4]
  io_seproxyhal_spi_send(buffer, 5);
c0d0162a:	2105      	movs	r1, #5
c0d0162c:	4628      	mov	r0, r5
c0d0162e:	f7ff ff79 	bl	c0d01524 <io_seproxyhal_spi_send>
  
  // start usb operation
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d01632:	702e      	strb	r6, [r5, #0]
  buffer[1] = 0;
c0d01634:	706c      	strb	r4, [r5, #1]
c0d01636:	2001      	movs	r0, #1
  buffer[2] = 1;
c0d01638:	70a8      	strb	r0, [r5, #2]
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_CONNECT;
c0d0163a:	70e8      	strb	r0, [r5, #3]
c0d0163c:	2104      	movs	r1, #4
  io_seproxyhal_spi_send(buffer, 4);
c0d0163e:	4628      	mov	r0, r5
c0d01640:	f7ff ff70 	bl	c0d01524 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d01644:	4620      	mov	r0, r4
c0d01646:	b003      	add	sp, #12
c0d01648:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0164a <USBD_LL_Stop>:
  * @brief  Stops the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Stop (USBD_HandleTypeDef *pdev)
{
c0d0164a:	b5d0      	push	{r4, r6, r7, lr}
c0d0164c:	af02      	add	r7, sp, #8
c0d0164e:	b082      	sub	sp, #8
c0d01650:	a801      	add	r0, sp, #4
  UNUSED(pdev);
  uint8_t buffer[4];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d01652:	214f      	movs	r1, #79	; 0x4f
c0d01654:	7001      	strb	r1, [r0, #0]
c0d01656:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d01658:	7044      	strb	r4, [r0, #1]
c0d0165a:	2101      	movs	r1, #1
  buffer[2] = 1;
c0d0165c:	7081      	strb	r1, [r0, #2]
c0d0165e:	2102      	movs	r1, #2
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d01660:	70c1      	strb	r1, [r0, #3]
  io_seproxyhal_spi_send(buffer, 4);
c0d01662:	2104      	movs	r1, #4
c0d01664:	f7ff ff5e 	bl	c0d01524 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d01668:	4620      	mov	r0, r4
c0d0166a:	b002      	add	sp, #8
c0d0166c:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d01670 <USBD_LL_OpenEP>:
  */
USBD_StatusTypeDef  USBD_LL_OpenEP  (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  ep_type,
                                      uint16_t ep_mps)
{
c0d01670:	b5b0      	push	{r4, r5, r7, lr}
c0d01672:	af02      	add	r7, sp, #8
c0d01674:	b082      	sub	sp, #8
  uint8_t buffer[8];
  UNUSED(pdev);

  ep_in_stall = 0;
c0d01676:	480f      	ldr	r0, [pc, #60]	; (c0d016b4 <USBD_LL_OpenEP+0x44>)
c0d01678:	2400      	movs	r4, #0
c0d0167a:	6004      	str	r4, [r0, #0]
  ep_out_stall = 0;
c0d0167c:	480e      	ldr	r0, [pc, #56]	; (c0d016b8 <USBD_LL_OpenEP+0x48>)
c0d0167e:	6004      	str	r4, [r0, #0]
c0d01680:	4668      	mov	r0, sp

  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d01682:	254f      	movs	r5, #79	; 0x4f
c0d01684:	7005      	strb	r5, [r0, #0]
  buffer[1] = 0;
c0d01686:	7044      	strb	r4, [r0, #1]
c0d01688:	2505      	movs	r5, #5
  buffer[2] = 5;
c0d0168a:	7085      	strb	r5, [r0, #2]
c0d0168c:	2504      	movs	r5, #4
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d0168e:	70c5      	strb	r5, [r0, #3]
c0d01690:	2501      	movs	r5, #1
  buffer[4] = 1;
c0d01692:	7105      	strb	r5, [r0, #4]
  buffer[5] = ep_addr;
c0d01694:	7141      	strb	r1, [r0, #5]
  buffer[6] = 0;
  switch(ep_type) {
c0d01696:	2a03      	cmp	r2, #3
c0d01698:	d802      	bhi.n	c0d016a0 <USBD_LL_OpenEP+0x30>
c0d0169a:	00d0      	lsls	r0, r2, #3
c0d0169c:	4c07      	ldr	r4, [pc, #28]	; (c0d016bc <USBD_LL_OpenEP+0x4c>)
c0d0169e:	40c4      	lsrs	r4, r0
c0d016a0:	4668      	mov	r0, sp
  buffer[1] = 0;
  buffer[2] = 5;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
  buffer[4] = 1;
  buffer[5] = ep_addr;
  buffer[6] = 0;
c0d016a2:	7184      	strb	r4, [r0, #6]
      break;
    case USBD_EP_TYPE_INTR:
      buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_INTERRUPT;
      break;
  }
  buffer[7] = ep_mps;
c0d016a4:	71c3      	strb	r3, [r0, #7]
  io_seproxyhal_spi_send(buffer, 8);
c0d016a6:	2108      	movs	r1, #8
c0d016a8:	f7ff ff3c 	bl	c0d01524 <io_seproxyhal_spi_send>
c0d016ac:	2000      	movs	r0, #0
  return USBD_OK; 
c0d016ae:	b002      	add	sp, #8
c0d016b0:	bdb0      	pop	{r4, r5, r7, pc}
c0d016b2:	46c0      	nop			; (mov r8, r8)
c0d016b4:	20001b1c 	.word	0x20001b1c
c0d016b8:	20001b20 	.word	0x20001b20
c0d016bc:	02030401 	.word	0x02030401

c0d016c0 <USBD_LL_CloseEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_CloseEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d016c0:	b5d0      	push	{r4, r6, r7, lr}
c0d016c2:	af02      	add	r7, sp, #8
c0d016c4:	b082      	sub	sp, #8
c0d016c6:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[8];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d016c8:	224f      	movs	r2, #79	; 0x4f
c0d016ca:	7002      	strb	r2, [r0, #0]
c0d016cc:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d016ce:	7044      	strb	r4, [r0, #1]
c0d016d0:	2205      	movs	r2, #5
  buffer[2] = 5;
c0d016d2:	7082      	strb	r2, [r0, #2]
c0d016d4:	2204      	movs	r2, #4
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d016d6:	70c2      	strb	r2, [r0, #3]
c0d016d8:	2201      	movs	r2, #1
  buffer[4] = 1;
c0d016da:	7102      	strb	r2, [r0, #4]
  buffer[5] = ep_addr;
c0d016dc:	7141      	strb	r1, [r0, #5]
  buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_DISABLED;
c0d016de:	7184      	strb	r4, [r0, #6]
  buffer[7] = 0;
c0d016e0:	71c4      	strb	r4, [r0, #7]
  io_seproxyhal_spi_send(buffer, 8);
c0d016e2:	2108      	movs	r1, #8
c0d016e4:	f7ff ff1e 	bl	c0d01524 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d016e8:	4620      	mov	r0, r4
c0d016ea:	b002      	add	sp, #8
c0d016ec:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d016f0 <USBD_LL_StallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_StallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{ 
c0d016f0:	b5b0      	push	{r4, r5, r7, lr}
c0d016f2:	af02      	add	r7, sp, #8
c0d016f4:	b082      	sub	sp, #8
c0d016f6:	460d      	mov	r5, r1
c0d016f8:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d016fa:	2150      	movs	r1, #80	; 0x50
c0d016fc:	7001      	strb	r1, [r0, #0]
c0d016fe:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d01700:	7044      	strb	r4, [r0, #1]
c0d01702:	2103      	movs	r1, #3
  buffer[2] = 3;
c0d01704:	7081      	strb	r1, [r0, #2]
  buffer[3] = ep_addr;
c0d01706:	70c5      	strb	r5, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_STALL;
c0d01708:	2140      	movs	r1, #64	; 0x40
c0d0170a:	7101      	strb	r1, [r0, #4]
  buffer[5] = 0;
c0d0170c:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d0170e:	2106      	movs	r1, #6
c0d01710:	f7ff ff08 	bl	c0d01524 <io_seproxyhal_spi_send>
  if (ep_addr & 0x80) {
c0d01714:	2080      	movs	r0, #128	; 0x80
c0d01716:	4205      	tst	r5, r0
c0d01718:	d101      	bne.n	c0d0171e <USBD_LL_StallEP+0x2e>
c0d0171a:	4807      	ldr	r0, [pc, #28]	; (c0d01738 <USBD_LL_StallEP+0x48>)
c0d0171c:	e000      	b.n	c0d01720 <USBD_LL_StallEP+0x30>
c0d0171e:	4805      	ldr	r0, [pc, #20]	; (c0d01734 <USBD_LL_StallEP+0x44>)
c0d01720:	6801      	ldr	r1, [r0, #0]
c0d01722:	227f      	movs	r2, #127	; 0x7f
c0d01724:	4015      	ands	r5, r2
c0d01726:	2201      	movs	r2, #1
c0d01728:	40aa      	lsls	r2, r5
c0d0172a:	430a      	orrs	r2, r1
c0d0172c:	6002      	str	r2, [r0, #0]
    ep_in_stall |= (1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall |= (1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d0172e:	4620      	mov	r0, r4
c0d01730:	b002      	add	sp, #8
c0d01732:	bdb0      	pop	{r4, r5, r7, pc}
c0d01734:	20001b1c 	.word	0x20001b1c
c0d01738:	20001b20 	.word	0x20001b20

c0d0173c <USBD_LL_ClearStallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_ClearStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d0173c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0173e:	af03      	add	r7, sp, #12
c0d01740:	b083      	sub	sp, #12
c0d01742:	460d      	mov	r5, r1
c0d01744:	a801      	add	r0, sp, #4
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d01746:	2150      	movs	r1, #80	; 0x50
c0d01748:	7001      	strb	r1, [r0, #0]
c0d0174a:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d0174c:	7044      	strb	r4, [r0, #1]
c0d0174e:	2103      	movs	r1, #3
  buffer[2] = 3;
c0d01750:	7081      	strb	r1, [r0, #2]
  buffer[3] = ep_addr;
c0d01752:	70c5      	strb	r5, [r0, #3]
c0d01754:	2680      	movs	r6, #128	; 0x80
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_UNSTALL;
c0d01756:	7106      	strb	r6, [r0, #4]
  buffer[5] = 0;
c0d01758:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d0175a:	2106      	movs	r1, #6
c0d0175c:	f7ff fee2 	bl	c0d01524 <io_seproxyhal_spi_send>
  if (ep_addr & 0x80) {
c0d01760:	4235      	tst	r5, r6
c0d01762:	d101      	bne.n	c0d01768 <USBD_LL_ClearStallEP+0x2c>
c0d01764:	4807      	ldr	r0, [pc, #28]	; (c0d01784 <USBD_LL_ClearStallEP+0x48>)
c0d01766:	e000      	b.n	c0d0176a <USBD_LL_ClearStallEP+0x2e>
c0d01768:	4805      	ldr	r0, [pc, #20]	; (c0d01780 <USBD_LL_ClearStallEP+0x44>)
c0d0176a:	6801      	ldr	r1, [r0, #0]
c0d0176c:	227f      	movs	r2, #127	; 0x7f
c0d0176e:	4015      	ands	r5, r2
c0d01770:	2201      	movs	r2, #1
c0d01772:	40aa      	lsls	r2, r5
c0d01774:	4391      	bics	r1, r2
c0d01776:	6001      	str	r1, [r0, #0]
    ep_in_stall &= ~(1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall &= ~(1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d01778:	4620      	mov	r0, r4
c0d0177a:	b003      	add	sp, #12
c0d0177c:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0177e:	46c0      	nop			; (mov r8, r8)
c0d01780:	20001b1c 	.word	0x20001b1c
c0d01784:	20001b20 	.word	0x20001b20

c0d01788 <USBD_LL_IsStallEP>:
  * @retval Stall (1: Yes, 0: No)
  */
uint8_t USBD_LL_IsStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
  UNUSED(pdev);
  if((ep_addr & 0x80) == 0x80)
c0d01788:	2080      	movs	r0, #128	; 0x80
c0d0178a:	4201      	tst	r1, r0
c0d0178c:	d001      	beq.n	c0d01792 <USBD_LL_IsStallEP+0xa>
c0d0178e:	4806      	ldr	r0, [pc, #24]	; (c0d017a8 <USBD_LL_IsStallEP+0x20>)
c0d01790:	e000      	b.n	c0d01794 <USBD_LL_IsStallEP+0xc>
c0d01792:	4804      	ldr	r0, [pc, #16]	; (c0d017a4 <USBD_LL_IsStallEP+0x1c>)
c0d01794:	6800      	ldr	r0, [r0, #0]
c0d01796:	227f      	movs	r2, #127	; 0x7f
c0d01798:	4011      	ands	r1, r2
c0d0179a:	2201      	movs	r2, #1
c0d0179c:	408a      	lsls	r2, r1
c0d0179e:	4002      	ands	r2, r0
  }
  else
  {
    return ep_out_stall & (1<<(ep_addr&0x7F));
  }
}
c0d017a0:	b2d0      	uxtb	r0, r2
c0d017a2:	4770      	bx	lr
c0d017a4:	20001b20 	.word	0x20001b20
c0d017a8:	20001b1c 	.word	0x20001b1c

c0d017ac <USBD_LL_SetUSBAddress>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_SetUSBAddress (USBD_HandleTypeDef *pdev, uint8_t dev_addr)   
{
c0d017ac:	b5d0      	push	{r4, r6, r7, lr}
c0d017ae:	af02      	add	r7, sp, #8
c0d017b0:	b082      	sub	sp, #8
c0d017b2:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[5];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d017b4:	224f      	movs	r2, #79	; 0x4f
c0d017b6:	7002      	strb	r2, [r0, #0]
c0d017b8:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d017ba:	7044      	strb	r4, [r0, #1]
c0d017bc:	2202      	movs	r2, #2
  buffer[2] = 2;
c0d017be:	7082      	strb	r2, [r0, #2]
c0d017c0:	2203      	movs	r2, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d017c2:	70c2      	strb	r2, [r0, #3]
  buffer[4] = dev_addr;
c0d017c4:	7101      	strb	r1, [r0, #4]
  io_seproxyhal_spi_send(buffer, 5);
c0d017c6:	2105      	movs	r1, #5
c0d017c8:	f7ff feac 	bl	c0d01524 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d017cc:	4620      	mov	r0, r4
c0d017ce:	b002      	add	sp, #8
c0d017d0:	bdd0      	pop	{r4, r6, r7, pc}

c0d017d2 <USBD_LL_Transmit>:
  */
USBD_StatusTypeDef  USBD_LL_Transmit (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  *pbuf,
                                      uint16_t  size)
{
c0d017d2:	b5b0      	push	{r4, r5, r7, lr}
c0d017d4:	af02      	add	r7, sp, #8
c0d017d6:	b082      	sub	sp, #8
c0d017d8:	461c      	mov	r4, r3
c0d017da:	4615      	mov	r5, r2
c0d017dc:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d017de:	2250      	movs	r2, #80	; 0x50
c0d017e0:	7002      	strb	r2, [r0, #0]
  buffer[1] = (3+size)>>8;
c0d017e2:	1ce2      	adds	r2, r4, #3
c0d017e4:	0a13      	lsrs	r3, r2, #8
c0d017e6:	7043      	strb	r3, [r0, #1]
  buffer[2] = (3+size);
c0d017e8:	7082      	strb	r2, [r0, #2]
  buffer[3] = ep_addr;
c0d017ea:	70c1      	strb	r1, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d017ec:	2120      	movs	r1, #32
c0d017ee:	7101      	strb	r1, [r0, #4]
  buffer[5] = size;
c0d017f0:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d017f2:	2106      	movs	r1, #6
c0d017f4:	f7ff fe96 	bl	c0d01524 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send(pbuf, size);
c0d017f8:	4628      	mov	r0, r5
c0d017fa:	4621      	mov	r1, r4
c0d017fc:	f7ff fe92 	bl	c0d01524 <io_seproxyhal_spi_send>
c0d01800:	2000      	movs	r0, #0
  return USBD_OK;   
c0d01802:	b002      	add	sp, #8
c0d01804:	bdb0      	pop	{r4, r5, r7, pc}

c0d01806 <USBD_LL_PrepareReceive>:
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_PrepareReceive(USBD_HandleTypeDef *pdev, 
                                           uint8_t  ep_addr,
                                           uint16_t  size)
{
c0d01806:	b5d0      	push	{r4, r6, r7, lr}
c0d01808:	af02      	add	r7, sp, #8
c0d0180a:	b082      	sub	sp, #8
c0d0180c:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d0180e:	2350      	movs	r3, #80	; 0x50
c0d01810:	7003      	strb	r3, [r0, #0]
c0d01812:	2400      	movs	r4, #0
  buffer[1] = (3/*+size*/)>>8;
c0d01814:	7044      	strb	r4, [r0, #1]
c0d01816:	2303      	movs	r3, #3
  buffer[2] = (3/*+size*/);
c0d01818:	7083      	strb	r3, [r0, #2]
  buffer[3] = ep_addr;
c0d0181a:	70c1      	strb	r1, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_OUT;
c0d0181c:	2130      	movs	r1, #48	; 0x30
c0d0181e:	7101      	strb	r1, [r0, #4]
  buffer[5] = size; // expected size, not transmitted here !
c0d01820:	7142      	strb	r2, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d01822:	2106      	movs	r1, #6
c0d01824:	f7ff fe7e 	bl	c0d01524 <io_seproxyhal_spi_send>
  return USBD_OK;   
c0d01828:	4620      	mov	r0, r4
c0d0182a:	b002      	add	sp, #8
c0d0182c:	bdd0      	pop	{r4, r6, r7, pc}

c0d0182e <USBD_Init>:
* @param  pdesc: Descriptor structure address
* @param  id: Low level core index
* @retval None
*/
USBD_StatusTypeDef USBD_Init(USBD_HandleTypeDef *pdev, USBD_DescriptorsTypeDef *pdesc, uint8_t id)
{
c0d0182e:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01830:	af03      	add	r7, sp, #12
c0d01832:	b081      	sub	sp, #4
c0d01834:	4615      	mov	r5, r2
c0d01836:	460e      	mov	r6, r1
c0d01838:	4604      	mov	r4, r0
c0d0183a:	2002      	movs	r0, #2
  /* Check whether the USB Host handle is valid */
  if(pdev == NULL)
c0d0183c:	2c00      	cmp	r4, #0
c0d0183e:	d011      	beq.n	c0d01864 <USBD_Init+0x36>
  {
    USBD_ErrLog("Invalid Device handle");
    return USBD_FAIL; 
  }

  memset(pdev, 0, sizeof(USBD_HandleTypeDef));
c0d01840:	2049      	movs	r0, #73	; 0x49
c0d01842:	0081      	lsls	r1, r0, #2
c0d01844:	4620      	mov	r0, r4
c0d01846:	f000 fde3 	bl	c0d02410 <__aeabi_memclr>
  
  /* Assign USBD Descriptors */
  if(pdesc != NULL)
c0d0184a:	2e00      	cmp	r6, #0
c0d0184c:	d002      	beq.n	c0d01854 <USBD_Init+0x26>
  {
    pdev->pDesc = pdesc;
c0d0184e:	2011      	movs	r0, #17
c0d01850:	0100      	lsls	r0, r0, #4
c0d01852:	5026      	str	r6, [r4, r0]
  }
  
  /* Set Device initial State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d01854:	20fc      	movs	r0, #252	; 0xfc
c0d01856:	2101      	movs	r1, #1
c0d01858:	5421      	strb	r1, [r4, r0]
  pdev->id = id;
c0d0185a:	7025      	strb	r5, [r4, #0]
  /* Initialize low level driver */
  USBD_LL_Init(pdev);
c0d0185c:	4620      	mov	r0, r4
c0d0185e:	f7ff febb 	bl	c0d015d8 <USBD_LL_Init>
c0d01862:	2000      	movs	r0, #0
  
  return USBD_OK; 
}
c0d01864:	b2c0      	uxtb	r0, r0
c0d01866:	b001      	add	sp, #4
c0d01868:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0186a <USBD_DeInit>:
*         Re-Initialize th device library
* @param  pdev: device instance
* @retval status: status
*/
USBD_StatusTypeDef USBD_DeInit(USBD_HandleTypeDef *pdev)
{
c0d0186a:	b5d0      	push	{r4, r6, r7, lr}
c0d0186c:	af02      	add	r7, sp, #8
c0d0186e:	4604      	mov	r4, r0
  /* Set Default State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d01870:	20fc      	movs	r0, #252	; 0xfc
c0d01872:	2101      	movs	r1, #1
c0d01874:	5421      	strb	r1, [r4, r0]
  
  /* Free Class Resources */
  if(pdev->pClass != NULL) {
c0d01876:	2045      	movs	r0, #69	; 0x45
c0d01878:	0080      	lsls	r0, r0, #2
c0d0187a:	5820      	ldr	r0, [r4, r0]
c0d0187c:	2800      	cmp	r0, #0
c0d0187e:	d006      	beq.n	c0d0188e <USBD_DeInit+0x24>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, pdev->dev_config);  
c0d01880:	6840      	ldr	r0, [r0, #4]
c0d01882:	f7ff fd4b 	bl	c0d0131c <pic>
c0d01886:	4602      	mov	r2, r0
c0d01888:	7921      	ldrb	r1, [r4, #4]
c0d0188a:	4620      	mov	r0, r4
c0d0188c:	4790      	blx	r2
  }
  
    /* Stop the low level driver  */
  USBD_LL_Stop(pdev); 
c0d0188e:	4620      	mov	r0, r4
c0d01890:	f7ff fedb 	bl	c0d0164a <USBD_LL_Stop>
  
  /* Initialize low level driver */
  USBD_LL_DeInit(pdev);
c0d01894:	4620      	mov	r0, r4
c0d01896:	f7ff fea9 	bl	c0d015ec <USBD_LL_DeInit>
  
  return USBD_OK;
c0d0189a:	2000      	movs	r0, #0
c0d0189c:	bdd0      	pop	{r4, r6, r7, pc}

c0d0189e <USBD_RegisterClass>:
  * @param  pDevice : Device Handle
  * @param  pclass: Class handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_RegisterClass(USBD_HandleTypeDef *pdev, USBD_ClassTypeDef *pclass)
{
c0d0189e:	2202      	movs	r2, #2
  USBD_StatusTypeDef   status = USBD_OK;
  if(pclass != 0)
c0d018a0:	2900      	cmp	r1, #0
c0d018a2:	d003      	beq.n	c0d018ac <USBD_RegisterClass+0xe>
  {
    /* link the class to the USB Device handle */
    pdev->pClass = pclass;
c0d018a4:	2245      	movs	r2, #69	; 0x45
c0d018a6:	0092      	lsls	r2, r2, #2
c0d018a8:	5081      	str	r1, [r0, r2]
c0d018aa:	2200      	movs	r2, #0
  {
    USBD_ErrLog("Invalid Class handle");
    status = USBD_FAIL; 
  }
  
  return status;
c0d018ac:	b2d0      	uxtb	r0, r2
c0d018ae:	4770      	bx	lr

c0d018b0 <USBD_Start>:
  *         Start the USB Device Core.
  * @param  pdev: Device Handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_Start  (USBD_HandleTypeDef *pdev)
{
c0d018b0:	b580      	push	{r7, lr}
c0d018b2:	af00      	add	r7, sp, #0
  
  /* Start the low level driver  */
  USBD_LL_Start(pdev); 
c0d018b4:	f7ff feac 	bl	c0d01610 <USBD_LL_Start>
  
  return USBD_OK;  
c0d018b8:	2000      	movs	r0, #0
c0d018ba:	bd80      	pop	{r7, pc}

c0d018bc <USBD_SetClassConfig>:
* @param  cfgidx: configuration index
* @retval status
*/

USBD_StatusTypeDef USBD_SetClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d018bc:	b5b0      	push	{r4, r5, r7, lr}
c0d018be:	af02      	add	r7, sp, #8
c0d018c0:	460c      	mov	r4, r1
c0d018c2:	4605      	mov	r5, r0
  USBD_StatusTypeDef   ret = USBD_FAIL;
  
  if(pdev->pClass != NULL)
c0d018c4:	2045      	movs	r0, #69	; 0x45
c0d018c6:	0080      	lsls	r0, r0, #2
c0d018c8:	5828      	ldr	r0, [r5, r0]
c0d018ca:	2800      	cmp	r0, #0
c0d018cc:	d00c      	beq.n	c0d018e8 <USBD_SetClassConfig+0x2c>
  {
    /* Set configuration  and Start the Class*/
    if(((Init_t)PIC(pdev->pClass->Init))(pdev, cfgidx) == 0)
c0d018ce:	6800      	ldr	r0, [r0, #0]
c0d018d0:	f7ff fd24 	bl	c0d0131c <pic>
c0d018d4:	4602      	mov	r2, r0
c0d018d6:	4628      	mov	r0, r5
c0d018d8:	4621      	mov	r1, r4
c0d018da:	4790      	blx	r2
c0d018dc:	4601      	mov	r1, r0
c0d018de:	2002      	movs	r0, #2
c0d018e0:	2900      	cmp	r1, #0
c0d018e2:	d100      	bne.n	c0d018e6 <USBD_SetClassConfig+0x2a>
c0d018e4:	4608      	mov	r0, r1
c0d018e6:	bdb0      	pop	{r4, r5, r7, pc}
    {
      ret = USBD_OK;
    }
  }
  return ret; 
c0d018e8:	2002      	movs	r0, #2
c0d018ea:	bdb0      	pop	{r4, r5, r7, pc}

c0d018ec <USBD_ClrClassConfig>:
* @param  pdev: device instance
* @param  cfgidx: configuration index
* @retval status: USBD_StatusTypeDef
*/
USBD_StatusTypeDef USBD_ClrClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d018ec:	b5b0      	push	{r4, r5, r7, lr}
c0d018ee:	af02      	add	r7, sp, #8
c0d018f0:	460c      	mov	r4, r1
c0d018f2:	4605      	mov	r5, r0
  /* Clear configuration  and De-initialize the Class process*/
  if(pdev->pClass != NULL) {
c0d018f4:	2045      	movs	r0, #69	; 0x45
c0d018f6:	0080      	lsls	r0, r0, #2
c0d018f8:	5828      	ldr	r0, [r5, r0]
c0d018fa:	2800      	cmp	r0, #0
c0d018fc:	d006      	beq.n	c0d0190c <USBD_ClrClassConfig+0x20>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, cfgidx);  
c0d018fe:	6840      	ldr	r0, [r0, #4]
c0d01900:	f7ff fd0c 	bl	c0d0131c <pic>
c0d01904:	4602      	mov	r2, r0
c0d01906:	4628      	mov	r0, r5
c0d01908:	4621      	mov	r1, r4
c0d0190a:	4790      	blx	r2
  }
  return USBD_OK;
c0d0190c:	2000      	movs	r0, #0
c0d0190e:	bdb0      	pop	{r4, r5, r7, pc}

c0d01910 <USBD_LL_SetupStage>:
*         Handle the setup stage
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetupStage(USBD_HandleTypeDef *pdev, uint8_t *psetup)
{
c0d01910:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01912:	af03      	add	r7, sp, #12
c0d01914:	b081      	sub	sp, #4
c0d01916:	4604      	mov	r4, r0
c0d01918:	2021      	movs	r0, #33	; 0x21
c0d0191a:	00c6      	lsls	r6, r0, #3
  USBD_ParseSetupRequest(&pdev->request, psetup);
c0d0191c:	19a5      	adds	r5, r4, r6
c0d0191e:	4628      	mov	r0, r5
c0d01920:	f000 fb69 	bl	c0d01ff6 <USBD_ParseSetupRequest>
  
  pdev->ep0_state = USBD_EP0_SETUP;
c0d01924:	20f4      	movs	r0, #244	; 0xf4
c0d01926:	2101      	movs	r1, #1
c0d01928:	5021      	str	r1, [r4, r0]
  pdev->ep0_data_len = pdev->request.wLength;
c0d0192a:	2087      	movs	r0, #135	; 0x87
c0d0192c:	0040      	lsls	r0, r0, #1
c0d0192e:	5a20      	ldrh	r0, [r4, r0]
c0d01930:	21f8      	movs	r1, #248	; 0xf8
c0d01932:	5060      	str	r0, [r4, r1]
  
  switch (pdev->request.bmRequest & 0x1F) 
c0d01934:	5da1      	ldrb	r1, [r4, r6]
c0d01936:	201f      	movs	r0, #31
c0d01938:	4008      	ands	r0, r1
c0d0193a:	2802      	cmp	r0, #2
c0d0193c:	d008      	beq.n	c0d01950 <USBD_LL_SetupStage+0x40>
c0d0193e:	2801      	cmp	r0, #1
c0d01940:	d00b      	beq.n	c0d0195a <USBD_LL_SetupStage+0x4a>
c0d01942:	2800      	cmp	r0, #0
c0d01944:	d10e      	bne.n	c0d01964 <USBD_LL_SetupStage+0x54>
  {
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
c0d01946:	4620      	mov	r0, r4
c0d01948:	4629      	mov	r1, r5
c0d0194a:	f000 f8f1 	bl	c0d01b30 <USBD_StdDevReq>
c0d0194e:	e00e      	b.n	c0d0196e <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
c0d01950:	4620      	mov	r0, r4
c0d01952:	4629      	mov	r1, r5
c0d01954:	f000 fad3 	bl	c0d01efe <USBD_StdEPReq>
c0d01958:	e009      	b.n	c0d0196e <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
c0d0195a:	4620      	mov	r0, r4
c0d0195c:	4629      	mov	r1, r5
c0d0195e:	f000 faa6 	bl	c0d01eae <USBD_StdItfReq>
c0d01962:	e004      	b.n	c0d0196e <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
    break;
    
  default:           
    USBD_LL_StallEP(pdev , pdev->request.bmRequest & 0x80);
c0d01964:	2080      	movs	r0, #128	; 0x80
c0d01966:	4001      	ands	r1, r0
c0d01968:	4620      	mov	r0, r4
c0d0196a:	f7ff fec1 	bl	c0d016f0 <USBD_LL_StallEP>
    break;
  }  
  return USBD_OK;  
c0d0196e:	2000      	movs	r0, #0
c0d01970:	b001      	add	sp, #4
c0d01972:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d01974 <USBD_LL_DataOutStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataOutStage(USBD_HandleTypeDef *pdev , uint8_t epnum, uint8_t *pdata)
{
c0d01974:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01976:	af03      	add	r7, sp, #12
c0d01978:	b081      	sub	sp, #4
c0d0197a:	4615      	mov	r5, r2
c0d0197c:	460e      	mov	r6, r1
c0d0197e:	4604      	mov	r4, r0
  USBD_EndpointTypeDef    *pep;
  
  if(epnum == 0) 
c0d01980:	2e00      	cmp	r6, #0
c0d01982:	d011      	beq.n	c0d019a8 <USBD_LL_DataOutStage+0x34>
        }
        USBD_CtlSendStatus(pdev);
      }
    }
  }
  else if((pdev->pClass->DataOut != NULL)&&
c0d01984:	2045      	movs	r0, #69	; 0x45
c0d01986:	0080      	lsls	r0, r0, #2
c0d01988:	5820      	ldr	r0, [r4, r0]
c0d0198a:	6980      	ldr	r0, [r0, #24]
c0d0198c:	2800      	cmp	r0, #0
c0d0198e:	d034      	beq.n	c0d019fa <USBD_LL_DataOutStage+0x86>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d01990:	21fc      	movs	r1, #252	; 0xfc
c0d01992:	5c61      	ldrb	r1, [r4, r1]
        }
        USBD_CtlSendStatus(pdev);
      }
    }
  }
  else if((pdev->pClass->DataOut != NULL)&&
c0d01994:	2903      	cmp	r1, #3
c0d01996:	d130      	bne.n	c0d019fa <USBD_LL_DataOutStage+0x86>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataOut_t)PIC(pdev->pClass->DataOut))(pdev, epnum, pdata); 
c0d01998:	f7ff fcc0 	bl	c0d0131c <pic>
c0d0199c:	4603      	mov	r3, r0
c0d0199e:	4620      	mov	r0, r4
c0d019a0:	4631      	mov	r1, r6
c0d019a2:	462a      	mov	r2, r5
c0d019a4:	4798      	blx	r3
c0d019a6:	e028      	b.n	c0d019fa <USBD_LL_DataOutStage+0x86>
  
  if(epnum == 0) 
  {
    pep = &pdev->ep_out[0];
    
    if ( pdev->ep0_state == USBD_EP0_DATA_OUT)
c0d019a8:	20f4      	movs	r0, #244	; 0xf4
c0d019aa:	5820      	ldr	r0, [r4, r0]
c0d019ac:	2803      	cmp	r0, #3
c0d019ae:	d124      	bne.n	c0d019fa <USBD_LL_DataOutStage+0x86>
    {
      if(pep->rem_length > pep->maxpacket)
c0d019b0:	2090      	movs	r0, #144	; 0x90
c0d019b2:	5820      	ldr	r0, [r4, r0]
c0d019b4:	218c      	movs	r1, #140	; 0x8c
c0d019b6:	5861      	ldr	r1, [r4, r1]
c0d019b8:	4622      	mov	r2, r4
c0d019ba:	328c      	adds	r2, #140	; 0x8c
c0d019bc:	4281      	cmp	r1, r0
c0d019be:	d90a      	bls.n	c0d019d6 <USBD_LL_DataOutStage+0x62>
      {
        pep->rem_length -=  pep->maxpacket;
c0d019c0:	1a09      	subs	r1, r1, r0
c0d019c2:	6011      	str	r1, [r2, #0]
c0d019c4:	4281      	cmp	r1, r0
c0d019c6:	d300      	bcc.n	c0d019ca <USBD_LL_DataOutStage+0x56>
c0d019c8:	4601      	mov	r1, r0
       
        USBD_CtlContinueRx (pdev, 
c0d019ca:	b28a      	uxth	r2, r1
c0d019cc:	4620      	mov	r0, r4
c0d019ce:	4629      	mov	r1, r5
c0d019d0:	f000 fc70 	bl	c0d022b4 <USBD_CtlContinueRx>
c0d019d4:	e011      	b.n	c0d019fa <USBD_LL_DataOutStage+0x86>
                            pdata,
                            MIN(pep->rem_length ,pep->maxpacket));
      }
      else
      {
        if((pdev->pClass->EP0_RxReady != NULL)&&
c0d019d6:	2045      	movs	r0, #69	; 0x45
c0d019d8:	0080      	lsls	r0, r0, #2
c0d019da:	5820      	ldr	r0, [r4, r0]
c0d019dc:	6900      	ldr	r0, [r0, #16]
c0d019de:	2800      	cmp	r0, #0
c0d019e0:	d008      	beq.n	c0d019f4 <USBD_LL_DataOutStage+0x80>
           (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d019e2:	21fc      	movs	r1, #252	; 0xfc
c0d019e4:	5c61      	ldrb	r1, [r4, r1]
                            pdata,
                            MIN(pep->rem_length ,pep->maxpacket));
      }
      else
      {
        if((pdev->pClass->EP0_RxReady != NULL)&&
c0d019e6:	2903      	cmp	r1, #3
c0d019e8:	d104      	bne.n	c0d019f4 <USBD_LL_DataOutStage+0x80>
           (pdev->dev_state == USBD_STATE_CONFIGURED))
        {
          ((EP0_RxReady_t)PIC(pdev->pClass->EP0_RxReady))(pdev); 
c0d019ea:	f7ff fc97 	bl	c0d0131c <pic>
c0d019ee:	4601      	mov	r1, r0
c0d019f0:	4620      	mov	r0, r4
c0d019f2:	4788      	blx	r1
        }
        USBD_CtlSendStatus(pdev);
c0d019f4:	4620      	mov	r0, r4
c0d019f6:	f000 fc65 	bl	c0d022c4 <USBD_CtlSendStatus>
  else if((pdev->pClass->DataOut != NULL)&&
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataOut_t)PIC(pdev->pClass->DataOut))(pdev, epnum, pdata); 
  }  
  return USBD_OK;
c0d019fa:	2000      	movs	r0, #0
c0d019fc:	b001      	add	sp, #4
c0d019fe:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d01a00 <USBD_LL_DataInStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataInStage(USBD_HandleTypeDef *pdev ,uint8_t epnum, uint8_t *pdata)
{
c0d01a00:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01a02:	af03      	add	r7, sp, #12
c0d01a04:	b081      	sub	sp, #4
c0d01a06:	460d      	mov	r5, r1
c0d01a08:	4604      	mov	r4, r0
  USBD_EndpointTypeDef    *pep;
  UNUSED(pdata);
    
  if(epnum == 0) 
c0d01a0a:	2d00      	cmp	r5, #0
c0d01a0c:	d012      	beq.n	c0d01a34 <USBD_LL_DataInStage+0x34>
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
    }
  }
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
c0d01a0e:	2045      	movs	r0, #69	; 0x45
c0d01a10:	0080      	lsls	r0, r0, #2
c0d01a12:	5820      	ldr	r0, [r4, r0]
c0d01a14:	2800      	cmp	r0, #0
c0d01a16:	d054      	beq.n	c0d01ac2 <USBD_LL_DataInStage+0xc2>
c0d01a18:	6940      	ldr	r0, [r0, #20]
c0d01a1a:	2800      	cmp	r0, #0
c0d01a1c:	d051      	beq.n	c0d01ac2 <USBD_LL_DataInStage+0xc2>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d01a1e:	21fc      	movs	r1, #252	; 0xfc
c0d01a20:	5c61      	ldrb	r1, [r4, r1]
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
    }
  }
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
c0d01a22:	2903      	cmp	r1, #3
c0d01a24:	d14d      	bne.n	c0d01ac2 <USBD_LL_DataInStage+0xc2>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataIn_t)PIC(pdev->pClass->DataIn))(pdev, epnum); 
c0d01a26:	f7ff fc79 	bl	c0d0131c <pic>
c0d01a2a:	4602      	mov	r2, r0
c0d01a2c:	4620      	mov	r0, r4
c0d01a2e:	4629      	mov	r1, r5
c0d01a30:	4790      	blx	r2
c0d01a32:	e046      	b.n	c0d01ac2 <USBD_LL_DataInStage+0xc2>
    
  if(epnum == 0) 
  {
    pep = &pdev->ep_in[0];
    
    if ( pdev->ep0_state == USBD_EP0_DATA_IN)
c0d01a34:	20f4      	movs	r0, #244	; 0xf4
c0d01a36:	5820      	ldr	r0, [r4, r0]
c0d01a38:	2802      	cmp	r0, #2
c0d01a3a:	d13a      	bne.n	c0d01ab2 <USBD_LL_DataInStage+0xb2>
    {
      if(pep->rem_length > pep->maxpacket)
c0d01a3c:	69e0      	ldr	r0, [r4, #28]
c0d01a3e:	6a25      	ldr	r5, [r4, #32]
c0d01a40:	42a8      	cmp	r0, r5
c0d01a42:	d90b      	bls.n	c0d01a5c <USBD_LL_DataInStage+0x5c>
      {
        pep->rem_length -=  pep->maxpacket;
c0d01a44:	1b40      	subs	r0, r0, r5
c0d01a46:	61e0      	str	r0, [r4, #28]
        pdev->pData += pep->maxpacket;
c0d01a48:	2109      	movs	r1, #9
c0d01a4a:	014a      	lsls	r2, r1, #5
c0d01a4c:	58a1      	ldr	r1, [r4, r2]
c0d01a4e:	1949      	adds	r1, r1, r5
c0d01a50:	50a1      	str	r1, [r4, r2]
        USBD_LL_PrepareReceive (pdev,
                                0,
                                0);  
        */
        
        USBD_CtlContinueSendData (pdev, 
c0d01a52:	b282      	uxth	r2, r0
c0d01a54:	4620      	mov	r0, r4
c0d01a56:	f000 fc1e 	bl	c0d02296 <USBD_CtlContinueSendData>
c0d01a5a:	e02a      	b.n	c0d01ab2 <USBD_LL_DataInStage+0xb2>
                                  pep->rem_length);
        
      }
      else
      { /* last packet is MPS multiple, so send ZLP packet */
        if((pep->total_length % pep->maxpacket == 0) &&
c0d01a5c:	69a6      	ldr	r6, [r4, #24]
c0d01a5e:	4630      	mov	r0, r6
c0d01a60:	4629      	mov	r1, r5
c0d01a62:	f000 fccf 	bl	c0d02404 <__aeabi_uidivmod>
c0d01a66:	42ae      	cmp	r6, r5
c0d01a68:	d30f      	bcc.n	c0d01a8a <USBD_LL_DataInStage+0x8a>
c0d01a6a:	2900      	cmp	r1, #0
c0d01a6c:	d10d      	bne.n	c0d01a8a <USBD_LL_DataInStage+0x8a>
           (pep->total_length >= pep->maxpacket) &&
             (pep->total_length < pdev->ep0_data_len ))
c0d01a6e:	20f8      	movs	r0, #248	; 0xf8
c0d01a70:	5820      	ldr	r0, [r4, r0]
c0d01a72:	4625      	mov	r5, r4
c0d01a74:	35f8      	adds	r5, #248	; 0xf8
                                  pep->rem_length);
        
      }
      else
      { /* last packet is MPS multiple, so send ZLP packet */
        if((pep->total_length % pep->maxpacket == 0) &&
c0d01a76:	4286      	cmp	r6, r0
c0d01a78:	d207      	bcs.n	c0d01a8a <USBD_LL_DataInStage+0x8a>
c0d01a7a:	2600      	movs	r6, #0
          USBD_LL_PrepareReceive (pdev,
                                  0,
                                  0);
          */

          USBD_CtlContinueSendData(pdev , NULL, 0);
c0d01a7c:	4620      	mov	r0, r4
c0d01a7e:	4631      	mov	r1, r6
c0d01a80:	4632      	mov	r2, r6
c0d01a82:	f000 fc08 	bl	c0d02296 <USBD_CtlContinueSendData>
          pdev->ep0_data_len = 0;
c0d01a86:	602e      	str	r6, [r5, #0]
c0d01a88:	e013      	b.n	c0d01ab2 <USBD_LL_DataInStage+0xb2>
          
        }
        else
        {
          if(pdev->pClass != NULL && (pdev->pClass->EP0_TxSent != NULL) &&
c0d01a8a:	2045      	movs	r0, #69	; 0x45
c0d01a8c:	0080      	lsls	r0, r0, #2
c0d01a8e:	5820      	ldr	r0, [r4, r0]
c0d01a90:	2800      	cmp	r0, #0
c0d01a92:	d00b      	beq.n	c0d01aac <USBD_LL_DataInStage+0xac>
c0d01a94:	68c0      	ldr	r0, [r0, #12]
c0d01a96:	2800      	cmp	r0, #0
c0d01a98:	d008      	beq.n	c0d01aac <USBD_LL_DataInStage+0xac>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d01a9a:	21fc      	movs	r1, #252	; 0xfc
c0d01a9c:	5c61      	ldrb	r1, [r4, r1]
          pdev->ep0_data_len = 0;
          
        }
        else
        {
          if(pdev->pClass != NULL && (pdev->pClass->EP0_TxSent != NULL) &&
c0d01a9e:	2903      	cmp	r1, #3
c0d01aa0:	d104      	bne.n	c0d01aac <USBD_LL_DataInStage+0xac>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
          {
            ((EP0_TxSent_t)PIC(pdev->pClass->EP0_TxSent))(pdev); 
c0d01aa2:	f7ff fc3b 	bl	c0d0131c <pic>
c0d01aa6:	4601      	mov	r1, r0
c0d01aa8:	4620      	mov	r0, r4
c0d01aaa:	4788      	blx	r1
          }          
          USBD_CtlReceiveStatus(pdev);
c0d01aac:	4620      	mov	r0, r4
c0d01aae:	f000 fc16 	bl	c0d022de <USBD_CtlReceiveStatus>
        }
      }
    }
    if (pdev->dev_test_mode == 1)
c0d01ab2:	2001      	movs	r0, #1
c0d01ab4:	0201      	lsls	r1, r0, #8
c0d01ab6:	1860      	adds	r0, r4, r1
c0d01ab8:	5c61      	ldrb	r1, [r4, r1]
c0d01aba:	2901      	cmp	r1, #1
c0d01abc:	d101      	bne.n	c0d01ac2 <USBD_LL_DataInStage+0xc2>
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
c0d01abe:	2100      	movs	r1, #0
c0d01ac0:	7001      	strb	r1, [r0, #0]
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataIn_t)PIC(pdev->pClass->DataIn))(pdev, epnum); 
  }  
  return USBD_OK;
c0d01ac2:	2000      	movs	r0, #0
c0d01ac4:	b001      	add	sp, #4
c0d01ac6:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d01ac8 <USBD_LL_Reset>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_Reset(USBD_HandleTypeDef  *pdev)
{
c0d01ac8:	b5d0      	push	{r4, r6, r7, lr}
c0d01aca:	af02      	add	r7, sp, #8
c0d01acc:	4604      	mov	r4, r0
  pdev->ep_out[0].maxpacket = USB_MAX_EP0_SIZE;
c0d01ace:	2090      	movs	r0, #144	; 0x90
c0d01ad0:	2140      	movs	r1, #64	; 0x40
c0d01ad2:	5021      	str	r1, [r4, r0]
  

  pdev->ep_in[0].maxpacket = USB_MAX_EP0_SIZE;
c0d01ad4:	6221      	str	r1, [r4, #32]
  /* Upon Reset call user call back */
  pdev->dev_state = USBD_STATE_DEFAULT;
c0d01ad6:	20fc      	movs	r0, #252	; 0xfc
c0d01ad8:	2101      	movs	r1, #1
c0d01ada:	5421      	strb	r1, [r4, r0]
  
  if (pdev->pClass) {
c0d01adc:	2045      	movs	r0, #69	; 0x45
c0d01ade:	0080      	lsls	r0, r0, #2
c0d01ae0:	5820      	ldr	r0, [r4, r0]
c0d01ae2:	2800      	cmp	r0, #0
c0d01ae4:	d006      	beq.n	c0d01af4 <USBD_LL_Reset+0x2c>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, pdev->dev_config);  
c0d01ae6:	6840      	ldr	r0, [r0, #4]
c0d01ae8:	f7ff fc18 	bl	c0d0131c <pic>
c0d01aec:	4602      	mov	r2, r0
c0d01aee:	7921      	ldrb	r1, [r4, #4]
c0d01af0:	4620      	mov	r0, r4
c0d01af2:	4790      	blx	r2
  }
 
  
  return USBD_OK;
c0d01af4:	2000      	movs	r0, #0
c0d01af6:	bdd0      	pop	{r4, r6, r7, pc}

c0d01af8 <USBD_LL_SetSpeed>:
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetSpeed(USBD_HandleTypeDef  *pdev, USBD_SpeedTypeDef speed)
{
  pdev->dev_speed = speed;
c0d01af8:	7401      	strb	r1, [r0, #16]
c0d01afa:	2000      	movs	r0, #0
  return USBD_OK;
c0d01afc:	4770      	bx	lr

c0d01afe <USBD_LL_Suspend>:
{
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_old_state =  pdev->dev_state;
  //pdev->dev_state  = USBD_STATE_SUSPENDED;
  return USBD_OK;
c0d01afe:	2000      	movs	r0, #0
c0d01b00:	4770      	bx	lr

c0d01b02 <USBD_LL_Resume>:
USBD_StatusTypeDef USBD_LL_Resume(USBD_HandleTypeDef  *pdev)
{
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_state = pdev->dev_old_state;  
  return USBD_OK;
c0d01b02:	2000      	movs	r0, #0
c0d01b04:	4770      	bx	lr

c0d01b06 <USBD_LL_SOF>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_SOF(USBD_HandleTypeDef  *pdev)
{
c0d01b06:	b5d0      	push	{r4, r6, r7, lr}
c0d01b08:	af02      	add	r7, sp, #8
c0d01b0a:	4604      	mov	r4, r0
  if(pdev->dev_state == USBD_STATE_CONFIGURED)
c0d01b0c:	20fc      	movs	r0, #252	; 0xfc
c0d01b0e:	5c20      	ldrb	r0, [r4, r0]
c0d01b10:	2803      	cmp	r0, #3
c0d01b12:	d10a      	bne.n	c0d01b2a <USBD_LL_SOF+0x24>
  {
    if(pdev->pClass->SOF != NULL)
c0d01b14:	2045      	movs	r0, #69	; 0x45
c0d01b16:	0080      	lsls	r0, r0, #2
c0d01b18:	5820      	ldr	r0, [r4, r0]
c0d01b1a:	69c0      	ldr	r0, [r0, #28]
c0d01b1c:	2800      	cmp	r0, #0
c0d01b1e:	d004      	beq.n	c0d01b2a <USBD_LL_SOF+0x24>
    {
      ((SOF_t)PIC(pdev->pClass->SOF))(pdev);
c0d01b20:	f7ff fbfc 	bl	c0d0131c <pic>
c0d01b24:	4601      	mov	r1, r0
c0d01b26:	4620      	mov	r0, r4
c0d01b28:	4788      	blx	r1
    }
  }
  return USBD_OK;
c0d01b2a:	2000      	movs	r0, #0
c0d01b2c:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d01b30 <USBD_StdDevReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdDevReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d01b30:	b5d0      	push	{r4, r6, r7, lr}
c0d01b32:	af02      	add	r7, sp, #8
c0d01b34:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK;  
  
  switch (req->bRequest) 
c0d01b36:	7848      	ldrb	r0, [r1, #1]
c0d01b38:	2809      	cmp	r0, #9
c0d01b3a:	d810      	bhi.n	c0d01b5e <USBD_StdDevReq+0x2e>
c0d01b3c:	4478      	add	r0, pc
c0d01b3e:	7900      	ldrb	r0, [r0, #4]
c0d01b40:	0040      	lsls	r0, r0, #1
c0d01b42:	4487      	add	pc, r0
c0d01b44:	150c0804 	.word	0x150c0804
c0d01b48:	0c25190c 	.word	0x0c25190c
c0d01b4c:	211d      	.short	0x211d
  case USB_REQ_GET_CONFIGURATION:                 
    USBD_GetConfig (pdev , req);
    break;
    
  case USB_REQ_GET_STATUS:                                  
    USBD_GetStatus (pdev , req);
c0d01b4e:	4620      	mov	r0, r4
c0d01b50:	f000 f938 	bl	c0d01dc4 <USBD_GetStatus>
c0d01b54:	e01f      	b.n	c0d01b96 <USBD_StdDevReq+0x66>
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
    break;
    
  case USB_REQ_CLEAR_FEATURE:                                   
    USBD_ClrFeature (pdev , req);
c0d01b56:	4620      	mov	r0, r4
c0d01b58:	f000 f976 	bl	c0d01e48 <USBD_ClrFeature>
c0d01b5c:	e01b      	b.n	c0d01b96 <USBD_StdDevReq+0x66>

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d01b5e:	2180      	movs	r1, #128	; 0x80
c0d01b60:	4620      	mov	r0, r4
c0d01b62:	f7ff fdc5 	bl	c0d016f0 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d01b66:	2100      	movs	r1, #0
c0d01b68:	4620      	mov	r0, r4
c0d01b6a:	f7ff fdc1 	bl	c0d016f0 <USBD_LL_StallEP>
c0d01b6e:	e012      	b.n	c0d01b96 <USBD_StdDevReq+0x66>
    USBD_GetStatus (pdev , req);
    break;
    
    
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
c0d01b70:	4620      	mov	r0, r4
c0d01b72:	f000 f950 	bl	c0d01e16 <USBD_SetFeature>
c0d01b76:	e00e      	b.n	c0d01b96 <USBD_StdDevReq+0x66>
    
    USBD_GetDescriptor (pdev, req) ;
    break;
    
  case USB_REQ_SET_ADDRESS:                      
    USBD_SetAddress(pdev, req);
c0d01b78:	4620      	mov	r0, r4
c0d01b7a:	f000 f897 	bl	c0d01cac <USBD_SetAddress>
c0d01b7e:	e00a      	b.n	c0d01b96 <USBD_StdDevReq+0x66>
  case USB_REQ_SET_CONFIGURATION:                    
    USBD_SetConfig (pdev , req);
    break;
    
  case USB_REQ_GET_CONFIGURATION:                 
    USBD_GetConfig (pdev , req);
c0d01b80:	4620      	mov	r0, r4
c0d01b82:	f000 f8ff 	bl	c0d01d84 <USBD_GetConfig>
c0d01b86:	e006      	b.n	c0d01b96 <USBD_StdDevReq+0x66>
  case USB_REQ_SET_ADDRESS:                      
    USBD_SetAddress(pdev, req);
    break;
    
  case USB_REQ_SET_CONFIGURATION:                    
    USBD_SetConfig (pdev , req);
c0d01b88:	4620      	mov	r0, r4
c0d01b8a:	f000 f8bd 	bl	c0d01d08 <USBD_SetConfig>
c0d01b8e:	e002      	b.n	c0d01b96 <USBD_StdDevReq+0x66>
  
  switch (req->bRequest) 
  {
  case USB_REQ_GET_DESCRIPTOR: 
    
    USBD_GetDescriptor (pdev, req) ;
c0d01b90:	4620      	mov	r0, r4
c0d01b92:	f000 f803 	bl	c0d01b9c <USBD_GetDescriptor>
  default:  
    USBD_CtlError(pdev , req);
    break;
  }
  
  return ret;
c0d01b96:	2000      	movs	r0, #0
c0d01b98:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d01b9c <USBD_GetDescriptor>:
* @param  req: usb request
* @retval status
*/
void USBD_GetDescriptor(USBD_HandleTypeDef *pdev , 
                               USBD_SetupReqTypedef *req)
{
c0d01b9c:	b5b0      	push	{r4, r5, r7, lr}
c0d01b9e:	af02      	add	r7, sp, #8
c0d01ba0:	b082      	sub	sp, #8
c0d01ba2:	460d      	mov	r5, r1
c0d01ba4:	4604      	mov	r4, r0
  uint16_t len;
  uint8_t *pbuf;
  
    
  switch (req->wValue >> 8)
c0d01ba6:	8868      	ldrh	r0, [r5, #2]
c0d01ba8:	0a01      	lsrs	r1, r0, #8
c0d01baa:	1e4a      	subs	r2, r1, #1

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d01bac:	2180      	movs	r1, #128	; 0x80
{
  uint16_t len;
  uint8_t *pbuf;
  
    
  switch (req->wValue >> 8)
c0d01bae:	2a0e      	cmp	r2, #14
c0d01bb0:	d83e      	bhi.n	c0d01c30 <USBD_GetDescriptor+0x94>
c0d01bb2:	46c0      	nop			; (mov r8, r8)
c0d01bb4:	447a      	add	r2, pc
c0d01bb6:	7912      	ldrb	r2, [r2, #4]
c0d01bb8:	0052      	lsls	r2, r2, #1
c0d01bba:	4497      	add	pc, r2
c0d01bbc:	390c2607 	.word	0x390c2607
c0d01bc0:	39362e39 	.word	0x39362e39
c0d01bc4:	39393939 	.word	0x39393939
c0d01bc8:	001b3939 	.word	0x001b3939
  case USB_DESC_TYPE_BOS:
    pbuf = ((GetBOSDescriptor_t)PIC(pdev->pDesc->GetBOSDescriptor))(pdev->dev_speed, &len);
    break;
#endif    
  case USB_DESC_TYPE_DEVICE:
    pbuf = ((GetDeviceDescriptor_t)PIC(pdev->pDesc->GetDeviceDescriptor))(pdev->dev_speed, &len);
c0d01bcc:	2011      	movs	r0, #17
c0d01bce:	0100      	lsls	r0, r0, #4
c0d01bd0:	5820      	ldr	r0, [r4, r0]
c0d01bd2:	6800      	ldr	r0, [r0, #0]
c0d01bd4:	e012      	b.n	c0d01bfc <USBD_GetDescriptor+0x60>
      //pbuf[1] = USB_DESC_TYPE_CONFIGURATION; CONST BUFFER KTHX
    }
    break;
    
  case USB_DESC_TYPE_STRING:
    switch ((uint8_t)(req->wValue))
c0d01bd6:	b2c0      	uxtb	r0, r0
c0d01bd8:	2805      	cmp	r0, #5
c0d01bda:	d829      	bhi.n	c0d01c30 <USBD_GetDescriptor+0x94>
c0d01bdc:	4478      	add	r0, pc
c0d01bde:	7900      	ldrb	r0, [r0, #4]
c0d01be0:	0040      	lsls	r0, r0, #1
c0d01be2:	4487      	add	pc, r0
c0d01be4:	544f4a02 	.word	0x544f4a02
c0d01be8:	5e59      	.short	0x5e59
    {
    case USBD_IDX_LANGID_STR:
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
c0d01bea:	2011      	movs	r0, #17
c0d01bec:	0100      	lsls	r0, r0, #4
c0d01bee:	5820      	ldr	r0, [r4, r0]
c0d01bf0:	6840      	ldr	r0, [r0, #4]
c0d01bf2:	e003      	b.n	c0d01bfc <USBD_GetDescriptor+0x60>
    
  switch (req->wValue >> 8)
  { 
#if (USBD_LPM_ENABLED == 1)
  case USB_DESC_TYPE_BOS:
    pbuf = ((GetBOSDescriptor_t)PIC(pdev->pDesc->GetBOSDescriptor))(pdev->dev_speed, &len);
c0d01bf4:	2011      	movs	r0, #17
c0d01bf6:	0100      	lsls	r0, r0, #4
c0d01bf8:	5820      	ldr	r0, [r4, r0]
c0d01bfa:	69c0      	ldr	r0, [r0, #28]
c0d01bfc:	f7ff fb8e 	bl	c0d0131c <pic>
c0d01c00:	4602      	mov	r2, r0
c0d01c02:	7c20      	ldrb	r0, [r4, #16]
c0d01c04:	a901      	add	r1, sp, #4
c0d01c06:	4790      	blx	r2
c0d01c08:	e025      	b.n	c0d01c56 <USBD_GetDescriptor+0xba>
c0d01c0a:	2045      	movs	r0, #69	; 0x45
c0d01c0c:	0080      	lsls	r0, r0, #2
c0d01c0e:	5820      	ldr	r0, [r4, r0]
  case USB_DESC_TYPE_DEVICE:
    pbuf = ((GetDeviceDescriptor_t)PIC(pdev->pDesc->GetDeviceDescriptor))(pdev->dev_speed, &len);
    break;
    
  case USB_DESC_TYPE_CONFIGURATION:     
    if(pdev->dev_speed == USBD_SPEED_HIGH )   
c0d01c10:	7c21      	ldrb	r1, [r4, #16]
c0d01c12:	2900      	cmp	r1, #0
c0d01c14:	d014      	beq.n	c0d01c40 <USBD_GetDescriptor+0xa4>
      pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->pClass->GetHSConfigDescriptor))(&len);
      //pbuf[1] = USB_DESC_TYPE_CONFIGURATION; CONST BUFFER KTHX
    }
    else
    {
      pbuf   = (uint8_t *)((GetFSConfigDescriptor_t)PIC(pdev->pClass->GetFSConfigDescriptor))(&len);
c0d01c16:	6ac0      	ldr	r0, [r0, #44]	; 0x2c
c0d01c18:	e018      	b.n	c0d01c4c <USBD_GetDescriptor+0xb0>
#endif   
    }
    break;
  case USB_DESC_TYPE_DEVICE_QUALIFIER:                   

    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
c0d01c1a:	7c20      	ldrb	r0, [r4, #16]
c0d01c1c:	2800      	cmp	r0, #0
c0d01c1e:	d107      	bne.n	c0d01c30 <USBD_GetDescriptor+0x94>
    {
      pbuf   = (uint8_t *)((GetDeviceQualifierDescriptor_t)PIC(pdev->pClass->GetDeviceQualifierDescriptor))(&len);
c0d01c20:	2045      	movs	r0, #69	; 0x45
c0d01c22:	0080      	lsls	r0, r0, #2
c0d01c24:	5820      	ldr	r0, [r4, r0]
c0d01c26:	6b40      	ldr	r0, [r0, #52]	; 0x34
c0d01c28:	e010      	b.n	c0d01c4c <USBD_GetDescriptor+0xb0>
      USBD_CtlError(pdev , req);
      return;
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
c0d01c2a:	7c20      	ldrb	r0, [r4, #16]
c0d01c2c:	2800      	cmp	r0, #0
c0d01c2e:	d009      	beq.n	c0d01c44 <USBD_GetDescriptor+0xa8>
c0d01c30:	4620      	mov	r0, r4
c0d01c32:	f7ff fd5d 	bl	c0d016f0 <USBD_LL_StallEP>
c0d01c36:	2100      	movs	r1, #0
c0d01c38:	4620      	mov	r0, r4
c0d01c3a:	f7ff fd59 	bl	c0d016f0 <USBD_LL_StallEP>
c0d01c3e:	e01a      	b.n	c0d01c76 <USBD_GetDescriptor+0xda>
    break;
    
  case USB_DESC_TYPE_CONFIGURATION:     
    if(pdev->dev_speed == USBD_SPEED_HIGH )   
    {
      pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->pClass->GetHSConfigDescriptor))(&len);
c0d01c40:	6a80      	ldr	r0, [r0, #40]	; 0x28
c0d01c42:	e003      	b.n	c0d01c4c <USBD_GetDescriptor+0xb0>
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
    {
      pbuf   = (uint8_t *)((GetOtherSpeedConfigDescriptor_t)PIC(pdev->pClass->GetOtherSpeedConfigDescriptor))(&len);
c0d01c44:	2045      	movs	r0, #69	; 0x45
c0d01c46:	0080      	lsls	r0, r0, #2
c0d01c48:	5820      	ldr	r0, [r4, r0]
c0d01c4a:	6b00      	ldr	r0, [r0, #48]	; 0x30
c0d01c4c:	f7ff fb66 	bl	c0d0131c <pic>
c0d01c50:	4601      	mov	r1, r0
c0d01c52:	a801      	add	r0, sp, #4
c0d01c54:	4788      	blx	r1
c0d01c56:	4601      	mov	r1, r0
c0d01c58:	a801      	add	r0, sp, #4
  default: 
     USBD_CtlError(pdev , req);
    return;
  }
  
  if((len != 0)&& (req->wLength != 0))
c0d01c5a:	8802      	ldrh	r2, [r0, #0]
c0d01c5c:	2a00      	cmp	r2, #0
c0d01c5e:	d00a      	beq.n	c0d01c76 <USBD_GetDescriptor+0xda>
c0d01c60:	88e8      	ldrh	r0, [r5, #6]
c0d01c62:	2800      	cmp	r0, #0
c0d01c64:	d007      	beq.n	c0d01c76 <USBD_GetDescriptor+0xda>
  {
    
    len = MIN(len , req->wLength);
c0d01c66:	4282      	cmp	r2, r0
c0d01c68:	d300      	bcc.n	c0d01c6c <USBD_GetDescriptor+0xd0>
c0d01c6a:	4602      	mov	r2, r0
c0d01c6c:	a801      	add	r0, sp, #4
c0d01c6e:	8002      	strh	r2, [r0, #0]
    
    // prepare abort if host does not read the whole data
    //USBD_CtlReceiveStatus(pdev);

    // start transfer
    USBD_CtlSendData (pdev, 
c0d01c70:	4620      	mov	r0, r4
c0d01c72:	f000 faf9 	bl	c0d02268 <USBD_CtlSendData>
                      pbuf,
                      len);
  }
  
}
c0d01c76:	b002      	add	sp, #8
c0d01c78:	bdb0      	pop	{r4, r5, r7, pc}
    case USBD_IDX_LANGID_STR:
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
      break;
      
    case USBD_IDX_MFC_STR:
      pbuf = ((GetManufacturerStrDescriptor_t)PIC(pdev->pDesc->GetManufacturerStrDescriptor))(pdev->dev_speed, &len);
c0d01c7a:	2011      	movs	r0, #17
c0d01c7c:	0100      	lsls	r0, r0, #4
c0d01c7e:	5820      	ldr	r0, [r4, r0]
c0d01c80:	6880      	ldr	r0, [r0, #8]
c0d01c82:	e7bb      	b.n	c0d01bfc <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_PRODUCT_STR:
      pbuf = ((GetProductStrDescriptor_t)PIC(pdev->pDesc->GetProductStrDescriptor))(pdev->dev_speed, &len);
c0d01c84:	2011      	movs	r0, #17
c0d01c86:	0100      	lsls	r0, r0, #4
c0d01c88:	5820      	ldr	r0, [r4, r0]
c0d01c8a:	68c0      	ldr	r0, [r0, #12]
c0d01c8c:	e7b6      	b.n	c0d01bfc <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_SERIAL_STR:
      pbuf = ((GetSerialStrDescriptor_t)PIC(pdev->pDesc->GetSerialStrDescriptor))(pdev->dev_speed, &len);
c0d01c8e:	2011      	movs	r0, #17
c0d01c90:	0100      	lsls	r0, r0, #4
c0d01c92:	5820      	ldr	r0, [r4, r0]
c0d01c94:	6900      	ldr	r0, [r0, #16]
c0d01c96:	e7b1      	b.n	c0d01bfc <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_CONFIG_STR:
      pbuf = ((GetConfigurationStrDescriptor_t)PIC(pdev->pDesc->GetConfigurationStrDescriptor))(pdev->dev_speed, &len);
c0d01c98:	2011      	movs	r0, #17
c0d01c9a:	0100      	lsls	r0, r0, #4
c0d01c9c:	5820      	ldr	r0, [r4, r0]
c0d01c9e:	6940      	ldr	r0, [r0, #20]
c0d01ca0:	e7ac      	b.n	c0d01bfc <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_INTERFACE_STR:
      pbuf = ((GetInterfaceStrDescriptor_t)PIC(pdev->pDesc->GetInterfaceStrDescriptor))(pdev->dev_speed, &len);
c0d01ca2:	2011      	movs	r0, #17
c0d01ca4:	0100      	lsls	r0, r0, #4
c0d01ca6:	5820      	ldr	r0, [r4, r0]
c0d01ca8:	6980      	ldr	r0, [r0, #24]
c0d01caa:	e7a7      	b.n	c0d01bfc <USBD_GetDescriptor+0x60>

c0d01cac <USBD_SetAddress>:
* @param  req: usb request
* @retval status
*/
void USBD_SetAddress(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d01cac:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01cae:	af03      	add	r7, sp, #12
c0d01cb0:	b081      	sub	sp, #4
c0d01cb2:	460a      	mov	r2, r1
c0d01cb4:	4604      	mov	r4, r0
  uint8_t  dev_addr; 
  
  if ((req->wIndex == 0) && (req->wLength == 0)) 
c0d01cb6:	8890      	ldrh	r0, [r2, #4]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d01cb8:	2180      	movs	r1, #128	; 0x80
void USBD_SetAddress(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
  uint8_t  dev_addr; 
  
  if ((req->wIndex == 0) && (req->wLength == 0)) 
c0d01cba:	2800      	cmp	r0, #0
c0d01cbc:	d10b      	bne.n	c0d01cd6 <USBD_SetAddress+0x2a>
c0d01cbe:	88d0      	ldrh	r0, [r2, #6]
c0d01cc0:	2800      	cmp	r0, #0
c0d01cc2:	d108      	bne.n	c0d01cd6 <USBD_SetAddress+0x2a>
  {
    dev_addr = (uint8_t)(req->wValue) & 0x7F;     
c0d01cc4:	8850      	ldrh	r0, [r2, #2]
c0d01cc6:	267f      	movs	r6, #127	; 0x7f
c0d01cc8:	4006      	ands	r6, r0
    
    if (pdev->dev_state == USBD_STATE_CONFIGURED) 
c0d01cca:	20fc      	movs	r0, #252	; 0xfc
c0d01ccc:	5c20      	ldrb	r0, [r4, r0]
c0d01cce:	4625      	mov	r5, r4
c0d01cd0:	35fc      	adds	r5, #252	; 0xfc
c0d01cd2:	2803      	cmp	r0, #3
c0d01cd4:	d108      	bne.n	c0d01ce8 <USBD_SetAddress+0x3c>
c0d01cd6:	4620      	mov	r0, r4
c0d01cd8:	f7ff fd0a 	bl	c0d016f0 <USBD_LL_StallEP>
c0d01cdc:	2100      	movs	r1, #0
c0d01cde:	4620      	mov	r0, r4
c0d01ce0:	f7ff fd06 	bl	c0d016f0 <USBD_LL_StallEP>
  } 
  else 
  {
     USBD_CtlError(pdev , req);                        
  } 
}
c0d01ce4:	b001      	add	sp, #4
c0d01ce6:	bdf0      	pop	{r4, r5, r6, r7, pc}
    {
      USBD_CtlError(pdev , req);
    } 
    else 
    {
      pdev->dev_address = dev_addr;
c0d01ce8:	20fe      	movs	r0, #254	; 0xfe
c0d01cea:	5426      	strb	r6, [r4, r0]
      USBD_LL_SetUSBAddress(pdev, dev_addr);               
c0d01cec:	b2f1      	uxtb	r1, r6
c0d01cee:	4620      	mov	r0, r4
c0d01cf0:	f7ff fd5c 	bl	c0d017ac <USBD_LL_SetUSBAddress>
      USBD_CtlSendStatus(pdev);                         
c0d01cf4:	4620      	mov	r0, r4
c0d01cf6:	f000 fae5 	bl	c0d022c4 <USBD_CtlSendStatus>
      
      if (dev_addr != 0) 
c0d01cfa:	2002      	movs	r0, #2
c0d01cfc:	2101      	movs	r1, #1
c0d01cfe:	2e00      	cmp	r6, #0
c0d01d00:	d100      	bne.n	c0d01d04 <USBD_SetAddress+0x58>
c0d01d02:	4608      	mov	r0, r1
c0d01d04:	7028      	strb	r0, [r5, #0]
c0d01d06:	e7ed      	b.n	c0d01ce4 <USBD_SetAddress+0x38>

c0d01d08 <USBD_SetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_SetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d01d08:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01d0a:	af03      	add	r7, sp, #12
c0d01d0c:	b081      	sub	sp, #4
c0d01d0e:	4604      	mov	r4, r0
  
  uint8_t  cfgidx;
  
  cfgidx = (uint8_t)(req->wValue);                 
c0d01d10:	788e      	ldrb	r6, [r1, #2]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d01d12:	2580      	movs	r5, #128	; 0x80
  
  uint8_t  cfgidx;
  
  cfgidx = (uint8_t)(req->wValue);                 
  
  if (cfgidx > USBD_MAX_NUM_CONFIGURATION ) 
c0d01d14:	2e02      	cmp	r6, #2
c0d01d16:	d21d      	bcs.n	c0d01d54 <USBD_SetConfig+0x4c>
  {            
     USBD_CtlError(pdev , req);                              
  } 
  else 
  {
    switch (pdev->dev_state) 
c0d01d18:	20fc      	movs	r0, #252	; 0xfc
c0d01d1a:	5c21      	ldrb	r1, [r4, r0]
c0d01d1c:	4620      	mov	r0, r4
c0d01d1e:	30fc      	adds	r0, #252	; 0xfc
c0d01d20:	2903      	cmp	r1, #3
c0d01d22:	d007      	beq.n	c0d01d34 <USBD_SetConfig+0x2c>
c0d01d24:	2902      	cmp	r1, #2
c0d01d26:	d115      	bne.n	c0d01d54 <USBD_SetConfig+0x4c>
    {
    case USBD_STATE_ADDRESSED:
      if (cfgidx) 
c0d01d28:	2e00      	cmp	r6, #0
c0d01d2a:	d026      	beq.n	c0d01d7a <USBD_SetConfig+0x72>
      {                                			   							   							   				
        pdev->dev_config = cfgidx;
c0d01d2c:	6066      	str	r6, [r4, #4]
        pdev->dev_state = USBD_STATE_CONFIGURED;
c0d01d2e:	2103      	movs	r1, #3
c0d01d30:	7001      	strb	r1, [r0, #0]
c0d01d32:	e009      	b.n	c0d01d48 <USBD_SetConfig+0x40>
      }
      USBD_CtlSendStatus(pdev);
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
c0d01d34:	2e00      	cmp	r6, #0
c0d01d36:	d016      	beq.n	c0d01d66 <USBD_SetConfig+0x5e>
        pdev->dev_state = USBD_STATE_ADDRESSED;
        pdev->dev_config = cfgidx;          
        USBD_ClrClassConfig(pdev , cfgidx);
        USBD_CtlSendStatus(pdev);
      } 
      else  if (cfgidx != pdev->dev_config) 
c0d01d38:	6860      	ldr	r0, [r4, #4]
c0d01d3a:	4286      	cmp	r6, r0
c0d01d3c:	d01d      	beq.n	c0d01d7a <USBD_SetConfig+0x72>
      {
        /* Clear old configuration */
        USBD_ClrClassConfig(pdev , pdev->dev_config);
c0d01d3e:	b2c1      	uxtb	r1, r0
c0d01d40:	4620      	mov	r0, r4
c0d01d42:	f7ff fdd3 	bl	c0d018ec <USBD_ClrClassConfig>
        
        /* set new configuration */
        pdev->dev_config = cfgidx;
c0d01d46:	6066      	str	r6, [r4, #4]
c0d01d48:	4620      	mov	r0, r4
c0d01d4a:	4631      	mov	r1, r6
c0d01d4c:	f7ff fdb6 	bl	c0d018bc <USBD_SetClassConfig>
c0d01d50:	2802      	cmp	r0, #2
c0d01d52:	d112      	bne.n	c0d01d7a <USBD_SetConfig+0x72>
c0d01d54:	4620      	mov	r0, r4
c0d01d56:	4629      	mov	r1, r5
c0d01d58:	f7ff fcca 	bl	c0d016f0 <USBD_LL_StallEP>
c0d01d5c:	2100      	movs	r1, #0
c0d01d5e:	4620      	mov	r0, r4
c0d01d60:	f7ff fcc6 	bl	c0d016f0 <USBD_LL_StallEP>
c0d01d64:	e00c      	b.n	c0d01d80 <USBD_SetConfig+0x78>
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
      {                           
        pdev->dev_state = USBD_STATE_ADDRESSED;
c0d01d66:	2102      	movs	r1, #2
c0d01d68:	7001      	strb	r1, [r0, #0]
        pdev->dev_config = cfgidx;          
c0d01d6a:	6066      	str	r6, [r4, #4]
        USBD_ClrClassConfig(pdev , cfgidx);
c0d01d6c:	4620      	mov	r0, r4
c0d01d6e:	4631      	mov	r1, r6
c0d01d70:	f7ff fdbc 	bl	c0d018ec <USBD_ClrClassConfig>
        USBD_CtlSendStatus(pdev);
c0d01d74:	4620      	mov	r0, r4
c0d01d76:	f000 faa5 	bl	c0d022c4 <USBD_CtlSendStatus>
c0d01d7a:	4620      	mov	r0, r4
c0d01d7c:	f000 faa2 	bl	c0d022c4 <USBD_CtlSendStatus>
    default:					
       USBD_CtlError(pdev , req);                     
      break;
    }
  }
}
c0d01d80:	b001      	add	sp, #4
c0d01d82:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d01d84 <USBD_GetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_GetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d01d84:	b5d0      	push	{r4, r6, r7, lr}
c0d01d86:	af02      	add	r7, sp, #8
c0d01d88:	4604      	mov	r4, r0

  if (req->wLength != 1) 
c0d01d8a:	88c8      	ldrh	r0, [r1, #6]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d01d8c:	2180      	movs	r1, #128	; 0x80
*/
void USBD_GetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{

  if (req->wLength != 1) 
c0d01d8e:	2801      	cmp	r0, #1
c0d01d90:	d10a      	bne.n	c0d01da8 <USBD_GetConfig+0x24>
  {                   
     USBD_CtlError(pdev , req);
  }
  else 
  {
    switch (pdev->dev_state )  
c0d01d92:	20fc      	movs	r0, #252	; 0xfc
c0d01d94:	5c20      	ldrb	r0, [r4, r0]
c0d01d96:	2803      	cmp	r0, #3
c0d01d98:	d00e      	beq.n	c0d01db8 <USBD_GetConfig+0x34>
c0d01d9a:	2802      	cmp	r0, #2
c0d01d9c:	d104      	bne.n	c0d01da8 <USBD_GetConfig+0x24>
    {
    case USBD_STATE_ADDRESSED:                     
      pdev->dev_default_config = 0;
c0d01d9e:	2000      	movs	r0, #0
c0d01da0:	60a0      	str	r0, [r4, #8]
c0d01da2:	4621      	mov	r1, r4
c0d01da4:	3108      	adds	r1, #8
c0d01da6:	e008      	b.n	c0d01dba <USBD_GetConfig+0x36>
c0d01da8:	4620      	mov	r0, r4
c0d01daa:	f7ff fca1 	bl	c0d016f0 <USBD_LL_StallEP>
c0d01dae:	2100      	movs	r1, #0
c0d01db0:	4620      	mov	r0, r4
c0d01db2:	f7ff fc9d 	bl	c0d016f0 <USBD_LL_StallEP>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d01db6:	bdd0      	pop	{r4, r6, r7, pc}
                        1);
      break;
      
    case USBD_STATE_CONFIGURED:   
      USBD_CtlSendData (pdev, 
                        (uint8_t *)&pdev->dev_config,
c0d01db8:	1d21      	adds	r1, r4, #4
c0d01dba:	2201      	movs	r2, #1
c0d01dbc:	4620      	mov	r0, r4
c0d01dbe:	f000 fa53 	bl	c0d02268 <USBD_CtlSendData>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d01dc2:	bdd0      	pop	{r4, r6, r7, pc}

c0d01dc4 <USBD_GetStatus>:
* @param  req: usb request
* @retval status
*/
void USBD_GetStatus(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d01dc4:	b5b0      	push	{r4, r5, r7, lr}
c0d01dc6:	af02      	add	r7, sp, #8
c0d01dc8:	4604      	mov	r4, r0
  
    
  switch (pdev->dev_state) 
c0d01dca:	20fc      	movs	r0, #252	; 0xfc
c0d01dcc:	5c20      	ldrb	r0, [r4, r0]
c0d01dce:	21fe      	movs	r1, #254	; 0xfe
c0d01dd0:	4001      	ands	r1, r0
c0d01dd2:	2902      	cmp	r1, #2
c0d01dd4:	d116      	bne.n	c0d01e04 <USBD_GetStatus+0x40>
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d01dd6:	2001      	movs	r0, #1
c0d01dd8:	60e0      	str	r0, [r4, #12]
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d01dda:	2041      	movs	r0, #65	; 0x41
c0d01ddc:	0080      	lsls	r0, r0, #2
c0d01dde:	5821      	ldr	r1, [r4, r0]
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d01de0:	4625      	mov	r5, r4
c0d01de2:	350c      	adds	r5, #12
c0d01de4:	2003      	movs	r0, #3
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d01de6:	2900      	cmp	r1, #0
c0d01de8:	d005      	beq.n	c0d01df6 <USBD_GetStatus+0x32>
c0d01dea:	4620      	mov	r0, r4
c0d01dec:	f000 fa77 	bl	c0d022de <USBD_CtlReceiveStatus>
c0d01df0:	68e1      	ldr	r1, [r4, #12]
c0d01df2:	2002      	movs	r0, #2
c0d01df4:	4308      	orrs	r0, r1
    {
       pdev->dev_config_status |= USB_CONFIG_REMOTE_WAKEUP;                                
c0d01df6:	60e0      	str	r0, [r4, #12]
    }
    
    USBD_CtlSendData (pdev, 
c0d01df8:	2202      	movs	r2, #2
c0d01dfa:	4620      	mov	r0, r4
c0d01dfc:	4629      	mov	r1, r5
c0d01dfe:	f000 fa33 	bl	c0d02268 <USBD_CtlSendData>
    
  default :
    USBD_CtlError(pdev , req);                        
    break;
  }
}
c0d01e02:	bdb0      	pop	{r4, r5, r7, pc}

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d01e04:	2180      	movs	r1, #128	; 0x80
c0d01e06:	4620      	mov	r0, r4
c0d01e08:	f7ff fc72 	bl	c0d016f0 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d01e0c:	2100      	movs	r1, #0
c0d01e0e:	4620      	mov	r0, r4
c0d01e10:	f7ff fc6e 	bl	c0d016f0 <USBD_LL_StallEP>
    
  default :
    USBD_CtlError(pdev , req);                        
    break;
  }
}
c0d01e14:	bdb0      	pop	{r4, r5, r7, pc}

c0d01e16 <USBD_SetFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_SetFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d01e16:	b5b0      	push	{r4, r5, r7, lr}
c0d01e18:	af02      	add	r7, sp, #8
c0d01e1a:	460d      	mov	r5, r1
c0d01e1c:	4604      	mov	r4, r0

  if (req->wValue == USB_FEATURE_REMOTE_WAKEUP)
c0d01e1e:	8868      	ldrh	r0, [r5, #2]
c0d01e20:	2801      	cmp	r0, #1
c0d01e22:	d110      	bne.n	c0d01e46 <USBD_SetFeature+0x30>
  {
    pdev->dev_remote_wakeup = 1;  
c0d01e24:	2041      	movs	r0, #65	; 0x41
c0d01e26:	0080      	lsls	r0, r0, #2
c0d01e28:	2101      	movs	r1, #1
c0d01e2a:	5021      	str	r1, [r4, r0]
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);   
c0d01e2c:	2045      	movs	r0, #69	; 0x45
c0d01e2e:	0080      	lsls	r0, r0, #2
c0d01e30:	5820      	ldr	r0, [r4, r0]
c0d01e32:	6880      	ldr	r0, [r0, #8]
c0d01e34:	f7ff fa72 	bl	c0d0131c <pic>
c0d01e38:	4602      	mov	r2, r0
c0d01e3a:	4620      	mov	r0, r4
c0d01e3c:	4629      	mov	r1, r5
c0d01e3e:	4790      	blx	r2
    USBD_CtlSendStatus(pdev);
c0d01e40:	4620      	mov	r0, r4
c0d01e42:	f000 fa3f 	bl	c0d022c4 <USBD_CtlSendStatus>
  }

}
c0d01e46:	bdb0      	pop	{r4, r5, r7, pc}

c0d01e48 <USBD_ClrFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_ClrFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d01e48:	b5b0      	push	{r4, r5, r7, lr}
c0d01e4a:	af02      	add	r7, sp, #8
c0d01e4c:	460d      	mov	r5, r1
c0d01e4e:	4604      	mov	r4, r0
  switch (pdev->dev_state)
c0d01e50:	20fc      	movs	r0, #252	; 0xfc
c0d01e52:	5c20      	ldrb	r0, [r4, r0]
c0d01e54:	21fe      	movs	r1, #254	; 0xfe
c0d01e56:	4001      	ands	r1, r0
c0d01e58:	2902      	cmp	r1, #2
c0d01e5a:	d114      	bne.n	c0d01e86 <USBD_ClrFeature+0x3e>
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    if (req->wValue == USB_FEATURE_REMOTE_WAKEUP) 
c0d01e5c:	8868      	ldrh	r0, [r5, #2]
c0d01e5e:	2801      	cmp	r0, #1
c0d01e60:	d119      	bne.n	c0d01e96 <USBD_ClrFeature+0x4e>
    {
      pdev->dev_remote_wakeup = 0; 
c0d01e62:	2041      	movs	r0, #65	; 0x41
c0d01e64:	0080      	lsls	r0, r0, #2
c0d01e66:	2100      	movs	r1, #0
c0d01e68:	5021      	str	r1, [r4, r0]
      ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);   
c0d01e6a:	2045      	movs	r0, #69	; 0x45
c0d01e6c:	0080      	lsls	r0, r0, #2
c0d01e6e:	5820      	ldr	r0, [r4, r0]
c0d01e70:	6880      	ldr	r0, [r0, #8]
c0d01e72:	f7ff fa53 	bl	c0d0131c <pic>
c0d01e76:	4602      	mov	r2, r0
c0d01e78:	4620      	mov	r0, r4
c0d01e7a:	4629      	mov	r1, r5
c0d01e7c:	4790      	blx	r2
      USBD_CtlSendStatus(pdev);
c0d01e7e:	4620      	mov	r0, r4
c0d01e80:	f000 fa20 	bl	c0d022c4 <USBD_CtlSendStatus>
    
  default :
     USBD_CtlError(pdev , req);
    break;
  }
}
c0d01e84:	bdb0      	pop	{r4, r5, r7, pc}

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d01e86:	2180      	movs	r1, #128	; 0x80
c0d01e88:	4620      	mov	r0, r4
c0d01e8a:	f7ff fc31 	bl	c0d016f0 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d01e8e:	2100      	movs	r1, #0
c0d01e90:	4620      	mov	r0, r4
c0d01e92:	f7ff fc2d 	bl	c0d016f0 <USBD_LL_StallEP>
    
  default :
     USBD_CtlError(pdev , req);
    break;
  }
}
c0d01e96:	bdb0      	pop	{r4, r5, r7, pc}

c0d01e98 <USBD_CtlError>:
* @retval None
*/

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
c0d01e98:	b5d0      	push	{r4, r6, r7, lr}
c0d01e9a:	af02      	add	r7, sp, #8
c0d01e9c:	4604      	mov	r4, r0
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d01e9e:	2180      	movs	r1, #128	; 0x80
c0d01ea0:	f7ff fc26 	bl	c0d016f0 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d01ea4:	2100      	movs	r1, #0
c0d01ea6:	4620      	mov	r0, r4
c0d01ea8:	f7ff fc22 	bl	c0d016f0 <USBD_LL_StallEP>
}
c0d01eac:	bdd0      	pop	{r4, r6, r7, pc}

c0d01eae <USBD_StdItfReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdItfReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d01eae:	b5b0      	push	{r4, r5, r7, lr}
c0d01eb0:	af02      	add	r7, sp, #8
c0d01eb2:	460d      	mov	r5, r1
c0d01eb4:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK; 
  
  switch (pdev->dev_state) 
c0d01eb6:	20fc      	movs	r0, #252	; 0xfc
c0d01eb8:	5c20      	ldrb	r0, [r4, r0]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d01eba:	2180      	movs	r1, #128	; 0x80
*/
USBD_StatusTypeDef  USBD_StdItfReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
  USBD_StatusTypeDef ret = USBD_OK; 
  
  switch (pdev->dev_state) 
c0d01ebc:	2803      	cmp	r0, #3
c0d01ebe:	d115      	bne.n	c0d01eec <USBD_StdItfReq+0x3e>
  {
  case USBD_STATE_CONFIGURED:
    
    if (LOBYTE(req->wIndex) <= USBD_MAX_NUM_INTERFACES) 
c0d01ec0:	88a8      	ldrh	r0, [r5, #4]
c0d01ec2:	22fe      	movs	r2, #254	; 0xfe
c0d01ec4:	4002      	ands	r2, r0
c0d01ec6:	2a01      	cmp	r2, #1
c0d01ec8:	d810      	bhi.n	c0d01eec <USBD_StdItfReq+0x3e>
    {
      ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req); 
c0d01eca:	2045      	movs	r0, #69	; 0x45
c0d01ecc:	0080      	lsls	r0, r0, #2
c0d01ece:	5820      	ldr	r0, [r4, r0]
c0d01ed0:	6880      	ldr	r0, [r0, #8]
c0d01ed2:	f7ff fa23 	bl	c0d0131c <pic>
c0d01ed6:	4602      	mov	r2, r0
c0d01ed8:	4620      	mov	r0, r4
c0d01eda:	4629      	mov	r1, r5
c0d01edc:	4790      	blx	r2
      
      if((req->wLength == 0)&& (ret == USBD_OK))
c0d01ede:	88e8      	ldrh	r0, [r5, #6]
c0d01ee0:	2800      	cmp	r0, #0
c0d01ee2:	d10a      	bne.n	c0d01efa <USBD_StdItfReq+0x4c>
      {
         USBD_CtlSendStatus(pdev);
c0d01ee4:	4620      	mov	r0, r4
c0d01ee6:	f000 f9ed 	bl	c0d022c4 <USBD_CtlSendStatus>
c0d01eea:	e006      	b.n	c0d01efa <USBD_StdItfReq+0x4c>
c0d01eec:	4620      	mov	r0, r4
c0d01eee:	f7ff fbff 	bl	c0d016f0 <USBD_LL_StallEP>
c0d01ef2:	2100      	movs	r1, #0
c0d01ef4:	4620      	mov	r0, r4
c0d01ef6:	f7ff fbfb 	bl	c0d016f0 <USBD_LL_StallEP>
    
  default:
     USBD_CtlError(pdev , req);
    break;
  }
  return USBD_OK;
c0d01efa:	2000      	movs	r0, #0
c0d01efc:	bdb0      	pop	{r4, r5, r7, pc}

c0d01efe <USBD_StdEPReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdEPReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d01efe:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01f00:	af03      	add	r7, sp, #12
c0d01f02:	b081      	sub	sp, #4
c0d01f04:	460e      	mov	r6, r1
c0d01f06:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
  
  /* Check if it is a class request */
  if ((req->bmRequest & 0x60) == 0x20)
c0d01f08:	7830      	ldrb	r0, [r6, #0]
c0d01f0a:	2160      	movs	r1, #96	; 0x60
c0d01f0c:	4001      	ands	r1, r0
c0d01f0e:	2920      	cmp	r1, #32
c0d01f10:	d10a      	bne.n	c0d01f28 <USBD_StdEPReq+0x2a>
  {
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
c0d01f12:	2045      	movs	r0, #69	; 0x45
c0d01f14:	0080      	lsls	r0, r0, #2
c0d01f16:	5820      	ldr	r0, [r4, r0]
c0d01f18:	6880      	ldr	r0, [r0, #8]
c0d01f1a:	f7ff f9ff 	bl	c0d0131c <pic>
c0d01f1e:	4602      	mov	r2, r0
c0d01f20:	4620      	mov	r0, r4
c0d01f22:	4631      	mov	r1, r6
c0d01f24:	4790      	blx	r2
c0d01f26:	e063      	b.n	c0d01ff0 <USBD_StdEPReq+0xf2>
{
  
  uint8_t   ep_addr;
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
c0d01f28:	7935      	ldrb	r5, [r6, #4]
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
    
    return USBD_OK;
  }
  
  switch (req->bRequest) 
c0d01f2a:	7870      	ldrb	r0, [r6, #1]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d01f2c:	2180      	movs	r1, #128	; 0x80
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
    
    return USBD_OK;
  }
  
  switch (req->bRequest) 
c0d01f2e:	2800      	cmp	r0, #0
c0d01f30:	d012      	beq.n	c0d01f58 <USBD_StdEPReq+0x5a>
c0d01f32:	2801      	cmp	r0, #1
c0d01f34:	d019      	beq.n	c0d01f6a <USBD_StdEPReq+0x6c>
c0d01f36:	2803      	cmp	r0, #3
c0d01f38:	d15a      	bne.n	c0d01ff0 <USBD_StdEPReq+0xf2>
  {
    
  case USB_REQ_SET_FEATURE :
    
    switch (pdev->dev_state) 
c0d01f3a:	20fc      	movs	r0, #252	; 0xfc
c0d01f3c:	5c20      	ldrb	r0, [r4, r0]
c0d01f3e:	2803      	cmp	r0, #3
c0d01f40:	d117      	bne.n	c0d01f72 <USBD_StdEPReq+0x74>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:   
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d01f42:	8870      	ldrh	r0, [r6, #2]
c0d01f44:	2800      	cmp	r0, #0
c0d01f46:	d12d      	bne.n	c0d01fa4 <USBD_StdEPReq+0xa6>
      {
        if ((ep_addr != 0x00) && (ep_addr != 0x80)) 
c0d01f48:	4329      	orrs	r1, r5
c0d01f4a:	2980      	cmp	r1, #128	; 0x80
c0d01f4c:	d02a      	beq.n	c0d01fa4 <USBD_StdEPReq+0xa6>
        { 
          USBD_LL_StallEP(pdev , ep_addr);
c0d01f4e:	4620      	mov	r0, r4
c0d01f50:	4629      	mov	r1, r5
c0d01f52:	f7ff fbcd 	bl	c0d016f0 <USBD_LL_StallEP>
c0d01f56:	e025      	b.n	c0d01fa4 <USBD_StdEPReq+0xa6>
      break;    
    }
    break;
    
  case USB_REQ_GET_STATUS:                  
    switch (pdev->dev_state) 
c0d01f58:	20fc      	movs	r0, #252	; 0xfc
c0d01f5a:	5c20      	ldrb	r0, [r4, r0]
c0d01f5c:	2803      	cmp	r0, #3
c0d01f5e:	d02f      	beq.n	c0d01fc0 <USBD_StdEPReq+0xc2>
c0d01f60:	2802      	cmp	r0, #2
c0d01f62:	d10e      	bne.n	c0d01f82 <USBD_StdEPReq+0x84>
    {
    case USBD_STATE_ADDRESSED:          
      if ((ep_addr & 0x7F) != 0x00) 
c0d01f64:	0668      	lsls	r0, r5, #25
c0d01f66:	d109      	bne.n	c0d01f7c <USBD_StdEPReq+0x7e>
c0d01f68:	e042      	b.n	c0d01ff0 <USBD_StdEPReq+0xf2>
    }
    break;
    
  case USB_REQ_CLEAR_FEATURE :
    
    switch (pdev->dev_state) 
c0d01f6a:	20fc      	movs	r0, #252	; 0xfc
c0d01f6c:	5c20      	ldrb	r0, [r4, r0]
c0d01f6e:	2803      	cmp	r0, #3
c0d01f70:	d00f      	beq.n	c0d01f92 <USBD_StdEPReq+0x94>
c0d01f72:	2802      	cmp	r0, #2
c0d01f74:	d105      	bne.n	c0d01f82 <USBD_StdEPReq+0x84>
c0d01f76:	4329      	orrs	r1, r5
c0d01f78:	2980      	cmp	r1, #128	; 0x80
c0d01f7a:	d039      	beq.n	c0d01ff0 <USBD_StdEPReq+0xf2>
c0d01f7c:	4620      	mov	r0, r4
c0d01f7e:	4629      	mov	r1, r5
c0d01f80:	e004      	b.n	c0d01f8c <USBD_StdEPReq+0x8e>
c0d01f82:	4620      	mov	r0, r4
c0d01f84:	f7ff fbb4 	bl	c0d016f0 <USBD_LL_StallEP>
c0d01f88:	2100      	movs	r1, #0
c0d01f8a:	4620      	mov	r0, r4
c0d01f8c:	f7ff fbb0 	bl	c0d016f0 <USBD_LL_StallEP>
c0d01f90:	e02e      	b.n	c0d01ff0 <USBD_StdEPReq+0xf2>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:   
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d01f92:	8870      	ldrh	r0, [r6, #2]
c0d01f94:	2800      	cmp	r0, #0
c0d01f96:	d12b      	bne.n	c0d01ff0 <USBD_StdEPReq+0xf2>
      {
        if ((ep_addr & 0x7F) != 0x00) 
c0d01f98:	0668      	lsls	r0, r5, #25
c0d01f9a:	d00d      	beq.n	c0d01fb8 <USBD_StdEPReq+0xba>
        {        
          USBD_LL_ClearStallEP(pdev , ep_addr);
c0d01f9c:	4620      	mov	r0, r4
c0d01f9e:	4629      	mov	r1, r5
c0d01fa0:	f7ff fbcc 	bl	c0d0173c <USBD_LL_ClearStallEP>
c0d01fa4:	2045      	movs	r0, #69	; 0x45
c0d01fa6:	0080      	lsls	r0, r0, #2
c0d01fa8:	5820      	ldr	r0, [r4, r0]
c0d01faa:	6880      	ldr	r0, [r0, #8]
c0d01fac:	f7ff f9b6 	bl	c0d0131c <pic>
c0d01fb0:	4602      	mov	r2, r0
c0d01fb2:	4620      	mov	r0, r4
c0d01fb4:	4631      	mov	r1, r6
c0d01fb6:	4790      	blx	r2
c0d01fb8:	4620      	mov	r0, r4
c0d01fba:	f000 f983 	bl	c0d022c4 <USBD_CtlSendStatus>
c0d01fbe:	e017      	b.n	c0d01ff0 <USBD_StdEPReq+0xf2>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:
      pep = ((ep_addr & 0x80) == 0x80) ? &pdev->ep_in[ep_addr & 0x7F]:\
c0d01fc0:	4626      	mov	r6, r4
c0d01fc2:	3614      	adds	r6, #20
                                         &pdev->ep_out[ep_addr & 0x7F];
c0d01fc4:	4620      	mov	r0, r4
c0d01fc6:	3084      	adds	r0, #132	; 0x84
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:
      pep = ((ep_addr & 0x80) == 0x80) ? &pdev->ep_in[ep_addr & 0x7F]:\
c0d01fc8:	420d      	tst	r5, r1
c0d01fca:	d100      	bne.n	c0d01fce <USBD_StdEPReq+0xd0>
c0d01fcc:	4606      	mov	r6, r0
                                         &pdev->ep_out[ep_addr & 0x7F];
      if(USBD_LL_IsStallEP(pdev, ep_addr))
c0d01fce:	4620      	mov	r0, r4
c0d01fd0:	4629      	mov	r1, r5
c0d01fd2:	f7ff fbd9 	bl	c0d01788 <USBD_LL_IsStallEP>
c0d01fd6:	2101      	movs	r1, #1
c0d01fd8:	2800      	cmp	r0, #0
c0d01fda:	d100      	bne.n	c0d01fde <USBD_StdEPReq+0xe0>
c0d01fdc:	4601      	mov	r1, r0
c0d01fde:	207f      	movs	r0, #127	; 0x7f
c0d01fe0:	4005      	ands	r5, r0
c0d01fe2:	0128      	lsls	r0, r5, #4
c0d01fe4:	5031      	str	r1, [r6, r0]
c0d01fe6:	1831      	adds	r1, r6, r0
      else
      {
        pep->status = 0x0000;  
      }
      
      USBD_CtlSendData (pdev,
c0d01fe8:	2202      	movs	r2, #2
c0d01fea:	4620      	mov	r0, r4
c0d01fec:	f000 f93c 	bl	c0d02268 <USBD_CtlSendData>
    
  default:
    break;
  }
  return ret;
}
c0d01ff0:	2000      	movs	r0, #0
c0d01ff2:	b001      	add	sp, #4
c0d01ff4:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d01ff6 <USBD_ParseSetupRequest>:
* @retval None
*/

void USBD_ParseSetupRequest(USBD_SetupReqTypedef *req, uint8_t *pdata)
{
  req->bmRequest     = *(uint8_t *)  (pdata);
c0d01ff6:	780a      	ldrb	r2, [r1, #0]
c0d01ff8:	7002      	strb	r2, [r0, #0]
  req->bRequest      = *(uint8_t *)  (pdata +  1);
c0d01ffa:	784a      	ldrb	r2, [r1, #1]
c0d01ffc:	7042      	strb	r2, [r0, #1]
  req->wValue        = SWAPBYTE      (pdata +  2);
c0d01ffe:	788a      	ldrb	r2, [r1, #2]
c0d02000:	78cb      	ldrb	r3, [r1, #3]
c0d02002:	021b      	lsls	r3, r3, #8
c0d02004:	4313      	orrs	r3, r2
c0d02006:	8043      	strh	r3, [r0, #2]
  req->wIndex        = SWAPBYTE      (pdata +  4);
c0d02008:	790a      	ldrb	r2, [r1, #4]
c0d0200a:	794b      	ldrb	r3, [r1, #5]
c0d0200c:	021b      	lsls	r3, r3, #8
c0d0200e:	4313      	orrs	r3, r2
c0d02010:	8083      	strh	r3, [r0, #4]
  req->wLength       = SWAPBYTE      (pdata +  6);
c0d02012:	798a      	ldrb	r2, [r1, #6]
c0d02014:	79c9      	ldrb	r1, [r1, #7]
c0d02016:	0209      	lsls	r1, r1, #8
c0d02018:	4311      	orrs	r1, r2
c0d0201a:	80c1      	strh	r1, [r0, #6]

}
c0d0201c:	4770      	bx	lr

c0d0201e <USBD_HID_Setup>:
  * @param  req: usb requests
  * @retval status
  */
uint8_t  USBD_HID_Setup (USBD_HandleTypeDef *pdev, 
                                USBD_SetupReqTypedef *req)
{
c0d0201e:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02020:	af03      	add	r7, sp, #12
c0d02022:	b083      	sub	sp, #12
c0d02024:	460d      	mov	r5, r1
c0d02026:	4604      	mov	r4, r0
c0d02028:	a802      	add	r0, sp, #8
c0d0202a:	2600      	movs	r6, #0
  uint16_t len = 0;
c0d0202c:	8006      	strh	r6, [r0, #0]
c0d0202e:	a801      	add	r0, sp, #4
  uint8_t  *pbuf = NULL;

  uint8_t val = 0;
c0d02030:	7006      	strb	r6, [r0, #0]

  switch (req->bmRequest & USB_REQ_TYPE_MASK)
c0d02032:	7829      	ldrb	r1, [r5, #0]
c0d02034:	2060      	movs	r0, #96	; 0x60
c0d02036:	4008      	ands	r0, r1
c0d02038:	2800      	cmp	r0, #0
c0d0203a:	d010      	beq.n	c0d0205e <USBD_HID_Setup+0x40>
c0d0203c:	2820      	cmp	r0, #32
c0d0203e:	d139      	bne.n	c0d020b4 <USBD_HID_Setup+0x96>
c0d02040:	7868      	ldrb	r0, [r5, #1]
  {
  case USB_REQ_TYPE_CLASS :  
    switch (req->bRequest)
c0d02042:	4601      	mov	r1, r0
c0d02044:	390a      	subs	r1, #10
c0d02046:	2902      	cmp	r1, #2
c0d02048:	d334      	bcc.n	c0d020b4 <USBD_HID_Setup+0x96>
c0d0204a:	2802      	cmp	r0, #2
c0d0204c:	d01c      	beq.n	c0d02088 <USBD_HID_Setup+0x6a>
c0d0204e:	2803      	cmp	r0, #3
c0d02050:	d01a      	beq.n	c0d02088 <USBD_HID_Setup+0x6a>
                        (uint8_t *)&val,
                        1);      
      break;      
      
    default:
      USBD_CtlError (pdev, req);
c0d02052:	4620      	mov	r0, r4
c0d02054:	4629      	mov	r1, r5
c0d02056:	f7ff ff1f 	bl	c0d01e98 <USBD_CtlError>
c0d0205a:	2602      	movs	r6, #2
c0d0205c:	e02a      	b.n	c0d020b4 <USBD_HID_Setup+0x96>
      return USBD_FAIL; 
    }
    break;
    
  case USB_REQ_TYPE_STANDARD:
    switch (req->bRequest)
c0d0205e:	7868      	ldrb	r0, [r5, #1]
c0d02060:	280b      	cmp	r0, #11
c0d02062:	d014      	beq.n	c0d0208e <USBD_HID_Setup+0x70>
c0d02064:	280a      	cmp	r0, #10
c0d02066:	d00f      	beq.n	c0d02088 <USBD_HID_Setup+0x6a>
c0d02068:	2806      	cmp	r0, #6
c0d0206a:	d123      	bne.n	c0d020b4 <USBD_HID_Setup+0x96>
    {
    case USB_REQ_GET_DESCRIPTOR: 
      // 0x22
      if( req->wValue >> 8 == HID_REPORT_DESC)
c0d0206c:	8868      	ldrh	r0, [r5, #2]
c0d0206e:	0a00      	lsrs	r0, r0, #8
c0d02070:	2600      	movs	r6, #0
c0d02072:	2821      	cmp	r0, #33	; 0x21
c0d02074:	d00f      	beq.n	c0d02096 <USBD_HID_Setup+0x78>
c0d02076:	2822      	cmp	r0, #34	; 0x22
      
      //USBD_CtlReceiveStatus(pdev);
      
      USBD_CtlSendData (pdev, 
                        pbuf,
                        len);
c0d02078:	4632      	mov	r2, r6
c0d0207a:	4631      	mov	r1, r6
c0d0207c:	d117      	bne.n	c0d020ae <USBD_HID_Setup+0x90>
c0d0207e:	a802      	add	r0, sp, #8
    {
    case USB_REQ_GET_DESCRIPTOR: 
      // 0x22
      if( req->wValue >> 8 == HID_REPORT_DESC)
      {
        pbuf =  USBD_HID_GetReportDescriptor_impl(&len);
c0d02080:	9000      	str	r0, [sp, #0]
c0d02082:	f000 f847 	bl	c0d02114 <USBD_HID_GetReportDescriptor_impl>
c0d02086:	e00a      	b.n	c0d0209e <USBD_HID_Setup+0x80>
c0d02088:	a901      	add	r1, sp, #4
c0d0208a:	2201      	movs	r2, #1
c0d0208c:	e00f      	b.n	c0d020ae <USBD_HID_Setup+0x90>
                        len);
      break;

    case USB_REQ_SET_INTERFACE :
      //hhid->AltSetting = (uint8_t)(req->wValue);
      USBD_CtlSendStatus(pdev);
c0d0208e:	4620      	mov	r0, r4
c0d02090:	f000 f918 	bl	c0d022c4 <USBD_CtlSendStatus>
c0d02094:	e00e      	b.n	c0d020b4 <USBD_HID_Setup+0x96>
c0d02096:	a802      	add	r0, sp, #8
        len = MIN(len , req->wLength);
      }
      // 0x21
      else if( req->wValue >> 8 == HID_DESCRIPTOR_TYPE)
      {
        pbuf = USBD_HID_GetHidDescriptor_impl(&len);
c0d02098:	9000      	str	r0, [sp, #0]
c0d0209a:	f000 f833 	bl	c0d02104 <USBD_HID_GetHidDescriptor_impl>
c0d0209e:	9b00      	ldr	r3, [sp, #0]
c0d020a0:	4601      	mov	r1, r0
c0d020a2:	881a      	ldrh	r2, [r3, #0]
c0d020a4:	88e8      	ldrh	r0, [r5, #6]
c0d020a6:	4282      	cmp	r2, r0
c0d020a8:	d300      	bcc.n	c0d020ac <USBD_HID_Setup+0x8e>
c0d020aa:	4602      	mov	r2, r0
c0d020ac:	801a      	strh	r2, [r3, #0]
c0d020ae:	4620      	mov	r0, r4
c0d020b0:	f000 f8da 	bl	c0d02268 <USBD_CtlSendData>
      
    }
  }

  return USBD_OK;
}
c0d020b4:	b2f0      	uxtb	r0, r6
c0d020b6:	b003      	add	sp, #12
c0d020b8:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d020ba <USBD_HID_Init>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_Init (USBD_HandleTypeDef *pdev, 
                               uint8_t cfgidx)
{
c0d020ba:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d020bc:	af03      	add	r7, sp, #12
c0d020be:	b081      	sub	sp, #4
c0d020c0:	4604      	mov	r4, r0
  UNUSED(cfgidx);

  /* Open EP IN */
  USBD_LL_OpenEP(pdev,
c0d020c2:	2182      	movs	r1, #130	; 0x82
c0d020c4:	2502      	movs	r5, #2
c0d020c6:	2640      	movs	r6, #64	; 0x40
c0d020c8:	462a      	mov	r2, r5
c0d020ca:	4633      	mov	r3, r6
c0d020cc:	f7ff fad0 	bl	c0d01670 <USBD_LL_OpenEP>
                 HID_EPIN_ADDR,
                 USBD_EP_TYPE_BULK,
                 HID_EPIN_SIZE);
  
  /* Open EP OUT */
  USBD_LL_OpenEP(pdev,
c0d020d0:	4620      	mov	r0, r4
c0d020d2:	4629      	mov	r1, r5
c0d020d4:	462a      	mov	r2, r5
c0d020d6:	4633      	mov	r3, r6
c0d020d8:	f7ff faca 	bl	c0d01670 <USBD_LL_OpenEP>
                 HID_EPOUT_ADDR,
                 USBD_EP_TYPE_BULK,
                 HID_EPOUT_SIZE);

        /* Prepare Out endpoint to receive 1st packet */ 
  USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR, HID_EPOUT_SIZE);
c0d020dc:	4620      	mov	r0, r4
c0d020de:	4629      	mov	r1, r5
c0d020e0:	4632      	mov	r2, r6
c0d020e2:	f7ff fb90 	bl	c0d01806 <USBD_LL_PrepareReceive>
  USBD_LL_Transmit (pdev, 
                    HID_EPIN_ADDR,                                      
                    NULL,
                    0);
  */
  return USBD_OK;
c0d020e6:	2000      	movs	r0, #0
c0d020e8:	b001      	add	sp, #4
c0d020ea:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d020ec <USBD_HID_DeInit>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_DeInit (USBD_HandleTypeDef *pdev, 
                                 uint8_t cfgidx)
{
c0d020ec:	b5d0      	push	{r4, r6, r7, lr}
c0d020ee:	af02      	add	r7, sp, #8
c0d020f0:	4604      	mov	r4, r0
  UNUSED(cfgidx);
  /* Close HID EP IN */
  USBD_LL_CloseEP(pdev,
c0d020f2:	2182      	movs	r1, #130	; 0x82
c0d020f4:	f7ff fae4 	bl	c0d016c0 <USBD_LL_CloseEP>
                  HID_EPIN_ADDR);
  
  /* Close HID EP OUT */
  USBD_LL_CloseEP(pdev,
c0d020f8:	2102      	movs	r1, #2
c0d020fa:	4620      	mov	r0, r4
c0d020fc:	f7ff fae0 	bl	c0d016c0 <USBD_LL_CloseEP>
                  HID_EPOUT_ADDR);
  
  return USBD_OK;
c0d02100:	2000      	movs	r0, #0
c0d02102:	bdd0      	pop	{r4, r6, r7, pc}

c0d02104 <USBD_HID_GetHidDescriptor_impl>:
  *length = sizeof (USBD_CfgDesc);
  return (uint8_t*)USBD_CfgDesc;
}

uint8_t* USBD_HID_GetHidDescriptor_impl(uint16_t* len) {
  *len = sizeof(USBD_HID_Desc);
c0d02104:	2109      	movs	r1, #9
c0d02106:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_HID_Desc; 
c0d02108:	4801      	ldr	r0, [pc, #4]	; (c0d02110 <USBD_HID_GetHidDescriptor_impl+0xc>)
c0d0210a:	4478      	add	r0, pc
c0d0210c:	4770      	bx	lr
c0d0210e:	46c0      	nop			; (mov r8, r8)
c0d02110:	00000596 	.word	0x00000596

c0d02114 <USBD_HID_GetReportDescriptor_impl>:
}

uint8_t* USBD_HID_GetReportDescriptor_impl(uint16_t* len) {
  *len = sizeof(HID_ReportDesc);
c0d02114:	2122      	movs	r1, #34	; 0x22
c0d02116:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)HID_ReportDesc;
c0d02118:	4801      	ldr	r0, [pc, #4]	; (c0d02120 <USBD_HID_GetReportDescriptor_impl+0xc>)
c0d0211a:	4478      	add	r0, pc
c0d0211c:	4770      	bx	lr
c0d0211e:	46c0      	nop			; (mov r8, r8)
c0d02120:	00000564 	.word	0x00000564

c0d02124 <USBD_HID_DataOut_impl>:
  */
extern volatile unsigned short G_io_apdu_length;

uint8_t  USBD_HID_DataOut_impl (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum, uint8_t* buffer)
{
c0d02124:	b5b0      	push	{r4, r5, r7, lr}
c0d02126:	af02      	add	r7, sp, #8
c0d02128:	4614      	mov	r4, r2
  UNUSED(epnum);

  // prepare receiving the next chunk (masked time)
  USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR , HID_EPOUT_SIZE);
c0d0212a:	2102      	movs	r1, #2
c0d0212c:	2240      	movs	r2, #64	; 0x40
c0d0212e:	f7ff fb6a 	bl	c0d01806 <USBD_LL_PrepareReceive>

  // avoid troubles when an apdu has not been replied yet
  if (G_io_apdu_media == IO_APDU_MEDIA_NONE) {
c0d02132:	4d0d      	ldr	r5, [pc, #52]	; (c0d02168 <USBD_HID_DataOut_impl+0x44>)
c0d02134:	7828      	ldrb	r0, [r5, #0]
c0d02136:	2800      	cmp	r0, #0
c0d02138:	d113      	bne.n	c0d02162 <USBD_HID_DataOut_impl+0x3e>
    
    // add to the hid transport
    switch(io_usb_hid_receive(io_usb_send_apdu_data, buffer, io_seproxyhal_get_ep_rx_size(HID_EPOUT_ADDR))) {
c0d0213a:	2002      	movs	r0, #2
c0d0213c:	f7fe fd2e 	bl	c0d00b9c <io_seproxyhal_get_ep_rx_size>
c0d02140:	4602      	mov	r2, r0
c0d02142:	480d      	ldr	r0, [pc, #52]	; (c0d02178 <USBD_HID_DataOut_impl+0x54>)
c0d02144:	4478      	add	r0, pc
c0d02146:	4621      	mov	r1, r4
c0d02148:	f7fe fb8c 	bl	c0d00864 <io_usb_hid_receive>
c0d0214c:	2802      	cmp	r0, #2
c0d0214e:	d108      	bne.n	c0d02162 <USBD_HID_DataOut_impl+0x3e>
      default:
        break;

      case IO_USB_APDU_RECEIVED:
        G_io_apdu_media = IO_APDU_MEDIA_USB_HID; // for application code
c0d02150:	2001      	movs	r0, #1
c0d02152:	7028      	strb	r0, [r5, #0]
        G_io_apdu_state = APDU_USB_HID; // for next call to io_exchange
c0d02154:	4805      	ldr	r0, [pc, #20]	; (c0d0216c <USBD_HID_DataOut_impl+0x48>)
c0d02156:	2107      	movs	r1, #7
c0d02158:	7001      	strb	r1, [r0, #0]
        G_io_apdu_length = G_io_usb_hid_total_length;
c0d0215a:	4805      	ldr	r0, [pc, #20]	; (c0d02170 <USBD_HID_DataOut_impl+0x4c>)
c0d0215c:	6800      	ldr	r0, [r0, #0]
c0d0215e:	4905      	ldr	r1, [pc, #20]	; (c0d02174 <USBD_HID_DataOut_impl+0x50>)
c0d02160:	8008      	strh	r0, [r1, #0]
        break;
    }

  }
  return USBD_OK;
c0d02162:	2000      	movs	r0, #0
c0d02164:	bdb0      	pop	{r4, r5, r7, pc}
c0d02166:	46c0      	nop			; (mov r8, r8)
c0d02168:	20001b00 	.word	0x20001b00
c0d0216c:	20001b08 	.word	0x20001b08
c0d02170:	200019f0 	.word	0x200019f0
c0d02174:	20001b0c 	.word	0x20001b0c
c0d02178:	ffffebad 	.word	0xffffebad

c0d0217c <USB_power>:
  USBD_GetCfgDesc_impl, 
  USBD_GetCfgDesc_impl,
  USBD_GetDeviceQualifierDesc_impl,
};

void USB_power(unsigned char enabled) {
c0d0217c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0217e:	af03      	add	r7, sp, #12
c0d02180:	b081      	sub	sp, #4
c0d02182:	4604      	mov	r4, r0
c0d02184:	2049      	movs	r0, #73	; 0x49
c0d02186:	0085      	lsls	r5, r0, #2
  os_memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d02188:	4810      	ldr	r0, [pc, #64]	; (c0d021cc <USB_power+0x50>)
c0d0218a:	2100      	movs	r1, #0
c0d0218c:	462a      	mov	r2, r5
c0d0218e:	f7fe fc15 	bl	c0d009bc <os_memset>

  if (enabled) {
c0d02192:	2c00      	cmp	r4, #0
c0d02194:	d015      	beq.n	c0d021c2 <USB_power+0x46>
    os_memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d02196:	4c0d      	ldr	r4, [pc, #52]	; (c0d021cc <USB_power+0x50>)
c0d02198:	2600      	movs	r6, #0
c0d0219a:	4620      	mov	r0, r4
c0d0219c:	4631      	mov	r1, r6
c0d0219e:	462a      	mov	r2, r5
c0d021a0:	f7fe fc0c 	bl	c0d009bc <os_memset>
    /* Init Device Library */
    USBD_Init(&USBD_Device, (USBD_DescriptorsTypeDef*)&HID_Desc, 0);
c0d021a4:	490a      	ldr	r1, [pc, #40]	; (c0d021d0 <USB_power+0x54>)
c0d021a6:	4479      	add	r1, pc
c0d021a8:	4620      	mov	r0, r4
c0d021aa:	4632      	mov	r2, r6
c0d021ac:	f7ff fb3f 	bl	c0d0182e <USBD_Init>
    
    /* Register the HID class */
    USBD_RegisterClass(&USBD_Device, (USBD_ClassTypeDef*)&USBD_HID);
c0d021b0:	4908      	ldr	r1, [pc, #32]	; (c0d021d4 <USB_power+0x58>)
c0d021b2:	4479      	add	r1, pc
c0d021b4:	4620      	mov	r0, r4
c0d021b6:	f7ff fb72 	bl	c0d0189e <USBD_RegisterClass>

    /* Start Device Process */
    USBD_Start(&USBD_Device);
c0d021ba:	4620      	mov	r0, r4
c0d021bc:	f7ff fb78 	bl	c0d018b0 <USBD_Start>
c0d021c0:	e002      	b.n	c0d021c8 <USB_power+0x4c>
  }
  else {
    USBD_DeInit(&USBD_Device);
c0d021c2:	4802      	ldr	r0, [pc, #8]	; (c0d021cc <USB_power+0x50>)
c0d021c4:	f7ff fb51 	bl	c0d0186a <USBD_DeInit>
  }
}
c0d021c8:	b001      	add	sp, #4
c0d021ca:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d021cc:	20001b24 	.word	0x20001b24
c0d021d0:	00000516 	.word	0x00000516
c0d021d4:	00000546 	.word	0x00000546

c0d021d8 <USBD_DeviceDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_DeviceDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_DeviceDesc);
c0d021d8:	2012      	movs	r0, #18
c0d021da:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_DeviceDesc;
c0d021dc:	4801      	ldr	r0, [pc, #4]	; (c0d021e4 <USBD_DeviceDescriptor+0xc>)
c0d021de:	4478      	add	r0, pc
c0d021e0:	4770      	bx	lr
c0d021e2:	46c0      	nop			; (mov r8, r8)
c0d021e4:	000004cb 	.word	0x000004cb

c0d021e8 <USBD_LangIDStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_LangIDStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_LangIDDesc);  
c0d021e8:	2004      	movs	r0, #4
c0d021ea:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_LangIDDesc;
c0d021ec:	4801      	ldr	r0, [pc, #4]	; (c0d021f4 <USBD_LangIDStrDescriptor+0xc>)
c0d021ee:	4478      	add	r0, pc
c0d021f0:	4770      	bx	lr
c0d021f2:	46c0      	nop			; (mov r8, r8)
c0d021f4:	000004ee 	.word	0x000004ee

c0d021f8 <USBD_ManufacturerStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ManufacturerStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_MANUFACTURER_STRING);
c0d021f8:	200e      	movs	r0, #14
c0d021fa:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_MANUFACTURER_STRING;
c0d021fc:	4801      	ldr	r0, [pc, #4]	; (c0d02204 <USBD_ManufacturerStrDescriptor+0xc>)
c0d021fe:	4478      	add	r0, pc
c0d02200:	4770      	bx	lr
c0d02202:	46c0      	nop			; (mov r8, r8)
c0d02204:	000004e2 	.word	0x000004e2

c0d02208 <USBD_ProductStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ProductStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_PRODUCT_FS_STRING);
c0d02208:	200e      	movs	r0, #14
c0d0220a:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_PRODUCT_FS_STRING;
c0d0220c:	4801      	ldr	r0, [pc, #4]	; (c0d02214 <USBD_ProductStrDescriptor+0xc>)
c0d0220e:	4478      	add	r0, pc
c0d02210:	4770      	bx	lr
c0d02212:	46c0      	nop			; (mov r8, r8)
c0d02214:	00000462 	.word	0x00000462

c0d02218 <USBD_SerialStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_SerialStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USB_SERIAL_STRING);
c0d02218:	200a      	movs	r0, #10
c0d0221a:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USB_SERIAL_STRING;
c0d0221c:	4801      	ldr	r0, [pc, #4]	; (c0d02224 <USBD_SerialStrDescriptor+0xc>)
c0d0221e:	4478      	add	r0, pc
c0d02220:	4770      	bx	lr
c0d02222:	46c0      	nop			; (mov r8, r8)
c0d02224:	000004d0 	.word	0x000004d0

c0d02228 <USBD_ConfigStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ConfigStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_CONFIGURATION_FS_STRING);
c0d02228:	200e      	movs	r0, #14
c0d0222a:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_CONFIGURATION_FS_STRING;
c0d0222c:	4801      	ldr	r0, [pc, #4]	; (c0d02234 <USBD_ConfigStrDescriptor+0xc>)
c0d0222e:	4478      	add	r0, pc
c0d02230:	4770      	bx	lr
c0d02232:	46c0      	nop			; (mov r8, r8)
c0d02234:	00000442 	.word	0x00000442

c0d02238 <USBD_InterfaceStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_InterfaceStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_INTERFACE_FS_STRING);
c0d02238:	200e      	movs	r0, #14
c0d0223a:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_INTERFACE_FS_STRING;
c0d0223c:	4801      	ldr	r0, [pc, #4]	; (c0d02244 <USBD_InterfaceStrDescriptor+0xc>)
c0d0223e:	4478      	add	r0, pc
c0d02240:	4770      	bx	lr
c0d02242:	46c0      	nop			; (mov r8, r8)
c0d02244:	00000432 	.word	0x00000432

c0d02248 <USBD_GetCfgDesc_impl>:
  * @param  length : pointer data length
  * @retval pointer to descriptor buffer
  */
static uint8_t  *USBD_GetCfgDesc_impl (uint16_t *length)
{
  *length = sizeof (USBD_CfgDesc);
c0d02248:	2129      	movs	r1, #41	; 0x29
c0d0224a:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_CfgDesc;
c0d0224c:	4801      	ldr	r0, [pc, #4]	; (c0d02254 <USBD_GetCfgDesc_impl+0xc>)
c0d0224e:	4478      	add	r0, pc
c0d02250:	4770      	bx	lr
c0d02252:	46c0      	nop			; (mov r8, r8)
c0d02254:	000004e2 	.word	0x000004e2

c0d02258 <USBD_GetDeviceQualifierDesc_impl>:
* @param  length : pointer data length
* @retval pointer to descriptor buffer
*/
static uint8_t  *USBD_GetDeviceQualifierDesc_impl (uint16_t *length)
{
  *length = sizeof (USBD_DeviceQualifierDesc);
c0d02258:	210a      	movs	r1, #10
c0d0225a:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_DeviceQualifierDesc;
c0d0225c:	4801      	ldr	r0, [pc, #4]	; (c0d02264 <USBD_GetDeviceQualifierDesc_impl+0xc>)
c0d0225e:	4478      	add	r0, pc
c0d02260:	4770      	bx	lr
c0d02262:	46c0      	nop			; (mov r8, r8)
c0d02264:	000004fe 	.word	0x000004fe

c0d02268 <USBD_CtlSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendData (USBD_HandleTypeDef  *pdev, 
                               uint8_t *pbuf,
                               uint16_t len)
{
c0d02268:	b5b0      	push	{r4, r5, r7, lr}
c0d0226a:	af02      	add	r7, sp, #8
c0d0226c:	460c      	mov	r4, r1
  /* Set EP0 State */
  pdev->ep0_state          = USBD_EP0_DATA_IN;                                      
c0d0226e:	21f4      	movs	r1, #244	; 0xf4
c0d02270:	2302      	movs	r3, #2
c0d02272:	5043      	str	r3, [r0, r1]
  pdev->ep_in[0].total_length = len;
c0d02274:	6182      	str	r2, [r0, #24]
  pdev->ep_in[0].rem_length   = len;
c0d02276:	61c2      	str	r2, [r0, #28]
  // store the continuation data if needed
  pdev->pData = pbuf;
c0d02278:	2109      	movs	r1, #9
c0d0227a:	0149      	lsls	r1, r1, #5
c0d0227c:	5044      	str	r4, [r0, r1]
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));  
c0d0227e:	6a01      	ldr	r1, [r0, #32]
c0d02280:	428a      	cmp	r2, r1
c0d02282:	d300      	bcc.n	c0d02286 <USBD_CtlSendData+0x1e>
c0d02284:	460a      	mov	r2, r1
c0d02286:	b293      	uxth	r3, r2
c0d02288:	2500      	movs	r5, #0
c0d0228a:	4629      	mov	r1, r5
c0d0228c:	4622      	mov	r2, r4
c0d0228e:	f7ff faa0 	bl	c0d017d2 <USBD_LL_Transmit>
  
  return USBD_OK;
c0d02292:	4628      	mov	r0, r5
c0d02294:	bdb0      	pop	{r4, r5, r7, pc}

c0d02296 <USBD_CtlContinueSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueSendData (USBD_HandleTypeDef  *pdev, 
                                       uint8_t *pbuf,
                                       uint16_t len)
{
c0d02296:	b5b0      	push	{r4, r5, r7, lr}
c0d02298:	af02      	add	r7, sp, #8
c0d0229a:	460c      	mov	r4, r1
 /* Start the next transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));   
c0d0229c:	6a01      	ldr	r1, [r0, #32]
c0d0229e:	428a      	cmp	r2, r1
c0d022a0:	d300      	bcc.n	c0d022a4 <USBD_CtlContinueSendData+0xe>
c0d022a2:	460a      	mov	r2, r1
c0d022a4:	b293      	uxth	r3, r2
c0d022a6:	2500      	movs	r5, #0
c0d022a8:	4629      	mov	r1, r5
c0d022aa:	4622      	mov	r2, r4
c0d022ac:	f7ff fa91 	bl	c0d017d2 <USBD_LL_Transmit>
  return USBD_OK;
c0d022b0:	4628      	mov	r0, r5
c0d022b2:	bdb0      	pop	{r4, r5, r7, pc}

c0d022b4 <USBD_CtlContinueRx>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueRx (USBD_HandleTypeDef  *pdev, 
                                          uint8_t *pbuf,                                          
                                          uint16_t len)
{
c0d022b4:	b5d0      	push	{r4, r6, r7, lr}
c0d022b6:	af02      	add	r7, sp, #8
c0d022b8:	2400      	movs	r4, #0
  UNUSED(pbuf);
  USBD_LL_PrepareReceive (pdev,
c0d022ba:	4621      	mov	r1, r4
c0d022bc:	f7ff faa3 	bl	c0d01806 <USBD_LL_PrepareReceive>
                          0,                                            
                          len);
  return USBD_OK;
c0d022c0:	4620      	mov	r0, r4
c0d022c2:	bdd0      	pop	{r4, r6, r7, pc}

c0d022c4 <USBD_CtlSendStatus>:
*         send zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendStatus (USBD_HandleTypeDef  *pdev)
{
c0d022c4:	b5d0      	push	{r4, r6, r7, lr}
c0d022c6:	af02      	add	r7, sp, #8

  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_IN;
c0d022c8:	21f4      	movs	r1, #244	; 0xf4
c0d022ca:	2204      	movs	r2, #4
c0d022cc:	5042      	str	r2, [r0, r1]
c0d022ce:	2400      	movs	r4, #0
  
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, NULL, 0);   
c0d022d0:	4621      	mov	r1, r4
c0d022d2:	4622      	mov	r2, r4
c0d022d4:	4623      	mov	r3, r4
c0d022d6:	f7ff fa7c 	bl	c0d017d2 <USBD_LL_Transmit>
  
  return USBD_OK;
c0d022da:	4620      	mov	r0, r4
c0d022dc:	bdd0      	pop	{r4, r6, r7, pc}

c0d022de <USBD_CtlReceiveStatus>:
*         receive zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlReceiveStatus (USBD_HandleTypeDef  *pdev)
{
c0d022de:	b5d0      	push	{r4, r6, r7, lr}
c0d022e0:	af02      	add	r7, sp, #8
  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_OUT; 
c0d022e2:	21f4      	movs	r1, #244	; 0xf4
c0d022e4:	2205      	movs	r2, #5
c0d022e6:	5042      	str	r2, [r0, r1]
c0d022e8:	2400      	movs	r4, #0
  
 /* Start the transfer */  
  USBD_LL_PrepareReceive ( pdev,
c0d022ea:	4621      	mov	r1, r4
c0d022ec:	4622      	mov	r2, r4
c0d022ee:	f7ff fa8a 	bl	c0d01806 <USBD_LL_PrepareReceive>
                    0,
                    0);  

  return USBD_OK;
c0d022f2:	4620      	mov	r0, r4
c0d022f4:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d022f8 <__aeabi_uidiv>:
c0d022f8:	2200      	movs	r2, #0
c0d022fa:	0843      	lsrs	r3, r0, #1
c0d022fc:	428b      	cmp	r3, r1
c0d022fe:	d374      	bcc.n	c0d023ea <__aeabi_uidiv+0xf2>
c0d02300:	0903      	lsrs	r3, r0, #4
c0d02302:	428b      	cmp	r3, r1
c0d02304:	d35f      	bcc.n	c0d023c6 <__aeabi_uidiv+0xce>
c0d02306:	0a03      	lsrs	r3, r0, #8
c0d02308:	428b      	cmp	r3, r1
c0d0230a:	d344      	bcc.n	c0d02396 <__aeabi_uidiv+0x9e>
c0d0230c:	0b03      	lsrs	r3, r0, #12
c0d0230e:	428b      	cmp	r3, r1
c0d02310:	d328      	bcc.n	c0d02364 <__aeabi_uidiv+0x6c>
c0d02312:	0c03      	lsrs	r3, r0, #16
c0d02314:	428b      	cmp	r3, r1
c0d02316:	d30d      	bcc.n	c0d02334 <__aeabi_uidiv+0x3c>
c0d02318:	22ff      	movs	r2, #255	; 0xff
c0d0231a:	0209      	lsls	r1, r1, #8
c0d0231c:	ba12      	rev	r2, r2
c0d0231e:	0c03      	lsrs	r3, r0, #16
c0d02320:	428b      	cmp	r3, r1
c0d02322:	d302      	bcc.n	c0d0232a <__aeabi_uidiv+0x32>
c0d02324:	1212      	asrs	r2, r2, #8
c0d02326:	0209      	lsls	r1, r1, #8
c0d02328:	d065      	beq.n	c0d023f6 <__aeabi_uidiv+0xfe>
c0d0232a:	0b03      	lsrs	r3, r0, #12
c0d0232c:	428b      	cmp	r3, r1
c0d0232e:	d319      	bcc.n	c0d02364 <__aeabi_uidiv+0x6c>
c0d02330:	e000      	b.n	c0d02334 <__aeabi_uidiv+0x3c>
c0d02332:	0a09      	lsrs	r1, r1, #8
c0d02334:	0bc3      	lsrs	r3, r0, #15
c0d02336:	428b      	cmp	r3, r1
c0d02338:	d301      	bcc.n	c0d0233e <__aeabi_uidiv+0x46>
c0d0233a:	03cb      	lsls	r3, r1, #15
c0d0233c:	1ac0      	subs	r0, r0, r3
c0d0233e:	4152      	adcs	r2, r2
c0d02340:	0b83      	lsrs	r3, r0, #14
c0d02342:	428b      	cmp	r3, r1
c0d02344:	d301      	bcc.n	c0d0234a <__aeabi_uidiv+0x52>
c0d02346:	038b      	lsls	r3, r1, #14
c0d02348:	1ac0      	subs	r0, r0, r3
c0d0234a:	4152      	adcs	r2, r2
c0d0234c:	0b43      	lsrs	r3, r0, #13
c0d0234e:	428b      	cmp	r3, r1
c0d02350:	d301      	bcc.n	c0d02356 <__aeabi_uidiv+0x5e>
c0d02352:	034b      	lsls	r3, r1, #13
c0d02354:	1ac0      	subs	r0, r0, r3
c0d02356:	4152      	adcs	r2, r2
c0d02358:	0b03      	lsrs	r3, r0, #12
c0d0235a:	428b      	cmp	r3, r1
c0d0235c:	d301      	bcc.n	c0d02362 <__aeabi_uidiv+0x6a>
c0d0235e:	030b      	lsls	r3, r1, #12
c0d02360:	1ac0      	subs	r0, r0, r3
c0d02362:	4152      	adcs	r2, r2
c0d02364:	0ac3      	lsrs	r3, r0, #11
c0d02366:	428b      	cmp	r3, r1
c0d02368:	d301      	bcc.n	c0d0236e <__aeabi_uidiv+0x76>
c0d0236a:	02cb      	lsls	r3, r1, #11
c0d0236c:	1ac0      	subs	r0, r0, r3
c0d0236e:	4152      	adcs	r2, r2
c0d02370:	0a83      	lsrs	r3, r0, #10
c0d02372:	428b      	cmp	r3, r1
c0d02374:	d301      	bcc.n	c0d0237a <__aeabi_uidiv+0x82>
c0d02376:	028b      	lsls	r3, r1, #10
c0d02378:	1ac0      	subs	r0, r0, r3
c0d0237a:	4152      	adcs	r2, r2
c0d0237c:	0a43      	lsrs	r3, r0, #9
c0d0237e:	428b      	cmp	r3, r1
c0d02380:	d301      	bcc.n	c0d02386 <__aeabi_uidiv+0x8e>
c0d02382:	024b      	lsls	r3, r1, #9
c0d02384:	1ac0      	subs	r0, r0, r3
c0d02386:	4152      	adcs	r2, r2
c0d02388:	0a03      	lsrs	r3, r0, #8
c0d0238a:	428b      	cmp	r3, r1
c0d0238c:	d301      	bcc.n	c0d02392 <__aeabi_uidiv+0x9a>
c0d0238e:	020b      	lsls	r3, r1, #8
c0d02390:	1ac0      	subs	r0, r0, r3
c0d02392:	4152      	adcs	r2, r2
c0d02394:	d2cd      	bcs.n	c0d02332 <__aeabi_uidiv+0x3a>
c0d02396:	09c3      	lsrs	r3, r0, #7
c0d02398:	428b      	cmp	r3, r1
c0d0239a:	d301      	bcc.n	c0d023a0 <__aeabi_uidiv+0xa8>
c0d0239c:	01cb      	lsls	r3, r1, #7
c0d0239e:	1ac0      	subs	r0, r0, r3
c0d023a0:	4152      	adcs	r2, r2
c0d023a2:	0983      	lsrs	r3, r0, #6
c0d023a4:	428b      	cmp	r3, r1
c0d023a6:	d301      	bcc.n	c0d023ac <__aeabi_uidiv+0xb4>
c0d023a8:	018b      	lsls	r3, r1, #6
c0d023aa:	1ac0      	subs	r0, r0, r3
c0d023ac:	4152      	adcs	r2, r2
c0d023ae:	0943      	lsrs	r3, r0, #5
c0d023b0:	428b      	cmp	r3, r1
c0d023b2:	d301      	bcc.n	c0d023b8 <__aeabi_uidiv+0xc0>
c0d023b4:	014b      	lsls	r3, r1, #5
c0d023b6:	1ac0      	subs	r0, r0, r3
c0d023b8:	4152      	adcs	r2, r2
c0d023ba:	0903      	lsrs	r3, r0, #4
c0d023bc:	428b      	cmp	r3, r1
c0d023be:	d301      	bcc.n	c0d023c4 <__aeabi_uidiv+0xcc>
c0d023c0:	010b      	lsls	r3, r1, #4
c0d023c2:	1ac0      	subs	r0, r0, r3
c0d023c4:	4152      	adcs	r2, r2
c0d023c6:	08c3      	lsrs	r3, r0, #3
c0d023c8:	428b      	cmp	r3, r1
c0d023ca:	d301      	bcc.n	c0d023d0 <__aeabi_uidiv+0xd8>
c0d023cc:	00cb      	lsls	r3, r1, #3
c0d023ce:	1ac0      	subs	r0, r0, r3
c0d023d0:	4152      	adcs	r2, r2
c0d023d2:	0883      	lsrs	r3, r0, #2
c0d023d4:	428b      	cmp	r3, r1
c0d023d6:	d301      	bcc.n	c0d023dc <__aeabi_uidiv+0xe4>
c0d023d8:	008b      	lsls	r3, r1, #2
c0d023da:	1ac0      	subs	r0, r0, r3
c0d023dc:	4152      	adcs	r2, r2
c0d023de:	0843      	lsrs	r3, r0, #1
c0d023e0:	428b      	cmp	r3, r1
c0d023e2:	d301      	bcc.n	c0d023e8 <__aeabi_uidiv+0xf0>
c0d023e4:	004b      	lsls	r3, r1, #1
c0d023e6:	1ac0      	subs	r0, r0, r3
c0d023e8:	4152      	adcs	r2, r2
c0d023ea:	1a41      	subs	r1, r0, r1
c0d023ec:	d200      	bcs.n	c0d023f0 <__aeabi_uidiv+0xf8>
c0d023ee:	4601      	mov	r1, r0
c0d023f0:	4152      	adcs	r2, r2
c0d023f2:	4610      	mov	r0, r2
c0d023f4:	4770      	bx	lr
c0d023f6:	e7ff      	b.n	c0d023f8 <__aeabi_uidiv+0x100>
c0d023f8:	b501      	push	{r0, lr}
c0d023fa:	2000      	movs	r0, #0
c0d023fc:	f000 f806 	bl	c0d0240c <__aeabi_idiv0>
c0d02400:	bd02      	pop	{r1, pc}
c0d02402:	46c0      	nop			; (mov r8, r8)

c0d02404 <__aeabi_uidivmod>:
c0d02404:	2900      	cmp	r1, #0
c0d02406:	d0f7      	beq.n	c0d023f8 <__aeabi_uidiv+0x100>
c0d02408:	e776      	b.n	c0d022f8 <__aeabi_uidiv>
c0d0240a:	4770      	bx	lr

c0d0240c <__aeabi_idiv0>:
c0d0240c:	4770      	bx	lr
c0d0240e:	46c0      	nop			; (mov r8, r8)

c0d02410 <__aeabi_memclr>:
c0d02410:	b510      	push	{r4, lr}
c0d02412:	2200      	movs	r2, #0
c0d02414:	f000 f802 	bl	c0d0241c <__aeabi_memset>
c0d02418:	bd10      	pop	{r4, pc}
c0d0241a:	46c0      	nop			; (mov r8, r8)

c0d0241c <__aeabi_memset>:
c0d0241c:	0013      	movs	r3, r2
c0d0241e:	b510      	push	{r4, lr}
c0d02420:	000a      	movs	r2, r1
c0d02422:	0019      	movs	r1, r3
c0d02424:	f000 f802 	bl	c0d0242c <memset>
c0d02428:	bd10      	pop	{r4, pc}
c0d0242a:	46c0      	nop			; (mov r8, r8)

c0d0242c <memset>:
c0d0242c:	b570      	push	{r4, r5, r6, lr}
c0d0242e:	0783      	lsls	r3, r0, #30
c0d02430:	d03f      	beq.n	c0d024b2 <memset+0x86>
c0d02432:	1e54      	subs	r4, r2, #1
c0d02434:	2a00      	cmp	r2, #0
c0d02436:	d03b      	beq.n	c0d024b0 <memset+0x84>
c0d02438:	b2ce      	uxtb	r6, r1
c0d0243a:	0003      	movs	r3, r0
c0d0243c:	2503      	movs	r5, #3
c0d0243e:	e003      	b.n	c0d02448 <memset+0x1c>
c0d02440:	1e62      	subs	r2, r4, #1
c0d02442:	2c00      	cmp	r4, #0
c0d02444:	d034      	beq.n	c0d024b0 <memset+0x84>
c0d02446:	0014      	movs	r4, r2
c0d02448:	3301      	adds	r3, #1
c0d0244a:	1e5a      	subs	r2, r3, #1
c0d0244c:	7016      	strb	r6, [r2, #0]
c0d0244e:	422b      	tst	r3, r5
c0d02450:	d1f6      	bne.n	c0d02440 <memset+0x14>
c0d02452:	2c03      	cmp	r4, #3
c0d02454:	d924      	bls.n	c0d024a0 <memset+0x74>
c0d02456:	25ff      	movs	r5, #255	; 0xff
c0d02458:	400d      	ands	r5, r1
c0d0245a:	022a      	lsls	r2, r5, #8
c0d0245c:	4315      	orrs	r5, r2
c0d0245e:	042a      	lsls	r2, r5, #16
c0d02460:	4315      	orrs	r5, r2
c0d02462:	2c0f      	cmp	r4, #15
c0d02464:	d911      	bls.n	c0d0248a <memset+0x5e>
c0d02466:	0026      	movs	r6, r4
c0d02468:	3e10      	subs	r6, #16
c0d0246a:	0936      	lsrs	r6, r6, #4
c0d0246c:	3601      	adds	r6, #1
c0d0246e:	0136      	lsls	r6, r6, #4
c0d02470:	001a      	movs	r2, r3
c0d02472:	199b      	adds	r3, r3, r6
c0d02474:	6015      	str	r5, [r2, #0]
c0d02476:	6055      	str	r5, [r2, #4]
c0d02478:	6095      	str	r5, [r2, #8]
c0d0247a:	60d5      	str	r5, [r2, #12]
c0d0247c:	3210      	adds	r2, #16
c0d0247e:	4293      	cmp	r3, r2
c0d02480:	d1f8      	bne.n	c0d02474 <memset+0x48>
c0d02482:	220f      	movs	r2, #15
c0d02484:	4014      	ands	r4, r2
c0d02486:	2c03      	cmp	r4, #3
c0d02488:	d90a      	bls.n	c0d024a0 <memset+0x74>
c0d0248a:	1f26      	subs	r6, r4, #4
c0d0248c:	08b6      	lsrs	r6, r6, #2
c0d0248e:	3601      	adds	r6, #1
c0d02490:	00b6      	lsls	r6, r6, #2
c0d02492:	001a      	movs	r2, r3
c0d02494:	199b      	adds	r3, r3, r6
c0d02496:	c220      	stmia	r2!, {r5}
c0d02498:	4293      	cmp	r3, r2
c0d0249a:	d1fc      	bne.n	c0d02496 <memset+0x6a>
c0d0249c:	2203      	movs	r2, #3
c0d0249e:	4014      	ands	r4, r2
c0d024a0:	2c00      	cmp	r4, #0
c0d024a2:	d005      	beq.n	c0d024b0 <memset+0x84>
c0d024a4:	b2c9      	uxtb	r1, r1
c0d024a6:	191c      	adds	r4, r3, r4
c0d024a8:	7019      	strb	r1, [r3, #0]
c0d024aa:	3301      	adds	r3, #1
c0d024ac:	429c      	cmp	r4, r3
c0d024ae:	d1fb      	bne.n	c0d024a8 <memset+0x7c>
c0d024b0:	bd70      	pop	{r4, r5, r6, pc}
c0d024b2:	0014      	movs	r4, r2
c0d024b4:	0003      	movs	r3, r0
c0d024b6:	e7cc      	b.n	c0d02452 <memset+0x26>

c0d024b8 <setjmp>:
c0d024b8:	c0f0      	stmia	r0!, {r4, r5, r6, r7}
c0d024ba:	4641      	mov	r1, r8
c0d024bc:	464a      	mov	r2, r9
c0d024be:	4653      	mov	r3, sl
c0d024c0:	465c      	mov	r4, fp
c0d024c2:	466d      	mov	r5, sp
c0d024c4:	4676      	mov	r6, lr
c0d024c6:	c07e      	stmia	r0!, {r1, r2, r3, r4, r5, r6}
c0d024c8:	3828      	subs	r0, #40	; 0x28
c0d024ca:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d024cc:	2000      	movs	r0, #0
c0d024ce:	4770      	bx	lr

c0d024d0 <longjmp>:
c0d024d0:	3010      	adds	r0, #16
c0d024d2:	c87c      	ldmia	r0!, {r2, r3, r4, r5, r6}
c0d024d4:	4690      	mov	r8, r2
c0d024d6:	4699      	mov	r9, r3
c0d024d8:	46a2      	mov	sl, r4
c0d024da:	46ab      	mov	fp, r5
c0d024dc:	46b5      	mov	sp, r6
c0d024de:	c808      	ldmia	r0!, {r3}
c0d024e0:	3828      	subs	r0, #40	; 0x28
c0d024e2:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d024e4:	1c08      	adds	r0, r1, #0
c0d024e6:	d100      	bne.n	c0d024ea <longjmp+0x1a>
c0d024e8:	2001      	movs	r0, #1
c0d024ea:	4718      	bx	r3

c0d024ec <strlen>:
c0d024ec:	b510      	push	{r4, lr}
c0d024ee:	0783      	lsls	r3, r0, #30
c0d024f0:	d027      	beq.n	c0d02542 <strlen+0x56>
c0d024f2:	7803      	ldrb	r3, [r0, #0]
c0d024f4:	2b00      	cmp	r3, #0
c0d024f6:	d026      	beq.n	c0d02546 <strlen+0x5a>
c0d024f8:	0003      	movs	r3, r0
c0d024fa:	2103      	movs	r1, #3
c0d024fc:	e002      	b.n	c0d02504 <strlen+0x18>
c0d024fe:	781a      	ldrb	r2, [r3, #0]
c0d02500:	2a00      	cmp	r2, #0
c0d02502:	d01c      	beq.n	c0d0253e <strlen+0x52>
c0d02504:	3301      	adds	r3, #1
c0d02506:	420b      	tst	r3, r1
c0d02508:	d1f9      	bne.n	c0d024fe <strlen+0x12>
c0d0250a:	6819      	ldr	r1, [r3, #0]
c0d0250c:	4a0f      	ldr	r2, [pc, #60]	; (c0d0254c <strlen+0x60>)
c0d0250e:	4c10      	ldr	r4, [pc, #64]	; (c0d02550 <strlen+0x64>)
c0d02510:	188a      	adds	r2, r1, r2
c0d02512:	438a      	bics	r2, r1
c0d02514:	4222      	tst	r2, r4
c0d02516:	d10f      	bne.n	c0d02538 <strlen+0x4c>
c0d02518:	3304      	adds	r3, #4
c0d0251a:	6819      	ldr	r1, [r3, #0]
c0d0251c:	4a0b      	ldr	r2, [pc, #44]	; (c0d0254c <strlen+0x60>)
c0d0251e:	188a      	adds	r2, r1, r2
c0d02520:	438a      	bics	r2, r1
c0d02522:	4222      	tst	r2, r4
c0d02524:	d108      	bne.n	c0d02538 <strlen+0x4c>
c0d02526:	3304      	adds	r3, #4
c0d02528:	6819      	ldr	r1, [r3, #0]
c0d0252a:	4a08      	ldr	r2, [pc, #32]	; (c0d0254c <strlen+0x60>)
c0d0252c:	188a      	adds	r2, r1, r2
c0d0252e:	438a      	bics	r2, r1
c0d02530:	4222      	tst	r2, r4
c0d02532:	d0f1      	beq.n	c0d02518 <strlen+0x2c>
c0d02534:	e000      	b.n	c0d02538 <strlen+0x4c>
c0d02536:	3301      	adds	r3, #1
c0d02538:	781a      	ldrb	r2, [r3, #0]
c0d0253a:	2a00      	cmp	r2, #0
c0d0253c:	d1fb      	bne.n	c0d02536 <strlen+0x4a>
c0d0253e:	1a18      	subs	r0, r3, r0
c0d02540:	bd10      	pop	{r4, pc}
c0d02542:	0003      	movs	r3, r0
c0d02544:	e7e1      	b.n	c0d0250a <strlen+0x1e>
c0d02546:	2000      	movs	r0, #0
c0d02548:	e7fa      	b.n	c0d02540 <strlen+0x54>
c0d0254a:	46c0      	nop			; (mov r8, r8)
c0d0254c:	fefefeff 	.word	0xfefefeff
c0d02550:	80808080 	.word	0x80808080

c0d02554 <bagl_ui_sample_nanos>:
c0d02554:	00000003 00800000 00000020 00000001     ........ .......
c0d02564:	00000000 00ffffff 00000000 00000000     ................
	...
c0d0258c:	00000207 0080000c 0000000b 00000000     ................
c0d0259c:	00ffffff 00000000 0000800a c0d0266c     ............l&..
	...
c0d025c4:	00170207 0052001a 008a000b 00000000     ......R.........
c0d025d4:	00ffffff 00000000 001a8008 20001944     ............D.. 
	...
c0d025fc:	00030005 0007000c 00000007 00000000     ................
c0d0260c:	00ffffff 00000000 00070000 00000000     ................
	...
c0d02634:	00750005 0008000d 00000006 00000000     ..u.............
c0d02644:	00ffffff 00000000 00060000 00000000     ................
	...
c0d0266c:	72646441 00737365                       Address.

c0d02674 <USBD_PRODUCT_FS_STRING>:
c0d02674:	004e030e 006e0061 0020006f a0060053              ..N.a.n.o. .S.

c0d02682 <HID_ReportDesc>:
c0d02682:	09ffa006 0901a101 26001503 087500ff     ...........&..u.
c0d02692:	08814095 00150409 7500ff26 91409508     .@......&..u..@.
c0d026a2:	2109c008                                         ..

c0d026a4 <USBD_HID_Desc>:
c0d026a4:	01112109 22220100 00011200                       .!...."".

c0d026ad <USBD_DeviceDesc>:
c0d026ad:	02000112 40000000 00012c97 02010200     .......@.,......
c0d026bd:	d9000103                                         ...

c0d026c0 <HID_Desc>:
c0d026c0:	c0d021d9 c0d021e9 c0d021f9 c0d02209     .!...!...!..."..
c0d026d0:	c0d02219 c0d02229 c0d02239 00000000     ."..)"..9"......

c0d026e0 <USBD_LangIDDesc>:
c0d026e0:	04090304                                ....

c0d026e4 <USBD_MANUFACTURER_STRING>:
c0d026e4:	004c030e 00640065 00650067 030a0072              ..L.e.d.g.e.r.

c0d026f2 <USB_SERIAL_STRING>:
c0d026f2:	0030030a 00300030 20bb0031                       ..0.0.0.1.

c0d026fc <USBD_HID>:
c0d026fc:	c0d020bb c0d020ed c0d0201f 00000000     . ... ... ......
	...
c0d02714:	c0d02125 00000000 00000000 00000000     %!..............
c0d02724:	c0d02249 c0d02249 c0d02249 c0d02259     I"..I"..I"..Y"..

c0d02734 <USBD_CfgDesc>:
c0d02734:	00290209 c0020101 00040932 00030200     ..).....2.......
c0d02744:	21090200 01000111 07002222 40038205     ...!...."".....@
c0d02754:	05070100 00400302 00000001              ......@.....

c0d02760 <USBD_DeviceQualifierDesc>:
c0d02760:	0200060a 40000000 6f4e0001                       .......@..

c0d0276a <NOT_AVAILABLE>:
c0d0276a:	20746f4e 69617661 6c62616c 00000065              Not available.

c0d02778 <_etext>:
	...
