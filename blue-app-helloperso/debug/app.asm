
bin/app.elf:     file format elf32-littlearm


Disassembly of section .text:

c0d00000 <main>:
    length = encode_base58(tmp, sizeof(tmp), address, sizeof(address));
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
c0d00008:	f000 fc7e 	bl	c0d00908 <os_boot>

    UX_INIT();
c0d0000c:	481e      	ldr	r0, [pc, #120]	; (c0d00088 <main+0x88>)
c0d0000e:	2400      	movs	r4, #0
c0d00010:	22b0      	movs	r2, #176	; 0xb0
c0d00012:	4621      	mov	r1, r4
c0d00014:	f000 fd2a 	bl	c0d00a6c <os_memset>

    BEGIN_TRY {
        TRY {
c0d00018:	4e1c      	ldr	r6, [pc, #112]	; (c0d0008c <main+0x8c>)
c0d0001a:	6830      	ldr	r0, [r6, #0]
c0d0001c:	900b      	str	r0, [sp, #44]	; 0x2c
c0d0001e:	ad01      	add	r5, sp, #4
c0d00020:	4628      	mov	r0, r5
c0d00022:	f002 fb39 	bl	c0d02698 <setjmp>
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
c0d0003c:	f000 febc 	bl	c0d00db8 <io_seproxyhal_init>

            // Invalidate the current authentication to demonstrate
            // reauthentication
            // Reauthenticate with "Auth" (Blue) or left button (Nano S)
            os_global_pin_invalidate();
c0d00040:	f001 fb08 	bl	c0d01654 <os_global_pin_invalidate>
                // restart IOs
                BLE_power(1, NULL);
            }
#endif

            USB_power(0);
c0d00044:	4620      	mov	r0, r4
c0d00046:	f002 f989 	bl	c0d0235c <USB_power>
            USB_power(1);
c0d0004a:	2501      	movs	r5, #1
c0d0004c:	4628      	mov	r0, r5
c0d0004e:	f002 f985 	bl	c0d0235c <USB_power>

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
c0d00068:	f000 fb16 	bl	c0d00698 <ui_idle>

            sample_main();
c0d0006c:	f000 fb66 	bl	c0d0073c <sample_main>
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
c0d00082:	f002 fb15 	bl	c0d026b0 <longjmp>
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
c0d000b2:	f001 fb27 	bl	c0d01704 <io_seproxyhal_spi_send>

            if (channel & IO_RESET_AFTER_REPLIED) {
c0d000b6:	b268      	sxtb	r0, r5
c0d000b8:	2800      	cmp	r0, #0
c0d000ba:	da09      	bge.n	c0d000d0 <io_exchange_al+0x38>
                reset();
c0d000bc:	f001 f9bc 	bl	c0d01438 <reset>
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
c0d000ca:	f001 fb55 	bl	c0d01778 <io_seproxyhal_spi_recv>
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
c0d000da:	f002 fae9 	bl	c0d026b0 <longjmp>
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
c0d000ec:	f000 ffd8 	bl	c0d010a0 <io_seproxyhal_display_default>
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
c0d00134:	f001 fac8 	bl	c0d016c8 <os_ux>
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
c0d0014c:	f001 fabc 	bl	c0d016c8 <os_ux>
c0d00150:	61f0      	str	r0, [r6, #28]
c0d00152:	f000 fe5b 	bl	c0d00e0c <io_seproxyhal_init_ux>
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
c0d0017e:	f001 faa3 	bl	c0d016c8 <os_ux>
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
c0d001a8:	f001 fa8e 	bl	c0d016c8 <os_ux>
c0d001ac:	61e8      	str	r0, [r5, #28]
c0d001ae:	f000 fe2d 	bl	c0d00e0c <io_seproxyhal_init_ux>
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
c0d001e4:	f001 fa70 	bl	c0d016c8 <os_ux>
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
c0d00208:	f001 fa5e 	bl	c0d016c8 <os_ux>
c0d0020c:	61e8      	str	r0, [r5, #28]
c0d0020e:	f000 fdfd 	bl	c0d00e0c <io_seproxyhal_init_ux>
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
c0d00228:	f000 fdf0 	bl	c0d00e0c <io_seproxyhal_init_ux>
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
c0d0024c:	f001 fa78 	bl	c0d01740 <io_seproxyhal_spi_is_status_sent>
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
c0d00286:	f001 fa5b 	bl	c0d01740 <io_seproxyhal_spi_is_status_sent>
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
c0d002d4:	f000 ff6a 	bl	c0d011ac <io_seproxyhal_button_push>
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
c0d002e6:	f001 fa2b 	bl	c0d01740 <io_seproxyhal_spi_is_status_sent>
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
c0d0034a:	f000 fdd9 	bl	c0d00f00 <io_seproxyhal_touch_element_callback>
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
c0d00356:	f001 f9f3 	bl	c0d01740 <io_seproxyhal_spi_is_status_sent>
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
c0d00390:	f001 f9d6 	bl	c0d01740 <io_seproxyhal_spi_is_status_sent>
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
c0d003c8:	f000 fe6a 	bl	c0d010a0 <io_seproxyhal_display_default>
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
c0d003e0:	f000 fe5e 	bl	c0d010a0 <io_seproxyhal_display_default>
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
c0d003f8:	f000 fe52 	bl	c0d010a0 <io_seproxyhal_display_default>
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
c0d0040a:	f001 f999 	bl	c0d01740 <io_seproxyhal_spi_is_status_sent>
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
c0d00420:	f000 fe3e 	bl	c0d010a0 <io_seproxyhal_display_default>
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
c0d0043c:	f000 fe30 	bl	c0d010a0 <io_seproxyhal_display_default>
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
c0d00446:	f001 f97b 	bl	c0d01740 <io_seproxyhal_spi_is_status_sent>
c0d0044a:	2800      	cmp	r0, #0
c0d0044c:	d101      	bne.n	c0d00452 <io_event+0x35e>
        io_seproxyhal_general_status();
c0d0044e:	f000 fbb1 	bl	c0d00bb4 <io_seproxyhal_general_status>
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
c0d0046c:	b0ff      	sub	sp, #508	; 0x1fc
c0d0046e:	b0a4      	sub	sp, #144	; 0x90
    } u;
    unsigned char privateKeyData[32];
    unsigned char tmp[25];
    unsigned int length;

    if (!os_global_pin_is_validated()) {
c0d00470:	f001 f8d4 	bl	c0d0161c <os_global_pin_is_validated>
c0d00474:	2800      	cmp	r0, #0
c0d00476:	d071      	beq.n	c0d0055c <derive+0xf4>
c0d00478:	2100      	movs	r1, #0
        os_memmove(address, NOT_AVAILABLE, sizeof(NOT_AVAILABLE));
        return false;
    }

    os_perso_derive_node_bip32(CX_CURVE_256K1, path, 5, privateKeyData, NULL);
c0d0047a:	9103      	str	r1, [sp, #12]
c0d0047c:	4668      	mov	r0, sp
c0d0047e:	6001      	str	r1, [r0, #0]
c0d00480:	2421      	movs	r4, #33	; 0x21
c0d00482:	4972      	ldr	r1, [pc, #456]	; (c0d0064c <derive+0x1e4>)
c0d00484:	2205      	movs	r2, #5
c0d00486:	ad11      	add	r5, sp, #68	; 0x44
c0d00488:	9509      	str	r5, [sp, #36]	; 0x24
c0d0048a:	4620      	mov	r0, r4
c0d0048c:	462b      	mov	r3, r5
c0d0048e:	f001 f8a5 	bl	c0d015dc <os_perso_derive_node_bip32>

    cx_ecdsa_init_private_key(CX_CURVE_256K1, privateKeyData, 32, &privateKey);
c0d00492:	2220      	movs	r2, #32
c0d00494:	9208      	str	r2, [sp, #32]
c0d00496:	ab47      	add	r3, sp, #284	; 0x11c
c0d00498:	9306      	str	r3, [sp, #24]
c0d0049a:	4620      	mov	r0, r4
c0d0049c:	9407      	str	r4, [sp, #28]
c0d0049e:	4629      	mov	r1, r5
c0d004a0:	f001 f860 	bl	c0d01564 <cx_ecfp_init_private_key>
c0d004a4:	ae34      	add	r6, sp, #208	; 0xd0
c0d004a6:	2501      	movs	r5, #1
    cx_ecfp_generate_pair(CX_CURVE_256K1, &publicKey, &privateKey, 1);
c0d004a8:	4620      	mov	r0, r4
c0d004aa:	4631      	mov	r1, r6
c0d004ac:	9a06      	ldr	r2, [sp, #24]
c0d004ae:	462b      	mov	r3, r5
c0d004b0:	f001 f876 	bl	c0d015a0 <cx_ecfp_generate_pair>
    publicKey.W[0] = ((publicKey.W[64] & 1) ? 0x03 : 0x02);
c0d004b4:	2048      	movs	r0, #72	; 0x48
c0d004b6:	5c30      	ldrb	r0, [r6, r0]
c0d004b8:	4028      	ands	r0, r5
c0d004ba:	2102      	movs	r1, #2
c0d004bc:	4301      	orrs	r1, r0
c0d004be:	7231      	strb	r1, [r6, #8]
c0d004c0:	ac19      	add	r4, sp, #100	; 0x64
    cx_sha256_init(&u.shasha);
c0d004c2:	4620      	mov	r0, r4
c0d004c4:	f001 f810 	bl	c0d014e8 <cx_sha256_init>
    cx_hash(&u.shasha.header, CX_LAST, publicKey.W, 33, privateKeyData);
c0d004c8:	4668      	mov	r0, sp
c0d004ca:	9909      	ldr	r1, [sp, #36]	; 0x24
c0d004cc:	6001      	str	r1, [r0, #0]

    os_perso_derive_node_bip32(CX_CURVE_256K1, path, 5, privateKeyData, NULL);

    cx_ecdsa_init_private_key(CX_CURVE_256K1, privateKeyData, 32, &privateKey);
    cx_ecfp_generate_pair(CX_CURVE_256K1, &publicKey, &privateKey, 1);
    publicKey.W[0] = ((publicKey.W[64] & 1) ? 0x03 : 0x02);
c0d004ce:	3608      	adds	r6, #8
    cx_sha256_init(&u.shasha);
    cx_hash(&u.shasha.header, CX_LAST, publicKey.W, 33, privateKeyData);
c0d004d0:	4620      	mov	r0, r4
c0d004d2:	4629      	mov	r1, r5
c0d004d4:	9502      	str	r5, [sp, #8]
c0d004d6:	4632      	mov	r2, r6
c0d004d8:	9b07      	ldr	r3, [sp, #28]
c0d004da:	f001 f823 	bl	c0d01524 <cx_hash>
    cx_ripemd160_init(&u.riprip);
c0d004de:	4620      	mov	r0, r4
c0d004e0:	f000 ffe4 	bl	c0d014ac <cx_ripemd160_init>
c0d004e4:	ae0a      	add	r6, sp, #40	; 0x28
    cx_hash(&u.riprip.header, CX_LAST, privateKeyData, 32, tmp + 1);
c0d004e6:	1c70      	adds	r0, r6, #1
c0d004e8:	4669      	mov	r1, sp
c0d004ea:	6008      	str	r0, [r1, #0]
c0d004ec:	4620      	mov	r0, r4
c0d004ee:	4629      	mov	r1, r5
c0d004f0:	9d09      	ldr	r5, [sp, #36]	; 0x24
c0d004f2:	462a      	mov	r2, r5
c0d004f4:	9b08      	ldr	r3, [sp, #32]
c0d004f6:	f001 f815 	bl	c0d01524 <cx_hash>
    tmp[0] = 0;
c0d004fa:	9803      	ldr	r0, [sp, #12]
c0d004fc:	7030      	strb	r0, [r6, #0]
    cx_sha256_init(&u.shasha);
c0d004fe:	4620      	mov	r0, r4
c0d00500:	f000 fff2 	bl	c0d014e8 <cx_sha256_init>
    cx_hash(&u.shasha.header, CX_LAST, tmp, 21, privateKeyData);
c0d00504:	4668      	mov	r0, sp
c0d00506:	6005      	str	r5, [r0, #0]
c0d00508:	2315      	movs	r3, #21
c0d0050a:	4620      	mov	r0, r4
c0d0050c:	9d02      	ldr	r5, [sp, #8]
c0d0050e:	4629      	mov	r1, r5
c0d00510:	4632      	mov	r2, r6
c0d00512:	f001 f807 	bl	c0d01524 <cx_hash>
    cx_sha256_init(&u.shasha);
c0d00516:	4620      	mov	r0, r4
c0d00518:	f000 ffe6 	bl	c0d014e8 <cx_sha256_init>
    cx_hash(&u.shasha.header, CX_LAST, privateKeyData, 32, privateKeyData);
c0d0051c:	4668      	mov	r0, sp
c0d0051e:	9a09      	ldr	r2, [sp, #36]	; 0x24
c0d00520:	6002      	str	r2, [r0, #0]
c0d00522:	4620      	mov	r0, r4
c0d00524:	4629      	mov	r1, r5
c0d00526:	9d03      	ldr	r5, [sp, #12]
c0d00528:	4614      	mov	r4, r2
c0d0052a:	9b08      	ldr	r3, [sp, #32]
c0d0052c:	f000 fffa 	bl	c0d01524 <cx_hash>
    os_memmove(tmp + 21, privateKeyData, 4);
c0d00530:	4630      	mov	r0, r6
c0d00532:	3015      	adds	r0, #21
c0d00534:	2204      	movs	r2, #4
c0d00536:	4621      	mov	r1, r4
c0d00538:	f000 faa2 	bl	c0d00a80 <os_memmove>
c0d0053c:	a87a      	add	r0, sp, #488	; 0x1e8
    unsigned char startAt;
    unsigned char zeroCount = 0;
    if (length > sizeof(tmp)) {
        THROW(INVALID_PARAMETER);
    }
    os_memmove(tmp, in, length);
c0d0053e:	2419      	movs	r4, #25
c0d00540:	4631      	mov	r1, r6
c0d00542:	4622      	mov	r2, r4
c0d00544:	f000 fa9c 	bl	c0d00a80 <os_memmove>
c0d00548:	a87a      	add	r0, sp, #488	; 0x1e8
    while ((zeroCount < length) && (tmp[zeroCount] == 0)) {
c0d0054a:	5d40      	ldrb	r0, [r0, r5]
c0d0054c:	2800      	cmp	r0, #0
c0d0054e:	d10d      	bne.n	c0d0056c <derive+0x104>
        ++zeroCount;
c0d00550:	1c6d      	adds	r5, r5, #1
c0d00552:	2632      	movs	r6, #50	; 0x32
    unsigned char zeroCount = 0;
    if (length > sizeof(tmp)) {
        THROW(INVALID_PARAMETER);
    }
    os_memmove(tmp, in, length);
    while ((zeroCount < length) && (tmp[zeroCount] == 0)) {
c0d00554:	2d19      	cmp	r5, #25
c0d00556:	d3f7      	bcc.n	c0d00548 <derive+0xe0>
c0d00558:	4625      	mov	r5, r4
c0d0055a:	e052      	b.n	c0d00602 <derive+0x19a>
    unsigned char privateKeyData[32];
    unsigned char tmp[25];
    unsigned int length;

    if (!os_global_pin_is_validated()) {
        os_memmove(address, NOT_AVAILABLE, sizeof(NOT_AVAILABLE));
c0d0055c:	484b      	ldr	r0, [pc, #300]	; (c0d0068c <BASE58ALPHABET+0x3c>)
c0d0055e:	494d      	ldr	r1, [pc, #308]	; (c0d00694 <BASE58ALPHABET+0x44>)
c0d00560:	4479      	add	r1, pc
c0d00562:	220e      	movs	r2, #14
c0d00564:	f000 fa8c 	bl	c0d00a80 <os_memmove>
c0d00568:	2000      	movs	r0, #0
c0d0056a:	e065      	b.n	c0d00638 <derive+0x1d0>
c0d0056c:	2000      	movs	r0, #0
c0d0056e:	9004      	str	r0, [sp, #16]
c0d00570:	43c0      	mvns	r0, r0
c0d00572:	2632      	movs	r6, #50	; 0x32
c0d00574:	2231      	movs	r2, #49	; 0x31
c0d00576:	9508      	str	r5, [sp, #32]
c0d00578:	9503      	str	r5, [sp, #12]
c0d0057a:	462b      	mov	r3, r5
c0d0057c:	4605      	mov	r5, r0
    }
    j = 2 * length;
    startAt = zeroCount;
    while (startAt < length) {
        unsigned short remainder = 0;
        unsigned char divLoop;
c0d0057e:	9509      	str	r5, [sp, #36]	; 0x24
c0d00580:	9607      	str	r6, [sp, #28]
c0d00582:	9206      	str	r2, [sp, #24]
c0d00584:	9305      	str	r3, [sp, #20]
        for (divLoop = startAt; divLoop < length; divLoop++) {
c0d00586:	b2de      	uxtb	r6, r3
c0d00588:	436e      	muls	r6, r5
c0d0058a:	9904      	ldr	r1, [sp, #16]
            unsigned short digit256 = (unsigned short)(tmp[divLoop] & 0xff);
c0d0058c:	462c      	mov	r4, r5
c0d0058e:	4374      	muls	r4, r6
c0d00590:	ad7a      	add	r5, sp, #488	; 0x1e8
            unsigned short tmpDiv = remainder * 256 + digit256;
c0d00592:	5d2a      	ldrb	r2, [r5, r4]
c0d00594:	0208      	lsls	r0, r1, #8
            tmp[divLoop] = (unsigned char)(tmpDiv / 58);
c0d00596:	4310      	orrs	r0, r2
c0d00598:	213a      	movs	r1, #58	; 0x3a
            remainder = (tmpDiv % 58);
c0d0059a:	f002 f823 	bl	c0d025e4 <__aeabi_uidivmod>
        unsigned short remainder = 0;
        unsigned char divLoop;
        for (divLoop = startAt; divLoop < length; divLoop++) {
            unsigned short digit256 = (unsigned short)(tmp[divLoop] & 0xff);
            unsigned short tmpDiv = remainder * 256 + digit256;
            tmp[divLoop] = (unsigned char)(tmpDiv / 58);
c0d0059e:	5528      	strb	r0, [r5, r4]
c0d005a0:	9d09      	ldr	r5, [sp, #36]	; 0x24
    j = 2 * length;
    startAt = zeroCount;
    while (startAt < length) {
        unsigned short remainder = 0;
        unsigned char divLoop;
        for (divLoop = startAt; divLoop < length; divLoop++) {
c0d005a2:	1e76      	subs	r6, r6, #1
c0d005a4:	4630      	mov	r0, r6
c0d005a6:	3019      	adds	r0, #25
c0d005a8:	d1f0      	bne.n	c0d0058c <derive+0x124>
c0d005aa:	a87a      	add	r0, sp, #488	; 0x1e8
            unsigned short digit256 = (unsigned short)(tmp[divLoop] & 0xff);
            unsigned short tmpDiv = remainder * 256 + digit256;
            tmp[divLoop] = (unsigned char)(tmpDiv / 58);
            remainder = (tmpDiv % 58);
        }
        if (tmp[startAt] == 0) {
c0d005ac:	9a08      	ldr	r2, [sp, #32]
c0d005ae:	5c82      	ldrb	r2, [r0, r2]
            ++startAt;
        }
        buffer[--j] = BASE58ALPHABET[remainder];
c0d005b0:	a027      	add	r0, pc, #156	; (adr r0, c0d00650 <BASE58ALPHABET>)
c0d005b2:	5c43      	ldrb	r3, [r0, r1]
c0d005b4:	9e07      	ldr	r6, [sp, #28]
c0d005b6:	1e76      	subs	r6, r6, #1
c0d005b8:	b2f0      	uxtb	r0, r6
c0d005ba:	ac51      	add	r4, sp, #324	; 0x144
c0d005bc:	9007      	str	r0, [sp, #28]
c0d005be:	5423      	strb	r3, [r4, r0]
c0d005c0:	9805      	ldr	r0, [sp, #20]
            unsigned short digit256 = (unsigned short)(tmp[divLoop] & 0xff);
            unsigned short tmpDiv = remainder * 256 + digit256;
            tmp[divLoop] = (unsigned char)(tmpDiv / 58);
            remainder = (tmpDiv % 58);
        }
        if (tmp[startAt] == 0) {
c0d005c2:	1c43      	adds	r3, r0, #1
c0d005c4:	2a00      	cmp	r2, #0
c0d005c6:	d000      	beq.n	c0d005ca <derive+0x162>
c0d005c8:	4603      	mov	r3, r0
c0d005ca:	b2d8      	uxtb	r0, r3
c0d005cc:	9c06      	ldr	r4, [sp, #24]
    while ((zeroCount < length) && (tmp[zeroCount] == 0)) {
        ++zeroCount;
    }
    j = 2 * length;
    startAt = zeroCount;
    while (startAt < length) {
c0d005ce:	1e62      	subs	r2, r4, #1
c0d005d0:	9008      	str	r0, [sp, #32]
c0d005d2:	2819      	cmp	r0, #25
c0d005d4:	d3d4      	bcc.n	c0d00580 <derive+0x118>
        if (tmp[startAt] == 0) {
            ++startAt;
        }
        buffer[--j] = BASE58ALPHABET[remainder];
    }
    while ((j < (2 * length)) && (buffer[j] == BASE58ALPHABET[0])) {
c0d005d6:	9807      	ldr	r0, [sp, #28]
c0d005d8:	2831      	cmp	r0, #49	; 0x31
c0d005da:	d80e      	bhi.n	c0d005fa <derive+0x192>
c0d005dc:	2900      	cmp	r1, #0
c0d005de:	9d03      	ldr	r5, [sp, #12]
c0d005e0:	d10c      	bne.n	c0d005fc <derive+0x194>
        ++j;
c0d005e2:	b2e0      	uxtb	r0, r4
c0d005e4:	1c40      	adds	r0, r0, #1
c0d005e6:	1c76      	adds	r6, r6, #1
        if (tmp[startAt] == 0) {
            ++startAt;
        }
        buffer[--j] = BASE58ALPHABET[remainder];
    }
    while ((j < (2 * length)) && (buffer[j] == BASE58ALPHABET[0])) {
c0d005e8:	2831      	cmp	r0, #49	; 0x31
c0d005ea:	d807      	bhi.n	c0d005fc <derive+0x194>
c0d005ec:	a951      	add	r1, sp, #324	; 0x144
c0d005ee:	5c09      	ldrb	r1, [r1, r0]
c0d005f0:	1c40      	adds	r0, r0, #1
c0d005f2:	2931      	cmp	r1, #49	; 0x31
c0d005f4:	d0f7      	beq.n	c0d005e6 <derive+0x17e>
c0d005f6:	1e46      	subs	r6, r0, #1
c0d005f8:	e000      	b.n	c0d005fc <derive+0x194>
c0d005fa:	9d03      	ldr	r5, [sp, #12]
c0d005fc:	20ff      	movs	r0, #255	; 0xff
        ++j;
    }
    while (zeroCount-- > 0) {
c0d005fe:	4205      	tst	r5, r0
c0d00600:	d00b      	beq.n	c0d0061a <derive+0x1b2>
c0d00602:	4630      	mov	r0, r6
c0d00604:	4629      	mov	r1, r5
        buffer[--j] = BASE58ALPHABET[0];
c0d00606:	1e40      	subs	r0, r0, #1
c0d00608:	b2c2      	uxtb	r2, r0
c0d0060a:	ab51      	add	r3, sp, #324	; 0x144
c0d0060c:	2431      	movs	r4, #49	; 0x31
c0d0060e:	549c      	strb	r4, [r3, r2]
        buffer[--j] = BASE58ALPHABET[remainder];
    }
    while ((j < (2 * length)) && (buffer[j] == BASE58ALPHABET[0])) {
        ++j;
    }
    while (zeroCount-- > 0) {
c0d00610:	1e49      	subs	r1, r1, #1
c0d00612:	22ff      	movs	r2, #255	; 0xff
c0d00614:	4211      	tst	r1, r2
c0d00616:	d1f6      	bne.n	c0d00606 <derive+0x19e>
c0d00618:	1b76      	subs	r6, r6, r5
        buffer[--j] = BASE58ALPHABET[0];
    }
    length = 2 * length - j;
c0d0061a:	b2f0      	uxtb	r0, r6
c0d0061c:	2132      	movs	r1, #50	; 0x32
c0d0061e:	1a0c      	subs	r4, r1, r0
    if (maxoutlen < length) {
c0d00620:	2c65      	cmp	r4, #101	; 0x65
c0d00622:	d20d      	bcs.n	c0d00640 <derive+0x1d8>
c0d00624:	a951      	add	r1, sp, #324	; 0x144
        THROW(EXCEPTION_OVERFLOW);
    }
    os_memmove(out, (buffer + j), length);
c0d00626:	1809      	adds	r1, r1, r0
c0d00628:	4d18      	ldr	r5, [pc, #96]	; (c0d0068c <BASE58ALPHABET+0x3c>)
c0d0062a:	4628      	mov	r0, r5
c0d0062c:	4622      	mov	r2, r4
c0d0062e:	f000 fa27 	bl	c0d00a80 <os_memmove>
    cx_hash(&u.shasha.header, CX_LAST, tmp, 21, privateKeyData);
    cx_sha256_init(&u.shasha);
    cx_hash(&u.shasha.header, CX_LAST, privateKeyData, 32, privateKeyData);
    os_memmove(tmp + 21, privateKeyData, 4);
    length = encode_base58(tmp, sizeof(tmp), address, sizeof(address));
    address[length] = '\0';
c0d00632:	2000      	movs	r0, #0
c0d00634:	5528      	strb	r0, [r5, r4]
c0d00636:	9802      	ldr	r0, [sp, #8]
    return true;
}
c0d00638:	1ffc      	subs	r4, r7, #7
c0d0063a:	3c05      	subs	r4, #5
c0d0063c:	46a5      	mov	sp, r4
c0d0063e:	bdf0      	pop	{r4, r5, r6, r7, pc}
    while (zeroCount-- > 0) {
        buffer[--j] = BASE58ALPHABET[0];
    }
    length = 2 * length - j;
    if (maxoutlen < length) {
        THROW(EXCEPTION_OVERFLOW);
c0d00640:	4813      	ldr	r0, [pc, #76]	; (c0d00690 <BASE58ALPHABET+0x40>)
c0d00642:	6800      	ldr	r0, [r0, #0]
c0d00644:	2103      	movs	r1, #3
c0d00646:	f002 f833 	bl	c0d026b0 <longjmp>
c0d0064a:	46c0      	nop			; (mov r8, r8)
c0d0064c:	20001930 	.word	0x20001930

c0d00650 <BASE58ALPHABET>:
c0d00650:	34333231 	.word	0x34333231
c0d00654:	38373635 	.word	0x38373635
c0d00658:	43424139 	.word	0x43424139
c0d0065c:	47464544 	.word	0x47464544
c0d00660:	4c4b4a48 	.word	0x4c4b4a48
c0d00664:	51504e4d 	.word	0x51504e4d
c0d00668:	55545352 	.word	0x55545352
c0d0066c:	59585756 	.word	0x59585756
c0d00670:	6362615a 	.word	0x6362615a
c0d00674:	67666564 	.word	0x67666564
c0d00678:	6b6a6968 	.word	0x6b6a6968
c0d0067c:	706f6e6d 	.word	0x706f6e6d
c0d00680:	74737271 	.word	0x74737271
c0d00684:	78777675 	.word	0x78777675
c0d00688:	00007a79 	.word	0x00007a79
c0d0068c:	20001944 	.word	0x20001944
c0d00690:	200019a8 	.word	0x200019a8
c0d00694:	000023e6 	.word	0x000023e6

c0d00698 <ui_idle>:
        THROW(INVALID_PARAMETER);
    }
    return 0;
}

static void ui_idle(void) {
c0d00698:	b5b0      	push	{r4, r5, r7, lr}
c0d0069a:	af02      	add	r7, sp, #8
#ifdef TARGET_BLUE
    UX_DISPLAY(bagl_ui_sample_blue, NULL);
#else
    UX_DISPLAY(bagl_ui_sample_nanos, bagl_ui_sample_nanos_prepro);
c0d0069c:	4c22      	ldr	r4, [pc, #136]	; (c0d00728 <ui_idle+0x90>)
c0d0069e:	4824      	ldr	r0, [pc, #144]	; (c0d00730 <ui_idle+0x98>)
c0d006a0:	4478      	add	r0, pc
c0d006a2:	6020      	str	r0, [r4, #0]
c0d006a4:	2005      	movs	r0, #5
c0d006a6:	6060      	str	r0, [r4, #4]
c0d006a8:	4822      	ldr	r0, [pc, #136]	; (c0d00734 <ui_idle+0x9c>)
c0d006aa:	4478      	add	r0, pc
c0d006ac:	6120      	str	r0, [r4, #16]
c0d006ae:	4822      	ldr	r0, [pc, #136]	; (c0d00738 <ui_idle+0xa0>)
c0d006b0:	4478      	add	r0, pc
c0d006b2:	60e0      	str	r0, [r4, #12]
c0d006b4:	2003      	movs	r0, #3
c0d006b6:	7620      	strb	r0, [r4, #24]
c0d006b8:	2500      	movs	r5, #0
c0d006ba:	61e5      	str	r5, [r4, #28]
c0d006bc:	4620      	mov	r0, r4
c0d006be:	3018      	adds	r0, #24
c0d006c0:	f001 f802 	bl	c0d016c8 <os_ux>
c0d006c4:	61e0      	str	r0, [r4, #28]
c0d006c6:	f000 fba1 	bl	c0d00e0c <io_seproxyhal_init_ux>
c0d006ca:	60a5      	str	r5, [r4, #8]
c0d006cc:	6820      	ldr	r0, [r4, #0]
c0d006ce:	2800      	cmp	r0, #0
c0d006d0:	d028      	beq.n	c0d00724 <ui_idle+0x8c>
c0d006d2:	69e0      	ldr	r0, [r4, #28]
c0d006d4:	4915      	ldr	r1, [pc, #84]	; (c0d0072c <ui_idle+0x94>)
c0d006d6:	4288      	cmp	r0, r1
c0d006d8:	d116      	bne.n	c0d00708 <ui_idle+0x70>
c0d006da:	e023      	b.n	c0d00724 <ui_idle+0x8c>
c0d006dc:	6860      	ldr	r0, [r4, #4]
c0d006de:	4285      	cmp	r5, r0
c0d006e0:	d220      	bcs.n	c0d00724 <ui_idle+0x8c>
c0d006e2:	f001 f82d 	bl	c0d01740 <io_seproxyhal_spi_is_status_sent>
c0d006e6:	2800      	cmp	r0, #0
c0d006e8:	d11c      	bne.n	c0d00724 <ui_idle+0x8c>
c0d006ea:	68a0      	ldr	r0, [r4, #8]
c0d006ec:	68e1      	ldr	r1, [r4, #12]
c0d006ee:	2538      	movs	r5, #56	; 0x38
c0d006f0:	4368      	muls	r0, r5
c0d006f2:	6822      	ldr	r2, [r4, #0]
c0d006f4:	1810      	adds	r0, r2, r0
c0d006f6:	2900      	cmp	r1, #0
c0d006f8:	d009      	beq.n	c0d0070e <ui_idle+0x76>
c0d006fa:	4788      	blx	r1
c0d006fc:	2800      	cmp	r0, #0
c0d006fe:	d106      	bne.n	c0d0070e <ui_idle+0x76>
c0d00700:	68a0      	ldr	r0, [r4, #8]
c0d00702:	1c45      	adds	r5, r0, #1
c0d00704:	60a5      	str	r5, [r4, #8]
c0d00706:	6820      	ldr	r0, [r4, #0]
c0d00708:	2800      	cmp	r0, #0
c0d0070a:	d1e7      	bne.n	c0d006dc <ui_idle+0x44>
c0d0070c:	e00a      	b.n	c0d00724 <ui_idle+0x8c>
c0d0070e:	2801      	cmp	r0, #1
c0d00710:	d103      	bne.n	c0d0071a <ui_idle+0x82>
c0d00712:	68a0      	ldr	r0, [r4, #8]
c0d00714:	4345      	muls	r5, r0
c0d00716:	6820      	ldr	r0, [r4, #0]
c0d00718:	1940      	adds	r0, r0, r5
return_to_dashboard:
    return;
}

void io_seproxyhal_display(const bagl_element_t *element) {
    io_seproxyhal_display_default((bagl_element_t *)element);
c0d0071a:	f000 fcc1 	bl	c0d010a0 <io_seproxyhal_display_default>
c0d0071e:	68a0      	ldr	r0, [r4, #8]
c0d00720:	1c40      	adds	r0, r0, #1

static void ui_idle(void) {
#ifdef TARGET_BLUE
    UX_DISPLAY(bagl_ui_sample_blue, NULL);
#else
    UX_DISPLAY(bagl_ui_sample_nanos, bagl_ui_sample_nanos_prepro);
c0d00722:	60a0      	str	r0, [r4, #8]
#endif
}
c0d00724:	bdb0      	pop	{r4, r5, r7, pc}
c0d00726:	46c0      	nop			; (mov r8, r8)
c0d00728:	20001880 	.word	0x20001880
c0d0072c:	b0105044 	.word	0xb0105044
c0d00730:	00002090 	.word	0x00002090
c0d00734:	000001af 	.word	0x000001af
c0d00738:	0000021d 	.word	0x0000021d

c0d0073c <sample_main>:

static void sample_main(void) {
c0d0073c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0073e:	af03      	add	r7, sp, #12
c0d00740:	b091      	sub	sp, #68	; 0x44
c0d00742:	2600      	movs	r6, #0
    volatile unsigned int rx = 0;
c0d00744:	9610      	str	r6, [sp, #64]	; 0x40
    volatile unsigned int tx = 0;
c0d00746:	960f      	str	r6, [sp, #60]	; 0x3c
    volatile unsigned int flags = 0;
c0d00748:	960e      	str	r6, [sp, #56]	; 0x38
c0d0074a:	a80d      	add	r0, sp, #52	; 0x34
    // When APDU are to be fetched from multiple IOs, like NFC+USB+BLE, make
    // sure the io_event is called with a
    // switch event, before the apdu is replied to the bootloader. This avoid
    // APDU injection faults.
    for (;;) {
        volatile unsigned short sw = 0;
c0d0074c:	8006      	strh	r6, [r0, #0]

        BEGIN_TRY {
            TRY {
c0d0074e:	4d3e      	ldr	r5, [pc, #248]	; (c0d00848 <sample_main+0x10c>)
c0d00750:	6828      	ldr	r0, [r5, #0]
c0d00752:	900b      	str	r0, [sp, #44]	; 0x2c
c0d00754:	ac01      	add	r4, sp, #4
c0d00756:	4620      	mov	r0, r4
c0d00758:	f001 ff9e 	bl	c0d02698 <setjmp>
c0d0075c:	85a0      	strh	r0, [r4, #44]	; 0x2c
c0d0075e:	602c      	str	r4, [r5, #0]
c0d00760:	462c      	mov	r4, r5
c0d00762:	4d3a      	ldr	r5, [pc, #232]	; (c0d0084c <sample_main+0x110>)
c0d00764:	e030      	b.n	c0d007c8 <sample_main+0x8c>
c0d00766:	a901      	add	r1, sp, #4
                default:
                    THROW(0x6D00);
                    break;
                }
            }
            CATCH_OTHER(e) {
c0d00768:	858e      	strh	r6, [r1, #44]	; 0x2c
c0d0076a:	990b      	ldr	r1, [sp, #44]	; 0x2c
c0d0076c:	6021      	str	r1, [r4, #0]
c0d0076e:	220f      	movs	r2, #15
c0d00770:	0312      	lsls	r2, r2, #12
                switch (e & 0xF000) {
c0d00772:	4002      	ands	r2, r0
c0d00774:	2309      	movs	r3, #9
c0d00776:	031b      	lsls	r3, r3, #12
c0d00778:	429a      	cmp	r2, r3
c0d0077a:	d003      	beq.n	c0d00784 <sample_main+0x48>
c0d0077c:	2303      	movs	r3, #3
c0d0077e:	035b      	lsls	r3, r3, #13
c0d00780:	429a      	cmp	r2, r3
c0d00782:	d102      	bne.n	c0d0078a <sample_main+0x4e>
c0d00784:	aa0d      	add	r2, sp, #52	; 0x34
                case 0x6000:
                case 0x9000:
                    sw = e;
c0d00786:	8010      	strh	r0, [r2, #0]
c0d00788:	e006      	b.n	c0d00798 <sample_main+0x5c>
                    break;
                default:
                    sw = 0x6800 | (e & 0x7FF);
c0d0078a:	4a31      	ldr	r2, [pc, #196]	; (c0d00850 <sample_main+0x114>)
c0d0078c:	4010      	ands	r0, r2
c0d0078e:	220d      	movs	r2, #13
c0d00790:	02d2      	lsls	r2, r2, #11
c0d00792:	4302      	orrs	r2, r0
c0d00794:	a80d      	add	r0, sp, #52	; 0x34
c0d00796:	8002      	strh	r2, [r0, #0]
                    break;
                }
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
c0d00798:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d0079a:	0a00      	lsrs	r0, r0, #8
c0d0079c:	9a0f      	ldr	r2, [sp, #60]	; 0x3c
c0d0079e:	4b2d      	ldr	r3, [pc, #180]	; (c0d00854 <sample_main+0x118>)
c0d007a0:	5498      	strb	r0, [r3, r2]
                G_io_apdu_buffer[tx + 1] = sw;
c0d007a2:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d007a4:	9a0f      	ldr	r2, [sp, #60]	; 0x3c
                default:
                    sw = 0x6800 | (e & 0x7FF);
                    break;
                }
                // Unexpected exception => report
                G_io_apdu_buffer[tx] = sw >> 8;
c0d007a6:	189a      	adds	r2, r3, r2
                G_io_apdu_buffer[tx + 1] = sw;
c0d007a8:	7050      	strb	r0, [r2, #1]
                tx += 2;
c0d007aa:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d007ac:	1c80      	adds	r0, r0, #2
c0d007ae:	900f      	str	r0, [sp, #60]	; 0x3c
            }
            FINALLY {
c0d007b0:	6021      	str	r1, [r4, #0]
c0d007b2:	a80d      	add	r0, sp, #52	; 0x34
    // When APDU are to be fetched from multiple IOs, like NFC+USB+BLE, make
    // sure the io_event is called with a
    // switch event, before the apdu is replied to the bootloader. This avoid
    // APDU injection faults.
    for (;;) {
        volatile unsigned short sw = 0;
c0d007b4:	8006      	strh	r6, [r0, #0]

        BEGIN_TRY {
            TRY {
c0d007b6:	910b      	str	r1, [sp, #44]	; 0x2c
c0d007b8:	ac01      	add	r4, sp, #4
c0d007ba:	4620      	mov	r0, r4
c0d007bc:	f001 ff6c 	bl	c0d02698 <setjmp>
c0d007c0:	85a0      	strh	r0, [r4, #44]	; 0x2c
c0d007c2:	4921      	ldr	r1, [pc, #132]	; (c0d00848 <sample_main+0x10c>)
c0d007c4:	600c      	str	r4, [r1, #0]
c0d007c6:	4c20      	ldr	r4, [pc, #128]	; (c0d00848 <sample_main+0x10c>)
c0d007c8:	4228      	tst	r0, r5
c0d007ca:	d1cc      	bne.n	c0d00766 <sample_main+0x2a>
                rx = tx;
c0d007cc:	980f      	ldr	r0, [sp, #60]	; 0x3c
c0d007ce:	9010      	str	r0, [sp, #64]	; 0x40
c0d007d0:	2400      	movs	r4, #0
                tx = 0; // ensure no race in catch_other if io_exchange throws
c0d007d2:	940f      	str	r4, [sp, #60]	; 0x3c
                        // an error
                rx = io_exchange(CHANNEL_APDU | flags, rx);
c0d007d4:	980e      	ldr	r0, [sp, #56]	; 0x38
c0d007d6:	9910      	ldr	r1, [sp, #64]	; 0x40
c0d007d8:	b2c0      	uxtb	r0, r0
c0d007da:	b289      	uxth	r1, r1
c0d007dc:	f000 fd22 	bl	c0d01224 <io_exchange>
c0d007e0:	9010      	str	r0, [sp, #64]	; 0x40
                flags = 0;
c0d007e2:	940e      	str	r4, [sp, #56]	; 0x38

                // no apdu received, well, reset the session, and reset the
                // bootloader configuration
                if (rx == 0) {
c0d007e4:	9810      	ldr	r0, [sp, #64]	; 0x40
c0d007e6:	2800      	cmp	r0, #0
c0d007e8:	d00c      	beq.n	c0d00804 <sample_main+0xc8>
                    THROW(0x6982);
                }

                if (G_io_apdu_buffer[0] != 0x80) {
c0d007ea:	481a      	ldr	r0, [pc, #104]	; (c0d00854 <sample_main+0x118>)
c0d007ec:	7801      	ldrb	r1, [r0, #0]
c0d007ee:	2980      	cmp	r1, #128	; 0x80
c0d007f0:	d10d      	bne.n	c0d0080e <sample_main+0xd2>
c0d007f2:	7840      	ldrb	r0, [r0, #1]
c0d007f4:	2109      	movs	r1, #9
c0d007f6:	0309      	lsls	r1, r1, #12
                    THROW(0x6E00);
                }

                // unauthenticated instruction
                switch (G_io_apdu_buffer[1]) {
c0d007f8:	28fe      	cmp	r0, #254	; 0xfe
c0d007fa:	dd0e      	ble.n	c0d0081a <sample_main+0xde>
c0d007fc:	28ff      	cmp	r0, #255	; 0xff
c0d007fe:	d11d      	bne.n	c0d0083c <sample_main+0x100>
        END_TRY;
    }

return_to_dashboard:
    return;
}
c0d00800:	b011      	add	sp, #68	; 0x44
c0d00802:	bdf0      	pop	{r4, r5, r6, r7, pc}
                flags = 0;

                // no apdu received, well, reset the session, and reset the
                // bootloader configuration
                if (rx == 0) {
                    THROW(0x6982);
c0d00804:	4810      	ldr	r0, [pc, #64]	; (c0d00848 <sample_main+0x10c>)
c0d00806:	6800      	ldr	r0, [r0, #0]
c0d00808:	4913      	ldr	r1, [pc, #76]	; (c0d00858 <sample_main+0x11c>)
c0d0080a:	f001 ff51 	bl	c0d026b0 <longjmp>
                }

                if (G_io_apdu_buffer[0] != 0x80) {
                    THROW(0x6E00);
c0d0080e:	480e      	ldr	r0, [pc, #56]	; (c0d00848 <sample_main+0x10c>)
c0d00810:	6800      	ldr	r0, [r0, #0]
c0d00812:	2137      	movs	r1, #55	; 0x37
c0d00814:	0249      	lsls	r1, r1, #9
c0d00816:	f001 ff4b 	bl	c0d026b0 <longjmp>
c0d0081a:	2800      	cmp	r0, #0
c0d0081c:	d006      	beq.n	c0d0082c <sample_main+0xf0>
c0d0081e:	2801      	cmp	r0, #1
c0d00820:	d008      	beq.n	c0d00834 <sample_main+0xf8>
c0d00822:	2802      	cmp	r0, #2
c0d00824:	d10a      	bne.n	c0d0083c <sample_main+0x100>
                case 0x01: // case 1
                    THROW(0x9000);
                    break;

                case 0x02: // echo
                    tx = rx;
c0d00826:	9810      	ldr	r0, [sp, #64]	; 0x40
c0d00828:	900f      	str	r0, [sp, #60]	; 0x3c
c0d0082a:	e003      	b.n	c0d00834 <sample_main+0xf8>
                }

                // unauthenticated instruction
                switch (G_io_apdu_buffer[1]) {
                case 0x00: // reset
                    flags |= IO_RESET_AFTER_REPLIED;
c0d0082c:	2080      	movs	r0, #128	; 0x80
c0d0082e:	9a0e      	ldr	r2, [sp, #56]	; 0x38
c0d00830:	4302      	orrs	r2, r0
c0d00832:	920e      	str	r2, [sp, #56]	; 0x38
c0d00834:	4804      	ldr	r0, [pc, #16]	; (c0d00848 <sample_main+0x10c>)
c0d00836:	6800      	ldr	r0, [r0, #0]
c0d00838:	f001 ff3a 	bl	c0d026b0 <longjmp>

                case 0xFF: // return to dashboard
                    goto return_to_dashboard;

                default:
                    THROW(0x6D00);
c0d0083c:	4802      	ldr	r0, [pc, #8]	; (c0d00848 <sample_main+0x10c>)
c0d0083e:	6800      	ldr	r0, [r0, #0]
c0d00840:	216d      	movs	r1, #109	; 0x6d
c0d00842:	0209      	lsls	r1, r1, #8
c0d00844:	f001 ff34 	bl	c0d026b0 <longjmp>
c0d00848:	200019a8 	.word	0x200019a8
c0d0084c:	0000ffff 	.word	0x0000ffff
c0d00850:	000007ff 	.word	0x000007ff
c0d00854:	200019f8 	.word	0x200019f8
c0d00858:	00006982 	.word	0x00006982

c0d0085c <bagl_ui_sample_nanos_button>:
    return element;
}

static unsigned int
bagl_ui_sample_nanos_button(unsigned int button_mask,
                            unsigned int button_mask_counter) {
c0d0085c:	b5d0      	push	{r4, r6, r7, lr}
c0d0085e:	af02      	add	r7, sp, #8
c0d00860:	b0a6      	sub	sp, #152	; 0x98
    switch (button_mask) {
c0d00862:	4917      	ldr	r1, [pc, #92]	; (c0d008c0 <bagl_ui_sample_nanos_button+0x64>)
c0d00864:	4288      	cmp	r0, r1
c0d00866:	d017      	beq.n	c0d00898 <bagl_ui_sample_nanos_button+0x3c>
c0d00868:	4916      	ldr	r1, [pc, #88]	; (c0d008c4 <bagl_ui_sample_nanos_button+0x68>)
c0d0086a:	4288      	cmp	r0, r1
c0d0086c:	d018      	beq.n	c0d008a0 <bagl_ui_sample_nanos_button+0x44>
c0d0086e:	4916      	ldr	r1, [pc, #88]	; (c0d008c8 <bagl_ui_sample_nanos_button+0x6c>)
c0d00870:	4288      	cmp	r0, r1
c0d00872:	d122      	bne.n	c0d008ba <bagl_ui_sample_nanos_button+0x5e>
    ui_idle();
    return NULL;
}

static const bagl_element_t *io_seproxyhal_touch_auth(const bagl_element_t *e) {
    if (!os_global_pin_is_validated()) {
c0d00874:	f000 fed2 	bl	c0d0161c <os_global_pin_is_validated>
c0d00878:	2800      	cmp	r0, #0
c0d0087a:	d11e      	bne.n	c0d008ba <bagl_ui_sample_nanos_button+0x5e>
c0d0087c:	466c      	mov	r4, sp
c0d0087e:	2100      	movs	r1, #0
        bolos_ux_params_t params;
        os_memset(&params, 0, sizeof(params));
c0d00880:	2298      	movs	r2, #152	; 0x98
c0d00882:	4620      	mov	r0, r4
c0d00884:	f000 f8f2 	bl	c0d00a6c <os_memset>
        params.ux_id = BOLOS_UX_VALIDATE_PIN;
c0d00888:	200f      	movs	r0, #15
c0d0088a:	7020      	strb	r0, [r4, #0]
        os_ux_blocking(&params);
c0d0088c:	4620      	mov	r0, r4
c0d0088e:	f000 fd6b 	bl	c0d01368 <os_ux_blocking>
        derive();
c0d00892:	f7ff fde9 	bl	c0d00468 <derive>
c0d00896:	e00e      	b.n	c0d008b6 <bagl_ui_sample_nanos_button+0x5a>

#endif

static const bagl_element_t *io_seproxyhal_touch_exit(const bagl_element_t *e) {
    // Go back to the dashboard
    os_sched_exit(0);
c0d00898:	2000      	movs	r0, #0
c0d0089a:	f000 fef7 	bl	c0d0168c <os_sched_exit>
c0d0089e:	e00c      	b.n	c0d008ba <bagl_ui_sample_nanos_button+0x5e>
    return NULL;
}

static const bagl_element_t *io_seproxyhal_touch_next(const bagl_element_t *e) {
    path[4]++;
c0d008a0:	4c0a      	ldr	r4, [pc, #40]	; (c0d008cc <bagl_ui_sample_nanos_button+0x70>)
c0d008a2:	6920      	ldr	r0, [r4, #16]
c0d008a4:	1c40      	adds	r0, r0, #1
c0d008a6:	6120      	str	r0, [r4, #16]
    if (!derive()) {
c0d008a8:	f7ff fdde 	bl	c0d00468 <derive>
c0d008ac:	2800      	cmp	r0, #0
c0d008ae:	d102      	bne.n	c0d008b6 <bagl_ui_sample_nanos_button+0x5a>
        path[4]--;
c0d008b0:	6920      	ldr	r0, [r4, #16]
c0d008b2:	1e40      	subs	r0, r0, #1
c0d008b4:	6120      	str	r0, [r4, #16]
c0d008b6:	f7ff feef 	bl	c0d00698 <ui_idle>

    case BUTTON_EVT_RELEASED | BUTTON_LEFT | BUTTON_RIGHT: // EXIT
        io_seproxyhal_touch_exit(NULL);
        break;
    }
    return 0;
c0d008ba:	2000      	movs	r0, #0
c0d008bc:	b026      	add	sp, #152	; 0x98
c0d008be:	bdd0      	pop	{r4, r6, r7, pc}
c0d008c0:	80000003 	.word	0x80000003
c0d008c4:	80000002 	.word	0x80000002
c0d008c8:	80000001 	.word	0x80000001
c0d008cc:	20001930 	.word	0x20001930

c0d008d0 <bagl_ui_sample_nanos_prepro>:
        NULL,
    },
};

static const bagl_element_t*
bagl_ui_sample_nanos_prepro(const bagl_element_t *element) {
c0d008d0:	b5b0      	push	{r4, r5, r7, lr}
c0d008d2:	af02      	add	r7, sp, #8
c0d008d4:	4604      	mov	r4, r0
    switch (element->component.userid) {
c0d008d6:	7860      	ldrb	r0, [r4, #1]
c0d008d8:	2802      	cmp	r0, #2
c0d008da:	d110      	bne.n	c0d008fe <bagl_ui_sample_nanos_prepro+0x2e>
    case 2:
        io_seproxyhal_setup_ticker(
            MAX(3000, 1000 + bagl_label_roundtrip_duration_ms(element, 7)));
c0d008dc:	2107      	movs	r1, #7
c0d008de:	4620      	mov	r0, r4
c0d008e0:	f000 fc20 	bl	c0d01124 <bagl_label_roundtrip_duration_ms>
c0d008e4:	217d      	movs	r1, #125	; 0x7d
c0d008e6:	00cd      	lsls	r5, r1, #3
c0d008e8:	1941      	adds	r1, r0, r5
c0d008ea:	4806      	ldr	r0, [pc, #24]	; (c0d00904 <bagl_ui_sample_nanos_prepro+0x34>)
c0d008ec:	4281      	cmp	r1, r0
c0d008ee:	d304      	bcc.n	c0d008fa <bagl_ui_sample_nanos_prepro+0x2a>
c0d008f0:	2107      	movs	r1, #7
c0d008f2:	4620      	mov	r0, r4
c0d008f4:	f000 fc16 	bl	c0d01124 <bagl_label_roundtrip_duration_ms>
c0d008f8:	1940      	adds	r0, r0, r5

static const bagl_element_t*
bagl_ui_sample_nanos_prepro(const bagl_element_t *element) {
    switch (element->component.userid) {
    case 2:
        io_seproxyhal_setup_ticker(
c0d008fa:	f000 fc43 	bl	c0d01184 <io_seproxyhal_setup_ticker>
            MAX(3000, 1000 + bagl_label_roundtrip_duration_ms(element, 7)));
        break;
    }
    return element;
c0d008fe:	4620      	mov	r0, r4
c0d00900:	bdb0      	pop	{r4, r5, r7, pc}
c0d00902:	46c0      	nop			; (mov r8, r8)
c0d00904:	00000bb8 	.word	0x00000bb8

c0d00908 <os_boot>:

void os_boot(void) {
  // TODO patch entry point when romming (f)

  // at startup no exception context in use
  G_try_last_open_context = NULL;
c0d00908:	4801      	ldr	r0, [pc, #4]	; (c0d00910 <os_boot+0x8>)
c0d0090a:	2100      	movs	r1, #0
c0d0090c:	6001      	str	r1, [r0, #0]
}
c0d0090e:	4770      	bx	lr
c0d00910:	200019a8 	.word	0x200019a8

c0d00914 <io_usb_hid_receive>:
volatile unsigned int   G_io_usb_hid_total_length;
volatile unsigned int   G_io_usb_hid_remaining_length;
volatile unsigned int   G_io_usb_hid_sequence_number;
volatile unsigned char* G_io_usb_hid_current_buffer;

io_usb_hid_receive_status_t io_usb_hid_receive (io_send_t sndfct, unsigned char* buffer, unsigned short l) {
c0d00914:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00916:	af03      	add	r7, sp, #12
c0d00918:	b083      	sub	sp, #12
c0d0091a:	9202      	str	r2, [sp, #8]
c0d0091c:	460c      	mov	r4, r1
c0d0091e:	9001      	str	r0, [sp, #4]
  // avoid over/under flows
  if (buffer != G_io_hid_chunk) {
c0d00920:	4d4a      	ldr	r5, [pc, #296]	; (c0d00a4c <io_usb_hid_receive+0x138>)
c0d00922:	42ac      	cmp	r4, r5
c0d00924:	d00f      	beq.n	c0d00946 <io_usb_hid_receive+0x32>
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d00926:	4e49      	ldr	r6, [pc, #292]	; (c0d00a4c <io_usb_hid_receive+0x138>)
c0d00928:	2540      	movs	r5, #64	; 0x40
c0d0092a:	4630      	mov	r0, r6
c0d0092c:	4629      	mov	r1, r5
c0d0092e:	f001 fe5f 	bl	c0d025f0 <__aeabi_memclr>
c0d00932:	9802      	ldr	r0, [sp, #8]

io_usb_hid_receive_status_t io_usb_hid_receive (io_send_t sndfct, unsigned char* buffer, unsigned short l) {
  // avoid over/under flows
  if (buffer != G_io_hid_chunk) {
    os_memset(G_io_hid_chunk, 0, sizeof(G_io_hid_chunk));
    os_memmove(G_io_hid_chunk, buffer, MIN(l, sizeof(G_io_hid_chunk)));
c0d00934:	2840      	cmp	r0, #64	; 0x40
c0d00936:	4602      	mov	r2, r0
c0d00938:	d300      	bcc.n	c0d0093c <io_usb_hid_receive+0x28>
c0d0093a:	462a      	mov	r2, r5
c0d0093c:	4630      	mov	r0, r6
c0d0093e:	4621      	mov	r1, r4
c0d00940:	f000 f89e 	bl	c0d00a80 <os_memmove>
c0d00944:	4d41      	ldr	r5, [pc, #260]	; (c0d00a4c <io_usb_hid_receive+0x138>)
  }

  // process the chunk content
  switch(G_io_hid_chunk[2]) {
c0d00946:	78a8      	ldrb	r0, [r5, #2]
c0d00948:	2805      	cmp	r0, #5
c0d0094a:	d900      	bls.n	c0d0094e <io_usb_hid_receive+0x3a>
c0d0094c:	e076      	b.n	c0d00a3c <io_usb_hid_receive+0x128>
c0d0094e:	46c0      	nop			; (mov r8, r8)
c0d00950:	4478      	add	r0, pc
c0d00952:	7900      	ldrb	r0, [r0, #4]
c0d00954:	0040      	lsls	r0, r0, #1
c0d00956:	4487      	add	pc, r0
c0d00958:	71130c02 	.word	0x71130c02
c0d0095c:	1f71      	.short	0x1f71
c0d0095e:	2600      	movs	r6, #0
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d00960:	71ae      	strb	r6, [r5, #6]
c0d00962:	716e      	strb	r6, [r5, #5]
c0d00964:	712e      	strb	r6, [r5, #4]
c0d00966:	70ee      	strb	r6, [r5, #3]

  case 0x00: // get version ID
    // do not reset the current apdu reception if any
    os_memset(G_io_hid_chunk+3, 0, 4); // PROTOCOL VERSION is 0
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d00968:	2140      	movs	r1, #64	; 0x40
c0d0096a:	4628      	mov	r0, r5
c0d0096c:	9a01      	ldr	r2, [sp, #4]
c0d0096e:	4790      	blx	r2
c0d00970:	e00b      	b.n	c0d0098a <io_usb_hid_receive+0x76>
    // await for the next chunk
    goto apdu_reset;

  case 0x01: // ALLOCATE CHANNEL
    // do not reset the current apdu reception if any
    cx_rng(G_io_hid_chunk+3, 4);
c0d00972:	1ce8      	adds	r0, r5, #3
c0d00974:	2104      	movs	r1, #4
c0d00976:	f000 fd7b 	bl	c0d01470 <cx_rng>
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d0097a:	2140      	movs	r1, #64	; 0x40
c0d0097c:	4628      	mov	r0, r5
c0d0097e:	e001      	b.n	c0d00984 <io_usb_hid_receive+0x70>
    goto apdu_reset;

  case 0x02: // ECHO|PING
    // do not reset the current apdu reception if any
    // send the response
    sndfct(G_io_hid_chunk, IO_HID_EP_LENGTH);
c0d00980:	4832      	ldr	r0, [pc, #200]	; (c0d00a4c <io_usb_hid_receive+0x138>)
c0d00982:	2140      	movs	r1, #64	; 0x40
c0d00984:	9a01      	ldr	r2, [sp, #4]
c0d00986:	4790      	blx	r2
c0d00988:	2600      	movs	r6, #0
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d0098a:	4831      	ldr	r0, [pc, #196]	; (c0d00a50 <io_usb_hid_receive+0x13c>)
c0d0098c:	2100      	movs	r1, #0
c0d0098e:	6001      	str	r1, [r0, #0]
c0d00990:	4630      	mov	r0, r6
  return IO_USB_APDU_RECEIVED;

apdu_reset:
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}
c0d00992:	b2c0      	uxtb	r0, r0
c0d00994:	b003      	add	sp, #12
c0d00996:	bdf0      	pop	{r4, r5, r6, r7, pc}

  // process the chunk content
  switch(G_io_hid_chunk[2]) {
  case 0x05:
    // ensure sequence idx is 0 for the first chunk ! 
    if (G_io_hid_chunk[3] != (G_io_usb_hid_sequence_number>>8) || G_io_hid_chunk[4] != (G_io_usb_hid_sequence_number&0xFF)) {
c0d00998:	78e8      	ldrb	r0, [r5, #3]
c0d0099a:	4c2d      	ldr	r4, [pc, #180]	; (c0d00a50 <io_usb_hid_receive+0x13c>)
c0d0099c:	6821      	ldr	r1, [r4, #0]
c0d0099e:	0a09      	lsrs	r1, r1, #8
c0d009a0:	2600      	movs	r6, #0
c0d009a2:	4288      	cmp	r0, r1
c0d009a4:	d1f1      	bne.n	c0d0098a <io_usb_hid_receive+0x76>
c0d009a6:	7928      	ldrb	r0, [r5, #4]
c0d009a8:	6821      	ldr	r1, [r4, #0]
c0d009aa:	b2c9      	uxtb	r1, r1
c0d009ac:	4288      	cmp	r0, r1
c0d009ae:	d1ec      	bne.n	c0d0098a <io_usb_hid_receive+0x76>
c0d009b0:	4b28      	ldr	r3, [pc, #160]	; (c0d00a54 <io_usb_hid_receive+0x140>)
      // ignore packet
      goto apdu_reset;
    }
    // cid, tag, seq
    l -= 2+1+2;
c0d009b2:	9802      	ldr	r0, [sp, #8]
c0d009b4:	18c0      	adds	r0, r0, r3
c0d009b6:	1f05      	subs	r5, r0, #4
    
    // append the received chunk to the current command apdu
    if (G_io_usb_hid_sequence_number == 0) {
c0d009b8:	6820      	ldr	r0, [r4, #0]
c0d009ba:	2800      	cmp	r0, #0
c0d009bc:	d00e      	beq.n	c0d009dc <io_usb_hid_receive+0xc8>
      // copy data
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+7, l);
    }
    else {
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (l > G_io_usb_hid_remaining_length) {
c0d009be:	4629      	mov	r1, r5
c0d009c0:	4019      	ands	r1, r3
c0d009c2:	4825      	ldr	r0, [pc, #148]	; (c0d00a58 <io_usb_hid_receive+0x144>)
c0d009c4:	6802      	ldr	r2, [r0, #0]
c0d009c6:	4291      	cmp	r1, r2
c0d009c8:	461e      	mov	r6, r3
c0d009ca:	d900      	bls.n	c0d009ce <io_usb_hid_receive+0xba>
        l = G_io_usb_hid_remaining_length;
c0d009cc:	6805      	ldr	r5, [r0, #0]
      }

      /// This is a following chunk
      // append content
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+5, l);
c0d009ce:	462a      	mov	r2, r5
c0d009d0:	4032      	ands	r2, r6
c0d009d2:	4822      	ldr	r0, [pc, #136]	; (c0d00a5c <io_usb_hid_receive+0x148>)
c0d009d4:	6800      	ldr	r0, [r0, #0]
c0d009d6:	491d      	ldr	r1, [pc, #116]	; (c0d00a4c <io_usb_hid_receive+0x138>)
c0d009d8:	1d49      	adds	r1, r1, #5
c0d009da:	e021      	b.n	c0d00a20 <io_usb_hid_receive+0x10c>
c0d009dc:	9301      	str	r3, [sp, #4]
c0d009de:	491b      	ldr	r1, [pc, #108]	; (c0d00a4c <io_usb_hid_receive+0x138>)
    
    // append the received chunk to the current command apdu
    if (G_io_usb_hid_sequence_number == 0) {
      /// This is the apdu first chunk
      // total apdu size to receive
      G_io_usb_hid_total_length = (G_io_hid_chunk[5]<<8)+(G_io_hid_chunk[6]&0xFF);
c0d009e0:	7988      	ldrb	r0, [r1, #6]
c0d009e2:	7949      	ldrb	r1, [r1, #5]
c0d009e4:	0209      	lsls	r1, r1, #8
c0d009e6:	4301      	orrs	r1, r0
c0d009e8:	481d      	ldr	r0, [pc, #116]	; (c0d00a60 <io_usb_hid_receive+0x14c>)
c0d009ea:	6001      	str	r1, [r0, #0]
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (G_io_usb_hid_total_length > sizeof(G_io_apdu_buffer)) {
c0d009ec:	6801      	ldr	r1, [r0, #0]
c0d009ee:	2241      	movs	r2, #65	; 0x41
c0d009f0:	0092      	lsls	r2, r2, #2
c0d009f2:	4291      	cmp	r1, r2
c0d009f4:	d8c9      	bhi.n	c0d0098a <io_usb_hid_receive+0x76>
        goto apdu_reset;
      }
      // seq and total length
      l -= 2;
      // compute remaining size to receive
      G_io_usb_hid_remaining_length = G_io_usb_hid_total_length;
c0d009f6:	6801      	ldr	r1, [r0, #0]
c0d009f8:	4817      	ldr	r0, [pc, #92]	; (c0d00a58 <io_usb_hid_receive+0x144>)
c0d009fa:	6001      	str	r1, [r0, #0]
      G_io_usb_hid_current_buffer = G_io_apdu_buffer;
c0d009fc:	4917      	ldr	r1, [pc, #92]	; (c0d00a5c <io_usb_hid_receive+0x148>)
c0d009fe:	4a19      	ldr	r2, [pc, #100]	; (c0d00a64 <io_usb_hid_receive+0x150>)
c0d00a00:	600a      	str	r2, [r1, #0]
      // check for invalid length encoding (more data in chunk that announced in the total apdu)
      if (G_io_usb_hid_total_length > sizeof(G_io_apdu_buffer)) {
        goto apdu_reset;
      }
      // seq and total length
      l -= 2;
c0d00a02:	4919      	ldr	r1, [pc, #100]	; (c0d00a68 <io_usb_hid_receive+0x154>)
c0d00a04:	9a02      	ldr	r2, [sp, #8]
c0d00a06:	1855      	adds	r5, r2, r1
      // compute remaining size to receive
      G_io_usb_hid_remaining_length = G_io_usb_hid_total_length;
      G_io_usb_hid_current_buffer = G_io_apdu_buffer;

      if (l > G_io_usb_hid_remaining_length) {
c0d00a08:	4629      	mov	r1, r5
c0d00a0a:	9e01      	ldr	r6, [sp, #4]
c0d00a0c:	4031      	ands	r1, r6
c0d00a0e:	6802      	ldr	r2, [r0, #0]
c0d00a10:	4291      	cmp	r1, r2
c0d00a12:	d900      	bls.n	c0d00a16 <io_usb_hid_receive+0x102>
        l = G_io_usb_hid_remaining_length;
c0d00a14:	6805      	ldr	r5, [r0, #0]
      }
      // copy data
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+7, l);
c0d00a16:	462a      	mov	r2, r5
c0d00a18:	4032      	ands	r2, r6
c0d00a1a:	480c      	ldr	r0, [pc, #48]	; (c0d00a4c <io_usb_hid_receive+0x138>)
c0d00a1c:	1dc1      	adds	r1, r0, #7
c0d00a1e:	4811      	ldr	r0, [pc, #68]	; (c0d00a64 <io_usb_hid_receive+0x150>)
c0d00a20:	f000 f82e 	bl	c0d00a80 <os_memmove>
      /// This is a following chunk
      // append content
      os_memmove((void*)G_io_usb_hid_current_buffer, G_io_hid_chunk+5, l);
    }
    // factorize (f)
    G_io_usb_hid_current_buffer += l;
c0d00a24:	4035      	ands	r5, r6
c0d00a26:	480d      	ldr	r0, [pc, #52]	; (c0d00a5c <io_usb_hid_receive+0x148>)
c0d00a28:	6801      	ldr	r1, [r0, #0]
c0d00a2a:	1949      	adds	r1, r1, r5
c0d00a2c:	6001      	str	r1, [r0, #0]
    G_io_usb_hid_remaining_length -= l;
c0d00a2e:	480a      	ldr	r0, [pc, #40]	; (c0d00a58 <io_usb_hid_receive+0x144>)
c0d00a30:	6801      	ldr	r1, [r0, #0]
c0d00a32:	1b49      	subs	r1, r1, r5
c0d00a34:	6001      	str	r1, [r0, #0]
    G_io_usb_hid_sequence_number++;
c0d00a36:	6820      	ldr	r0, [r4, #0]
c0d00a38:	1c40      	adds	r0, r0, #1
c0d00a3a:	6020      	str	r0, [r4, #0]
    // await for the next chunk
    goto apdu_reset;
  }

  // if more data to be received, notify it
  if (G_io_usb_hid_remaining_length) {
c0d00a3c:	4806      	ldr	r0, [pc, #24]	; (c0d00a58 <io_usb_hid_receive+0x144>)
c0d00a3e:	6801      	ldr	r1, [r0, #0]
c0d00a40:	2001      	movs	r0, #1
c0d00a42:	2602      	movs	r6, #2
c0d00a44:	2900      	cmp	r1, #0
c0d00a46:	d1a4      	bne.n	c0d00992 <io_usb_hid_receive+0x7e>
c0d00a48:	e79f      	b.n	c0d0098a <io_usb_hid_receive+0x76>
c0d00a4a:	46c0      	nop			; (mov r8, r8)
c0d00a4c:	200019ac 	.word	0x200019ac
c0d00a50:	200019ec 	.word	0x200019ec
c0d00a54:	0000ffff 	.word	0x0000ffff
c0d00a58:	200019f4 	.word	0x200019f4
c0d00a5c:	20001afc 	.word	0x20001afc
c0d00a60:	200019f0 	.word	0x200019f0
c0d00a64:	200019f8 	.word	0x200019f8
c0d00a68:	0001fff9 	.word	0x0001fff9

c0d00a6c <os_memset>:
    }
  }
#undef DSTCHAR
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
c0d00a6c:	b580      	push	{r7, lr}
c0d00a6e:	af00      	add	r7, sp, #0
c0d00a70:	460b      	mov	r3, r1
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
c0d00a72:	2a00      	cmp	r2, #0
c0d00a74:	d003      	beq.n	c0d00a7e <os_memset+0x12>
    DSTCHAR[length] = c;
c0d00a76:	4611      	mov	r1, r2
c0d00a78:	461a      	mov	r2, r3
c0d00a7a:	f001 fdbf 	bl	c0d025fc <__aeabi_memset>
  }
#undef DSTCHAR
}
c0d00a7e:	bd80      	pop	{r7, pc}

c0d00a80 <os_memmove>:
    }
  }
}
#endif // HAVE_USB_APDU

REENTRANT(void os_memmove(void * dst, const void WIDE * src, unsigned int length)) {
c0d00a80:	b5b0      	push	{r4, r5, r7, lr}
c0d00a82:	af02      	add	r7, sp, #8
#define DSTCHAR ((unsigned char *)dst)
#define SRCCHAR ((unsigned char WIDE *)src)
  if (dst > src) {
c0d00a84:	4288      	cmp	r0, r1
c0d00a86:	d90d      	bls.n	c0d00aa4 <os_memmove+0x24>
    while(length--) {
c0d00a88:	2a00      	cmp	r2, #0
c0d00a8a:	d014      	beq.n	c0d00ab6 <os_memmove+0x36>
c0d00a8c:	1e49      	subs	r1, r1, #1
c0d00a8e:	4252      	negs	r2, r2
c0d00a90:	1e40      	subs	r0, r0, #1
c0d00a92:	2300      	movs	r3, #0
c0d00a94:	43db      	mvns	r3, r3
      DSTCHAR[length] = SRCCHAR[length];
c0d00a96:	461c      	mov	r4, r3
c0d00a98:	4354      	muls	r4, r2
c0d00a9a:	5d0d      	ldrb	r5, [r1, r4]
c0d00a9c:	5505      	strb	r5, [r0, r4]

REENTRANT(void os_memmove(void * dst, const void WIDE * src, unsigned int length)) {
#define DSTCHAR ((unsigned char *)dst)
#define SRCCHAR ((unsigned char WIDE *)src)
  if (dst > src) {
    while(length--) {
c0d00a9e:	1c52      	adds	r2, r2, #1
c0d00aa0:	d1f9      	bne.n	c0d00a96 <os_memmove+0x16>
c0d00aa2:	e008      	b.n	c0d00ab6 <os_memmove+0x36>
      DSTCHAR[length] = SRCCHAR[length];
    }
  }
  else {
    unsigned short l = 0;
    while (length--) {
c0d00aa4:	2a00      	cmp	r2, #0
c0d00aa6:	d006      	beq.n	c0d00ab6 <os_memmove+0x36>
c0d00aa8:	2300      	movs	r3, #0
      DSTCHAR[l] = SRCCHAR[l];
c0d00aaa:	b29c      	uxth	r4, r3
c0d00aac:	5d0d      	ldrb	r5, [r1, r4]
c0d00aae:	5505      	strb	r5, [r0, r4]
      l++;
c0d00ab0:	1c5b      	adds	r3, r3, #1
      DSTCHAR[length] = SRCCHAR[length];
    }
  }
  else {
    unsigned short l = 0;
    while (length--) {
c0d00ab2:	1e52      	subs	r2, r2, #1
c0d00ab4:	d1f9      	bne.n	c0d00aaa <os_memmove+0x2a>
      DSTCHAR[l] = SRCCHAR[l];
      l++;
    }
  }
#undef DSTCHAR
}
c0d00ab6:	bdb0      	pop	{r4, r5, r7, pc}

c0d00ab8 <io_usb_hid_init>:
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d00ab8:	4801      	ldr	r0, [pc, #4]	; (c0d00ac0 <io_usb_hid_init+0x8>)
c0d00aba:	2100      	movs	r1, #0
c0d00abc:	6001      	str	r1, [r0, #0]
  //G_io_usb_hid_remaining_length = 0; // not really needed
  //G_io_usb_hid_total_length = 0; // not really needed
  //G_io_usb_hid_current_buffer = G_io_apdu_buffer; // not really needed
}
c0d00abe:	4770      	bx	lr
c0d00ac0:	200019ec 	.word	0x200019ec

c0d00ac4 <io_usb_hid_exchange>:

unsigned short io_usb_hid_exchange(io_send_t sndfct, unsigned short sndlength,
                                   io_recv_t rcvfct,
                                   unsigned char flags) {
c0d00ac4:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00ac6:	af03      	add	r7, sp, #12
c0d00ac8:	b087      	sub	sp, #28
c0d00aca:	9301      	str	r3, [sp, #4]
c0d00acc:	9203      	str	r2, [sp, #12]
c0d00ace:	460e      	mov	r6, r1
c0d00ad0:	9004      	str	r0, [sp, #16]
  unsigned char l;

  // perform send
  if (sndlength) {
c0d00ad2:	2e00      	cmp	r6, #0
c0d00ad4:	d042      	beq.n	c0d00b5c <io_usb_hid_exchange+0x98>
    G_io_usb_hid_sequence_number = 0; 
c0d00ad6:	4d31      	ldr	r5, [pc, #196]	; (c0d00b9c <io_usb_hid_exchange+0xd8>)
c0d00ad8:	2000      	movs	r0, #0
c0d00ada:	6028      	str	r0, [r5, #0]
    G_io_usb_hid_current_buffer = G_io_apdu_buffer;
c0d00adc:	4930      	ldr	r1, [pc, #192]	; (c0d00ba0 <io_usb_hid_exchange+0xdc>)
c0d00ade:	4831      	ldr	r0, [pc, #196]	; (c0d00ba4 <io_usb_hid_exchange+0xe0>)
c0d00ae0:	6008      	str	r0, [r1, #0]
c0d00ae2:	4c31      	ldr	r4, [pc, #196]	; (c0d00ba8 <io_usb_hid_exchange+0xe4>)
}

void os_memset(void * dst, unsigned char c, unsigned int length) {
#define DSTCHAR ((unsigned char *)dst)
  while(length--) {
    DSTCHAR[length] = c;
c0d00ae4:	1d60      	adds	r0, r4, #5
c0d00ae6:	213b      	movs	r1, #59	; 0x3b
c0d00ae8:	9005      	str	r0, [sp, #20]
c0d00aea:	9102      	str	r1, [sp, #8]
c0d00aec:	f001 fd80 	bl	c0d025f0 <__aeabi_memclr>
c0d00af0:	2005      	movs	r0, #5

    // fill the chunk
    os_memset(G_io_hid_chunk+2, 0, IO_HID_EP_LENGTH-2);

    // keep the channel identifier
    G_io_hid_chunk[2] = 0x05;
c0d00af2:	70a0      	strb	r0, [r4, #2]
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
c0d00af4:	6828      	ldr	r0, [r5, #0]
c0d00af6:	0a00      	lsrs	r0, r0, #8
c0d00af8:	70e0      	strb	r0, [r4, #3]
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;
c0d00afa:	6828      	ldr	r0, [r5, #0]
c0d00afc:	7120      	strb	r0, [r4, #4]
c0d00afe:	b2b1      	uxth	r1, r6

    if (G_io_usb_hid_sequence_number == 0) {
c0d00b00:	6828      	ldr	r0, [r5, #0]
c0d00b02:	2800      	cmp	r0, #0
c0d00b04:	9106      	str	r1, [sp, #24]
c0d00b06:	d009      	beq.n	c0d00b1c <io_usb_hid_exchange+0x58>
      G_io_usb_hid_current_buffer += l;
      sndlength -= l;
      l += 7;
    }
    else {
      l = ((sndlength>IO_HID_EP_LENGTH-5) ? IO_HID_EP_LENGTH-5 : sndlength);
c0d00b08:	293b      	cmp	r1, #59	; 0x3b
c0d00b0a:	460a      	mov	r2, r1
c0d00b0c:	d300      	bcc.n	c0d00b10 <io_usb_hid_exchange+0x4c>
c0d00b0e:	9a02      	ldr	r2, [sp, #8]
c0d00b10:	4823      	ldr	r0, [pc, #140]	; (c0d00ba0 <io_usb_hid_exchange+0xdc>)
c0d00b12:	4603      	mov	r3, r0
      os_memmove(G_io_hid_chunk+5, (const void*)G_io_usb_hid_current_buffer, l);
c0d00b14:	6819      	ldr	r1, [r3, #0]
c0d00b16:	9805      	ldr	r0, [sp, #20]
c0d00b18:	461e      	mov	r6, r3
c0d00b1a:	e00a      	b.n	c0d00b32 <io_usb_hid_exchange+0x6e>
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;

    if (G_io_usb_hid_sequence_number == 0) {
      l = ((sndlength>IO_HID_EP_LENGTH-7) ? IO_HID_EP_LENGTH-7 : sndlength);
      G_io_hid_chunk[5] = sndlength>>8;
c0d00b1c:	0a30      	lsrs	r0, r6, #8
c0d00b1e:	7160      	strb	r0, [r4, #5]
      G_io_hid_chunk[6] = sndlength;
c0d00b20:	71a6      	strb	r6, [r4, #6]
    G_io_hid_chunk[2] = 0x05;
    G_io_hid_chunk[3] = G_io_usb_hid_sequence_number>>8;
    G_io_hid_chunk[4] = G_io_usb_hid_sequence_number;

    if (G_io_usb_hid_sequence_number == 0) {
      l = ((sndlength>IO_HID_EP_LENGTH-7) ? IO_HID_EP_LENGTH-7 : sndlength);
c0d00b22:	2039      	movs	r0, #57	; 0x39
c0d00b24:	2939      	cmp	r1, #57	; 0x39
c0d00b26:	460a      	mov	r2, r1
c0d00b28:	d300      	bcc.n	c0d00b2c <io_usb_hid_exchange+0x68>
c0d00b2a:	4602      	mov	r2, r0
c0d00b2c:	4e1c      	ldr	r6, [pc, #112]	; (c0d00ba0 <io_usb_hid_exchange+0xdc>)
      G_io_hid_chunk[5] = sndlength>>8;
      G_io_hid_chunk[6] = sndlength;
      os_memmove(G_io_hid_chunk+7, (const void*)G_io_usb_hid_current_buffer, l);
c0d00b2e:	6831      	ldr	r1, [r6, #0]
c0d00b30:	1de0      	adds	r0, r4, #7
c0d00b32:	9205      	str	r2, [sp, #20]
c0d00b34:	f7ff ffa4 	bl	c0d00a80 <os_memmove>
c0d00b38:	4d18      	ldr	r5, [pc, #96]	; (c0d00b9c <io_usb_hid_exchange+0xd8>)
c0d00b3a:	6830      	ldr	r0, [r6, #0]
c0d00b3c:	4631      	mov	r1, r6
c0d00b3e:	9e05      	ldr	r6, [sp, #20]
c0d00b40:	1980      	adds	r0, r0, r6
      G_io_usb_hid_current_buffer += l;
c0d00b42:	6008      	str	r0, [r1, #0]
      G_io_usb_hid_current_buffer += l;
      sndlength -= l;
      l += 5;
    }
    // prepare next chunk numbering
    G_io_usb_hid_sequence_number++;
c0d00b44:	6828      	ldr	r0, [r5, #0]
c0d00b46:	1c40      	adds	r0, r0, #1
c0d00b48:	6028      	str	r0, [r5, #0]
    // send the chunk
    // always pad :)
    sndfct(G_io_hid_chunk, sizeof(G_io_hid_chunk));
c0d00b4a:	2140      	movs	r1, #64	; 0x40
c0d00b4c:	4620      	mov	r0, r4
c0d00b4e:	9a04      	ldr	r2, [sp, #16]
c0d00b50:	4790      	blx	r2
c0d00b52:	9806      	ldr	r0, [sp, #24]
c0d00b54:	1b86      	subs	r6, r0, r6
c0d00b56:	4815      	ldr	r0, [pc, #84]	; (c0d00bac <io_usb_hid_exchange+0xe8>)
  // perform send
  if (sndlength) {
    G_io_usb_hid_sequence_number = 0; 
    G_io_usb_hid_current_buffer = G_io_apdu_buffer;
  }
  while(sndlength) {
c0d00b58:	4206      	tst	r6, r0
c0d00b5a:	d1c3      	bne.n	c0d00ae4 <io_usb_hid_exchange+0x20>
  io_usb_hid_init();
  return IO_USB_APDU_RESET;
}

void io_usb_hid_init(void) {
  G_io_usb_hid_sequence_number = 0; 
c0d00b5c:	480f      	ldr	r0, [pc, #60]	; (c0d00b9c <io_usb_hid_exchange+0xd8>)
c0d00b5e:	2400      	movs	r4, #0
c0d00b60:	6004      	str	r4, [r0, #0]
  }

  // prepare for next apdu
  io_usb_hid_init();

  if (flags & IO_RESET_AFTER_REPLIED) {
c0d00b62:	2080      	movs	r0, #128	; 0x80
c0d00b64:	9901      	ldr	r1, [sp, #4]
c0d00b66:	4201      	tst	r1, r0
c0d00b68:	d001      	beq.n	c0d00b6e <io_usb_hid_exchange+0xaa>
    reset();
c0d00b6a:	f000 fc65 	bl	c0d01438 <reset>
  }

  if (flags & IO_RETURN_AFTER_TX ) {
c0d00b6e:	9801      	ldr	r0, [sp, #4]
c0d00b70:	0680      	lsls	r0, r0, #26
c0d00b72:	d40f      	bmi.n	c0d00b94 <io_usb_hid_exchange+0xd0>
c0d00b74:	4c0c      	ldr	r4, [pc, #48]	; (c0d00ba8 <io_usb_hid_exchange+0xe4>)
  }

  // receive the next command
  for(;;) {
    // receive a hid chunk
    l = rcvfct(G_io_hid_chunk, sizeof(G_io_hid_chunk));
c0d00b76:	2140      	movs	r1, #64	; 0x40
c0d00b78:	4620      	mov	r0, r4
c0d00b7a:	9a03      	ldr	r2, [sp, #12]
c0d00b7c:	4790      	blx	r2
    // check for wrongly sized tlvs
    if (l > sizeof(G_io_hid_chunk)) {
c0d00b7e:	b2c2      	uxtb	r2, r0
c0d00b80:	2a40      	cmp	r2, #64	; 0x40
c0d00b82:	d8f8      	bhi.n	c0d00b76 <io_usb_hid_exchange+0xb2>
      continue;
    }

    // call the chunk reception
    switch(io_usb_hid_receive(sndfct, G_io_hid_chunk, l)) {
c0d00b84:	9804      	ldr	r0, [sp, #16]
c0d00b86:	4621      	mov	r1, r4
c0d00b88:	f7ff fec4 	bl	c0d00914 <io_usb_hid_receive>
c0d00b8c:	2802      	cmp	r0, #2
c0d00b8e:	d1f2      	bne.n	c0d00b76 <io_usb_hid_exchange+0xb2>
      default:
        continue;

      case IO_USB_APDU_RECEIVED:

        return G_io_usb_hid_total_length;
c0d00b90:	4807      	ldr	r0, [pc, #28]	; (c0d00bb0 <io_usb_hid_exchange+0xec>)
c0d00b92:	6804      	ldr	r4, [r0, #0]
    }
  }
}
c0d00b94:	b2a0      	uxth	r0, r4
c0d00b96:	b007      	add	sp, #28
c0d00b98:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00b9a:	46c0      	nop			; (mov r8, r8)
c0d00b9c:	200019ec 	.word	0x200019ec
c0d00ba0:	20001afc 	.word	0x20001afc
c0d00ba4:	200019f8 	.word	0x200019f8
c0d00ba8:	200019ac 	.word	0x200019ac
c0d00bac:	0000ffff 	.word	0x0000ffff
c0d00bb0:	200019f0 	.word	0x200019f0

c0d00bb4 <io_seproxyhal_general_status>:
volatile unsigned short G_io_apdu_seq;
volatile io_apdu_media_t G_io_apdu_media;
volatile unsigned int G_button_mask;
volatile unsigned int G_button_same_mask_counter;

void io_seproxyhal_general_status(void) {
c0d00bb4:	b580      	push	{r7, lr}
c0d00bb6:	af00      	add	r7, sp, #0
  // avoid troubles
  if (io_seproxyhal_spi_is_status_sent()) {
c0d00bb8:	f000 fdc2 	bl	c0d01740 <io_seproxyhal_spi_is_status_sent>
c0d00bbc:	2800      	cmp	r0, #0
c0d00bbe:	d10b      	bne.n	c0d00bd8 <io_seproxyhal_general_status+0x24>
    return;
  }
  // send the general status
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_GENERAL_STATUS;
c0d00bc0:	4806      	ldr	r0, [pc, #24]	; (c0d00bdc <io_seproxyhal_general_status+0x28>)
c0d00bc2:	2160      	movs	r1, #96	; 0x60
c0d00bc4:	7001      	strb	r1, [r0, #0]
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d00bc6:	2100      	movs	r1, #0
c0d00bc8:	7041      	strb	r1, [r0, #1]
  G_io_seproxyhal_spi_buffer[2] = 2;
c0d00bca:	2202      	movs	r2, #2
c0d00bcc:	7082      	strb	r2, [r0, #2]
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND>>8;
c0d00bce:	70c1      	strb	r1, [r0, #3]
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_GENERAL_STATUS_LAST_COMMAND;
c0d00bd0:	7101      	strb	r1, [r0, #4]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 5);
c0d00bd2:	2105      	movs	r1, #5
c0d00bd4:	f000 fd96 	bl	c0d01704 <io_seproxyhal_spi_send>
}
c0d00bd8:	bd80      	pop	{r7, pc}
c0d00bda:	46c0      	nop			; (mov r8, r8)
c0d00bdc:	20001800 	.word	0x20001800

c0d00be0 <io_seproxyhal_handle_usb_event>:
static volatile unsigned char G_io_usb_ep_xfer_len[IO_USB_MAX_ENDPOINTS];
#include "usbd_def.h"
#include "usbd_core.h"
extern USBD_HandleTypeDef USBD_Device;

void io_seproxyhal_handle_usb_event(void) {
c0d00be0:	b5d0      	push	{r4, r6, r7, lr}
c0d00be2:	af02      	add	r7, sp, #8
  switch(G_io_seproxyhal_spi_buffer[3]) {
c0d00be4:	4815      	ldr	r0, [pc, #84]	; (c0d00c3c <io_seproxyhal_handle_usb_event+0x5c>)
c0d00be6:	78c0      	ldrb	r0, [r0, #3]
c0d00be8:	1e40      	subs	r0, r0, #1
c0d00bea:	2807      	cmp	r0, #7
c0d00bec:	d824      	bhi.n	c0d00c38 <io_seproxyhal_handle_usb_event+0x58>
c0d00bee:	46c0      	nop			; (mov r8, r8)
c0d00bf0:	4478      	add	r0, pc
c0d00bf2:	7900      	ldrb	r0, [r0, #4]
c0d00bf4:	0040      	lsls	r0, r0, #1
c0d00bf6:	4487      	add	pc, r0
c0d00bf8:	141f1803 	.word	0x141f1803
c0d00bfc:	1c1f1f1f 	.word	0x1c1f1f1f
    case SEPROXYHAL_TAG_USB_EVENT_RESET:
      // ongoing APDU detected, throw a reset
      USBD_LL_SetSpeed(&USBD_Device, USBD_SPEED_FULL);  
c0d00c00:	4c0f      	ldr	r4, [pc, #60]	; (c0d00c40 <io_seproxyhal_handle_usb_event+0x60>)
c0d00c02:	2101      	movs	r1, #1
c0d00c04:	4620      	mov	r0, r4
c0d00c06:	f001 f867 	bl	c0d01cd8 <USBD_LL_SetSpeed>
      USBD_LL_Reset(&USBD_Device);
c0d00c0a:	4620      	mov	r0, r4
c0d00c0c:	f001 f84c 	bl	c0d01ca8 <USBD_LL_Reset>
      if (G_io_apdu_media == IO_APDU_MEDIA_USB_HID) {
c0d00c10:	480c      	ldr	r0, [pc, #48]	; (c0d00c44 <io_seproxyhal_handle_usb_event+0x64>)
c0d00c12:	7800      	ldrb	r0, [r0, #0]
c0d00c14:	2801      	cmp	r0, #1
c0d00c16:	d10f      	bne.n	c0d00c38 <io_seproxyhal_handle_usb_event+0x58>
        THROW(EXCEPTION_IO_RESET);
c0d00c18:	480b      	ldr	r0, [pc, #44]	; (c0d00c48 <io_seproxyhal_handle_usb_event+0x68>)
c0d00c1a:	6800      	ldr	r0, [r0, #0]
c0d00c1c:	2110      	movs	r1, #16
c0d00c1e:	f001 fd47 	bl	c0d026b0 <longjmp>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SOF:
      USBD_LL_SOF(&USBD_Device);
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SUSPENDED:
      USBD_LL_Suspend(&USBD_Device);
c0d00c22:	4807      	ldr	r0, [pc, #28]	; (c0d00c40 <io_seproxyhal_handle_usb_event+0x60>)
c0d00c24:	f001 f85b 	bl	c0d01cde <USBD_LL_Suspend>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d00c28:	bdd0      	pop	{r4, r6, r7, pc}
      if (G_io_apdu_media == IO_APDU_MEDIA_USB_HID) {
        THROW(EXCEPTION_IO_RESET);
      }
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SOF:
      USBD_LL_SOF(&USBD_Device);
c0d00c2a:	4805      	ldr	r0, [pc, #20]	; (c0d00c40 <io_seproxyhal_handle_usb_event+0x60>)
c0d00c2c:	f001 f85b 	bl	c0d01ce6 <USBD_LL_SOF>
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
      break;
  }
}
c0d00c30:	bdd0      	pop	{r4, r6, r7, pc}
      break;
    case SEPROXYHAL_TAG_USB_EVENT_SUSPENDED:
      USBD_LL_Suspend(&USBD_Device);
      break;
    case SEPROXYHAL_TAG_USB_EVENT_RESUMED:
      USBD_LL_Resume(&USBD_Device);
c0d00c32:	4803      	ldr	r0, [pc, #12]	; (c0d00c40 <io_seproxyhal_handle_usb_event+0x60>)
c0d00c34:	f001 f855 	bl	c0d01ce2 <USBD_LL_Resume>
      break;
  }
}
c0d00c38:	bdd0      	pop	{r4, r6, r7, pc}
c0d00c3a:	46c0      	nop			; (mov r8, r8)
c0d00c3c:	20001800 	.word	0x20001800
c0d00c40:	20001b24 	.word	0x20001b24
c0d00c44:	20001b00 	.word	0x20001b00
c0d00c48:	200019a8 	.word	0x200019a8

c0d00c4c <io_seproxyhal_get_ep_rx_size>:

uint16_t io_seproxyhal_get_ep_rx_size(uint8_t epnum) {
  return G_io_usb_ep_xfer_len[epnum&0x7F];
c0d00c4c:	217f      	movs	r1, #127	; 0x7f
c0d00c4e:	4001      	ands	r1, r0
c0d00c50:	4801      	ldr	r0, [pc, #4]	; (c0d00c58 <io_seproxyhal_get_ep_rx_size+0xc>)
c0d00c52:	5c40      	ldrb	r0, [r0, r1]
c0d00c54:	4770      	bx	lr
c0d00c56:	46c0      	nop			; (mov r8, r8)
c0d00c58:	20001b01 	.word	0x20001b01

c0d00c5c <io_seproxyhal_handle_usb_ep_xfer_event>:
}

void io_seproxyhal_handle_usb_ep_xfer_event(void) {
c0d00c5c:	b580      	push	{r7, lr}
c0d00c5e:	af00      	add	r7, sp, #0
  switch(G_io_seproxyhal_spi_buffer[4]) {
c0d00c60:	480f      	ldr	r0, [pc, #60]	; (c0d00ca0 <io_seproxyhal_handle_usb_ep_xfer_event+0x44>)
c0d00c62:	7901      	ldrb	r1, [r0, #4]
c0d00c64:	2904      	cmp	r1, #4
c0d00c66:	d008      	beq.n	c0d00c7a <io_seproxyhal_handle_usb_ep_xfer_event+0x1e>
c0d00c68:	2902      	cmp	r1, #2
c0d00c6a:	d011      	beq.n	c0d00c90 <io_seproxyhal_handle_usb_ep_xfer_event+0x34>
c0d00c6c:	2901      	cmp	r1, #1
c0d00c6e:	d10e      	bne.n	c0d00c8e <io_seproxyhal_handle_usb_ep_xfer_event+0x32>
    case SEPROXYHAL_TAG_USB_EP_XFER_SETUP:
      // assume length of setup packet, and that it is on endpoint 0
      USBD_LL_SetupStage(&USBD_Device, &G_io_seproxyhal_spi_buffer[6]);
c0d00c70:	1d81      	adds	r1, r0, #6
c0d00c72:	480d      	ldr	r0, [pc, #52]	; (c0d00ca8 <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d00c74:	f000 ff3c 	bl	c0d01af0 <USBD_LL_SetupStage>
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;
  }
}
c0d00c78:	bd80      	pop	{r7, pc}
      USBD_LL_DataInStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;

    case SEPROXYHAL_TAG_USB_EP_XFER_OUT:
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
c0d00c7a:	78c2      	ldrb	r2, [r0, #3]
c0d00c7c:	217f      	movs	r1, #127	; 0x7f
c0d00c7e:	4011      	ands	r1, r2
c0d00c80:	7942      	ldrb	r2, [r0, #5]
c0d00c82:	4b08      	ldr	r3, [pc, #32]	; (c0d00ca4 <io_seproxyhal_handle_usb_ep_xfer_event+0x48>)
c0d00c84:	545a      	strb	r2, [r3, r1]
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
c0d00c86:	1d82      	adds	r2, r0, #6
c0d00c88:	4807      	ldr	r0, [pc, #28]	; (c0d00ca8 <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d00c8a:	f000 ff63 	bl	c0d01b54 <USBD_LL_DataOutStage>
      break;
  }
}
c0d00c8e:	bd80      	pop	{r7, pc}
      // assume length of setup packet, and that it is on endpoint 0
      USBD_LL_SetupStage(&USBD_Device, &G_io_seproxyhal_spi_buffer[6]);
      break;

    case SEPROXYHAL_TAG_USB_EP_XFER_IN:
      USBD_LL_DataInStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
c0d00c90:	78c2      	ldrb	r2, [r0, #3]
c0d00c92:	217f      	movs	r1, #127	; 0x7f
c0d00c94:	4011      	ands	r1, r2
c0d00c96:	1d82      	adds	r2, r0, #6
c0d00c98:	4803      	ldr	r0, [pc, #12]	; (c0d00ca8 <io_seproxyhal_handle_usb_ep_xfer_event+0x4c>)
c0d00c9a:	f000 ffa1 	bl	c0d01be0 <USBD_LL_DataInStage>
      // saved just in case it is needed ...
      G_io_usb_ep_xfer_len[G_io_seproxyhal_spi_buffer[3]&0x7F] = G_io_seproxyhal_spi_buffer[5];
      USBD_LL_DataOutStage(&USBD_Device, G_io_seproxyhal_spi_buffer[3]&0x7F, &G_io_seproxyhal_spi_buffer[6]);
      break;
  }
}
c0d00c9e:	bd80      	pop	{r7, pc}
c0d00ca0:	20001800 	.word	0x20001800
c0d00ca4:	20001b01 	.word	0x20001b01
c0d00ca8:	20001b24 	.word	0x20001b24

c0d00cac <io_usb_send_ep>:
void io_seproxyhal_handle_usb_ep_xfer_event(void) { 
}

#endif // HAVE_L4_USBLIB

void io_usb_send_ep(unsigned int ep, unsigned char* buffer, unsigned short length, unsigned int timeout) {
c0d00cac:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00cae:	af03      	add	r7, sp, #12
c0d00cb0:	b083      	sub	sp, #12
c0d00cb2:	9201      	str	r2, [sp, #4]
c0d00cb4:	4602      	mov	r2, r0
  unsigned int rx_len;

  // don't spoil the timeout :)
  if (timeout) {
    timeout++;
c0d00cb6:	1c5d      	adds	r5, r3, #1

void io_usb_send_ep(unsigned int ep, unsigned char* buffer, unsigned short length, unsigned int timeout) {
  unsigned int rx_len;

  // don't spoil the timeout :)
  if (timeout) {
c0d00cb8:	2b00      	cmp	r3, #0
c0d00cba:	d100      	bne.n	c0d00cbe <io_usb_send_ep+0x12>
c0d00cbc:	461d      	mov	r5, r3
    timeout++;
  }

  // won't send if overflowing seproxyhal buffer format
  if (length > 255) {
c0d00cbe:	9801      	ldr	r0, [sp, #4]
c0d00cc0:	28ff      	cmp	r0, #255	; 0xff
c0d00cc2:	d843      	bhi.n	c0d00d4c <io_usb_send_ep+0xa0>
    return;
  }
  
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d00cc4:	4e25      	ldr	r6, [pc, #148]	; (c0d00d5c <io_usb_send_ep+0xb0>)
c0d00cc6:	2050      	movs	r0, #80	; 0x50
c0d00cc8:	7030      	strb	r0, [r6, #0]
c0d00cca:	9c01      	ldr	r4, [sp, #4]
  G_io_seproxyhal_spi_buffer[1] = (3+length)>>8;
c0d00ccc:	1ce0      	adds	r0, r4, #3
c0d00cce:	9100      	str	r1, [sp, #0]
c0d00cd0:	0a01      	lsrs	r1, r0, #8
c0d00cd2:	7071      	strb	r1, [r6, #1]
  G_io_seproxyhal_spi_buffer[2] = (3+length);
c0d00cd4:	70b0      	strb	r0, [r6, #2]
  G_io_seproxyhal_spi_buffer[3] = ep|0x80;
c0d00cd6:	2080      	movs	r0, #128	; 0x80
c0d00cd8:	4302      	orrs	r2, r0
c0d00cda:	9202      	str	r2, [sp, #8]
c0d00cdc:	70f2      	strb	r2, [r6, #3]
  G_io_seproxyhal_spi_buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d00cde:	2020      	movs	r0, #32
c0d00ce0:	7130      	strb	r0, [r6, #4]
  G_io_seproxyhal_spi_buffer[5] = length;
c0d00ce2:	7174      	strb	r4, [r6, #5]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 6);
c0d00ce4:	2106      	movs	r1, #6
c0d00ce6:	4630      	mov	r0, r6
c0d00ce8:	f000 fd0c 	bl	c0d01704 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send(buffer, length);
c0d00cec:	9800      	ldr	r0, [sp, #0]
c0d00cee:	4621      	mov	r1, r4
c0d00cf0:	f000 fd08 	bl	c0d01704 <io_seproxyhal_spi_send>

  // if timeout is requested
  if(timeout) {
c0d00cf4:	2d00      	cmp	r5, #0
c0d00cf6:	d10d      	bne.n	c0d00d14 <io_usb_send_ep+0x68>
c0d00cf8:	e028      	b.n	c0d00d4c <io_usb_send_ep+0xa0>
        || G_io_seproxyhal_spi_buffer[3] != (ep|0x80)
        || G_io_seproxyhal_spi_buffer[4] != SEPROXYHAL_TAG_USB_EP_XFER_IN
        || G_io_seproxyhal_spi_buffer[5] != length) {
        
        // handle loss of communication with the host
        if (timeout && timeout--==1) {
c0d00cfa:	2d00      	cmp	r5, #0
c0d00cfc:	d002      	beq.n	c0d00d04 <io_usb_send_ep+0x58>
c0d00cfe:	1e6c      	subs	r4, r5, #1
c0d00d00:	2d01      	cmp	r5, #1
c0d00d02:	d025      	beq.n	c0d00d50 <io_usb_send_ep+0xa4>
          THROW(EXCEPTION_IO_RESET);
        }

        // link disconnected ?
        if(G_io_seproxyhal_spi_buffer[0] == SEPROXYHAL_TAG_STATUS_EVENT) {
c0d00d04:	2915      	cmp	r1, #21
c0d00d06:	d102      	bne.n	c0d00d0e <io_usb_send_ep+0x62>
          if (!(U4BE(G_io_seproxyhal_spi_buffer, 3) & SEPROXYHAL_TAG_STATUS_EVENT_FLAG_USB_POWERED)) {
c0d00d08:	79b0      	ldrb	r0, [r6, #6]
c0d00d0a:	0700      	lsls	r0, r0, #28
c0d00d0c:	d520      	bpl.n	c0d00d50 <io_usb_send_ep+0xa4>
        }
        
        // usb reset ?
        //io_seproxyhal_handle_usb_event();
        // also process other transfer requests if any (useful for HID keyboard while playing with CAPS lock key, side effect on LED status)
        io_seproxyhal_handle_event();
c0d00d0e:	f000 f829 	bl	c0d00d64 <io_seproxyhal_handle_event>
c0d00d12:	4625      	mov	r5, r4
  io_seproxyhal_spi_send(buffer, length);

  // if timeout is requested
  if(timeout) {
    for (;;) {
      if (!io_seproxyhal_spi_is_status_sent()) {
c0d00d14:	f000 fd14 	bl	c0d01740 <io_seproxyhal_spi_is_status_sent>
c0d00d18:	2800      	cmp	r0, #0
c0d00d1a:	d101      	bne.n	c0d00d20 <io_usb_send_ep+0x74>
        io_seproxyhal_general_status();
c0d00d1c:	f7ff ff4a 	bl	c0d00bb4 <io_seproxyhal_general_status>
      }

      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d00d20:	2180      	movs	r1, #128	; 0x80
c0d00d22:	2400      	movs	r4, #0
c0d00d24:	4630      	mov	r0, r6
c0d00d26:	4622      	mov	r2, r4
c0d00d28:	f000 fd26 	bl	c0d01778 <io_seproxyhal_spi_recv>

      // wait for ack of the seproxyhal
      // discard if not an acknowledgment
      if (G_io_seproxyhal_spi_buffer[0] != SEPROXYHAL_TAG_USB_EP_XFER_EVENT
c0d00d2c:	7831      	ldrb	r1, [r6, #0]
        || rx_len != 6 
c0d00d2e:	2806      	cmp	r0, #6
c0d00d30:	d1e3      	bne.n	c0d00cfa <io_usb_send_ep+0x4e>
c0d00d32:	2910      	cmp	r1, #16
c0d00d34:	d1e1      	bne.n	c0d00cfa <io_usb_send_ep+0x4e>
        || G_io_seproxyhal_spi_buffer[3] != (ep|0x80)
c0d00d36:	78f0      	ldrb	r0, [r6, #3]
        || G_io_seproxyhal_spi_buffer[4] != SEPROXYHAL_TAG_USB_EP_XFER_IN
c0d00d38:	9a02      	ldr	r2, [sp, #8]
c0d00d3a:	4290      	cmp	r0, r2
c0d00d3c:	d1dd      	bne.n	c0d00cfa <io_usb_send_ep+0x4e>
c0d00d3e:	7930      	ldrb	r0, [r6, #4]
c0d00d40:	2802      	cmp	r0, #2
c0d00d42:	d1da      	bne.n	c0d00cfa <io_usb_send_ep+0x4e>
        || G_io_seproxyhal_spi_buffer[5] != length) {
c0d00d44:	7970      	ldrb	r0, [r6, #5]

      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);

      // wait for ack of the seproxyhal
      // discard if not an acknowledgment
      if (G_io_seproxyhal_spi_buffer[0] != SEPROXYHAL_TAG_USB_EP_XFER_EVENT
c0d00d46:	9a01      	ldr	r2, [sp, #4]
c0d00d48:	4290      	cmp	r0, r2
c0d00d4a:	d1d6      	bne.n	c0d00cfa <io_usb_send_ep+0x4e>

      // chunk sending succeeded
      break;
    }
  }
}
c0d00d4c:	b003      	add	sp, #12
c0d00d4e:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d00d50:	4803      	ldr	r0, [pc, #12]	; (c0d00d60 <io_usb_send_ep+0xb4>)
c0d00d52:	6800      	ldr	r0, [r0, #0]
c0d00d54:	2110      	movs	r1, #16
c0d00d56:	f001 fcab 	bl	c0d026b0 <longjmp>
c0d00d5a:	46c0      	nop			; (mov r8, r8)
c0d00d5c:	20001800 	.word	0x20001800
c0d00d60:	200019a8 	.word	0x200019a8

c0d00d64 <io_seproxyhal_handle_event>:
void io_seproxyhal_handle_bluenrg_event(void) {

}
#endif

unsigned int io_seproxyhal_handle_event(void) {
c0d00d64:	b580      	push	{r7, lr}
c0d00d66:	af00      	add	r7, sp, #0
  unsigned int rx_len = U2BE(G_io_seproxyhal_spi_buffer, 1);
c0d00d68:	480d      	ldr	r0, [pc, #52]	; (c0d00da0 <io_seproxyhal_handle_event+0x3c>)
c0d00d6a:	7882      	ldrb	r2, [r0, #2]
c0d00d6c:	7841      	ldrb	r1, [r0, #1]
c0d00d6e:	0209      	lsls	r1, r1, #8
c0d00d70:	4311      	orrs	r1, r2

  switch(G_io_seproxyhal_spi_buffer[0]) {
c0d00d72:	7800      	ldrb	r0, [r0, #0]
c0d00d74:	2810      	cmp	r0, #16
c0d00d76:	d008      	beq.n	c0d00d8a <io_seproxyhal_handle_event+0x26>
c0d00d78:	280f      	cmp	r0, #15
c0d00d7a:	d10d      	bne.n	c0d00d98 <io_seproxyhal_handle_event+0x34>
c0d00d7c:	2000      	movs	r0, #0
  #ifdef HAVE_IO_USB
    case SEPROXYHAL_TAG_USB_EVENT:
      if (rx_len != 3+1) {
c0d00d7e:	2904      	cmp	r1, #4
c0d00d80:	d10d      	bne.n	c0d00d9e <io_seproxyhal_handle_event+0x3a>
        return 0;
      }
      io_seproxyhal_handle_usb_event();
c0d00d82:	f7ff ff2d 	bl	c0d00be0 <io_seproxyhal_handle_usb_event>
c0d00d86:	2001      	movs	r0, #1
    default:
      return io_event(CHANNEL_SPI);
  }
  // defaulty return as not processed
  return 0;
}
c0d00d88:	bd80      	pop	{r7, pc}
c0d00d8a:	2000      	movs	r0, #0
      }
      io_seproxyhal_handle_usb_event();
      return 1;

    case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
      if (rx_len < 3+3) {
c0d00d8c:	2906      	cmp	r1, #6
c0d00d8e:	d306      	bcc.n	c0d00d9e <io_seproxyhal_handle_event+0x3a>
        // error !
        return 0;
      }
      io_seproxyhal_handle_usb_ep_xfer_event();
c0d00d90:	f7ff ff64 	bl	c0d00c5c <io_seproxyhal_handle_usb_ep_xfer_event>
c0d00d94:	2001      	movs	r0, #1
    default:
      return io_event(CHANNEL_SPI);
  }
  // defaulty return as not processed
  return 0;
}
c0d00d96:	bd80      	pop	{r7, pc}
      return 1;
  #endif // HAVE_BLE

      // ask the user if not processed here
    default:
      return io_event(CHANNEL_SPI);
c0d00d98:	2002      	movs	r0, #2
c0d00d9a:	f7ff f9ab 	bl	c0d000f4 <io_event>
  }
  // defaulty return as not processed
  return 0;
}
c0d00d9e:	bd80      	pop	{r7, pc}
c0d00da0:	20001800 	.word	0x20001800

c0d00da4 <io_usb_send_apdu_data>:
      break;
    }
  }
}

void io_usb_send_apdu_data(unsigned char* buffer, unsigned short length) {
c0d00da4:	b580      	push	{r7, lr}
c0d00da6:	af00      	add	r7, sp, #0
c0d00da8:	460a      	mov	r2, r1
c0d00daa:	4601      	mov	r1, r0
  // wait for 20 events before hanging up and timeout (~2 seconds of timeout)
  io_usb_send_ep(0x82, buffer, length, 20);
c0d00dac:	2082      	movs	r0, #130	; 0x82
c0d00dae:	2314      	movs	r3, #20
c0d00db0:	f7ff ff7c 	bl	c0d00cac <io_usb_send_ep>
}
c0d00db4:	bd80      	pop	{r7, pc}
	...

c0d00db8 <io_seproxyhal_init>:
const char debug_apdus[] = {
  9, 0xe0, 0x22, 0x00, 0x00, 0x04, 0x31, 0x32, 0x33, 0x34,
};
#endif // DEBUG_APDU

void io_seproxyhal_init(void) {
c0d00db8:	b5d0      	push	{r4, r6, r7, lr}
c0d00dba:	af02      	add	r7, sp, #8
  // Enforce OS compatibility
  check_api_level(CX_COMPAT_APILEVEL);
c0d00dbc:	2007      	movs	r0, #7
c0d00dbe:	f000 fb1d 	bl	c0d013fc <check_api_level>

  G_io_apdu_state = APDU_IDLE;
c0d00dc2:	480a      	ldr	r0, [pc, #40]	; (c0d00dec <io_seproxyhal_init+0x34>)
c0d00dc4:	2400      	movs	r4, #0
c0d00dc6:	7004      	strb	r4, [r0, #0]
  G_io_apdu_offset = 0;
c0d00dc8:	4809      	ldr	r0, [pc, #36]	; (c0d00df0 <io_seproxyhal_init+0x38>)
c0d00dca:	8004      	strh	r4, [r0, #0]
  G_io_apdu_length = 0;
c0d00dcc:	4809      	ldr	r0, [pc, #36]	; (c0d00df4 <io_seproxyhal_init+0x3c>)
c0d00dce:	8004      	strh	r4, [r0, #0]
  G_io_apdu_seq = 0;
c0d00dd0:	4809      	ldr	r0, [pc, #36]	; (c0d00df8 <io_seproxyhal_init+0x40>)
c0d00dd2:	8004      	strh	r4, [r0, #0]
  G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d00dd4:	4809      	ldr	r0, [pc, #36]	; (c0d00dfc <io_seproxyhal_init+0x44>)
c0d00dd6:	7004      	strb	r4, [r0, #0]
  debug_apdus_offset = 0;
  #endif // DEBUG_APDU


  #ifdef HAVE_USB_APDU
  io_usb_hid_init();
c0d00dd8:	f7ff fe6e 	bl	c0d00ab8 <io_usb_hid_init>
  io_seproxyhal_init_button();
}

void io_seproxyhal_init_ux(void) {
  // initialize the touch part
  G_bagl_last_touched_not_released_component = NULL;
c0d00ddc:	4808      	ldr	r0, [pc, #32]	; (c0d00e00 <io_seproxyhal_init+0x48>)
c0d00dde:	6004      	str	r4, [r0, #0]

}

void io_seproxyhal_init_button(void) {
  // no button push so far
  G_button_mask = 0;
c0d00de0:	4808      	ldr	r0, [pc, #32]	; (c0d00e04 <io_seproxyhal_init+0x4c>)
c0d00de2:	6004      	str	r4, [r0, #0]
  G_button_same_mask_counter = 0;
c0d00de4:	4808      	ldr	r0, [pc, #32]	; (c0d00e08 <io_seproxyhal_init+0x50>)
c0d00de6:	6004      	str	r4, [r0, #0]
  io_usb_hid_init();
  #endif // HAVE_USB_APDU

  io_seproxyhal_init_ux();
  io_seproxyhal_init_button();
}
c0d00de8:	bdd0      	pop	{r4, r6, r7, pc}
c0d00dea:	46c0      	nop			; (mov r8, r8)
c0d00dec:	20001b08 	.word	0x20001b08
c0d00df0:	20001b0a 	.word	0x20001b0a
c0d00df4:	20001b0c 	.word	0x20001b0c
c0d00df8:	20001b0e 	.word	0x20001b0e
c0d00dfc:	20001b00 	.word	0x20001b00
c0d00e00:	20001b10 	.word	0x20001b10
c0d00e04:	20001b14 	.word	0x20001b14
c0d00e08:	20001b18 	.word	0x20001b18

c0d00e0c <io_seproxyhal_init_ux>:

void io_seproxyhal_init_ux(void) {
  // initialize the touch part
  G_bagl_last_touched_not_released_component = NULL;
c0d00e0c:	4801      	ldr	r0, [pc, #4]	; (c0d00e14 <io_seproxyhal_init_ux+0x8>)
c0d00e0e:	2100      	movs	r1, #0
c0d00e10:	6001      	str	r1, [r0, #0]

}
c0d00e12:	4770      	bx	lr
c0d00e14:	20001b10 	.word	0x20001b10

c0d00e18 <io_seproxyhal_touch_out>:
  G_button_same_mask_counter = 0;
}

#ifdef HAVE_BAGL

unsigned int io_seproxyhal_touch_out(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d00e18:	b5b0      	push	{r4, r5, r7, lr}
c0d00e1a:	af02      	add	r7, sp, #8
c0d00e1c:	460d      	mov	r5, r1
c0d00e1e:	4604      	mov	r4, r0
  const bagl_element_t* el;
  if (element->out != NULL) {
c0d00e20:	6b20      	ldr	r0, [r4, #48]	; 0x30
c0d00e22:	2800      	cmp	r0, #0
c0d00e24:	d00c      	beq.n	c0d00e40 <io_seproxyhal_touch_out+0x28>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->out))(element));
c0d00e26:	f000 fad1 	bl	c0d013cc <pic>
c0d00e2a:	4601      	mov	r1, r0
c0d00e2c:	4620      	mov	r0, r4
c0d00e2e:	4788      	blx	r1
c0d00e30:	f000 facc 	bl	c0d013cc <pic>
c0d00e34:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (! el) {
c0d00e36:	2800      	cmp	r0, #0
c0d00e38:	d010      	beq.n	c0d00e5c <io_seproxyhal_touch_out+0x44>
c0d00e3a:	2801      	cmp	r0, #1
c0d00e3c:	d000      	beq.n	c0d00e40 <io_seproxyhal_touch_out+0x28>
c0d00e3e:	4604      	mov	r4, r0
      element = el;
    }
  }

  // out function might have triggered a draw of its own during a display callback
  if (before_display) {
c0d00e40:	2d00      	cmp	r5, #0
c0d00e42:	d007      	beq.n	c0d00e54 <io_seproxyhal_touch_out+0x3c>
    el = before_display(element);
c0d00e44:	4620      	mov	r0, r4
c0d00e46:	47a8      	blx	r5
c0d00e48:	2100      	movs	r1, #0
    if (!el) {
c0d00e4a:	2800      	cmp	r0, #0
c0d00e4c:	d006      	beq.n	c0d00e5c <io_seproxyhal_touch_out+0x44>
c0d00e4e:	2801      	cmp	r0, #1
c0d00e50:	d000      	beq.n	c0d00e54 <io_seproxyhal_touch_out+0x3c>
c0d00e52:	4604      	mov	r4, r0
    if ((unsigned int)el != 1) {
      element = el;
    }
  }

  io_seproxyhal_display(element);
c0d00e54:	4620      	mov	r0, r4
c0d00e56:	f7ff f947 	bl	c0d000e8 <io_seproxyhal_display>
c0d00e5a:	2101      	movs	r1, #1
  return 1;
}
c0d00e5c:	4608      	mov	r0, r1
c0d00e5e:	bdb0      	pop	{r4, r5, r7, pc}

c0d00e60 <io_seproxyhal_touch_over>:

unsigned int io_seproxyhal_touch_over(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d00e60:	b5b0      	push	{r4, r5, r7, lr}
c0d00e62:	af02      	add	r7, sp, #8
c0d00e64:	b08e      	sub	sp, #56	; 0x38
c0d00e66:	460c      	mov	r4, r1
c0d00e68:	4605      	mov	r5, r0
  bagl_element_t e;
  const bagl_element_t* el;
  if (element->over != NULL) {
c0d00e6a:	6b68      	ldr	r0, [r5, #52]	; 0x34
c0d00e6c:	2800      	cmp	r0, #0
c0d00e6e:	d00c      	beq.n	c0d00e8a <io_seproxyhal_touch_over+0x2a>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->over))(element));
c0d00e70:	f000 faac 	bl	c0d013cc <pic>
c0d00e74:	4601      	mov	r1, r0
c0d00e76:	4628      	mov	r0, r5
c0d00e78:	4788      	blx	r1
c0d00e7a:	f000 faa7 	bl	c0d013cc <pic>
c0d00e7e:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (!el) {
c0d00e80:	2800      	cmp	r0, #0
c0d00e82:	d016      	beq.n	c0d00eb2 <io_seproxyhal_touch_over+0x52>
c0d00e84:	2801      	cmp	r0, #1
c0d00e86:	d000      	beq.n	c0d00e8a <io_seproxyhal_touch_over+0x2a>
c0d00e88:	4605      	mov	r5, r0
c0d00e8a:	4668      	mov	r0, sp
      element = el;
    }
  }

  // over function might have triggered a draw of its own during a display callback
  os_memmove(&e, (void*)element, sizeof(bagl_element_t));
c0d00e8c:	2238      	movs	r2, #56	; 0x38
c0d00e8e:	4629      	mov	r1, r5
c0d00e90:	f7ff fdf6 	bl	c0d00a80 <os_memmove>
  e.component.fgcolor = element->overfgcolor;
c0d00e94:	6a68      	ldr	r0, [r5, #36]	; 0x24
c0d00e96:	9004      	str	r0, [sp, #16]
  e.component.bgcolor = element->overbgcolor;
c0d00e98:	6aa8      	ldr	r0, [r5, #40]	; 0x28
c0d00e9a:	9005      	str	r0, [sp, #20]

  //element = &e; // for INARRAY checks, it disturbs a bit. avoid it

  if (before_display) {
c0d00e9c:	2c00      	cmp	r4, #0
c0d00e9e:	d004      	beq.n	c0d00eaa <io_seproxyhal_touch_over+0x4a>
    el = before_display(element);
c0d00ea0:	4628      	mov	r0, r5
c0d00ea2:	47a0      	blx	r4
c0d00ea4:	2100      	movs	r1, #0
    element = &e;
    if (!el) {
c0d00ea6:	2800      	cmp	r0, #0
c0d00ea8:	d003      	beq.n	c0d00eb2 <io_seproxyhal_touch_over+0x52>
c0d00eaa:	4668      	mov	r0, sp
  //else 
  {
    element = &e;
  }

  io_seproxyhal_display(element);
c0d00eac:	f7ff f91c 	bl	c0d000e8 <io_seproxyhal_display>
c0d00eb0:	2101      	movs	r1, #1
  return 1;
}
c0d00eb2:	4608      	mov	r0, r1
c0d00eb4:	b00e      	add	sp, #56	; 0x38
c0d00eb6:	bdb0      	pop	{r4, r5, r7, pc}

c0d00eb8 <io_seproxyhal_touch_tap>:

unsigned int io_seproxyhal_touch_tap(const bagl_element_t* element, bagl_element_callback_t before_display) {
c0d00eb8:	b5b0      	push	{r4, r5, r7, lr}
c0d00eba:	af02      	add	r7, sp, #8
c0d00ebc:	460d      	mov	r5, r1
c0d00ebe:	4604      	mov	r4, r0
  const bagl_element_t* el;
  if (element->tap != NULL) {
c0d00ec0:	6ae0      	ldr	r0, [r4, #44]	; 0x2c
c0d00ec2:	2800      	cmp	r0, #0
c0d00ec4:	d00c      	beq.n	c0d00ee0 <io_seproxyhal_touch_tap+0x28>
    el = (const bagl_element_t*)PIC(((bagl_element_callback_t)PIC(element->tap))(element));
c0d00ec6:	f000 fa81 	bl	c0d013cc <pic>
c0d00eca:	4601      	mov	r1, r0
c0d00ecc:	4620      	mov	r0, r4
c0d00ece:	4788      	blx	r1
c0d00ed0:	f000 fa7c 	bl	c0d013cc <pic>
c0d00ed4:	2100      	movs	r1, #0
    // backward compatible with samples and such
    if (!el) {
c0d00ed6:	2800      	cmp	r0, #0
c0d00ed8:	d010      	beq.n	c0d00efc <io_seproxyhal_touch_tap+0x44>
c0d00eda:	2801      	cmp	r0, #1
c0d00edc:	d000      	beq.n	c0d00ee0 <io_seproxyhal_touch_tap+0x28>
c0d00ede:	4604      	mov	r4, r0
      element = el;
    }
  }

  // tap function might have triggered a draw of its own during a display callback
  if (before_display) {
c0d00ee0:	2d00      	cmp	r5, #0
c0d00ee2:	d007      	beq.n	c0d00ef4 <io_seproxyhal_touch_tap+0x3c>
    el = before_display(element);
c0d00ee4:	4620      	mov	r0, r4
c0d00ee6:	47a8      	blx	r5
c0d00ee8:	2100      	movs	r1, #0
    if (!el) {
c0d00eea:	2800      	cmp	r0, #0
c0d00eec:	d006      	beq.n	c0d00efc <io_seproxyhal_touch_tap+0x44>
c0d00eee:	2801      	cmp	r0, #1
c0d00ef0:	d000      	beq.n	c0d00ef4 <io_seproxyhal_touch_tap+0x3c>
c0d00ef2:	4604      	mov	r4, r0
    }
    if ((unsigned int)el != 1) {
      element = el;
    }
  }
  io_seproxyhal_display(element);
c0d00ef4:	4620      	mov	r0, r4
c0d00ef6:	f7ff f8f7 	bl	c0d000e8 <io_seproxyhal_display>
c0d00efa:	2101      	movs	r1, #1
  return 1;
}
c0d00efc:	4608      	mov	r0, r1
c0d00efe:	bdb0      	pop	{r4, r5, r7, pc}

c0d00f00 <io_seproxyhal_touch_element_callback>:
  io_seproxyhal_touch_element_callback(elements, element_count, x, y, event_kind, NULL);  
}

// browse all elements and until an element has changed state, continue browsing
// return if processed or not
void io_seproxyhal_touch_element_callback(const bagl_element_t* elements, unsigned short element_count, unsigned short x, unsigned short y, unsigned char event_kind, bagl_element_callback_t before_display) {
c0d00f00:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d00f02:	af03      	add	r7, sp, #12
c0d00f04:	b087      	sub	sp, #28
c0d00f06:	9302      	str	r3, [sp, #8]
c0d00f08:	9203      	str	r2, [sp, #12]
c0d00f0a:	9105      	str	r1, [sp, #20]
  unsigned char comp_idx;
  unsigned char last_touched_not_released_component_was_in_current_array = 0;

  // find the first empty entry
  for (comp_idx=0; comp_idx < element_count; comp_idx++) {
c0d00f0c:	2900      	cmp	r1, #0
c0d00f0e:	d076      	beq.n	c0d00ffe <io_seproxyhal_touch_element_callback+0xfe>
c0d00f10:	9004      	str	r0, [sp, #16]
c0d00f12:	980d      	ldr	r0, [sp, #52]	; 0x34
c0d00f14:	9001      	str	r0, [sp, #4]
c0d00f16:	980c      	ldr	r0, [sp, #48]	; 0x30
c0d00f18:	9000      	str	r0, [sp, #0]
c0d00f1a:	2600      	movs	r6, #0
c0d00f1c:	9606      	str	r6, [sp, #24]
c0d00f1e:	4634      	mov	r4, r6
    // process all components matching the x/y/w/h (no break) => fishy for the released out of zone
    // continue processing only if a status has not been sent
    if (io_seproxyhal_spi_is_status_sent()) {
c0d00f20:	f000 fc0e 	bl	c0d01740 <io_seproxyhal_spi_is_status_sent>
c0d00f24:	2800      	cmp	r0, #0
c0d00f26:	d155      	bne.n	c0d00fd4 <io_seproxyhal_touch_element_callback+0xd4>
      // continue instead of return to process all elemnts and therefore discard last touched element
      break;
    }

    // only perform out callback when element was in the current array, else, leave it be
    if (&elements[comp_idx] == G_bagl_last_touched_not_released_component) {
c0d00f28:	2038      	movs	r0, #56	; 0x38
c0d00f2a:	4370      	muls	r0, r6
c0d00f2c:	9d04      	ldr	r5, [sp, #16]
c0d00f2e:	182e      	adds	r6, r5, r0
c0d00f30:	4b36      	ldr	r3, [pc, #216]	; (c0d0100c <io_seproxyhal_touch_element_callback+0x10c>)
c0d00f32:	681a      	ldr	r2, [r3, #0]
c0d00f34:	2101      	movs	r1, #1
c0d00f36:	4296      	cmp	r6, r2
c0d00f38:	d000      	beq.n	c0d00f3c <io_seproxyhal_touch_element_callback+0x3c>
c0d00f3a:	9906      	ldr	r1, [sp, #24]
c0d00f3c:	9106      	str	r1, [sp, #24]
      last_touched_not_released_component_was_in_current_array = 1;
    }

    // the first component drawn with a 
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
c0d00f3e:	5628      	ldrsb	r0, [r5, r0]
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
c0d00f40:	2800      	cmp	r0, #0
c0d00f42:	da41      	bge.n	c0d00fc8 <io_seproxyhal_touch_element_callback+0xc8>
c0d00f44:	2020      	movs	r0, #32
c0d00f46:	5c35      	ldrb	r5, [r6, r0]
c0d00f48:	2102      	movs	r1, #2
c0d00f4a:	5e71      	ldrsh	r1, [r6, r1]
c0d00f4c:	1b4a      	subs	r2, r1, r5
c0d00f4e:	9803      	ldr	r0, [sp, #12]
c0d00f50:	4282      	cmp	r2, r0
c0d00f52:	dc39      	bgt.n	c0d00fc8 <io_seproxyhal_touch_element_callback+0xc8>
c0d00f54:	1869      	adds	r1, r5, r1
c0d00f56:	88f2      	ldrh	r2, [r6, #6]
c0d00f58:	1889      	adds	r1, r1, r2
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {
c0d00f5a:	9803      	ldr	r0, [sp, #12]
c0d00f5c:	4288      	cmp	r0, r1
c0d00f5e:	da33      	bge.n	c0d00fc8 <io_seproxyhal_touch_element_callback+0xc8>
c0d00f60:	2104      	movs	r1, #4
c0d00f62:	5e70      	ldrsh	r0, [r6, r1]
c0d00f64:	1b42      	subs	r2, r0, r5
c0d00f66:	9902      	ldr	r1, [sp, #8]
c0d00f68:	428a      	cmp	r2, r1
c0d00f6a:	dc2d      	bgt.n	c0d00fc8 <io_seproxyhal_touch_element_callback+0xc8>
c0d00f6c:	1940      	adds	r0, r0, r5
c0d00f6e:	8931      	ldrh	r1, [r6, #8]
c0d00f70:	1840      	adds	r0, r0, r1
    if (&elements[comp_idx] == G_bagl_last_touched_not_released_component) {
      last_touched_not_released_component_was_in_current_array = 1;
    }

    // the first component drawn with a 
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
c0d00f72:	9902      	ldr	r1, [sp, #8]
c0d00f74:	4281      	cmp	r1, r0
c0d00f76:	da27      	bge.n	c0d00fc8 <io_seproxyhal_touch_element_callback+0xc8>
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {

      // outing the previous over'ed component
      if (&elements[comp_idx] != G_bagl_last_touched_not_released_component 
c0d00f78:	6818      	ldr	r0, [r3, #0]
              && G_bagl_last_touched_not_released_component != NULL) {
c0d00f7a:	4286      	cmp	r6, r0
c0d00f7c:	d010      	beq.n	c0d00fa0 <io_seproxyhal_touch_element_callback+0xa0>
c0d00f7e:	6818      	ldr	r0, [r3, #0]
    if ((elements[comp_idx].component.type & BAGL_FLAG_TOUCHABLE) 
        && elements[comp_idx].component.x-elements[comp_idx].touch_area_brim <= x && x<elements[comp_idx].component.x+elements[comp_idx].component.width+elements[comp_idx].touch_area_brim
        && elements[comp_idx].component.y-elements[comp_idx].touch_area_brim <= y && y<elements[comp_idx].component.y+elements[comp_idx].component.height+elements[comp_idx].touch_area_brim) {

      // outing the previous over'ed component
      if (&elements[comp_idx] != G_bagl_last_touched_not_released_component 
c0d00f80:	2800      	cmp	r0, #0
c0d00f82:	d00d      	beq.n	c0d00fa0 <io_seproxyhal_touch_element_callback+0xa0>
              && G_bagl_last_touched_not_released_component != NULL) {
        // only out the previous element if the newly matching will be displayed 
        if (!before_display || before_display(&elements[comp_idx])) {
c0d00f84:	9801      	ldr	r0, [sp, #4]
c0d00f86:	2800      	cmp	r0, #0
c0d00f88:	d005      	beq.n	c0d00f96 <io_seproxyhal_touch_element_callback+0x96>
c0d00f8a:	4630      	mov	r0, r6
c0d00f8c:	9901      	ldr	r1, [sp, #4]
c0d00f8e:	4788      	blx	r1
c0d00f90:	4b1e      	ldr	r3, [pc, #120]	; (c0d0100c <io_seproxyhal_touch_element_callback+0x10c>)
c0d00f92:	2800      	cmp	r0, #0
c0d00f94:	d018      	beq.n	c0d00fc8 <io_seproxyhal_touch_element_callback+0xc8>
          if (io_seproxyhal_touch_out(G_bagl_last_touched_not_released_component, before_display)) {
c0d00f96:	6818      	ldr	r0, [r3, #0]
c0d00f98:	9901      	ldr	r1, [sp, #4]
c0d00f9a:	f7ff ff3d 	bl	c0d00e18 <io_seproxyhal_touch_out>
c0d00f9e:	e008      	b.n	c0d00fb2 <io_seproxyhal_touch_element_callback+0xb2>
c0d00fa0:	9800      	ldr	r0, [sp, #0]
        continue;
      }
      */
      
      // callback the hal to notify the component impacted by the user input
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_RELEASE) {
c0d00fa2:	2801      	cmp	r0, #1
c0d00fa4:	d009      	beq.n	c0d00fba <io_seproxyhal_touch_element_callback+0xba>
c0d00fa6:	2802      	cmp	r0, #2
c0d00fa8:	d10e      	bne.n	c0d00fc8 <io_seproxyhal_touch_element_callback+0xc8>
        if (io_seproxyhal_touch_tap(&elements[comp_idx], before_display)) {
c0d00faa:	4630      	mov	r0, r6
c0d00fac:	9901      	ldr	r1, [sp, #4]
c0d00fae:	f7ff ff83 	bl	c0d00eb8 <io_seproxyhal_touch_tap>
c0d00fb2:	4b16      	ldr	r3, [pc, #88]	; (c0d0100c <io_seproxyhal_touch_element_callback+0x10c>)
c0d00fb4:	2800      	cmp	r0, #0
c0d00fb6:	d007      	beq.n	c0d00fc8 <io_seproxyhal_touch_element_callback+0xc8>
c0d00fb8:	e023      	b.n	c0d01002 <io_seproxyhal_touch_element_callback+0x102>
          return;
        }
      }
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_TOUCH) {
        // ask for overing
        if (io_seproxyhal_touch_over(&elements[comp_idx], before_display)) {
c0d00fba:	4630      	mov	r0, r6
c0d00fbc:	9901      	ldr	r1, [sp, #4]
c0d00fbe:	f7ff ff4f 	bl	c0d00e60 <io_seproxyhal_touch_over>
c0d00fc2:	4b12      	ldr	r3, [pc, #72]	; (c0d0100c <io_seproxyhal_touch_element_callback+0x10c>)
c0d00fc4:	2800      	cmp	r0, #0
c0d00fc6:	d11f      	bne.n	c0d01008 <io_seproxyhal_touch_element_callback+0x108>
void io_seproxyhal_touch_element_callback(const bagl_element_t* elements, unsigned short element_count, unsigned short x, unsigned short y, unsigned char event_kind, bagl_element_callback_t before_display) {
  unsigned char comp_idx;
  unsigned char last_touched_not_released_component_was_in_current_array = 0;

  // find the first empty entry
  for (comp_idx=0; comp_idx < element_count; comp_idx++) {
c0d00fc8:	1c64      	adds	r4, r4, #1
c0d00fca:	b2e6      	uxtb	r6, r4
c0d00fcc:	9805      	ldr	r0, [sp, #20]
c0d00fce:	4286      	cmp	r6, r0
c0d00fd0:	d3a6      	bcc.n	c0d00f20 <io_seproxyhal_touch_element_callback+0x20>
c0d00fd2:	e000      	b.n	c0d00fd6 <io_seproxyhal_touch_element_callback+0xd6>
c0d00fd4:	4b0d      	ldr	r3, [pc, #52]	; (c0d0100c <io_seproxyhal_touch_element_callback+0x10c>)
    }
  }

  // if overing out of component or over another component, the out event is sent after the over event of the previous component
  if(last_touched_not_released_component_was_in_current_array 
    && G_bagl_last_touched_not_released_component != NULL) {
c0d00fd6:	9806      	ldr	r0, [sp, #24]
c0d00fd8:	0600      	lsls	r0, r0, #24
c0d00fda:	d010      	beq.n	c0d00ffe <io_seproxyhal_touch_element_callback+0xfe>
c0d00fdc:	6818      	ldr	r0, [r3, #0]
      }
    }
  }

  // if overing out of component or over another component, the out event is sent after the over event of the previous component
  if(last_touched_not_released_component_was_in_current_array 
c0d00fde:	2800      	cmp	r0, #0
c0d00fe0:	d00d      	beq.n	c0d00ffe <io_seproxyhal_touch_element_callback+0xfe>
    && G_bagl_last_touched_not_released_component != NULL) {

    // we won't be able to notify the out, don't do it, in case a diplay refused the dra of the relased element and the position matched another element of the array (in autocomplete for example)
    if (io_seproxyhal_spi_is_status_sent()) {
c0d00fe2:	f000 fbad 	bl	c0d01740 <io_seproxyhal_spi_is_status_sent>
c0d00fe6:	4909      	ldr	r1, [pc, #36]	; (c0d0100c <io_seproxyhal_touch_element_callback+0x10c>)
c0d00fe8:	2800      	cmp	r0, #0
c0d00fea:	d108      	bne.n	c0d00ffe <io_seproxyhal_touch_element_callback+0xfe>
      return;
    }
    
    if (io_seproxyhal_touch_out(G_bagl_last_touched_not_released_component, before_display)) {
c0d00fec:	6808      	ldr	r0, [r1, #0]
c0d00fee:	9901      	ldr	r1, [sp, #4]
c0d00ff0:	f7ff ff12 	bl	c0d00e18 <io_seproxyhal_touch_out>
c0d00ff4:	4d05      	ldr	r5, [pc, #20]	; (c0d0100c <io_seproxyhal_touch_element_callback+0x10c>)
c0d00ff6:	2800      	cmp	r0, #0
c0d00ff8:	d001      	beq.n	c0d00ffe <io_seproxyhal_touch_element_callback+0xfe>
      // ok component out has been emitted
      G_bagl_last_touched_not_released_component = NULL;
c0d00ffa:	2000      	movs	r0, #0
c0d00ffc:	6028      	str	r0, [r5, #0]
    }
  }

  // not processed
}
c0d00ffe:	b007      	add	sp, #28
c0d01000:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d01002:	2000      	movs	r0, #0
c0d01004:	6018      	str	r0, [r3, #0]
c0d01006:	e7fa      	b.n	c0d00ffe <io_seproxyhal_touch_element_callback+0xfe>
      }
      else if (event_kind == SEPROXYHAL_TAG_FINGER_EVENT_TOUCH) {
        // ask for overing
        if (io_seproxyhal_touch_over(&elements[comp_idx], before_display)) {
          // remember the last touched component
          G_bagl_last_touched_not_released_component = (bagl_element_t*)&elements[comp_idx];
c0d01008:	601e      	str	r6, [r3, #0]
c0d0100a:	e7f8      	b.n	c0d00ffe <io_seproxyhal_touch_element_callback+0xfe>
c0d0100c:	20001b10 	.word	0x20001b10

c0d01010 <io_seproxyhal_display_icon>:
  io_seproxyhal_spi_send((unsigned char*)color_index, h);
  io_seproxyhal_spi_send(bitmap, w);
  */
}

void io_seproxyhal_display_icon(bagl_component_t* icon_component, bagl_icon_details_t* icon_details) {
c0d01010:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01012:	af03      	add	r7, sp, #12
c0d01014:	b08b      	sub	sp, #44	; 0x2c
c0d01016:	460c      	mov	r4, r1
c0d01018:	4601      	mov	r1, r0
c0d0101a:	ad04      	add	r5, sp, #16
c0d0101c:	221c      	movs	r2, #28
  bagl_component_t icon_component_mod;
  // ensure not being out of bounds in the icon component agianst the declared icon real size
  os_memmove(&icon_component_mod, icon_component, sizeof(bagl_component_t));
c0d0101e:	4628      	mov	r0, r5
c0d01020:	9203      	str	r2, [sp, #12]
c0d01022:	f7ff fd2d 	bl	c0d00a80 <os_memmove>
  icon_component_mod.width = icon_details->width;
c0d01026:	6821      	ldr	r1, [r4, #0]
c0d01028:	80e9      	strh	r1, [r5, #6]
  icon_component_mod.height = icon_details->height;
c0d0102a:	6862      	ldr	r2, [r4, #4]
c0d0102c:	9502      	str	r5, [sp, #8]
c0d0102e:	812a      	strh	r2, [r5, #8]
  // component type = ICON, provided bitmap
  // => bitmap transmitted


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
c0d01030:	68a0      	ldr	r0, [r4, #8]
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
  unsigned short length = sizeof(bagl_component_t)
                          +1 /* bpp */
                          +h /* color index */
                          +w; /* image bitmap size */
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d01032:	4e1a      	ldr	r6, [pc, #104]	; (c0d0109c <io_seproxyhal_display_icon+0x8c>)
c0d01034:	2365      	movs	r3, #101	; 0x65
c0d01036:	4635      	mov	r5, r6
c0d01038:	7033      	strb	r3, [r6, #0]


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
  // bitmap size
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
c0d0103a:	b292      	uxth	r2, r2
c0d0103c:	4342      	muls	r2, r0
c0d0103e:	b28b      	uxth	r3, r1
c0d01040:	4353      	muls	r3, r2
c0d01042:	08d9      	lsrs	r1, r3, #3
c0d01044:	1c4e      	adds	r6, r1, #1
c0d01046:	2207      	movs	r2, #7
c0d01048:	4213      	tst	r3, r2
c0d0104a:	d100      	bne.n	c0d0104e <io_seproxyhal_display_icon+0x3e>
c0d0104c:	460e      	mov	r6, r1
c0d0104e:	4631      	mov	r1, r6
c0d01050:	9101      	str	r1, [sp, #4]
c0d01052:	2604      	movs	r6, #4
  // component type = ICON, provided bitmap
  // => bitmap transmitted


  // color index size
  unsigned int h = (1<<(icon_details->bpp))*sizeof(unsigned int); 
c0d01054:	4086      	lsls	r6, r0
  // bitmap size
  unsigned int w = ((icon_component->width*icon_component->height*icon_details->bpp)/8)+((icon_component->width*icon_component->height*icon_details->bpp)%8?1:0);
  unsigned short length = sizeof(bagl_component_t)
                          +1 /* bpp */
                          +h /* color index */
c0d01056:	1870      	adds	r0, r6, r1
                          +w; /* image bitmap size */
c0d01058:	301d      	adds	r0, #29
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
  G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d0105a:	0a01      	lsrs	r1, r0, #8
c0d0105c:	7069      	strb	r1, [r5, #1]
  G_io_seproxyhal_spi_buffer[2] = length;
c0d0105e:	70a8      	strb	r0, [r5, #2]
c0d01060:	2103      	movs	r1, #3
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d01062:	4628      	mov	r0, r5
c0d01064:	f000 fb4e 	bl	c0d01704 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)icon_component, sizeof(bagl_component_t));
c0d01068:	9802      	ldr	r0, [sp, #8]
c0d0106a:	9903      	ldr	r1, [sp, #12]
c0d0106c:	f000 fb4a 	bl	c0d01704 <io_seproxyhal_spi_send>
  G_io_seproxyhal_spi_buffer[0] = icon_details->bpp;
c0d01070:	68a0      	ldr	r0, [r4, #8]
c0d01072:	7028      	strb	r0, [r5, #0]
c0d01074:	2101      	movs	r1, #1
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 1);
c0d01076:	4628      	mov	r0, r5
c0d01078:	f000 fb44 	bl	c0d01704 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->colors), h);
c0d0107c:	68e0      	ldr	r0, [r4, #12]
c0d0107e:	f000 f9a5 	bl	c0d013cc <pic>
c0d01082:	b2b1      	uxth	r1, r6
c0d01084:	f000 fb3e 	bl	c0d01704 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send((unsigned char*)PIC(icon_details->bitmap), w);
c0d01088:	9801      	ldr	r0, [sp, #4]
c0d0108a:	b285      	uxth	r5, r0
c0d0108c:	6920      	ldr	r0, [r4, #16]
c0d0108e:	f000 f99d 	bl	c0d013cc <pic>
c0d01092:	4629      	mov	r1, r5
c0d01094:	f000 fb36 	bl	c0d01704 <io_seproxyhal_spi_send>
#endif // !SEPROXYHAL_TAG_SCREEN_DISPLAY_RAW_STATUS
}
c0d01098:	b00b      	add	sp, #44	; 0x2c
c0d0109a:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0109c:	20001800 	.word	0x20001800

c0d010a0 <io_seproxyhal_display_default>:

void io_seproxyhal_display_default(bagl_element_t * element) {
c0d010a0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d010a2:	af03      	add	r7, sp, #12
c0d010a4:	b081      	sub	sp, #4
c0d010a6:	4604      	mov	r4, r0
  // process automagically address from rom and from ram
  unsigned int type = (element->component.type & ~(BAGL_FLAG_TOUCHABLE));
c0d010a8:	7820      	ldrb	r0, [r4, #0]
c0d010aa:	267f      	movs	r6, #127	; 0x7f
c0d010ac:	4006      	ands	r6, r0

  if (type != BAGL_NONE) {
c0d010ae:	2e00      	cmp	r6, #0
c0d010b0:	d02e      	beq.n	c0d01110 <io_seproxyhal_display_default+0x70>
    if (element->text != NULL) {
c0d010b2:	69e0      	ldr	r0, [r4, #28]
c0d010b4:	2800      	cmp	r0, #0
c0d010b6:	d01d      	beq.n	c0d010f4 <io_seproxyhal_display_default+0x54>
      unsigned int text_adr = PIC((unsigned int)element->text);
c0d010b8:	f000 f988 	bl	c0d013cc <pic>
c0d010bc:	4605      	mov	r5, r0
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
c0d010be:	2e05      	cmp	r6, #5
c0d010c0:	d102      	bne.n	c0d010c8 <io_seproxyhal_display_default+0x28>
c0d010c2:	7ea0      	ldrb	r0, [r4, #26]
c0d010c4:	2800      	cmp	r0, #0
c0d010c6:	d025      	beq.n	c0d01114 <io_seproxyhal_display_default+0x74>
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
c0d010c8:	4628      	mov	r0, r5
c0d010ca:	f001 faff 	bl	c0d026cc <strlen>
c0d010ce:	4606      	mov	r6, r0
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d010d0:	4813      	ldr	r0, [pc, #76]	; (c0d01120 <io_seproxyhal_display_default+0x80>)
c0d010d2:	2165      	movs	r1, #101	; 0x65
c0d010d4:	7001      	strb	r1, [r0, #0]
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
      }
      else {
        unsigned short length = sizeof(bagl_component_t)+strlen((const char*)text_adr);
c0d010d6:	4631      	mov	r1, r6
c0d010d8:	311c      	adds	r1, #28
        G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
        G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d010da:	0a0a      	lsrs	r2, r1, #8
c0d010dc:	7042      	strb	r2, [r0, #1]
        G_io_seproxyhal_spi_buffer[2] = length;
c0d010de:	7081      	strb	r1, [r0, #2]
        io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d010e0:	2103      	movs	r1, #3
c0d010e2:	f000 fb0f 	bl	c0d01704 <io_seproxyhal_spi_send>
c0d010e6:	211c      	movs	r1, #28
        io_seproxyhal_spi_send((const void*)&element->component, sizeof(bagl_component_t));
c0d010e8:	4620      	mov	r0, r4
c0d010ea:	f000 fb0b 	bl	c0d01704 <io_seproxyhal_spi_send>
        io_seproxyhal_spi_send((const void*)text_adr, length-sizeof(bagl_component_t));
c0d010ee:	b2b1      	uxth	r1, r6
c0d010f0:	4628      	mov	r0, r5
c0d010f2:	e00b      	b.n	c0d0110c <io_seproxyhal_display_default+0x6c>
      }
    }
    else {
      unsigned short length = sizeof(bagl_component_t);
      G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SCREEN_DISPLAY_STATUS;
c0d010f4:	480a      	ldr	r0, [pc, #40]	; (c0d01120 <io_seproxyhal_display_default+0x80>)
c0d010f6:	2165      	movs	r1, #101	; 0x65
c0d010f8:	7001      	strb	r1, [r0, #0]
      G_io_seproxyhal_spi_buffer[1] = length>>8;
c0d010fa:	2100      	movs	r1, #0
c0d010fc:	7041      	strb	r1, [r0, #1]
c0d010fe:	251c      	movs	r5, #28
      G_io_seproxyhal_spi_buffer[2] = length;
c0d01100:	7085      	strb	r5, [r0, #2]
      io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 3);
c0d01102:	2103      	movs	r1, #3
c0d01104:	f000 fafe 	bl	c0d01704 <io_seproxyhal_spi_send>
      io_seproxyhal_spi_send((const void*)&element->component, sizeof(bagl_component_t));
c0d01108:	4620      	mov	r0, r4
c0d0110a:	4629      	mov	r1, r5
c0d0110c:	f000 fafa 	bl	c0d01704 <io_seproxyhal_spi_send>
    }
  }
}
c0d01110:	b001      	add	sp, #4
c0d01112:	bdf0      	pop	{r4, r5, r6, r7, pc}
  if (type != BAGL_NONE) {
    if (element->text != NULL) {
      unsigned int text_adr = PIC((unsigned int)element->text);
      // consider an icon details descriptor is pointed by the context
      if (type == BAGL_ICON && element->component.icon_id == 0) {
        io_seproxyhal_display_icon(&element->component, (bagl_icon_details_t*)text_adr);
c0d01114:	4620      	mov	r0, r4
c0d01116:	4629      	mov	r1, r5
c0d01118:	f7ff ff7a 	bl	c0d01010 <io_seproxyhal_display_icon>
c0d0111c:	e7f8      	b.n	c0d01110 <io_seproxyhal_display_default+0x70>
c0d0111e:	46c0      	nop			; (mov r8, r8)
c0d01120:	20001800 	.word	0x20001800

c0d01124 <bagl_label_roundtrip_duration_ms>:
      io_seproxyhal_spi_send((const void*)&element->component, sizeof(bagl_component_t));
    }
  }
}

unsigned int bagl_label_roundtrip_duration_ms(const bagl_element_t* e, unsigned int average_char_width) {
c0d01124:	b580      	push	{r7, lr}
c0d01126:	af00      	add	r7, sp, #0
c0d01128:	460a      	mov	r2, r1
  return bagl_label_roundtrip_duration_ms_buf(e, e->text, average_char_width);
c0d0112a:	69c1      	ldr	r1, [r0, #28]
c0d0112c:	f000 f801 	bl	c0d01132 <bagl_label_roundtrip_duration_ms_buf>
c0d01130:	bd80      	pop	{r7, pc}

c0d01132 <bagl_label_roundtrip_duration_ms_buf>:
}

unsigned int bagl_label_roundtrip_duration_ms_buf(const bagl_element_t* e, const char* str, unsigned int average_char_width) {
c0d01132:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01134:	af03      	add	r7, sp, #12
c0d01136:	b081      	sub	sp, #4
c0d01138:	4616      	mov	r6, r2
c0d0113a:	4604      	mov	r4, r0
c0d0113c:	2500      	movs	r5, #0
  // not a scrollable label
  if (e == NULL || (e->component.type != BAGL_LABEL && e->component.type != BAGL_LABELINE)) {
c0d0113e:	2c00      	cmp	r4, #0
c0d01140:	d01c      	beq.n	c0d0117c <bagl_label_roundtrip_duration_ms_buf+0x4a>
c0d01142:	7820      	ldrb	r0, [r4, #0]
c0d01144:	2807      	cmp	r0, #7
c0d01146:	d001      	beq.n	c0d0114c <bagl_label_roundtrip_duration_ms_buf+0x1a>
c0d01148:	2802      	cmp	r0, #2
c0d0114a:	d117      	bne.n	c0d0117c <bagl_label_roundtrip_duration_ms_buf+0x4a>
    return 0;
  }
  
  unsigned int text_adr = PIC((unsigned int)str);
c0d0114c:	4608      	mov	r0, r1
c0d0114e:	f000 f93d 	bl	c0d013cc <pic>
  unsigned int textlen = 0;
  
  // no delay, no text to display
  if (!text_adr) {
c0d01152:	2800      	cmp	r0, #0
c0d01154:	d012      	beq.n	c0d0117c <bagl_label_roundtrip_duration_ms_buf+0x4a>
    return 0;
  }
  textlen = strlen((const char*)text_adr);
c0d01156:	f001 fab9 	bl	c0d026cc <strlen>
  
  // no delay, all text fits
  textlen = textlen * average_char_width;
c0d0115a:	4346      	muls	r6, r0
  if (textlen <= e->component.width) {
c0d0115c:	88e0      	ldrh	r0, [r4, #6]
c0d0115e:	4286      	cmp	r6, r0
c0d01160:	d90c      	bls.n	c0d0117c <bagl_label_roundtrip_duration_ms_buf+0x4a>
    return 0; 
  }
  
  // compute scrolled text length
  return 2*(textlen - e->component.width)*1000/e->component.icon_id + 2*(e->component.stroke & ~(0x80))*100;
c0d01162:	1a31      	subs	r1, r6, r0
c0d01164:	207d      	movs	r0, #125	; 0x7d
c0d01166:	0100      	lsls	r0, r0, #4
c0d01168:	4348      	muls	r0, r1
c0d0116a:	7ea1      	ldrb	r1, [r4, #26]
c0d0116c:	f001 f9b4 	bl	c0d024d8 <__aeabi_uidiv>
c0d01170:	7aa1      	ldrb	r1, [r4, #10]
c0d01172:	0049      	lsls	r1, r1, #1
c0d01174:	b2c9      	uxtb	r1, r1
c0d01176:	2264      	movs	r2, #100	; 0x64
c0d01178:	434a      	muls	r2, r1
c0d0117a:	1815      	adds	r5, r2, r0
}
c0d0117c:	4628      	mov	r0, r5
c0d0117e:	b001      	add	sp, #4
c0d01180:	bdf0      	pop	{r4, r5, r6, r7, pc}
	...

c0d01184 <io_seproxyhal_setup_ticker>:

void io_seproxyhal_setup_ticker(unsigned int interval_ms) {
c0d01184:	b580      	push	{r7, lr}
c0d01186:	af00      	add	r7, sp, #0
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_SET_TICKER_INTERVAL;
c0d01188:	4a07      	ldr	r2, [pc, #28]	; (c0d011a8 <io_seproxyhal_setup_ticker+0x24>)
c0d0118a:	214e      	movs	r1, #78	; 0x4e
c0d0118c:	7011      	strb	r1, [r2, #0]
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d0118e:	2100      	movs	r1, #0
c0d01190:	7051      	strb	r1, [r2, #1]
  G_io_seproxyhal_spi_buffer[2] = 2;
c0d01192:	2102      	movs	r1, #2
c0d01194:	7091      	strb	r1, [r2, #2]
  G_io_seproxyhal_spi_buffer[3] = (interval_ms>>8)&0xff;
c0d01196:	0a01      	lsrs	r1, r0, #8
c0d01198:	70d1      	strb	r1, [r2, #3]
  G_io_seproxyhal_spi_buffer[4] = (interval_ms)&0xff;
c0d0119a:	7110      	strb	r0, [r2, #4]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 5);
c0d0119c:	2105      	movs	r1, #5
c0d0119e:	4610      	mov	r0, r2
c0d011a0:	f000 fab0 	bl	c0d01704 <io_seproxyhal_spi_send>
}
c0d011a4:	bd80      	pop	{r7, pc}
c0d011a6:	46c0      	nop			; (mov r8, r8)
c0d011a8:	20001800 	.word	0x20001800

c0d011ac <io_seproxyhal_button_push>:
  G_io_seproxyhal_spi_buffer[3] = (backlight_percentage?0x80:0)|(flags & 0x7F); // power on
  G_io_seproxyhal_spi_buffer[4] = backlight_percentage;
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 5);
}

void io_seproxyhal_button_push(button_push_callback_t button_callback, unsigned int new_button_mask) {
c0d011ac:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d011ae:	af03      	add	r7, sp, #12
c0d011b0:	b081      	sub	sp, #4
c0d011b2:	4604      	mov	r4, r0
  if (button_callback) {
c0d011b4:	2c00      	cmp	r4, #0
c0d011b6:	d02e      	beq.n	c0d01216 <io_seproxyhal_button_push+0x6a>
    unsigned int button_mask;
    unsigned int button_same_mask_counter;
    // enable speeded up long push
    if (new_button_mask == G_button_mask) {
c0d011b8:	4818      	ldr	r0, [pc, #96]	; (c0d0121c <io_seproxyhal_button_push+0x70>)
c0d011ba:	6802      	ldr	r2, [r0, #0]
c0d011bc:	428a      	cmp	r2, r1
c0d011be:	d103      	bne.n	c0d011c8 <io_seproxyhal_button_push+0x1c>
      // each 100ms ~
      G_button_same_mask_counter++;
c0d011c0:	4a17      	ldr	r2, [pc, #92]	; (c0d01220 <io_seproxyhal_button_push+0x74>)
c0d011c2:	6813      	ldr	r3, [r2, #0]
c0d011c4:	1c5b      	adds	r3, r3, #1
c0d011c6:	6013      	str	r3, [r2, #0]
    }

    // append the button mask
    button_mask = G_button_mask | new_button_mask;
c0d011c8:	6806      	ldr	r6, [r0, #0]
c0d011ca:	430e      	orrs	r6, r1

    // pre reset variable due to os_sched_exit
    button_same_mask_counter = G_button_same_mask_counter;
c0d011cc:	4a14      	ldr	r2, [pc, #80]	; (c0d01220 <io_seproxyhal_button_push+0x74>)
c0d011ce:	6815      	ldr	r5, [r2, #0]

    // reset button mask
    if (new_button_mask == 0) {
c0d011d0:	2900      	cmp	r1, #0
c0d011d2:	d001      	beq.n	c0d011d8 <io_seproxyhal_button_push+0x2c>

      // notify button released event
      button_mask |= BUTTON_EVT_RELEASED;
    }
    else {
      G_button_mask = button_mask;
c0d011d4:	6006      	str	r6, [r0, #0]
c0d011d6:	e005      	b.n	c0d011e4 <io_seproxyhal_button_push+0x38>
c0d011d8:	2300      	movs	r3, #0
    button_same_mask_counter = G_button_same_mask_counter;

    // reset button mask
    if (new_button_mask == 0) {
      // reset next state when button are released
      G_button_mask = 0;
c0d011da:	6003      	str	r3, [r0, #0]
      G_button_same_mask_counter=0;
c0d011dc:	6013      	str	r3, [r2, #0]

      // notify button released event
      button_mask |= BUTTON_EVT_RELEASED;
c0d011de:	2301      	movs	r3, #1
c0d011e0:	07db      	lsls	r3, r3, #31
c0d011e2:	431e      	orrs	r6, r3
    else {
      G_button_mask = button_mask;
    }

    // reset counter when button mask changes
    if (new_button_mask != G_button_mask) {
c0d011e4:	6800      	ldr	r0, [r0, #0]
c0d011e6:	4288      	cmp	r0, r1
c0d011e8:	d001      	beq.n	c0d011ee <io_seproxyhal_button_push+0x42>
      G_button_same_mask_counter=0;
c0d011ea:	2000      	movs	r0, #0
c0d011ec:	6010      	str	r0, [r2, #0]
    }

    if (button_same_mask_counter >= BUTTON_FAST_THRESHOLD_CS) {
c0d011ee:	2d08      	cmp	r5, #8
c0d011f0:	d30e      	bcc.n	c0d01210 <io_seproxyhal_button_push+0x64>
      // fast bit when pressing and timing is right
      if ((button_same_mask_counter%BUTTON_FAST_ACTION_CS) == 0) {
c0d011f2:	2103      	movs	r1, #3
c0d011f4:	4628      	mov	r0, r5
c0d011f6:	f001 f9f5 	bl	c0d025e4 <__aeabi_uidivmod>
        button_mask |= BUTTON_EVT_FAST;
c0d011fa:	2001      	movs	r0, #1
c0d011fc:	0780      	lsls	r0, r0, #30
c0d011fe:	4330      	orrs	r0, r6
      G_button_same_mask_counter=0;
    }

    if (button_same_mask_counter >= BUTTON_FAST_THRESHOLD_CS) {
      // fast bit when pressing and timing is right
      if ((button_same_mask_counter%BUTTON_FAST_ACTION_CS) == 0) {
c0d01200:	2900      	cmp	r1, #0
c0d01202:	4601      	mov	r1, r0
c0d01204:	d000      	beq.n	c0d01208 <io_seproxyhal_button_push+0x5c>
c0d01206:	4631      	mov	r1, r6
        button_mask |= BUTTON_EVT_FAST;
      }
      // fast bit when releasing and threshold has been exceeded
      if ((button_mask & BUTTON_EVT_RELEASED)) {
c0d01208:	2900      	cmp	r1, #0
c0d0120a:	db02      	blt.n	c0d01212 <io_seproxyhal_button_push+0x66>
c0d0120c:	4608      	mov	r0, r1
c0d0120e:	e000      	b.n	c0d01212 <io_seproxyhal_button_push+0x66>
c0d01210:	4630      	mov	r0, r6
        button_mask |= BUTTON_EVT_FAST;
      }
    }

    // indicate if button have been released
    button_callback(button_mask, button_same_mask_counter);
c0d01212:	4629      	mov	r1, r5
c0d01214:	47a0      	blx	r4
  }
}
c0d01216:	b001      	add	sp, #4
c0d01218:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0121a:	46c0      	nop			; (mov r8, r8)
c0d0121c:	20001b14 	.word	0x20001b14
c0d01220:	20001b18 	.word	0x20001b18

c0d01224 <io_exchange>:

#endif // HAVE_BAGL

unsigned short io_exchange(unsigned char channel, unsigned short tx_len) {
c0d01224:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01226:	af03      	add	r7, sp, #12
c0d01228:	b081      	sub	sp, #4
c0d0122a:	4604      	mov	r4, r0
    }
  }
  after_debug:
#endif // DEBUG_APDU

  switch(channel&~(IO_FLAGS)) {
c0d0122c:	200f      	movs	r0, #15
c0d0122e:	4204      	tst	r4, r0
c0d01230:	d006      	beq.n	c0d01240 <io_exchange+0x1c>
      }
    }
    break;

  default:
    return io_exchange_al(channel, tx_len);
c0d01232:	4620      	mov	r0, r4
c0d01234:	f7fe ff30 	bl	c0d00098 <io_exchange_al>
c0d01238:	4605      	mov	r5, r0
  }
}
c0d0123a:	b2a8      	uxth	r0, r5
c0d0123c:	b001      	add	sp, #4
c0d0123e:	bdf0      	pop	{r4, r5, r6, r7, pc}

  switch(channel&~(IO_FLAGS)) {
  case CHANNEL_APDU:
    // TODO work up the spi state machine over the HAL proxy until an APDU is available

    if (tx_len && !(channel&IO_ASYNCH_REPLY)) {
c0d01240:	2610      	movs	r6, #16
c0d01242:	4026      	ands	r6, r4
c0d01244:	2900      	cmp	r1, #0
c0d01246:	d02a      	beq.n	c0d0129e <io_exchange+0x7a>
c0d01248:	2e00      	cmp	r6, #0
c0d0124a:	d128      	bne.n	c0d0129e <io_exchange+0x7a>

      // until the whole RAPDU is transmitted, send chunks using the current mode for communication
      for (;;) {
        switch(G_io_apdu_state) {
c0d0124c:	483d      	ldr	r0, [pc, #244]	; (c0d01344 <io_exchange+0x120>)
c0d0124e:	7800      	ldrb	r0, [r0, #0]
c0d01250:	2807      	cmp	r0, #7
c0d01252:	d00b      	beq.n	c0d0126c <io_exchange+0x48>
c0d01254:	2800      	cmp	r0, #0
c0d01256:	d004      	beq.n	c0d01262 <io_exchange+0x3e>
          default: 
            // delegate to the hal in case of not generic transport mode (or asynch)
            if (io_exchange_al(channel, tx_len) == 0) {
c0d01258:	4620      	mov	r0, r4
c0d0125a:	f7fe ff1d 	bl	c0d00098 <io_exchange_al>
c0d0125e:	2800      	cmp	r0, #0
c0d01260:	d00a      	beq.n	c0d01278 <io_exchange+0x54>
              goto break_send;
            }
          case APDU_IDLE:
            LOG("invalid state for APDU reply\n");
            THROW(INVALID_STATE);
c0d01262:	4839      	ldr	r0, [pc, #228]	; (c0d01348 <io_exchange+0x124>)
c0d01264:	6800      	ldr	r0, [r0, #0]
c0d01266:	2109      	movs	r1, #9
c0d01268:	f001 fa22 	bl	c0d026b0 <longjmp>
            break;

#ifdef HAVE_USB_APDU
          case APDU_USB_HID:
            // only send, don't perform synchronous reception of the next command (will be done later by the seproxyhal packet processing)
            io_usb_hid_exchange(io_usb_send_apdu_data, tx_len, NULL, IO_RETURN_AFTER_TX);
c0d0126c:	483d      	ldr	r0, [pc, #244]	; (c0d01364 <io_exchange+0x140>)
c0d0126e:	4478      	add	r0, pc
c0d01270:	2200      	movs	r2, #0
c0d01272:	2320      	movs	r3, #32
c0d01274:	f7ff fc26 	bl	c0d00ac4 <io_usb_hid_exchange>
c0d01278:	2500      	movs	r5, #0
        }
        continue;

      break_send:
        // reset apdu state
        G_io_apdu_state = APDU_IDLE;
c0d0127a:	4832      	ldr	r0, [pc, #200]	; (c0d01344 <io_exchange+0x120>)
c0d0127c:	7005      	strb	r5, [r0, #0]
        G_io_apdu_offset = 0;
c0d0127e:	4833      	ldr	r0, [pc, #204]	; (c0d0134c <io_exchange+0x128>)
c0d01280:	8005      	strh	r5, [r0, #0]
        G_io_apdu_length = 0;
c0d01282:	4833      	ldr	r0, [pc, #204]	; (c0d01350 <io_exchange+0x12c>)
c0d01284:	8005      	strh	r5, [r0, #0]
        G_io_apdu_seq = 0;
c0d01286:	4833      	ldr	r0, [pc, #204]	; (c0d01354 <io_exchange+0x130>)
c0d01288:	8005      	strh	r5, [r0, #0]
        G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d0128a:	4833      	ldr	r0, [pc, #204]	; (c0d01358 <io_exchange+0x134>)
c0d0128c:	7005      	strb	r5, [r0, #0]

        // continue sending commands, don't issue status yet
        if (channel & IO_RETURN_AFTER_TX) {
c0d0128e:	06a0      	lsls	r0, r4, #26
c0d01290:	d4d3      	bmi.n	c0d0123a <io_exchange+0x16>
          return 0;
        }
        // acknowledge the write request (general status OK) and no more command to follow (wait until another APDU container is received to continue unwrapping)
        io_seproxyhal_general_status();
c0d01292:	f7ff fc8f 	bl	c0d00bb4 <io_seproxyhal_general_status>
        break;
      }

      // perform reset after io exchange
      if (channel & IO_RESET_AFTER_REPLIED) {
c0d01296:	0620      	lsls	r0, r4, #24
c0d01298:	d501      	bpl.n	c0d0129e <io_exchange+0x7a>
        reset();
c0d0129a:	f000 f8cd 	bl	c0d01438 <reset>
      }
    }

    if (!(channel&IO_ASYNCH_REPLY)) {
c0d0129e:	2e00      	cmp	r6, #0
c0d012a0:	d10c      	bne.n	c0d012bc <io_exchange+0x98>
      
      // already received the data of the apdu when received the whole apdu
      if ((channel & (CHANNEL_APDU|IO_RECEIVE_DATA)) == (CHANNEL_APDU|IO_RECEIVE_DATA)) {
c0d012a2:	0660      	lsls	r0, r4, #25
c0d012a4:	d448      	bmi.n	c0d01338 <io_exchange+0x114>
        // return apdu data - header
        return G_io_apdu_length-5;
      }

      // reply has ended, proceed to next apdu reception (reset status only after asynch reply)
      G_io_apdu_state = APDU_IDLE;
c0d012a6:	4827      	ldr	r0, [pc, #156]	; (c0d01344 <io_exchange+0x120>)
c0d012a8:	2100      	movs	r1, #0
c0d012aa:	7001      	strb	r1, [r0, #0]
      G_io_apdu_offset = 0;
c0d012ac:	4827      	ldr	r0, [pc, #156]	; (c0d0134c <io_exchange+0x128>)
c0d012ae:	8001      	strh	r1, [r0, #0]
      G_io_apdu_length = 0;
c0d012b0:	4827      	ldr	r0, [pc, #156]	; (c0d01350 <io_exchange+0x12c>)
c0d012b2:	8001      	strh	r1, [r0, #0]
      G_io_apdu_seq = 0;
c0d012b4:	4827      	ldr	r0, [pc, #156]	; (c0d01354 <io_exchange+0x130>)
c0d012b6:	8001      	strh	r1, [r0, #0]
      G_io_apdu_media = IO_APDU_MEDIA_NONE;
c0d012b8:	4827      	ldr	r0, [pc, #156]	; (c0d01358 <io_exchange+0x134>)
c0d012ba:	7001      	strb	r1, [r0, #0]
c0d012bc:	4c28      	ldr	r4, [pc, #160]	; (c0d01360 <io_exchange+0x13c>)
c0d012be:	4e24      	ldr	r6, [pc, #144]	; (c0d01350 <io_exchange+0x12c>)
c0d012c0:	e008      	b.n	c0d012d4 <io_exchange+0xb0>
        case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
          if (rx_len < 3+3) {
            // error !
            return 0;
          }
          io_seproxyhal_handle_usb_ep_xfer_event();
c0d012c2:	f7ff fccb 	bl	c0d00c5c <io_seproxyhal_handle_usb_ep_xfer_event>

          // an apdu has been received, ack with mode commands (the reply at least)
          if (G_io_apdu_length > 0) {
c0d012c6:	8830      	ldrh	r0, [r6, #0]
c0d012c8:	2800      	cmp	r0, #0
c0d012ca:	d003      	beq.n	c0d012d4 <io_exchange+0xb0>
c0d012cc:	e032      	b.n	c0d01334 <io_exchange+0x110>
          break;
#endif // HAVE_IO_USB

        default:
          // tell the application that a non-apdu packet has been received
          io_event(CHANNEL_SPI);
c0d012ce:	2002      	movs	r0, #2
c0d012d0:	f7fe ff10 	bl	c0d000f4 <io_event>

    // ensure ready to receive an event (after an apdu processing with asynch flag, it may occur if the channel is not correctly managed)

    // until a new whole CAPDU is received
    for (;;) {
      if (!io_seproxyhal_spi_is_status_sent()) {
c0d012d4:	f000 fa34 	bl	c0d01740 <io_seproxyhal_spi_is_status_sent>
c0d012d8:	2800      	cmp	r0, #0
c0d012da:	d101      	bne.n	c0d012e0 <io_exchange+0xbc>
        io_seproxyhal_general_status();
c0d012dc:	f7ff fc6a 	bl	c0d00bb4 <io_seproxyhal_general_status>
      }

      // wait until a SPI packet is available
      // NOTE: on ST31, dual wait ISO & RF (ISO instead of SPI)
      rx_len = io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d012e0:	2180      	movs	r1, #128	; 0x80
c0d012e2:	2500      	movs	r5, #0
c0d012e4:	4620      	mov	r0, r4
c0d012e6:	462a      	mov	r2, r5
c0d012e8:	f000 fa46 	bl	c0d01778 <io_seproxyhal_spi_recv>

      // can't process split TLV, continue
      if (rx_len-3 != U2(G_io_seproxyhal_spi_buffer[1],G_io_seproxyhal_spi_buffer[2])) {
c0d012ec:	1ec1      	subs	r1, r0, #3
c0d012ee:	78a2      	ldrb	r2, [r4, #2]
c0d012f0:	7863      	ldrb	r3, [r4, #1]
c0d012f2:	021b      	lsls	r3, r3, #8
c0d012f4:	4313      	orrs	r3, r2
c0d012f6:	4299      	cmp	r1, r3
c0d012f8:	d110      	bne.n	c0d0131c <io_exchange+0xf8>
      send_last_command:
        continue;
      }

      // if an apdu is already ongoing, then discard packet as a new packet
      if (G_io_apdu_media != IO_APDU_MEDIA_NONE) {
c0d012fa:	4917      	ldr	r1, [pc, #92]	; (c0d01358 <io_exchange+0x134>)
c0d012fc:	7809      	ldrb	r1, [r1, #0]
c0d012fe:	2900      	cmp	r1, #0
c0d01300:	d002      	beq.n	c0d01308 <io_exchange+0xe4>
        io_seproxyhal_handle_event();
c0d01302:	f7ff fd2f 	bl	c0d00d64 <io_seproxyhal_handle_event>
c0d01306:	e7e5      	b.n	c0d012d4 <io_exchange+0xb0>
        continue;
      }

      // depending on received TAG
      switch(G_io_seproxyhal_spi_buffer[0]) {
c0d01308:	7821      	ldrb	r1, [r4, #0]
c0d0130a:	2910      	cmp	r1, #16
c0d0130c:	d00f      	beq.n	c0d0132e <io_exchange+0x10a>
c0d0130e:	290f      	cmp	r1, #15
c0d01310:	d1dd      	bne.n	c0d012ce <io_exchange+0xaa>
          goto send_last_command;
#endif // HAVE_BLE

#ifdef HAVE_IO_USB
        case SEPROXYHAL_TAG_USB_EVENT:
          if (rx_len != 3+1) {
c0d01312:	2804      	cmp	r0, #4
c0d01314:	d102      	bne.n	c0d0131c <io_exchange+0xf8>
            // invalid length, not processable
            goto invalid_apdu_packet;
          }
          io_seproxyhal_handle_usb_event();
c0d01316:	f7ff fc63 	bl	c0d00be0 <io_seproxyhal_handle_usb_event>
c0d0131a:	e7db      	b.n	c0d012d4 <io_exchange+0xb0>
c0d0131c:	2000      	movs	r0, #0

      // can't process split TLV, continue
      if (rx_len-3 != U2(G_io_seproxyhal_spi_buffer[1],G_io_seproxyhal_spi_buffer[2])) {
        LOG("invalid TLV format\n");
      invalid_apdu_packet:
        G_io_apdu_state = APDU_IDLE;
c0d0131e:	4909      	ldr	r1, [pc, #36]	; (c0d01344 <io_exchange+0x120>)
c0d01320:	7008      	strb	r0, [r1, #0]
        G_io_apdu_offset = 0;
c0d01322:	490a      	ldr	r1, [pc, #40]	; (c0d0134c <io_exchange+0x128>)
c0d01324:	8008      	strh	r0, [r1, #0]
        G_io_apdu_length = 0;
c0d01326:	8030      	strh	r0, [r6, #0]
        G_io_apdu_seq = 0;
c0d01328:	490a      	ldr	r1, [pc, #40]	; (c0d01354 <io_exchange+0x130>)
c0d0132a:	8008      	strh	r0, [r1, #0]
c0d0132c:	e7d2      	b.n	c0d012d4 <io_exchange+0xb0>

          // no state change, we're not dealing with an apdu yet
          goto send_last_command;

        case SEPROXYHAL_TAG_USB_EP_XFER_EVENT:
          if (rx_len < 3+3) {
c0d0132e:	2806      	cmp	r0, #6
c0d01330:	d2c7      	bcs.n	c0d012c2 <io_exchange+0x9e>
c0d01332:	e782      	b.n	c0d0123a <io_exchange+0x16>
          io_seproxyhal_handle_usb_ep_xfer_event();

          // an apdu has been received, ack with mode commands (the reply at least)
          if (G_io_apdu_length > 0) {
            // invalid return when reentered and an apdu is already under processing
            return G_io_apdu_length;
c0d01334:	8835      	ldrh	r5, [r6, #0]
c0d01336:	e780      	b.n	c0d0123a <io_exchange+0x16>
    if (!(channel&IO_ASYNCH_REPLY)) {
      
      // already received the data of the apdu when received the whole apdu
      if ((channel & (CHANNEL_APDU|IO_RECEIVE_DATA)) == (CHANNEL_APDU|IO_RECEIVE_DATA)) {
        // return apdu data - header
        return G_io_apdu_length-5;
c0d01338:	4805      	ldr	r0, [pc, #20]	; (c0d01350 <io_exchange+0x12c>)
c0d0133a:	8800      	ldrh	r0, [r0, #0]
c0d0133c:	4907      	ldr	r1, [pc, #28]	; (c0d0135c <io_exchange+0x138>)
c0d0133e:	1845      	adds	r5, r0, r1
c0d01340:	e77b      	b.n	c0d0123a <io_exchange+0x16>
c0d01342:	46c0      	nop			; (mov r8, r8)
c0d01344:	20001b08 	.word	0x20001b08
c0d01348:	200019a8 	.word	0x200019a8
c0d0134c:	20001b0a 	.word	0x20001b0a
c0d01350:	20001b0c 	.word	0x20001b0c
c0d01354:	20001b0e 	.word	0x20001b0e
c0d01358:	20001b00 	.word	0x20001b00
c0d0135c:	0000fffb 	.word	0x0000fffb
c0d01360:	20001800 	.word	0x20001800
c0d01364:	fffffb33 	.word	0xfffffb33

c0d01368 <os_ux_blocking>:
  default:
    return io_exchange_al(channel, tx_len);
  }
}

unsigned int os_ux_blocking(bolos_ux_params_t* params) {
c0d01368:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0136a:	af03      	add	r7, sp, #12
c0d0136c:	b081      	sub	sp, #4
c0d0136e:	4604      	mov	r4, r0
c0d01370:	4d14      	ldr	r5, [pc, #80]	; (c0d013c4 <os_ux_blocking+0x5c>)
c0d01372:	e01a      	b.n	c0d013aa <os_ux_blocking+0x42>


    // process events
    for (;;) {
      // send general status before receiving next event
      if (!io_seproxyhal_spi_is_status_sent()) {
c0d01374:	f000 f9e4 	bl	c0d01740 <io_seproxyhal_spi_is_status_sent>
c0d01378:	2800      	cmp	r0, #0
c0d0137a:	d101      	bne.n	c0d01380 <os_ux_blocking+0x18>
        io_seproxyhal_general_status();
c0d0137c:	f7ff fc1a 	bl	c0d00bb4 <io_seproxyhal_general_status>
      }

      /*unsigned int rx_len = */io_seproxyhal_spi_recv(G_io_seproxyhal_spi_buffer, sizeof(G_io_seproxyhal_spi_buffer), 0);
c0d01380:	2180      	movs	r1, #128	; 0x80
c0d01382:	2600      	movs	r6, #0
c0d01384:	4628      	mov	r0, r5
c0d01386:	4632      	mov	r2, r6
c0d01388:	f000 f9f6 	bl	c0d01778 <io_seproxyhal_spi_recv>

      switch (G_io_seproxyhal_spi_buffer[0]) {
c0d0138c:	7828      	ldrb	r0, [r5, #0]
c0d0138e:	2815      	cmp	r0, #21
c0d01390:	d804      	bhi.n	c0d0139c <os_ux_blocking+0x34>
c0d01392:	2101      	movs	r1, #1
c0d01394:	4081      	lsls	r1, r0
c0d01396:	480c      	ldr	r0, [pc, #48]	; (c0d013c8 <os_ux_blocking+0x60>)
c0d01398:	4201      	tst	r1, r0
c0d0139a:	d103      	bne.n	c0d013a4 <os_ux_blocking+0x3c>
          // perform UX event on these ones, don't process as an IO event
          break;

        default:
          // if malformed, then a stall is likely to occur
          if (io_seproxyhal_handle_event()) {
c0d0139c:	f7ff fce2 	bl	c0d00d64 <io_seproxyhal_handle_event>
c0d013a0:	2800      	cmp	r0, #0
c0d013a2:	d1e7      	bne.n	c0d01374 <os_ux_blocking+0xc>

      // pass the packet to the ux
      break;
    }
    // prepare processing of the packet by the ux
    params->ux_id = BOLOS_UX_EVENT;
c0d013a4:	2001      	movs	r0, #1
c0d013a6:	7020      	strb	r0, [r4, #0]
    params->len = 0;
c0d013a8:	6066      	str	r6, [r4, #4]
    ret = os_ux(params);
c0d013aa:	4620      	mov	r0, r4
c0d013ac:	f000 f98c 	bl	c0d016c8 <os_ux>

unsigned int os_ux_blocking(bolos_ux_params_t* params) {
  unsigned int ret;
  // until a real status is returned
  ret = os_ux(params);
  while(ret == BOLOS_UX_IGNORE 
c0d013b0:	2800      	cmp	r0, #0
c0d013b2:	d0df      	beq.n	c0d01374 <os_ux_blocking+0xc>
c0d013b4:	4902      	ldr	r1, [pc, #8]	; (c0d013c0 <os_ux_blocking+0x58>)
c0d013b6:	4288      	cmp	r0, r1
c0d013b8:	d0dc      	beq.n	c0d01374 <os_ux_blocking+0xc>
    params->ux_id = BOLOS_UX_EVENT;
    params->len = 0;
    ret = os_ux(params);
  }

  return ret;
c0d013ba:	b001      	add	sp, #4
c0d013bc:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d013be:	46c0      	nop			; (mov r8, r8)
c0d013c0:	b0105044 	.word	0xb0105044
c0d013c4:	20001800 	.word	0x20001800
c0d013c8:	00207020 	.word	0x00207020

c0d013cc <pic>:

// only apply PIC conversion if link_address is in linked code (over 0xC0D00000 in our example)
// this way, PIC call are armless if the address is not meant to be converted
extern unsigned int _nvram;
extern unsigned int _envram;
unsigned int pic(unsigned int link_address) {
c0d013cc:	b580      	push	{r7, lr}
c0d013ce:	af00      	add	r7, sp, #0
//  screen_printf(" %08X", link_address);
	if (link_address >= ((unsigned int)&_nvram) && link_address < ((unsigned int)&_envram)) {
c0d013d0:	4904      	ldr	r1, [pc, #16]	; (c0d013e4 <pic+0x18>)
c0d013d2:	4288      	cmp	r0, r1
c0d013d4:	d304      	bcc.n	c0d013e0 <pic+0x14>
c0d013d6:	4904      	ldr	r1, [pc, #16]	; (c0d013e8 <pic+0x1c>)
c0d013d8:	4288      	cmp	r0, r1
c0d013da:	d201      	bcs.n	c0d013e0 <pic+0x14>
		link_address = pic_internal(link_address);
c0d013dc:	f000 f806 	bl	c0d013ec <pic_internal>
//    screen_printf(" -> %08X\n", link_address);
  }
	return link_address;
c0d013e0:	bd80      	pop	{r7, pc}
c0d013e2:	46c0      	nop			; (mov r8, r8)
c0d013e4:	c0d00000 	.word	0xc0d00000
c0d013e8:	c0d02980 	.word	0xc0d02980

c0d013ec <pic_internal>:

unsigned int pic_internal(unsigned int link_address) __attribute__((naked));
unsigned int pic_internal(unsigned int link_address) 
{
  // compute the delta offset between LinkMemAddr & ExecMemAddr
  __asm volatile ("mov r2, pc\n");          // r2 = 0x109004
c0d013ec:	467a      	mov	r2, pc
  __asm volatile ("ldr r1, =pic_internal\n");        // r1 = 0xC0D00001
c0d013ee:	4902      	ldr	r1, [pc, #8]	; (c0d013f8 <pic_internal+0xc>)
  __asm volatile ("adds r1, r1, #3\n");     // r1 = 0xC0D00004
c0d013f0:	1cc9      	adds	r1, r1, #3
  __asm volatile ("subs r1, r1, r2\n");     // r1 = 0xC0BF7000 (delta between load and exec address)
c0d013f2:	1a89      	subs	r1, r1, r2

  // adjust value of the given parameter
  __asm volatile ("subs r0, r0, r1\n");     // r0 = 0xC0D0C244 => r0 = 0x115244
c0d013f4:	1a40      	subs	r0, r0, r1
  __asm volatile ("bx lr\n");
c0d013f6:	4770      	bx	lr
c0d013f8:	c0d013ed 	.word	0xc0d013ed

c0d013fc <check_api_level>:
/* MACHINE GENERATED: DO NOT MODIFY */
#include "os.h"
#include "syscalls.h"

void check_api_level ( unsigned int apiLevel ) 
{
c0d013fc:	b580      	push	{r7, lr}
c0d013fe:	af00      	add	r7, sp, #0
c0d01400:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_check_api_level_ID_IN;
c0d01402:	490a      	ldr	r1, [pc, #40]	; (c0d0142c <check_api_level+0x30>)
c0d01404:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01406:	490a      	ldr	r1, [pc, #40]	; (c0d01430 <check_api_level+0x34>)
c0d01408:	680a      	ldr	r2, [r1, #0]
c0d0140a:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)apiLevel;
c0d0140c:	9003      	str	r0, [sp, #12]
c0d0140e:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01410:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01412:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01414:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_check_api_level_ID_OUT)
c0d01416:	4807      	ldr	r0, [pc, #28]	; (c0d01434 <check_api_level+0x38>)
c0d01418:	9a01      	ldr	r2, [sp, #4]
c0d0141a:	4282      	cmp	r2, r0
c0d0141c:	d101      	bne.n	c0d01422 <check_api_level+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d0141e:	b004      	add	sp, #16
c0d01420:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_check_api_level_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01422:	6808      	ldr	r0, [r1, #0]
c0d01424:	2104      	movs	r1, #4
c0d01426:	f001 f943 	bl	c0d026b0 <longjmp>
c0d0142a:	46c0      	nop			; (mov r8, r8)
c0d0142c:	60000137 	.word	0x60000137
c0d01430:	200019a8 	.word	0x200019a8
c0d01434:	900001c6 	.word	0x900001c6

c0d01438 <reset>:
  }
}

void reset ( void ) 
{
c0d01438:	b580      	push	{r7, lr}
c0d0143a:	af00      	add	r7, sp, #0
c0d0143c:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_reset_ID_IN;
c0d0143e:	4809      	ldr	r0, [pc, #36]	; (c0d01464 <reset+0x2c>)
c0d01440:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01442:	4809      	ldr	r0, [pc, #36]	; (c0d01468 <reset+0x30>)
c0d01444:	6801      	ldr	r1, [r0, #0]
c0d01446:	9101      	str	r1, [sp, #4]
c0d01448:	4669      	mov	r1, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0144a:	4608      	mov	r0, r1
                              asm volatile("svc #1");
c0d0144c:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d0144e:	4601      	mov	r1, r0
                                if (parameters[0] != SYSCALL_reset_ID_OUT)
c0d01450:	4906      	ldr	r1, [pc, #24]	; (c0d0146c <reset+0x34>)
c0d01452:	9a00      	ldr	r2, [sp, #0]
c0d01454:	428a      	cmp	r2, r1
c0d01456:	d101      	bne.n	c0d0145c <reset+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01458:	b002      	add	sp, #8
c0d0145a:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_reset_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d0145c:	6800      	ldr	r0, [r0, #0]
c0d0145e:	2104      	movs	r1, #4
c0d01460:	f001 f926 	bl	c0d026b0 <longjmp>
c0d01464:	60000200 	.word	0x60000200
c0d01468:	200019a8 	.word	0x200019a8
c0d0146c:	900002f1 	.word	0x900002f1

c0d01470 <cx_rng>:
  }
  return (unsigned char)ret;
}

unsigned char * cx_rng ( unsigned char * buffer, unsigned int len ) 
{
c0d01470:	b580      	push	{r7, lr}
c0d01472:	af00      	add	r7, sp, #0
c0d01474:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_cx_rng_ID_IN;
c0d01476:	4a0a      	ldr	r2, [pc, #40]	; (c0d014a0 <cx_rng+0x30>)
c0d01478:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0147a:	4a0a      	ldr	r2, [pc, #40]	; (c0d014a4 <cx_rng+0x34>)
c0d0147c:	6813      	ldr	r3, [r2, #0]
c0d0147e:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)buffer;
c0d01480:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)len;
c0d01482:	9103      	str	r1, [sp, #12]
c0d01484:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01486:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01488:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d0148a:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_rng_ID_OUT)
c0d0148c:	4906      	ldr	r1, [pc, #24]	; (c0d014a8 <cx_rng+0x38>)
c0d0148e:	9b00      	ldr	r3, [sp, #0]
c0d01490:	428b      	cmp	r3, r1
c0d01492:	d101      	bne.n	c0d01498 <cx_rng+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned char *)ret;
c0d01494:	b004      	add	sp, #16
c0d01496:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_rng_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01498:	6810      	ldr	r0, [r2, #0]
c0d0149a:	2104      	movs	r1, #4
c0d0149c:	f001 f908 	bl	c0d026b0 <longjmp>
c0d014a0:	6000052c 	.word	0x6000052c
c0d014a4:	200019a8 	.word	0x200019a8
c0d014a8:	90000567 	.word	0x90000567

c0d014ac <cx_ripemd160_init>:
  }
  return (unsigned char *)ret;
}

int cx_ripemd160_init ( cx_ripemd160_t * hash ) 
{
c0d014ac:	b580      	push	{r7, lr}
c0d014ae:	af00      	add	r7, sp, #0
c0d014b0:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_cx_ripemd160_init_ID_IN;
c0d014b2:	490a      	ldr	r1, [pc, #40]	; (c0d014dc <cx_ripemd160_init+0x30>)
c0d014b4:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d014b6:	490a      	ldr	r1, [pc, #40]	; (c0d014e0 <cx_ripemd160_init+0x34>)
c0d014b8:	680a      	ldr	r2, [r1, #0]
c0d014ba:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)hash;
c0d014bc:	9003      	str	r0, [sp, #12]
c0d014be:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d014c0:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d014c2:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d014c4:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ripemd160_init_ID_OUT)
c0d014c6:	4a07      	ldr	r2, [pc, #28]	; (c0d014e4 <cx_ripemd160_init+0x38>)
c0d014c8:	9b01      	ldr	r3, [sp, #4]
c0d014ca:	4293      	cmp	r3, r2
c0d014cc:	d101      	bne.n	c0d014d2 <cx_ripemd160_init+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d014ce:	b004      	add	sp, #16
c0d014d0:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ripemd160_init_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d014d2:	6808      	ldr	r0, [r1, #0]
c0d014d4:	2104      	movs	r1, #4
c0d014d6:	f001 f8eb 	bl	c0d026b0 <longjmp>
c0d014da:	46c0      	nop			; (mov r8, r8)
c0d014dc:	6000067f 	.word	0x6000067f
c0d014e0:	200019a8 	.word	0x200019a8
c0d014e4:	900006f8 	.word	0x900006f8

c0d014e8 <cx_sha256_init>:
  }
  return (int)ret;
}

int cx_sha256_init ( cx_sha256_t * hash ) 
{
c0d014e8:	b580      	push	{r7, lr}
c0d014ea:	af00      	add	r7, sp, #0
c0d014ec:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_cx_sha256_init_ID_IN;
c0d014ee:	490a      	ldr	r1, [pc, #40]	; (c0d01518 <cx_sha256_init+0x30>)
c0d014f0:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d014f2:	490a      	ldr	r1, [pc, #40]	; (c0d0151c <cx_sha256_init+0x34>)
c0d014f4:	680a      	ldr	r2, [r1, #0]
c0d014f6:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)hash;
c0d014f8:	9003      	str	r0, [sp, #12]
c0d014fa:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d014fc:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d014fe:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01500:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_sha256_init_ID_OUT)
c0d01502:	4a07      	ldr	r2, [pc, #28]	; (c0d01520 <cx_sha256_init+0x38>)
c0d01504:	9b01      	ldr	r3, [sp, #4]
c0d01506:	4293      	cmp	r3, r2
c0d01508:	d101      	bne.n	c0d0150e <cx_sha256_init+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d0150a:	b004      	add	sp, #16
c0d0150c:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_sha256_init_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d0150e:	6808      	ldr	r0, [r1, #0]
c0d01510:	2104      	movs	r1, #4
c0d01512:	f001 f8cd 	bl	c0d026b0 <longjmp>
c0d01516:	46c0      	nop			; (mov r8, r8)
c0d01518:	600008db 	.word	0x600008db
c0d0151c:	200019a8 	.word	0x200019a8
c0d01520:	90000864 	.word	0x90000864

c0d01524 <cx_hash>:
  }
  return (int)ret;
}

int cx_hash ( cx_hash_t * hash, int mode, unsigned char * in, unsigned int len, unsigned char * out ) 
{
c0d01524:	b5b0      	push	{r4, r5, r7, lr}
c0d01526:	af02      	add	r7, sp, #8
c0d01528:	b088      	sub	sp, #32
  unsigned int ret;
  unsigned int parameters [2+5];
  parameters[0] = (unsigned int)SYSCALL_cx_hash_ID_IN;
c0d0152a:	4c0b      	ldr	r4, [pc, #44]	; (c0d01558 <cx_hash+0x34>)
c0d0152c:	9401      	str	r4, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0152e:	4c0b      	ldr	r4, [pc, #44]	; (c0d0155c <cx_hash+0x38>)
c0d01530:	6825      	ldr	r5, [r4, #0]
c0d01532:	9502      	str	r5, [sp, #8]
  parameters[2] = (unsigned int)hash;
c0d01534:	ad03      	add	r5, sp, #12
c0d01536:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d01538:	980c      	ldr	r0, [sp, #48]	; 0x30
  parameters[3] = (unsigned int)mode;
  parameters[4] = (unsigned int)in;
  parameters[5] = (unsigned int)len;
  parameters[6] = (unsigned int)out;
c0d0153a:	9007      	str	r0, [sp, #28]
c0d0153c:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0153e:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01540:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01542:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_hash_ID_OUT)
c0d01544:	4906      	ldr	r1, [pc, #24]	; (c0d01560 <cx_hash+0x3c>)
c0d01546:	9a01      	ldr	r2, [sp, #4]
c0d01548:	428a      	cmp	r2, r1
c0d0154a:	d101      	bne.n	c0d01550 <cx_hash+0x2c>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d0154c:	b008      	add	sp, #32
c0d0154e:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_hash_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01550:	6820      	ldr	r0, [r4, #0]
c0d01552:	2104      	movs	r1, #4
c0d01554:	f001 f8ac 	bl	c0d026b0 <longjmp>
c0d01558:	60000ea6 	.word	0x60000ea6
c0d0155c:	200019a8 	.word	0x200019a8
c0d01560:	90000e46 	.word	0x90000e46

c0d01564 <cx_ecfp_init_private_key>:
  }
  return (int)ret;
}

int cx_ecfp_init_private_key ( cx_curve_t curve, unsigned char * rawkey, unsigned int key_len, cx_ecfp_private_key_t * key ) 
{
c0d01564:	b5b0      	push	{r4, r5, r7, lr}
c0d01566:	af02      	add	r7, sp, #8
c0d01568:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_init_private_key_ID_IN;
c0d0156a:	4c0a      	ldr	r4, [pc, #40]	; (c0d01594 <cx_ecfp_init_private_key+0x30>)
c0d0156c:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0156e:	4c0a      	ldr	r4, [pc, #40]	; (c0d01598 <cx_ecfp_init_private_key+0x34>)
c0d01570:	6825      	ldr	r5, [r4, #0]
c0d01572:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d01574:	ad02      	add	r5, sp, #8
c0d01576:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d01578:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)rawkey;
  parameters[4] = (unsigned int)key_len;
  parameters[5] = (unsigned int)key;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0157a:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d0157c:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d0157e:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_init_private_key_ID_OUT)
c0d01580:	4906      	ldr	r1, [pc, #24]	; (c0d0159c <cx_ecfp_init_private_key+0x38>)
c0d01582:	9a00      	ldr	r2, [sp, #0]
c0d01584:	428a      	cmp	r2, r1
c0d01586:	d101      	bne.n	c0d0158c <cx_ecfp_init_private_key+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d01588:	b006      	add	sp, #24
c0d0158a:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_init_private_key_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d0158c:	6820      	ldr	r0, [r4, #0]
c0d0158e:	2104      	movs	r1, #4
c0d01590:	f001 f88e 	bl	c0d026b0 <longjmp>
c0d01594:	600029ed 	.word	0x600029ed
c0d01598:	200019a8 	.word	0x200019a8
c0d0159c:	900029ae 	.word	0x900029ae

c0d015a0 <cx_ecfp_generate_pair>:
  }
  return (int)ret;
}

int cx_ecfp_generate_pair ( cx_curve_t curve, cx_ecfp_public_key_t * pubkey, cx_ecfp_private_key_t * privkey, int keepprivate ) 
{
c0d015a0:	b5b0      	push	{r4, r5, r7, lr}
c0d015a2:	af02      	add	r7, sp, #8
c0d015a4:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+4];
  parameters[0] = (unsigned int)SYSCALL_cx_ecfp_generate_pair_ID_IN;
c0d015a6:	4c0a      	ldr	r4, [pc, #40]	; (c0d015d0 <cx_ecfp_generate_pair+0x30>)
c0d015a8:	9400      	str	r4, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d015aa:	4c0a      	ldr	r4, [pc, #40]	; (c0d015d4 <cx_ecfp_generate_pair+0x34>)
c0d015ac:	6825      	ldr	r5, [r4, #0]
c0d015ae:	9501      	str	r5, [sp, #4]
  parameters[2] = (unsigned int)curve;
c0d015b0:	ad02      	add	r5, sp, #8
c0d015b2:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d015b4:	4668      	mov	r0, sp
  parameters[3] = (unsigned int)pubkey;
  parameters[4] = (unsigned int)privkey;
  parameters[5] = (unsigned int)keepprivate;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d015b6:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d015b8:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d015ba:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_cx_ecfp_generate_pair_ID_OUT)
c0d015bc:	4906      	ldr	r1, [pc, #24]	; (c0d015d8 <cx_ecfp_generate_pair+0x38>)
c0d015be:	9a00      	ldr	r2, [sp, #0]
c0d015c0:	428a      	cmp	r2, r1
c0d015c2:	d101      	bne.n	c0d015c8 <cx_ecfp_generate_pair+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (int)ret;
c0d015c4:	b006      	add	sp, #24
c0d015c6:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_cx_ecfp_generate_pair_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d015c8:	6820      	ldr	r0, [r4, #0]
c0d015ca:	2104      	movs	r1, #4
c0d015cc:	f001 f870 	bl	c0d026b0 <longjmp>
c0d015d0:	60002a2e 	.word	0x60002a2e
c0d015d4:	200019a8 	.word	0x200019a8
c0d015d8:	90002a74 	.word	0x90002a74

c0d015dc <os_perso_derive_node_bip32>:
  }
  return (unsigned int)ret;
}

void os_perso_derive_node_bip32 ( cx_curve_t curve, unsigned int * path, unsigned int pathLength, unsigned char * privateKey, unsigned char * chain ) 
{
c0d015dc:	b5b0      	push	{r4, r5, r7, lr}
c0d015de:	af02      	add	r7, sp, #8
c0d015e0:	b088      	sub	sp, #32
  unsigned int ret;
  unsigned int parameters [2+5];
  parameters[0] = (unsigned int)SYSCALL_os_perso_derive_node_bip32_ID_IN;
c0d015e2:	4c0b      	ldr	r4, [pc, #44]	; (c0d01610 <os_perso_derive_node_bip32+0x34>)
c0d015e4:	9401      	str	r4, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d015e6:	4c0b      	ldr	r4, [pc, #44]	; (c0d01614 <os_perso_derive_node_bip32+0x38>)
c0d015e8:	6825      	ldr	r5, [r4, #0]
c0d015ea:	9502      	str	r5, [sp, #8]
  parameters[2] = (unsigned int)curve;
c0d015ec:	ad03      	add	r5, sp, #12
c0d015ee:	c50f      	stmia	r5!, {r0, r1, r2, r3}
c0d015f0:	980c      	ldr	r0, [sp, #48]	; 0x30
  parameters[3] = (unsigned int)path;
  parameters[4] = (unsigned int)pathLength;
  parameters[5] = (unsigned int)privateKey;
  parameters[6] = (unsigned int)chain;
c0d015f2:	9007      	str	r0, [sp, #28]
c0d015f4:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d015f6:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d015f8:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d015fa:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_perso_derive_node_bip32_ID_OUT)
c0d015fc:	4806      	ldr	r0, [pc, #24]	; (c0d01618 <os_perso_derive_node_bip32+0x3c>)
c0d015fe:	9901      	ldr	r1, [sp, #4]
c0d01600:	4281      	cmp	r1, r0
c0d01602:	d101      	bne.n	c0d01608 <os_perso_derive_node_bip32+0x2c>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01604:	b008      	add	sp, #32
c0d01606:	bdb0      	pop	{r4, r5, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_perso_derive_node_bip32_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01608:	6820      	ldr	r0, [r4, #0]
c0d0160a:	2104      	movs	r1, #4
c0d0160c:	f001 f850 	bl	c0d026b0 <longjmp>
c0d01610:	6000512b 	.word	0x6000512b
c0d01614:	200019a8 	.word	0x200019a8
c0d01618:	9000517f 	.word	0x9000517f

c0d0161c <os_global_pin_is_validated>:
  }
  return (unsigned int)ret;
}

unsigned int os_global_pin_is_validated ( void ) 
{
c0d0161c:	b580      	push	{r7, lr}
c0d0161e:	af00      	add	r7, sp, #0
c0d01620:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_os_global_pin_is_validated_ID_IN;
c0d01622:	4809      	ldr	r0, [pc, #36]	; (c0d01648 <os_global_pin_is_validated+0x2c>)
c0d01624:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01626:	4909      	ldr	r1, [pc, #36]	; (c0d0164c <os_global_pin_is_validated+0x30>)
c0d01628:	6808      	ldr	r0, [r1, #0]
c0d0162a:	9001      	str	r0, [sp, #4]
c0d0162c:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0162e:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01630:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01632:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_global_pin_is_validated_ID_OUT)
c0d01634:	4a06      	ldr	r2, [pc, #24]	; (c0d01650 <os_global_pin_is_validated+0x34>)
c0d01636:	9b00      	ldr	r3, [sp, #0]
c0d01638:	4293      	cmp	r3, r2
c0d0163a:	d101      	bne.n	c0d01640 <os_global_pin_is_validated+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d0163c:	b002      	add	sp, #8
c0d0163e:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_global_pin_is_validated_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01640:	6808      	ldr	r0, [r1, #0]
c0d01642:	2104      	movs	r1, #4
c0d01644:	f001 f834 	bl	c0d026b0 <longjmp>
c0d01648:	60005889 	.word	0x60005889
c0d0164c:	200019a8 	.word	0x200019a8
c0d01650:	90005845 	.word	0x90005845

c0d01654 <os_global_pin_invalidate>:
  }
  return (unsigned int)ret;
}

void os_global_pin_invalidate ( void ) 
{
c0d01654:	b580      	push	{r7, lr}
c0d01656:	af00      	add	r7, sp, #0
c0d01658:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_os_global_pin_invalidate_ID_IN;
c0d0165a:	4809      	ldr	r0, [pc, #36]	; (c0d01680 <os_global_pin_invalidate+0x2c>)
c0d0165c:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0165e:	4809      	ldr	r0, [pc, #36]	; (c0d01684 <os_global_pin_invalidate+0x30>)
c0d01660:	6801      	ldr	r1, [r0, #0]
c0d01662:	9101      	str	r1, [sp, #4]
c0d01664:	4669      	mov	r1, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01666:	4608      	mov	r0, r1
                              asm volatile("svc #1");
c0d01668:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d0166a:	4601      	mov	r1, r0
                                if (parameters[0] != SYSCALL_os_global_pin_invalidate_ID_OUT)
c0d0166c:	4906      	ldr	r1, [pc, #24]	; (c0d01688 <os_global_pin_invalidate+0x34>)
c0d0166e:	9a00      	ldr	r2, [sp, #0]
c0d01670:	428a      	cmp	r2, r1
c0d01672:	d101      	bne.n	c0d01678 <os_global_pin_invalidate+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01674:	b002      	add	sp, #8
c0d01676:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_global_pin_invalidate_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01678:	6800      	ldr	r0, [r0, #0]
c0d0167a:	2104      	movs	r1, #4
c0d0167c:	f001 f818 	bl	c0d026b0 <longjmp>
c0d01680:	60005ad0 	.word	0x60005ad0
c0d01684:	200019a8 	.word	0x200019a8
c0d01688:	90005afb 	.word	0x90005afb

c0d0168c <os_sched_exit>:
  }
  return (unsigned int)ret;
}

void os_sched_exit ( unsigned int exit_code ) 
{
c0d0168c:	b580      	push	{r7, lr}
c0d0168e:	af00      	add	r7, sp, #0
c0d01690:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_os_sched_exit_ID_IN;
c0d01692:	490a      	ldr	r1, [pc, #40]	; (c0d016bc <os_sched_exit+0x30>)
c0d01694:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01696:	490a      	ldr	r1, [pc, #40]	; (c0d016c0 <os_sched_exit+0x34>)
c0d01698:	680a      	ldr	r2, [r1, #0]
c0d0169a:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)exit_code;
c0d0169c:	9003      	str	r0, [sp, #12]
c0d0169e:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d016a0:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d016a2:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d016a4:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_sched_exit_ID_OUT)
c0d016a6:	4807      	ldr	r0, [pc, #28]	; (c0d016c4 <os_sched_exit+0x38>)
c0d016a8:	9a01      	ldr	r2, [sp, #4]
c0d016aa:	4282      	cmp	r2, r0
c0d016ac:	d101      	bne.n	c0d016b2 <os_sched_exit+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d016ae:	b004      	add	sp, #16
c0d016b0:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_sched_exit_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d016b2:	6808      	ldr	r0, [r1, #0]
c0d016b4:	2104      	movs	r1, #4
c0d016b6:	f000 fffb 	bl	c0d026b0 <longjmp>
c0d016ba:	46c0      	nop			; (mov r8, r8)
c0d016bc:	60005fe1 	.word	0x60005fe1
c0d016c0:	200019a8 	.word	0x200019a8
c0d016c4:	90005f6f 	.word	0x90005f6f

c0d016c8 <os_ux>:
    THROW(EXCEPTION_SECURITY);
  }
}

unsigned int os_ux ( bolos_ux_params_t * params ) 
{
c0d016c8:	b580      	push	{r7, lr}
c0d016ca:	af00      	add	r7, sp, #0
c0d016cc:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+1];
  parameters[0] = (unsigned int)SYSCALL_os_ux_ID_IN;
c0d016ce:	490a      	ldr	r1, [pc, #40]	; (c0d016f8 <os_ux+0x30>)
c0d016d0:	9101      	str	r1, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d016d2:	490a      	ldr	r1, [pc, #40]	; (c0d016fc <os_ux+0x34>)
c0d016d4:	680a      	ldr	r2, [r1, #0]
c0d016d6:	9202      	str	r2, [sp, #8]
  parameters[2] = (unsigned int)params;
c0d016d8:	9003      	str	r0, [sp, #12]
c0d016da:	a801      	add	r0, sp, #4

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d016dc:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d016de:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d016e0:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_os_ux_ID_OUT)
c0d016e2:	4a07      	ldr	r2, [pc, #28]	; (c0d01700 <os_ux+0x38>)
c0d016e4:	9b01      	ldr	r3, [sp, #4]
c0d016e6:	4293      	cmp	r3, r2
c0d016e8:	d101      	bne.n	c0d016ee <os_ux+0x26>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d016ea:	b004      	add	sp, #16
c0d016ec:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_os_ux_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d016ee:	6808      	ldr	r0, [r1, #0]
c0d016f0:	2104      	movs	r1, #4
c0d016f2:	f000 ffdd 	bl	c0d026b0 <longjmp>
c0d016f6:	46c0      	nop			; (mov r8, r8)
c0d016f8:	60006158 	.word	0x60006158
c0d016fc:	200019a8 	.word	0x200019a8
c0d01700:	9000611f 	.word	0x9000611f

c0d01704 <io_seproxyhal_spi_send>:
  }
  return (unsigned int)ret;
}

void io_seproxyhal_spi_send ( const unsigned char * buffer, unsigned short length ) 
{
c0d01704:	b580      	push	{r7, lr}
c0d01706:	af00      	add	r7, sp, #0
c0d01708:	b084      	sub	sp, #16
  unsigned int ret;
  unsigned int parameters [2+2];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_send_ID_IN;
c0d0170a:	4a0a      	ldr	r2, [pc, #40]	; (c0d01734 <io_seproxyhal_spi_send+0x30>)
c0d0170c:	9200      	str	r2, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0170e:	4a0a      	ldr	r2, [pc, #40]	; (c0d01738 <io_seproxyhal_spi_send+0x34>)
c0d01710:	6813      	ldr	r3, [r2, #0]
c0d01712:	9301      	str	r3, [sp, #4]
  parameters[2] = (unsigned int)buffer;
c0d01714:	9002      	str	r0, [sp, #8]
  parameters[3] = (unsigned int)length;
c0d01716:	9103      	str	r1, [sp, #12]
c0d01718:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0171a:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d0171c:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d0171e:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_send_ID_OUT)
c0d01720:	4806      	ldr	r0, [pc, #24]	; (c0d0173c <io_seproxyhal_spi_send+0x38>)
c0d01722:	9900      	ldr	r1, [sp, #0]
c0d01724:	4281      	cmp	r1, r0
c0d01726:	d101      	bne.n	c0d0172c <io_seproxyhal_spi_send+0x28>
  {
    THROW(EXCEPTION_SECURITY);
  }
}
c0d01728:	b004      	add	sp, #16
c0d0172a:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_send_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d0172c:	6810      	ldr	r0, [r2, #0]
c0d0172e:	2104      	movs	r1, #4
c0d01730:	f000 ffbe 	bl	c0d026b0 <longjmp>
c0d01734:	60006a1c 	.word	0x60006a1c
c0d01738:	200019a8 	.word	0x200019a8
c0d0173c:	90006af3 	.word	0x90006af3

c0d01740 <io_seproxyhal_spi_is_status_sent>:
  }
}

unsigned int io_seproxyhal_spi_is_status_sent ( void ) 
{
c0d01740:	b580      	push	{r7, lr}
c0d01742:	af00      	add	r7, sp, #0
c0d01744:	b082      	sub	sp, #8
  unsigned int ret;
  unsigned int parameters [2];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_is_status_sent_ID_IN;
c0d01746:	4809      	ldr	r0, [pc, #36]	; (c0d0176c <io_seproxyhal_spi_is_status_sent+0x2c>)
c0d01748:	9000      	str	r0, [sp, #0]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d0174a:	4909      	ldr	r1, [pc, #36]	; (c0d01770 <io_seproxyhal_spi_is_status_sent+0x30>)
c0d0174c:	6808      	ldr	r0, [r1, #0]
c0d0174e:	9001      	str	r0, [sp, #4]
c0d01750:	4668      	mov	r0, sp

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d01752:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01754:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01756:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_is_status_sent_ID_OUT)
c0d01758:	4a06      	ldr	r2, [pc, #24]	; (c0d01774 <io_seproxyhal_spi_is_status_sent+0x34>)
c0d0175a:	9b00      	ldr	r3, [sp, #0]
c0d0175c:	4293      	cmp	r3, r2
c0d0175e:	d101      	bne.n	c0d01764 <io_seproxyhal_spi_is_status_sent+0x24>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned int)ret;
c0d01760:	b002      	add	sp, #8
c0d01762:	bd80      	pop	{r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_is_status_sent_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d01764:	6808      	ldr	r0, [r1, #0]
c0d01766:	2104      	movs	r1, #4
c0d01768:	f000 ffa2 	bl	c0d026b0 <longjmp>
c0d0176c:	60006bcf 	.word	0x60006bcf
c0d01770:	200019a8 	.word	0x200019a8
c0d01774:	90006b7f 	.word	0x90006b7f

c0d01778 <io_seproxyhal_spi_recv>:
  }
  return (unsigned int)ret;
}

unsigned short io_seproxyhal_spi_recv ( unsigned char * buffer, unsigned short maxlength, unsigned int flags ) 
{
c0d01778:	b5d0      	push	{r4, r6, r7, lr}
c0d0177a:	af02      	add	r7, sp, #8
c0d0177c:	b086      	sub	sp, #24
  unsigned int ret;
  unsigned int parameters [2+3];
  parameters[0] = (unsigned int)SYSCALL_io_seproxyhal_spi_recv_ID_IN;
c0d0177e:	4b0b      	ldr	r3, [pc, #44]	; (c0d017ac <io_seproxyhal_spi_recv+0x34>)
c0d01780:	9301      	str	r3, [sp, #4]
  parameters[1] = (unsigned int)G_try_last_open_context->jmp_buf;
c0d01782:	4b0b      	ldr	r3, [pc, #44]	; (c0d017b0 <io_seproxyhal_spi_recv+0x38>)
c0d01784:	681c      	ldr	r4, [r3, #0]
c0d01786:	9402      	str	r4, [sp, #8]
  parameters[2] = (unsigned int)buffer;
c0d01788:	ac03      	add	r4, sp, #12
c0d0178a:	c407      	stmia	r4!, {r0, r1, r2}
c0d0178c:	a801      	add	r0, sp, #4
  parameters[3] = (unsigned int)maxlength;
  parameters[4] = (unsigned int)flags;

                              asm volatile("mov r0, %0"::"r"(parameters));
c0d0178e:	4600      	mov	r0, r0
                              asm volatile("svc #1");
c0d01790:	df01      	svc	1
                              asm volatile("mov %0, r0":"=r"(ret));
c0d01792:	4600      	mov	r0, r0
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_recv_ID_OUT)
c0d01794:	4907      	ldr	r1, [pc, #28]	; (c0d017b4 <io_seproxyhal_spi_recv+0x3c>)
c0d01796:	9a01      	ldr	r2, [sp, #4]
c0d01798:	428a      	cmp	r2, r1
c0d0179a:	d102      	bne.n	c0d017a2 <io_seproxyhal_spi_recv+0x2a>
  {
    THROW(EXCEPTION_SECURITY);
  }
  return (unsigned short)ret;
c0d0179c:	b280      	uxth	r0, r0
c0d0179e:	b006      	add	sp, #24
c0d017a0:	bdd0      	pop	{r4, r6, r7, pc}
                              asm volatile("mov r0, %0"::"r"(parameters));
                              asm volatile("svc #1");
                              asm volatile("mov %0, r0":"=r"(ret));
                                if (parameters[0] != SYSCALL_io_seproxyhal_spi_recv_ID_OUT)
  {
    THROW(EXCEPTION_SECURITY);
c0d017a2:	6818      	ldr	r0, [r3, #0]
c0d017a4:	2104      	movs	r1, #4
c0d017a6:	f000 ff83 	bl	c0d026b0 <longjmp>
c0d017aa:	46c0      	nop			; (mov r8, r8)
c0d017ac:	60006cd1 	.word	0x60006cd1
c0d017b0:	200019a8 	.word	0x200019a8
c0d017b4:	90006c2b 	.word	0x90006c2b

c0d017b8 <USBD_LL_Init>:
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Init (USBD_HandleTypeDef *pdev)
{ 
  UNUSED(pdev);
  ep_in_stall = 0;
c0d017b8:	4902      	ldr	r1, [pc, #8]	; (c0d017c4 <USBD_LL_Init+0xc>)
c0d017ba:	2000      	movs	r0, #0
c0d017bc:	6008      	str	r0, [r1, #0]
  ep_out_stall = 0;
c0d017be:	4902      	ldr	r1, [pc, #8]	; (c0d017c8 <USBD_LL_Init+0x10>)
c0d017c0:	6008      	str	r0, [r1, #0]
  return USBD_OK;
c0d017c2:	4770      	bx	lr
c0d017c4:	20001b1c 	.word	0x20001b1c
c0d017c8:	20001b20 	.word	0x20001b20

c0d017cc <USBD_LL_DeInit>:
  * @brief  De-Initializes the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_DeInit (USBD_HandleTypeDef *pdev)
{
c0d017cc:	b5d0      	push	{r4, r6, r7, lr}
c0d017ce:	af02      	add	r7, sp, #8
  UNUSED(pdev);
  // usb off
  G_io_seproxyhal_spi_buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d017d0:	4806      	ldr	r0, [pc, #24]	; (c0d017ec <USBD_LL_DeInit+0x20>)
c0d017d2:	214f      	movs	r1, #79	; 0x4f
c0d017d4:	7001      	strb	r1, [r0, #0]
c0d017d6:	2400      	movs	r4, #0
  G_io_seproxyhal_spi_buffer[1] = 0;
c0d017d8:	7044      	strb	r4, [r0, #1]
c0d017da:	2101      	movs	r1, #1
  G_io_seproxyhal_spi_buffer[2] = 1;
c0d017dc:	7081      	strb	r1, [r0, #2]
c0d017de:	2102      	movs	r1, #2
  G_io_seproxyhal_spi_buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d017e0:	70c1      	strb	r1, [r0, #3]
  io_seproxyhal_spi_send(G_io_seproxyhal_spi_buffer, 4);
c0d017e2:	2104      	movs	r1, #4
c0d017e4:	f7ff ff8e 	bl	c0d01704 <io_seproxyhal_spi_send>

  return USBD_OK; 
c0d017e8:	4620      	mov	r0, r4
c0d017ea:	bdd0      	pop	{r4, r6, r7, pc}
c0d017ec:	20001800 	.word	0x20001800

c0d017f0 <USBD_LL_Start>:
  * @brief  Starts the Low Level portion of the Device driver. 
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Start(USBD_HandleTypeDef *pdev)
{
c0d017f0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d017f2:	af03      	add	r7, sp, #12
c0d017f4:	b083      	sub	sp, #12
c0d017f6:	ad01      	add	r5, sp, #4
  uint8_t buffer[5];
  UNUSED(pdev);

  // reset address
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d017f8:	264f      	movs	r6, #79	; 0x4f
c0d017fa:	702e      	strb	r6, [r5, #0]
c0d017fc:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d017fe:	706c      	strb	r4, [r5, #1]
c0d01800:	2002      	movs	r0, #2
  buffer[2] = 2;
c0d01802:	70a8      	strb	r0, [r5, #2]
c0d01804:	2003      	movs	r0, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d01806:	70e8      	strb	r0, [r5, #3]
  buffer[4] = 0;
c0d01808:	712c      	strb	r4, [r5, #4]
  io_seproxyhal_spi_send(buffer, 5);
c0d0180a:	2105      	movs	r1, #5
c0d0180c:	4628      	mov	r0, r5
c0d0180e:	f7ff ff79 	bl	c0d01704 <io_seproxyhal_spi_send>
  
  // start usb operation
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d01812:	702e      	strb	r6, [r5, #0]
  buffer[1] = 0;
c0d01814:	706c      	strb	r4, [r5, #1]
c0d01816:	2001      	movs	r0, #1
  buffer[2] = 1;
c0d01818:	70a8      	strb	r0, [r5, #2]
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_CONNECT;
c0d0181a:	70e8      	strb	r0, [r5, #3]
c0d0181c:	2104      	movs	r1, #4
  io_seproxyhal_spi_send(buffer, 4);
c0d0181e:	4628      	mov	r0, r5
c0d01820:	f7ff ff70 	bl	c0d01704 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d01824:	4620      	mov	r0, r4
c0d01826:	b003      	add	sp, #12
c0d01828:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0182a <USBD_LL_Stop>:
  * @brief  Stops the Low Level portion of the Device driver.
  * @param  pdev: Device handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_Stop (USBD_HandleTypeDef *pdev)
{
c0d0182a:	b5d0      	push	{r4, r6, r7, lr}
c0d0182c:	af02      	add	r7, sp, #8
c0d0182e:	b082      	sub	sp, #8
c0d01830:	a801      	add	r0, sp, #4
  UNUSED(pdev);
  uint8_t buffer[4];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d01832:	214f      	movs	r1, #79	; 0x4f
c0d01834:	7001      	strb	r1, [r0, #0]
c0d01836:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d01838:	7044      	strb	r4, [r0, #1]
c0d0183a:	2101      	movs	r1, #1
  buffer[2] = 1;
c0d0183c:	7081      	strb	r1, [r0, #2]
c0d0183e:	2102      	movs	r1, #2
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_DISCONNECT;
c0d01840:	70c1      	strb	r1, [r0, #3]
  io_seproxyhal_spi_send(buffer, 4);
c0d01842:	2104      	movs	r1, #4
c0d01844:	f7ff ff5e 	bl	c0d01704 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d01848:	4620      	mov	r0, r4
c0d0184a:	b002      	add	sp, #8
c0d0184c:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d01850 <USBD_LL_OpenEP>:
  */
USBD_StatusTypeDef  USBD_LL_OpenEP  (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  ep_type,
                                      uint16_t ep_mps)
{
c0d01850:	b5b0      	push	{r4, r5, r7, lr}
c0d01852:	af02      	add	r7, sp, #8
c0d01854:	b082      	sub	sp, #8
  uint8_t buffer[8];
  UNUSED(pdev);

  ep_in_stall = 0;
c0d01856:	480f      	ldr	r0, [pc, #60]	; (c0d01894 <USBD_LL_OpenEP+0x44>)
c0d01858:	2400      	movs	r4, #0
c0d0185a:	6004      	str	r4, [r0, #0]
  ep_out_stall = 0;
c0d0185c:	480e      	ldr	r0, [pc, #56]	; (c0d01898 <USBD_LL_OpenEP+0x48>)
c0d0185e:	6004      	str	r4, [r0, #0]
c0d01860:	4668      	mov	r0, sp

  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d01862:	254f      	movs	r5, #79	; 0x4f
c0d01864:	7005      	strb	r5, [r0, #0]
  buffer[1] = 0;
c0d01866:	7044      	strb	r4, [r0, #1]
c0d01868:	2505      	movs	r5, #5
  buffer[2] = 5;
c0d0186a:	7085      	strb	r5, [r0, #2]
c0d0186c:	2504      	movs	r5, #4
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d0186e:	70c5      	strb	r5, [r0, #3]
c0d01870:	2501      	movs	r5, #1
  buffer[4] = 1;
c0d01872:	7105      	strb	r5, [r0, #4]
  buffer[5] = ep_addr;
c0d01874:	7141      	strb	r1, [r0, #5]
  buffer[6] = 0;
  switch(ep_type) {
c0d01876:	2a03      	cmp	r2, #3
c0d01878:	d802      	bhi.n	c0d01880 <USBD_LL_OpenEP+0x30>
c0d0187a:	00d0      	lsls	r0, r2, #3
c0d0187c:	4c07      	ldr	r4, [pc, #28]	; (c0d0189c <USBD_LL_OpenEP+0x4c>)
c0d0187e:	40c4      	lsrs	r4, r0
c0d01880:	4668      	mov	r0, sp
  buffer[1] = 0;
  buffer[2] = 5;
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
  buffer[4] = 1;
  buffer[5] = ep_addr;
  buffer[6] = 0;
c0d01882:	7184      	strb	r4, [r0, #6]
      break;
    case USBD_EP_TYPE_INTR:
      buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_INTERRUPT;
      break;
  }
  buffer[7] = ep_mps;
c0d01884:	71c3      	strb	r3, [r0, #7]
  io_seproxyhal_spi_send(buffer, 8);
c0d01886:	2108      	movs	r1, #8
c0d01888:	f7ff ff3c 	bl	c0d01704 <io_seproxyhal_spi_send>
c0d0188c:	2000      	movs	r0, #0
  return USBD_OK; 
c0d0188e:	b002      	add	sp, #8
c0d01890:	bdb0      	pop	{r4, r5, r7, pc}
c0d01892:	46c0      	nop			; (mov r8, r8)
c0d01894:	20001b1c 	.word	0x20001b1c
c0d01898:	20001b20 	.word	0x20001b20
c0d0189c:	02030401 	.word	0x02030401

c0d018a0 <USBD_LL_CloseEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_CloseEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d018a0:	b5d0      	push	{r4, r6, r7, lr}
c0d018a2:	af02      	add	r7, sp, #8
c0d018a4:	b082      	sub	sp, #8
c0d018a6:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[8];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d018a8:	224f      	movs	r2, #79	; 0x4f
c0d018aa:	7002      	strb	r2, [r0, #0]
c0d018ac:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d018ae:	7044      	strb	r4, [r0, #1]
c0d018b0:	2205      	movs	r2, #5
  buffer[2] = 5;
c0d018b2:	7082      	strb	r2, [r0, #2]
c0d018b4:	2204      	movs	r2, #4
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ENDPOINTS;
c0d018b6:	70c2      	strb	r2, [r0, #3]
c0d018b8:	2201      	movs	r2, #1
  buffer[4] = 1;
c0d018ba:	7102      	strb	r2, [r0, #4]
  buffer[5] = ep_addr;
c0d018bc:	7141      	strb	r1, [r0, #5]
  buffer[6] = SEPROXYHAL_TAG_USB_CONFIG_TYPE_DISABLED;
c0d018be:	7184      	strb	r4, [r0, #6]
  buffer[7] = 0;
c0d018c0:	71c4      	strb	r4, [r0, #7]
  io_seproxyhal_spi_send(buffer, 8);
c0d018c2:	2108      	movs	r1, #8
c0d018c4:	f7ff ff1e 	bl	c0d01704 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d018c8:	4620      	mov	r0, r4
c0d018ca:	b002      	add	sp, #8
c0d018cc:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d018d0 <USBD_LL_StallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_StallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{ 
c0d018d0:	b5b0      	push	{r4, r5, r7, lr}
c0d018d2:	af02      	add	r7, sp, #8
c0d018d4:	b082      	sub	sp, #8
c0d018d6:	460d      	mov	r5, r1
c0d018d8:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d018da:	2150      	movs	r1, #80	; 0x50
c0d018dc:	7001      	strb	r1, [r0, #0]
c0d018de:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d018e0:	7044      	strb	r4, [r0, #1]
c0d018e2:	2103      	movs	r1, #3
  buffer[2] = 3;
c0d018e4:	7081      	strb	r1, [r0, #2]
  buffer[3] = ep_addr;
c0d018e6:	70c5      	strb	r5, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_STALL;
c0d018e8:	2140      	movs	r1, #64	; 0x40
c0d018ea:	7101      	strb	r1, [r0, #4]
  buffer[5] = 0;
c0d018ec:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d018ee:	2106      	movs	r1, #6
c0d018f0:	f7ff ff08 	bl	c0d01704 <io_seproxyhal_spi_send>
  if (ep_addr & 0x80) {
c0d018f4:	2080      	movs	r0, #128	; 0x80
c0d018f6:	4205      	tst	r5, r0
c0d018f8:	d101      	bne.n	c0d018fe <USBD_LL_StallEP+0x2e>
c0d018fa:	4807      	ldr	r0, [pc, #28]	; (c0d01918 <USBD_LL_StallEP+0x48>)
c0d018fc:	e000      	b.n	c0d01900 <USBD_LL_StallEP+0x30>
c0d018fe:	4805      	ldr	r0, [pc, #20]	; (c0d01914 <USBD_LL_StallEP+0x44>)
c0d01900:	6801      	ldr	r1, [r0, #0]
c0d01902:	227f      	movs	r2, #127	; 0x7f
c0d01904:	4015      	ands	r5, r2
c0d01906:	2201      	movs	r2, #1
c0d01908:	40aa      	lsls	r2, r5
c0d0190a:	430a      	orrs	r2, r1
c0d0190c:	6002      	str	r2, [r0, #0]
    ep_in_stall |= (1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall |= (1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d0190e:	4620      	mov	r0, r4
c0d01910:	b002      	add	sp, #8
c0d01912:	bdb0      	pop	{r4, r5, r7, pc}
c0d01914:	20001b1c 	.word	0x20001b1c
c0d01918:	20001b20 	.word	0x20001b20

c0d0191c <USBD_LL_ClearStallEP>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_ClearStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
c0d0191c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0191e:	af03      	add	r7, sp, #12
c0d01920:	b083      	sub	sp, #12
c0d01922:	460d      	mov	r5, r1
c0d01924:	a801      	add	r0, sp, #4
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d01926:	2150      	movs	r1, #80	; 0x50
c0d01928:	7001      	strb	r1, [r0, #0]
c0d0192a:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d0192c:	7044      	strb	r4, [r0, #1]
c0d0192e:	2103      	movs	r1, #3
  buffer[2] = 3;
c0d01930:	7081      	strb	r1, [r0, #2]
  buffer[3] = ep_addr;
c0d01932:	70c5      	strb	r5, [r0, #3]
c0d01934:	2680      	movs	r6, #128	; 0x80
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_UNSTALL;
c0d01936:	7106      	strb	r6, [r0, #4]
  buffer[5] = 0;
c0d01938:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d0193a:	2106      	movs	r1, #6
c0d0193c:	f7ff fee2 	bl	c0d01704 <io_seproxyhal_spi_send>
  if (ep_addr & 0x80) {
c0d01940:	4235      	tst	r5, r6
c0d01942:	d101      	bne.n	c0d01948 <USBD_LL_ClearStallEP+0x2c>
c0d01944:	4807      	ldr	r0, [pc, #28]	; (c0d01964 <USBD_LL_ClearStallEP+0x48>)
c0d01946:	e000      	b.n	c0d0194a <USBD_LL_ClearStallEP+0x2e>
c0d01948:	4805      	ldr	r0, [pc, #20]	; (c0d01960 <USBD_LL_ClearStallEP+0x44>)
c0d0194a:	6801      	ldr	r1, [r0, #0]
c0d0194c:	227f      	movs	r2, #127	; 0x7f
c0d0194e:	4015      	ands	r5, r2
c0d01950:	2201      	movs	r2, #1
c0d01952:	40aa      	lsls	r2, r5
c0d01954:	4391      	bics	r1, r2
c0d01956:	6001      	str	r1, [r0, #0]
    ep_in_stall &= ~(1<<(ep_addr&0x7F));
  }
  else {
    ep_out_stall &= ~(1<<(ep_addr&0x7F)); 
  }
  return USBD_OK; 
c0d01958:	4620      	mov	r0, r4
c0d0195a:	b003      	add	sp, #12
c0d0195c:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d0195e:	46c0      	nop			; (mov r8, r8)
c0d01960:	20001b1c 	.word	0x20001b1c
c0d01964:	20001b20 	.word	0x20001b20

c0d01968 <USBD_LL_IsStallEP>:
  * @retval Stall (1: Yes, 0: No)
  */
uint8_t USBD_LL_IsStallEP (USBD_HandleTypeDef *pdev, uint8_t ep_addr)   
{
  UNUSED(pdev);
  if((ep_addr & 0x80) == 0x80)
c0d01968:	2080      	movs	r0, #128	; 0x80
c0d0196a:	4201      	tst	r1, r0
c0d0196c:	d001      	beq.n	c0d01972 <USBD_LL_IsStallEP+0xa>
c0d0196e:	4806      	ldr	r0, [pc, #24]	; (c0d01988 <USBD_LL_IsStallEP+0x20>)
c0d01970:	e000      	b.n	c0d01974 <USBD_LL_IsStallEP+0xc>
c0d01972:	4804      	ldr	r0, [pc, #16]	; (c0d01984 <USBD_LL_IsStallEP+0x1c>)
c0d01974:	6800      	ldr	r0, [r0, #0]
c0d01976:	227f      	movs	r2, #127	; 0x7f
c0d01978:	4011      	ands	r1, r2
c0d0197a:	2201      	movs	r2, #1
c0d0197c:	408a      	lsls	r2, r1
c0d0197e:	4002      	ands	r2, r0
  }
  else
  {
    return ep_out_stall & (1<<(ep_addr&0x7F));
  }
}
c0d01980:	b2d0      	uxtb	r0, r2
c0d01982:	4770      	bx	lr
c0d01984:	20001b20 	.word	0x20001b20
c0d01988:	20001b1c 	.word	0x20001b1c

c0d0198c <USBD_LL_SetUSBAddress>:
  * @param  pdev: Device handle
  * @param  ep_addr: Endpoint Number
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_SetUSBAddress (USBD_HandleTypeDef *pdev, uint8_t dev_addr)   
{
c0d0198c:	b5d0      	push	{r4, r6, r7, lr}
c0d0198e:	af02      	add	r7, sp, #8
c0d01990:	b082      	sub	sp, #8
c0d01992:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[5];
  buffer[0] = SEPROXYHAL_TAG_USB_CONFIG;
c0d01994:	224f      	movs	r2, #79	; 0x4f
c0d01996:	7002      	strb	r2, [r0, #0]
c0d01998:	2400      	movs	r4, #0
  buffer[1] = 0;
c0d0199a:	7044      	strb	r4, [r0, #1]
c0d0199c:	2202      	movs	r2, #2
  buffer[2] = 2;
c0d0199e:	7082      	strb	r2, [r0, #2]
c0d019a0:	2203      	movs	r2, #3
  buffer[3] = SEPROXYHAL_TAG_USB_CONFIG_ADDR;
c0d019a2:	70c2      	strb	r2, [r0, #3]
  buffer[4] = dev_addr;
c0d019a4:	7101      	strb	r1, [r0, #4]
  io_seproxyhal_spi_send(buffer, 5);
c0d019a6:	2105      	movs	r1, #5
c0d019a8:	f7ff feac 	bl	c0d01704 <io_seproxyhal_spi_send>
  return USBD_OK; 
c0d019ac:	4620      	mov	r0, r4
c0d019ae:	b002      	add	sp, #8
c0d019b0:	bdd0      	pop	{r4, r6, r7, pc}

c0d019b2 <USBD_LL_Transmit>:
  */
USBD_StatusTypeDef  USBD_LL_Transmit (USBD_HandleTypeDef *pdev, 
                                      uint8_t  ep_addr,                                      
                                      uint8_t  *pbuf,
                                      uint16_t  size)
{
c0d019b2:	b5b0      	push	{r4, r5, r7, lr}
c0d019b4:	af02      	add	r7, sp, #8
c0d019b6:	b082      	sub	sp, #8
c0d019b8:	461c      	mov	r4, r3
c0d019ba:	4615      	mov	r5, r2
c0d019bc:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d019be:	2250      	movs	r2, #80	; 0x50
c0d019c0:	7002      	strb	r2, [r0, #0]
  buffer[1] = (3+size)>>8;
c0d019c2:	1ce2      	adds	r2, r4, #3
c0d019c4:	0a13      	lsrs	r3, r2, #8
c0d019c6:	7043      	strb	r3, [r0, #1]
  buffer[2] = (3+size);
c0d019c8:	7082      	strb	r2, [r0, #2]
  buffer[3] = ep_addr;
c0d019ca:	70c1      	strb	r1, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_IN;
c0d019cc:	2120      	movs	r1, #32
c0d019ce:	7101      	strb	r1, [r0, #4]
  buffer[5] = size;
c0d019d0:	7144      	strb	r4, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d019d2:	2106      	movs	r1, #6
c0d019d4:	f7ff fe96 	bl	c0d01704 <io_seproxyhal_spi_send>
  io_seproxyhal_spi_send(pbuf, size);
c0d019d8:	4628      	mov	r0, r5
c0d019da:	4621      	mov	r1, r4
c0d019dc:	f7ff fe92 	bl	c0d01704 <io_seproxyhal_spi_send>
c0d019e0:	2000      	movs	r0, #0
  return USBD_OK;   
c0d019e2:	b002      	add	sp, #8
c0d019e4:	bdb0      	pop	{r4, r5, r7, pc}

c0d019e6 <USBD_LL_PrepareReceive>:
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_LL_PrepareReceive(USBD_HandleTypeDef *pdev, 
                                           uint8_t  ep_addr,
                                           uint16_t  size)
{
c0d019e6:	b5d0      	push	{r4, r6, r7, lr}
c0d019e8:	af02      	add	r7, sp, #8
c0d019ea:	b082      	sub	sp, #8
c0d019ec:	4668      	mov	r0, sp
  UNUSED(pdev);
  uint8_t buffer[6];
  buffer[0] = SEPROXYHAL_TAG_USB_EP_PREPARE;
c0d019ee:	2350      	movs	r3, #80	; 0x50
c0d019f0:	7003      	strb	r3, [r0, #0]
c0d019f2:	2400      	movs	r4, #0
  buffer[1] = (3/*+size*/)>>8;
c0d019f4:	7044      	strb	r4, [r0, #1]
c0d019f6:	2303      	movs	r3, #3
  buffer[2] = (3/*+size*/);
c0d019f8:	7083      	strb	r3, [r0, #2]
  buffer[3] = ep_addr;
c0d019fa:	70c1      	strb	r1, [r0, #3]
  buffer[4] = SEPROXYHAL_TAG_USB_EP_PREPARE_DIR_OUT;
c0d019fc:	2130      	movs	r1, #48	; 0x30
c0d019fe:	7101      	strb	r1, [r0, #4]
  buffer[5] = size; // expected size, not transmitted here !
c0d01a00:	7142      	strb	r2, [r0, #5]
  io_seproxyhal_spi_send(buffer, 6);
c0d01a02:	2106      	movs	r1, #6
c0d01a04:	f7ff fe7e 	bl	c0d01704 <io_seproxyhal_spi_send>
  return USBD_OK;   
c0d01a08:	4620      	mov	r0, r4
c0d01a0a:	b002      	add	sp, #8
c0d01a0c:	bdd0      	pop	{r4, r6, r7, pc}

c0d01a0e <USBD_Init>:
* @param  pdesc: Descriptor structure address
* @param  id: Low level core index
* @retval None
*/
USBD_StatusTypeDef USBD_Init(USBD_HandleTypeDef *pdev, USBD_DescriptorsTypeDef *pdesc, uint8_t id)
{
c0d01a0e:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01a10:	af03      	add	r7, sp, #12
c0d01a12:	b081      	sub	sp, #4
c0d01a14:	4615      	mov	r5, r2
c0d01a16:	460e      	mov	r6, r1
c0d01a18:	4604      	mov	r4, r0
c0d01a1a:	2002      	movs	r0, #2
  /* Check whether the USB Host handle is valid */
  if(pdev == NULL)
c0d01a1c:	2c00      	cmp	r4, #0
c0d01a1e:	d011      	beq.n	c0d01a44 <USBD_Init+0x36>
  {
    USBD_ErrLog("Invalid Device handle");
    return USBD_FAIL; 
  }

  memset(pdev, 0, sizeof(USBD_HandleTypeDef));
c0d01a20:	2049      	movs	r0, #73	; 0x49
c0d01a22:	0081      	lsls	r1, r0, #2
c0d01a24:	4620      	mov	r0, r4
c0d01a26:	f000 fde3 	bl	c0d025f0 <__aeabi_memclr>
  
  /* Assign USBD Descriptors */
  if(pdesc != NULL)
c0d01a2a:	2e00      	cmp	r6, #0
c0d01a2c:	d002      	beq.n	c0d01a34 <USBD_Init+0x26>
  {
    pdev->pDesc = pdesc;
c0d01a2e:	2011      	movs	r0, #17
c0d01a30:	0100      	lsls	r0, r0, #4
c0d01a32:	5026      	str	r6, [r4, r0]
  }
  
  /* Set Device initial State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d01a34:	20fc      	movs	r0, #252	; 0xfc
c0d01a36:	2101      	movs	r1, #1
c0d01a38:	5421      	strb	r1, [r4, r0]
  pdev->id = id;
c0d01a3a:	7025      	strb	r5, [r4, #0]
  /* Initialize low level driver */
  USBD_LL_Init(pdev);
c0d01a3c:	4620      	mov	r0, r4
c0d01a3e:	f7ff febb 	bl	c0d017b8 <USBD_LL_Init>
c0d01a42:	2000      	movs	r0, #0
  
  return USBD_OK; 
}
c0d01a44:	b2c0      	uxtb	r0, r0
c0d01a46:	b001      	add	sp, #4
c0d01a48:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d01a4a <USBD_DeInit>:
*         Re-Initialize th device library
* @param  pdev: device instance
* @retval status: status
*/
USBD_StatusTypeDef USBD_DeInit(USBD_HandleTypeDef *pdev)
{
c0d01a4a:	b5d0      	push	{r4, r6, r7, lr}
c0d01a4c:	af02      	add	r7, sp, #8
c0d01a4e:	4604      	mov	r4, r0
  /* Set Default State */
  pdev->dev_state  = USBD_STATE_DEFAULT;
c0d01a50:	20fc      	movs	r0, #252	; 0xfc
c0d01a52:	2101      	movs	r1, #1
c0d01a54:	5421      	strb	r1, [r4, r0]
  
  /* Free Class Resources */
  if(pdev->pClass != NULL) {
c0d01a56:	2045      	movs	r0, #69	; 0x45
c0d01a58:	0080      	lsls	r0, r0, #2
c0d01a5a:	5820      	ldr	r0, [r4, r0]
c0d01a5c:	2800      	cmp	r0, #0
c0d01a5e:	d006      	beq.n	c0d01a6e <USBD_DeInit+0x24>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, pdev->dev_config);  
c0d01a60:	6840      	ldr	r0, [r0, #4]
c0d01a62:	f7ff fcb3 	bl	c0d013cc <pic>
c0d01a66:	4602      	mov	r2, r0
c0d01a68:	7921      	ldrb	r1, [r4, #4]
c0d01a6a:	4620      	mov	r0, r4
c0d01a6c:	4790      	blx	r2
  }
  
    /* Stop the low level driver  */
  USBD_LL_Stop(pdev); 
c0d01a6e:	4620      	mov	r0, r4
c0d01a70:	f7ff fedb 	bl	c0d0182a <USBD_LL_Stop>
  
  /* Initialize low level driver */
  USBD_LL_DeInit(pdev);
c0d01a74:	4620      	mov	r0, r4
c0d01a76:	f7ff fea9 	bl	c0d017cc <USBD_LL_DeInit>
  
  return USBD_OK;
c0d01a7a:	2000      	movs	r0, #0
c0d01a7c:	bdd0      	pop	{r4, r6, r7, pc}

c0d01a7e <USBD_RegisterClass>:
  * @param  pDevice : Device Handle
  * @param  pclass: Class handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_RegisterClass(USBD_HandleTypeDef *pdev, USBD_ClassTypeDef *pclass)
{
c0d01a7e:	2202      	movs	r2, #2
  USBD_StatusTypeDef   status = USBD_OK;
  if(pclass != 0)
c0d01a80:	2900      	cmp	r1, #0
c0d01a82:	d003      	beq.n	c0d01a8c <USBD_RegisterClass+0xe>
  {
    /* link the class to the USB Device handle */
    pdev->pClass = pclass;
c0d01a84:	2245      	movs	r2, #69	; 0x45
c0d01a86:	0092      	lsls	r2, r2, #2
c0d01a88:	5081      	str	r1, [r0, r2]
c0d01a8a:	2200      	movs	r2, #0
  {
    USBD_ErrLog("Invalid Class handle");
    status = USBD_FAIL; 
  }
  
  return status;
c0d01a8c:	b2d0      	uxtb	r0, r2
c0d01a8e:	4770      	bx	lr

c0d01a90 <USBD_Start>:
  *         Start the USB Device Core.
  * @param  pdev: Device Handle
  * @retval USBD Status
  */
USBD_StatusTypeDef  USBD_Start  (USBD_HandleTypeDef *pdev)
{
c0d01a90:	b580      	push	{r7, lr}
c0d01a92:	af00      	add	r7, sp, #0
  
  /* Start the low level driver  */
  USBD_LL_Start(pdev); 
c0d01a94:	f7ff feac 	bl	c0d017f0 <USBD_LL_Start>
  
  return USBD_OK;  
c0d01a98:	2000      	movs	r0, #0
c0d01a9a:	bd80      	pop	{r7, pc}

c0d01a9c <USBD_SetClassConfig>:
* @param  cfgidx: configuration index
* @retval status
*/

USBD_StatusTypeDef USBD_SetClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d01a9c:	b5b0      	push	{r4, r5, r7, lr}
c0d01a9e:	af02      	add	r7, sp, #8
c0d01aa0:	460c      	mov	r4, r1
c0d01aa2:	4605      	mov	r5, r0
  USBD_StatusTypeDef   ret = USBD_FAIL;
  
  if(pdev->pClass != NULL)
c0d01aa4:	2045      	movs	r0, #69	; 0x45
c0d01aa6:	0080      	lsls	r0, r0, #2
c0d01aa8:	5828      	ldr	r0, [r5, r0]
c0d01aaa:	2800      	cmp	r0, #0
c0d01aac:	d00c      	beq.n	c0d01ac8 <USBD_SetClassConfig+0x2c>
  {
    /* Set configuration  and Start the Class*/
    if(((Init_t)PIC(pdev->pClass->Init))(pdev, cfgidx) == 0)
c0d01aae:	6800      	ldr	r0, [r0, #0]
c0d01ab0:	f7ff fc8c 	bl	c0d013cc <pic>
c0d01ab4:	4602      	mov	r2, r0
c0d01ab6:	4628      	mov	r0, r5
c0d01ab8:	4621      	mov	r1, r4
c0d01aba:	4790      	blx	r2
c0d01abc:	4601      	mov	r1, r0
c0d01abe:	2002      	movs	r0, #2
c0d01ac0:	2900      	cmp	r1, #0
c0d01ac2:	d100      	bne.n	c0d01ac6 <USBD_SetClassConfig+0x2a>
c0d01ac4:	4608      	mov	r0, r1
c0d01ac6:	bdb0      	pop	{r4, r5, r7, pc}
    {
      ret = USBD_OK;
    }
  }
  return ret; 
c0d01ac8:	2002      	movs	r0, #2
c0d01aca:	bdb0      	pop	{r4, r5, r7, pc}

c0d01acc <USBD_ClrClassConfig>:
* @param  pdev: device instance
* @param  cfgidx: configuration index
* @retval status: USBD_StatusTypeDef
*/
USBD_StatusTypeDef USBD_ClrClassConfig(USBD_HandleTypeDef  *pdev, uint8_t cfgidx)
{
c0d01acc:	b5b0      	push	{r4, r5, r7, lr}
c0d01ace:	af02      	add	r7, sp, #8
c0d01ad0:	460c      	mov	r4, r1
c0d01ad2:	4605      	mov	r5, r0
  /* Clear configuration  and De-initialize the Class process*/
  if(pdev->pClass != NULL) {
c0d01ad4:	2045      	movs	r0, #69	; 0x45
c0d01ad6:	0080      	lsls	r0, r0, #2
c0d01ad8:	5828      	ldr	r0, [r5, r0]
c0d01ada:	2800      	cmp	r0, #0
c0d01adc:	d006      	beq.n	c0d01aec <USBD_ClrClassConfig+0x20>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, cfgidx);  
c0d01ade:	6840      	ldr	r0, [r0, #4]
c0d01ae0:	f7ff fc74 	bl	c0d013cc <pic>
c0d01ae4:	4602      	mov	r2, r0
c0d01ae6:	4628      	mov	r0, r5
c0d01ae8:	4621      	mov	r1, r4
c0d01aea:	4790      	blx	r2
  }
  return USBD_OK;
c0d01aec:	2000      	movs	r0, #0
c0d01aee:	bdb0      	pop	{r4, r5, r7, pc}

c0d01af0 <USBD_LL_SetupStage>:
*         Handle the setup stage
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetupStage(USBD_HandleTypeDef *pdev, uint8_t *psetup)
{
c0d01af0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01af2:	af03      	add	r7, sp, #12
c0d01af4:	b081      	sub	sp, #4
c0d01af6:	4604      	mov	r4, r0
c0d01af8:	2021      	movs	r0, #33	; 0x21
c0d01afa:	00c6      	lsls	r6, r0, #3
  USBD_ParseSetupRequest(&pdev->request, psetup);
c0d01afc:	19a5      	adds	r5, r4, r6
c0d01afe:	4628      	mov	r0, r5
c0d01b00:	f000 fb69 	bl	c0d021d6 <USBD_ParseSetupRequest>
  
  pdev->ep0_state = USBD_EP0_SETUP;
c0d01b04:	20f4      	movs	r0, #244	; 0xf4
c0d01b06:	2101      	movs	r1, #1
c0d01b08:	5021      	str	r1, [r4, r0]
  pdev->ep0_data_len = pdev->request.wLength;
c0d01b0a:	2087      	movs	r0, #135	; 0x87
c0d01b0c:	0040      	lsls	r0, r0, #1
c0d01b0e:	5a20      	ldrh	r0, [r4, r0]
c0d01b10:	21f8      	movs	r1, #248	; 0xf8
c0d01b12:	5060      	str	r0, [r4, r1]
  
  switch (pdev->request.bmRequest & 0x1F) 
c0d01b14:	5da1      	ldrb	r1, [r4, r6]
c0d01b16:	201f      	movs	r0, #31
c0d01b18:	4008      	ands	r0, r1
c0d01b1a:	2802      	cmp	r0, #2
c0d01b1c:	d008      	beq.n	c0d01b30 <USBD_LL_SetupStage+0x40>
c0d01b1e:	2801      	cmp	r0, #1
c0d01b20:	d00b      	beq.n	c0d01b3a <USBD_LL_SetupStage+0x4a>
c0d01b22:	2800      	cmp	r0, #0
c0d01b24:	d10e      	bne.n	c0d01b44 <USBD_LL_SetupStage+0x54>
  {
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
c0d01b26:	4620      	mov	r0, r4
c0d01b28:	4629      	mov	r1, r5
c0d01b2a:	f000 f8f1 	bl	c0d01d10 <USBD_StdDevReq>
c0d01b2e:	e00e      	b.n	c0d01b4e <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
c0d01b30:	4620      	mov	r0, r4
c0d01b32:	4629      	mov	r1, r5
c0d01b34:	f000 fad3 	bl	c0d020de <USBD_StdEPReq>
c0d01b38:	e009      	b.n	c0d01b4e <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_DEVICE:   
    USBD_StdDevReq (pdev, &pdev->request);
    break;
    
  case USB_REQ_RECIPIENT_INTERFACE:     
    USBD_StdItfReq(pdev, &pdev->request);
c0d01b3a:	4620      	mov	r0, r4
c0d01b3c:	4629      	mov	r1, r5
c0d01b3e:	f000 faa6 	bl	c0d0208e <USBD_StdItfReq>
c0d01b42:	e004      	b.n	c0d01b4e <USBD_LL_SetupStage+0x5e>
  case USB_REQ_RECIPIENT_ENDPOINT:        
    USBD_StdEPReq(pdev, &pdev->request);   
    break;
    
  default:           
    USBD_LL_StallEP(pdev , pdev->request.bmRequest & 0x80);
c0d01b44:	2080      	movs	r0, #128	; 0x80
c0d01b46:	4001      	ands	r1, r0
c0d01b48:	4620      	mov	r0, r4
c0d01b4a:	f7ff fec1 	bl	c0d018d0 <USBD_LL_StallEP>
    break;
  }  
  return USBD_OK;  
c0d01b4e:	2000      	movs	r0, #0
c0d01b50:	b001      	add	sp, #4
c0d01b52:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d01b54 <USBD_LL_DataOutStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataOutStage(USBD_HandleTypeDef *pdev , uint8_t epnum, uint8_t *pdata)
{
c0d01b54:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01b56:	af03      	add	r7, sp, #12
c0d01b58:	b081      	sub	sp, #4
c0d01b5a:	4615      	mov	r5, r2
c0d01b5c:	460e      	mov	r6, r1
c0d01b5e:	4604      	mov	r4, r0
  USBD_EndpointTypeDef    *pep;
  
  if(epnum == 0) 
c0d01b60:	2e00      	cmp	r6, #0
c0d01b62:	d011      	beq.n	c0d01b88 <USBD_LL_DataOutStage+0x34>
        }
        USBD_CtlSendStatus(pdev);
      }
    }
  }
  else if((pdev->pClass->DataOut != NULL)&&
c0d01b64:	2045      	movs	r0, #69	; 0x45
c0d01b66:	0080      	lsls	r0, r0, #2
c0d01b68:	5820      	ldr	r0, [r4, r0]
c0d01b6a:	6980      	ldr	r0, [r0, #24]
c0d01b6c:	2800      	cmp	r0, #0
c0d01b6e:	d034      	beq.n	c0d01bda <USBD_LL_DataOutStage+0x86>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d01b70:	21fc      	movs	r1, #252	; 0xfc
c0d01b72:	5c61      	ldrb	r1, [r4, r1]
        }
        USBD_CtlSendStatus(pdev);
      }
    }
  }
  else if((pdev->pClass->DataOut != NULL)&&
c0d01b74:	2903      	cmp	r1, #3
c0d01b76:	d130      	bne.n	c0d01bda <USBD_LL_DataOutStage+0x86>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataOut_t)PIC(pdev->pClass->DataOut))(pdev, epnum, pdata); 
c0d01b78:	f7ff fc28 	bl	c0d013cc <pic>
c0d01b7c:	4603      	mov	r3, r0
c0d01b7e:	4620      	mov	r0, r4
c0d01b80:	4631      	mov	r1, r6
c0d01b82:	462a      	mov	r2, r5
c0d01b84:	4798      	blx	r3
c0d01b86:	e028      	b.n	c0d01bda <USBD_LL_DataOutStage+0x86>
  
  if(epnum == 0) 
  {
    pep = &pdev->ep_out[0];
    
    if ( pdev->ep0_state == USBD_EP0_DATA_OUT)
c0d01b88:	20f4      	movs	r0, #244	; 0xf4
c0d01b8a:	5820      	ldr	r0, [r4, r0]
c0d01b8c:	2803      	cmp	r0, #3
c0d01b8e:	d124      	bne.n	c0d01bda <USBD_LL_DataOutStage+0x86>
    {
      if(pep->rem_length > pep->maxpacket)
c0d01b90:	2090      	movs	r0, #144	; 0x90
c0d01b92:	5820      	ldr	r0, [r4, r0]
c0d01b94:	218c      	movs	r1, #140	; 0x8c
c0d01b96:	5861      	ldr	r1, [r4, r1]
c0d01b98:	4622      	mov	r2, r4
c0d01b9a:	328c      	adds	r2, #140	; 0x8c
c0d01b9c:	4281      	cmp	r1, r0
c0d01b9e:	d90a      	bls.n	c0d01bb6 <USBD_LL_DataOutStage+0x62>
      {
        pep->rem_length -=  pep->maxpacket;
c0d01ba0:	1a09      	subs	r1, r1, r0
c0d01ba2:	6011      	str	r1, [r2, #0]
c0d01ba4:	4281      	cmp	r1, r0
c0d01ba6:	d300      	bcc.n	c0d01baa <USBD_LL_DataOutStage+0x56>
c0d01ba8:	4601      	mov	r1, r0
       
        USBD_CtlContinueRx (pdev, 
c0d01baa:	b28a      	uxth	r2, r1
c0d01bac:	4620      	mov	r0, r4
c0d01bae:	4629      	mov	r1, r5
c0d01bb0:	f000 fc70 	bl	c0d02494 <USBD_CtlContinueRx>
c0d01bb4:	e011      	b.n	c0d01bda <USBD_LL_DataOutStage+0x86>
                            pdata,
                            MIN(pep->rem_length ,pep->maxpacket));
      }
      else
      {
        if((pdev->pClass->EP0_RxReady != NULL)&&
c0d01bb6:	2045      	movs	r0, #69	; 0x45
c0d01bb8:	0080      	lsls	r0, r0, #2
c0d01bba:	5820      	ldr	r0, [r4, r0]
c0d01bbc:	6900      	ldr	r0, [r0, #16]
c0d01bbe:	2800      	cmp	r0, #0
c0d01bc0:	d008      	beq.n	c0d01bd4 <USBD_LL_DataOutStage+0x80>
           (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d01bc2:	21fc      	movs	r1, #252	; 0xfc
c0d01bc4:	5c61      	ldrb	r1, [r4, r1]
                            pdata,
                            MIN(pep->rem_length ,pep->maxpacket));
      }
      else
      {
        if((pdev->pClass->EP0_RxReady != NULL)&&
c0d01bc6:	2903      	cmp	r1, #3
c0d01bc8:	d104      	bne.n	c0d01bd4 <USBD_LL_DataOutStage+0x80>
           (pdev->dev_state == USBD_STATE_CONFIGURED))
        {
          ((EP0_RxReady_t)PIC(pdev->pClass->EP0_RxReady))(pdev); 
c0d01bca:	f7ff fbff 	bl	c0d013cc <pic>
c0d01bce:	4601      	mov	r1, r0
c0d01bd0:	4620      	mov	r0, r4
c0d01bd2:	4788      	blx	r1
        }
        USBD_CtlSendStatus(pdev);
c0d01bd4:	4620      	mov	r0, r4
c0d01bd6:	f000 fc65 	bl	c0d024a4 <USBD_CtlSendStatus>
  else if((pdev->pClass->DataOut != NULL)&&
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataOut_t)PIC(pdev->pClass->DataOut))(pdev, epnum, pdata); 
  }  
  return USBD_OK;
c0d01bda:	2000      	movs	r0, #0
c0d01bdc:	b001      	add	sp, #4
c0d01bde:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d01be0 <USBD_LL_DataInStage>:
* @param  pdev: device instance
* @param  epnum: endpoint index
* @retval status
*/
USBD_StatusTypeDef USBD_LL_DataInStage(USBD_HandleTypeDef *pdev ,uint8_t epnum, uint8_t *pdata)
{
c0d01be0:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01be2:	af03      	add	r7, sp, #12
c0d01be4:	b081      	sub	sp, #4
c0d01be6:	460d      	mov	r5, r1
c0d01be8:	4604      	mov	r4, r0
  USBD_EndpointTypeDef    *pep;
  UNUSED(pdata);
    
  if(epnum == 0) 
c0d01bea:	2d00      	cmp	r5, #0
c0d01bec:	d012      	beq.n	c0d01c14 <USBD_LL_DataInStage+0x34>
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
    }
  }
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
c0d01bee:	2045      	movs	r0, #69	; 0x45
c0d01bf0:	0080      	lsls	r0, r0, #2
c0d01bf2:	5820      	ldr	r0, [r4, r0]
c0d01bf4:	2800      	cmp	r0, #0
c0d01bf6:	d054      	beq.n	c0d01ca2 <USBD_LL_DataInStage+0xc2>
c0d01bf8:	6940      	ldr	r0, [r0, #20]
c0d01bfa:	2800      	cmp	r0, #0
c0d01bfc:	d051      	beq.n	c0d01ca2 <USBD_LL_DataInStage+0xc2>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d01bfe:	21fc      	movs	r1, #252	; 0xfc
c0d01c00:	5c61      	ldrb	r1, [r4, r1]
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
    }
  }
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
c0d01c02:	2903      	cmp	r1, #3
c0d01c04:	d14d      	bne.n	c0d01ca2 <USBD_LL_DataInStage+0xc2>
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataIn_t)PIC(pdev->pClass->DataIn))(pdev, epnum); 
c0d01c06:	f7ff fbe1 	bl	c0d013cc <pic>
c0d01c0a:	4602      	mov	r2, r0
c0d01c0c:	4620      	mov	r0, r4
c0d01c0e:	4629      	mov	r1, r5
c0d01c10:	4790      	blx	r2
c0d01c12:	e046      	b.n	c0d01ca2 <USBD_LL_DataInStage+0xc2>
    
  if(epnum == 0) 
  {
    pep = &pdev->ep_in[0];
    
    if ( pdev->ep0_state == USBD_EP0_DATA_IN)
c0d01c14:	20f4      	movs	r0, #244	; 0xf4
c0d01c16:	5820      	ldr	r0, [r4, r0]
c0d01c18:	2802      	cmp	r0, #2
c0d01c1a:	d13a      	bne.n	c0d01c92 <USBD_LL_DataInStage+0xb2>
    {
      if(pep->rem_length > pep->maxpacket)
c0d01c1c:	69e0      	ldr	r0, [r4, #28]
c0d01c1e:	6a25      	ldr	r5, [r4, #32]
c0d01c20:	42a8      	cmp	r0, r5
c0d01c22:	d90b      	bls.n	c0d01c3c <USBD_LL_DataInStage+0x5c>
      {
        pep->rem_length -=  pep->maxpacket;
c0d01c24:	1b40      	subs	r0, r0, r5
c0d01c26:	61e0      	str	r0, [r4, #28]
        pdev->pData += pep->maxpacket;
c0d01c28:	2109      	movs	r1, #9
c0d01c2a:	014a      	lsls	r2, r1, #5
c0d01c2c:	58a1      	ldr	r1, [r4, r2]
c0d01c2e:	1949      	adds	r1, r1, r5
c0d01c30:	50a1      	str	r1, [r4, r2]
        USBD_LL_PrepareReceive (pdev,
                                0,
                                0);  
        */
        
        USBD_CtlContinueSendData (pdev, 
c0d01c32:	b282      	uxth	r2, r0
c0d01c34:	4620      	mov	r0, r4
c0d01c36:	f000 fc1e 	bl	c0d02476 <USBD_CtlContinueSendData>
c0d01c3a:	e02a      	b.n	c0d01c92 <USBD_LL_DataInStage+0xb2>
                                  pep->rem_length);
        
      }
      else
      { /* last packet is MPS multiple, so send ZLP packet */
        if((pep->total_length % pep->maxpacket == 0) &&
c0d01c3c:	69a6      	ldr	r6, [r4, #24]
c0d01c3e:	4630      	mov	r0, r6
c0d01c40:	4629      	mov	r1, r5
c0d01c42:	f000 fccf 	bl	c0d025e4 <__aeabi_uidivmod>
c0d01c46:	42ae      	cmp	r6, r5
c0d01c48:	d30f      	bcc.n	c0d01c6a <USBD_LL_DataInStage+0x8a>
c0d01c4a:	2900      	cmp	r1, #0
c0d01c4c:	d10d      	bne.n	c0d01c6a <USBD_LL_DataInStage+0x8a>
           (pep->total_length >= pep->maxpacket) &&
             (pep->total_length < pdev->ep0_data_len ))
c0d01c4e:	20f8      	movs	r0, #248	; 0xf8
c0d01c50:	5820      	ldr	r0, [r4, r0]
c0d01c52:	4625      	mov	r5, r4
c0d01c54:	35f8      	adds	r5, #248	; 0xf8
                                  pep->rem_length);
        
      }
      else
      { /* last packet is MPS multiple, so send ZLP packet */
        if((pep->total_length % pep->maxpacket == 0) &&
c0d01c56:	4286      	cmp	r6, r0
c0d01c58:	d207      	bcs.n	c0d01c6a <USBD_LL_DataInStage+0x8a>
c0d01c5a:	2600      	movs	r6, #0
          USBD_LL_PrepareReceive (pdev,
                                  0,
                                  0);
          */

          USBD_CtlContinueSendData(pdev , NULL, 0);
c0d01c5c:	4620      	mov	r0, r4
c0d01c5e:	4631      	mov	r1, r6
c0d01c60:	4632      	mov	r2, r6
c0d01c62:	f000 fc08 	bl	c0d02476 <USBD_CtlContinueSendData>
          pdev->ep0_data_len = 0;
c0d01c66:	602e      	str	r6, [r5, #0]
c0d01c68:	e013      	b.n	c0d01c92 <USBD_LL_DataInStage+0xb2>
          
        }
        else
        {
          if(pdev->pClass != NULL && (pdev->pClass->EP0_TxSent != NULL) &&
c0d01c6a:	2045      	movs	r0, #69	; 0x45
c0d01c6c:	0080      	lsls	r0, r0, #2
c0d01c6e:	5820      	ldr	r0, [r4, r0]
c0d01c70:	2800      	cmp	r0, #0
c0d01c72:	d00b      	beq.n	c0d01c8c <USBD_LL_DataInStage+0xac>
c0d01c74:	68c0      	ldr	r0, [r0, #12]
c0d01c76:	2800      	cmp	r0, #0
c0d01c78:	d008      	beq.n	c0d01c8c <USBD_LL_DataInStage+0xac>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
c0d01c7a:	21fc      	movs	r1, #252	; 0xfc
c0d01c7c:	5c61      	ldrb	r1, [r4, r1]
          pdev->ep0_data_len = 0;
          
        }
        else
        {
          if(pdev->pClass != NULL && (pdev->pClass->EP0_TxSent != NULL) &&
c0d01c7e:	2903      	cmp	r1, #3
c0d01c80:	d104      	bne.n	c0d01c8c <USBD_LL_DataInStage+0xac>
             (pdev->dev_state == USBD_STATE_CONFIGURED))
          {
            ((EP0_TxSent_t)PIC(pdev->pClass->EP0_TxSent))(pdev); 
c0d01c82:	f7ff fba3 	bl	c0d013cc <pic>
c0d01c86:	4601      	mov	r1, r0
c0d01c88:	4620      	mov	r0, r4
c0d01c8a:	4788      	blx	r1
          }          
          USBD_CtlReceiveStatus(pdev);
c0d01c8c:	4620      	mov	r0, r4
c0d01c8e:	f000 fc16 	bl	c0d024be <USBD_CtlReceiveStatus>
        }
      }
    }
    if (pdev->dev_test_mode == 1)
c0d01c92:	2001      	movs	r0, #1
c0d01c94:	0201      	lsls	r1, r0, #8
c0d01c96:	1860      	adds	r0, r4, r1
c0d01c98:	5c61      	ldrb	r1, [r4, r1]
c0d01c9a:	2901      	cmp	r1, #1
c0d01c9c:	d101      	bne.n	c0d01ca2 <USBD_LL_DataInStage+0xc2>
    {
      USBD_RunTestMode(pdev); 
      pdev->dev_test_mode = 0;
c0d01c9e:	2100      	movs	r1, #0
c0d01ca0:	7001      	strb	r1, [r0, #0]
  else if(pdev->pClass != NULL && (pdev->pClass->DataIn != NULL)&& 
          (pdev->dev_state == USBD_STATE_CONFIGURED))
  {
    ((DataIn_t)PIC(pdev->pClass->DataIn))(pdev, epnum); 
  }  
  return USBD_OK;
c0d01ca2:	2000      	movs	r0, #0
c0d01ca4:	b001      	add	sp, #4
c0d01ca6:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d01ca8 <USBD_LL_Reset>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_Reset(USBD_HandleTypeDef  *pdev)
{
c0d01ca8:	b5d0      	push	{r4, r6, r7, lr}
c0d01caa:	af02      	add	r7, sp, #8
c0d01cac:	4604      	mov	r4, r0
  pdev->ep_out[0].maxpacket = USB_MAX_EP0_SIZE;
c0d01cae:	2090      	movs	r0, #144	; 0x90
c0d01cb0:	2140      	movs	r1, #64	; 0x40
c0d01cb2:	5021      	str	r1, [r4, r0]
  

  pdev->ep_in[0].maxpacket = USB_MAX_EP0_SIZE;
c0d01cb4:	6221      	str	r1, [r4, #32]
  /* Upon Reset call user call back */
  pdev->dev_state = USBD_STATE_DEFAULT;
c0d01cb6:	20fc      	movs	r0, #252	; 0xfc
c0d01cb8:	2101      	movs	r1, #1
c0d01cba:	5421      	strb	r1, [r4, r0]
  
  if (pdev->pClass) {
c0d01cbc:	2045      	movs	r0, #69	; 0x45
c0d01cbe:	0080      	lsls	r0, r0, #2
c0d01cc0:	5820      	ldr	r0, [r4, r0]
c0d01cc2:	2800      	cmp	r0, #0
c0d01cc4:	d006      	beq.n	c0d01cd4 <USBD_LL_Reset+0x2c>
    ((DeInit_t)PIC(pdev->pClass->DeInit))(pdev, pdev->dev_config);  
c0d01cc6:	6840      	ldr	r0, [r0, #4]
c0d01cc8:	f7ff fb80 	bl	c0d013cc <pic>
c0d01ccc:	4602      	mov	r2, r0
c0d01cce:	7921      	ldrb	r1, [r4, #4]
c0d01cd0:	4620      	mov	r0, r4
c0d01cd2:	4790      	blx	r2
  }
 
  
  return USBD_OK;
c0d01cd4:	2000      	movs	r0, #0
c0d01cd6:	bdd0      	pop	{r4, r6, r7, pc}

c0d01cd8 <USBD_LL_SetSpeed>:
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef USBD_LL_SetSpeed(USBD_HandleTypeDef  *pdev, USBD_SpeedTypeDef speed)
{
  pdev->dev_speed = speed;
c0d01cd8:	7401      	strb	r1, [r0, #16]
c0d01cda:	2000      	movs	r0, #0
  return USBD_OK;
c0d01cdc:	4770      	bx	lr

c0d01cde <USBD_LL_Suspend>:
{
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_old_state =  pdev->dev_state;
  //pdev->dev_state  = USBD_STATE_SUSPENDED;
  return USBD_OK;
c0d01cde:	2000      	movs	r0, #0
c0d01ce0:	4770      	bx	lr

c0d01ce2 <USBD_LL_Resume>:
USBD_StatusTypeDef USBD_LL_Resume(USBD_HandleTypeDef  *pdev)
{
  UNUSED(pdev);
  // Ignored, gently
  //pdev->dev_state = pdev->dev_old_state;  
  return USBD_OK;
c0d01ce2:	2000      	movs	r0, #0
c0d01ce4:	4770      	bx	lr

c0d01ce6 <USBD_LL_SOF>:
* @param  pdev: device instance
* @retval status
*/

USBD_StatusTypeDef USBD_LL_SOF(USBD_HandleTypeDef  *pdev)
{
c0d01ce6:	b5d0      	push	{r4, r6, r7, lr}
c0d01ce8:	af02      	add	r7, sp, #8
c0d01cea:	4604      	mov	r4, r0
  if(pdev->dev_state == USBD_STATE_CONFIGURED)
c0d01cec:	20fc      	movs	r0, #252	; 0xfc
c0d01cee:	5c20      	ldrb	r0, [r4, r0]
c0d01cf0:	2803      	cmp	r0, #3
c0d01cf2:	d10a      	bne.n	c0d01d0a <USBD_LL_SOF+0x24>
  {
    if(pdev->pClass->SOF != NULL)
c0d01cf4:	2045      	movs	r0, #69	; 0x45
c0d01cf6:	0080      	lsls	r0, r0, #2
c0d01cf8:	5820      	ldr	r0, [r4, r0]
c0d01cfa:	69c0      	ldr	r0, [r0, #28]
c0d01cfc:	2800      	cmp	r0, #0
c0d01cfe:	d004      	beq.n	c0d01d0a <USBD_LL_SOF+0x24>
    {
      ((SOF_t)PIC(pdev->pClass->SOF))(pdev);
c0d01d00:	f7ff fb64 	bl	c0d013cc <pic>
c0d01d04:	4601      	mov	r1, r0
c0d01d06:	4620      	mov	r0, r4
c0d01d08:	4788      	blx	r1
    }
  }
  return USBD_OK;
c0d01d0a:	2000      	movs	r0, #0
c0d01d0c:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d01d10 <USBD_StdDevReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdDevReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d01d10:	b5d0      	push	{r4, r6, r7, lr}
c0d01d12:	af02      	add	r7, sp, #8
c0d01d14:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK;  
  
  switch (req->bRequest) 
c0d01d16:	7848      	ldrb	r0, [r1, #1]
c0d01d18:	2809      	cmp	r0, #9
c0d01d1a:	d810      	bhi.n	c0d01d3e <USBD_StdDevReq+0x2e>
c0d01d1c:	4478      	add	r0, pc
c0d01d1e:	7900      	ldrb	r0, [r0, #4]
c0d01d20:	0040      	lsls	r0, r0, #1
c0d01d22:	4487      	add	pc, r0
c0d01d24:	150c0804 	.word	0x150c0804
c0d01d28:	0c25190c 	.word	0x0c25190c
c0d01d2c:	211d      	.short	0x211d
  case USB_REQ_GET_CONFIGURATION:                 
    USBD_GetConfig (pdev , req);
    break;
    
  case USB_REQ_GET_STATUS:                                  
    USBD_GetStatus (pdev , req);
c0d01d2e:	4620      	mov	r0, r4
c0d01d30:	f000 f938 	bl	c0d01fa4 <USBD_GetStatus>
c0d01d34:	e01f      	b.n	c0d01d76 <USBD_StdDevReq+0x66>
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
    break;
    
  case USB_REQ_CLEAR_FEATURE:                                   
    USBD_ClrFeature (pdev , req);
c0d01d36:	4620      	mov	r0, r4
c0d01d38:	f000 f976 	bl	c0d02028 <USBD_ClrFeature>
c0d01d3c:	e01b      	b.n	c0d01d76 <USBD_StdDevReq+0x66>

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d01d3e:	2180      	movs	r1, #128	; 0x80
c0d01d40:	4620      	mov	r0, r4
c0d01d42:	f7ff fdc5 	bl	c0d018d0 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d01d46:	2100      	movs	r1, #0
c0d01d48:	4620      	mov	r0, r4
c0d01d4a:	f7ff fdc1 	bl	c0d018d0 <USBD_LL_StallEP>
c0d01d4e:	e012      	b.n	c0d01d76 <USBD_StdDevReq+0x66>
    USBD_GetStatus (pdev , req);
    break;
    
    
  case USB_REQ_SET_FEATURE:   
    USBD_SetFeature (pdev , req);    
c0d01d50:	4620      	mov	r0, r4
c0d01d52:	f000 f950 	bl	c0d01ff6 <USBD_SetFeature>
c0d01d56:	e00e      	b.n	c0d01d76 <USBD_StdDevReq+0x66>
    
    USBD_GetDescriptor (pdev, req) ;
    break;
    
  case USB_REQ_SET_ADDRESS:                      
    USBD_SetAddress(pdev, req);
c0d01d58:	4620      	mov	r0, r4
c0d01d5a:	f000 f897 	bl	c0d01e8c <USBD_SetAddress>
c0d01d5e:	e00a      	b.n	c0d01d76 <USBD_StdDevReq+0x66>
  case USB_REQ_SET_CONFIGURATION:                    
    USBD_SetConfig (pdev , req);
    break;
    
  case USB_REQ_GET_CONFIGURATION:                 
    USBD_GetConfig (pdev , req);
c0d01d60:	4620      	mov	r0, r4
c0d01d62:	f000 f8ff 	bl	c0d01f64 <USBD_GetConfig>
c0d01d66:	e006      	b.n	c0d01d76 <USBD_StdDevReq+0x66>
  case USB_REQ_SET_ADDRESS:                      
    USBD_SetAddress(pdev, req);
    break;
    
  case USB_REQ_SET_CONFIGURATION:                    
    USBD_SetConfig (pdev , req);
c0d01d68:	4620      	mov	r0, r4
c0d01d6a:	f000 f8bd 	bl	c0d01ee8 <USBD_SetConfig>
c0d01d6e:	e002      	b.n	c0d01d76 <USBD_StdDevReq+0x66>
  
  switch (req->bRequest) 
  {
  case USB_REQ_GET_DESCRIPTOR: 
    
    USBD_GetDescriptor (pdev, req) ;
c0d01d70:	4620      	mov	r0, r4
c0d01d72:	f000 f803 	bl	c0d01d7c <USBD_GetDescriptor>
  default:  
    USBD_CtlError(pdev , req);
    break;
  }
  
  return ret;
c0d01d76:	2000      	movs	r0, #0
c0d01d78:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d01d7c <USBD_GetDescriptor>:
* @param  req: usb request
* @retval status
*/
void USBD_GetDescriptor(USBD_HandleTypeDef *pdev , 
                               USBD_SetupReqTypedef *req)
{
c0d01d7c:	b5b0      	push	{r4, r5, r7, lr}
c0d01d7e:	af02      	add	r7, sp, #8
c0d01d80:	b082      	sub	sp, #8
c0d01d82:	460d      	mov	r5, r1
c0d01d84:	4604      	mov	r4, r0
  uint16_t len;
  uint8_t *pbuf;
  
    
  switch (req->wValue >> 8)
c0d01d86:	8868      	ldrh	r0, [r5, #2]
c0d01d88:	0a01      	lsrs	r1, r0, #8
c0d01d8a:	1e4a      	subs	r2, r1, #1

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d01d8c:	2180      	movs	r1, #128	; 0x80
{
  uint16_t len;
  uint8_t *pbuf;
  
    
  switch (req->wValue >> 8)
c0d01d8e:	2a0e      	cmp	r2, #14
c0d01d90:	d83e      	bhi.n	c0d01e10 <USBD_GetDescriptor+0x94>
c0d01d92:	46c0      	nop			; (mov r8, r8)
c0d01d94:	447a      	add	r2, pc
c0d01d96:	7912      	ldrb	r2, [r2, #4]
c0d01d98:	0052      	lsls	r2, r2, #1
c0d01d9a:	4497      	add	pc, r2
c0d01d9c:	390c2607 	.word	0x390c2607
c0d01da0:	39362e39 	.word	0x39362e39
c0d01da4:	39393939 	.word	0x39393939
c0d01da8:	001b3939 	.word	0x001b3939
  case USB_DESC_TYPE_BOS:
    pbuf = ((GetBOSDescriptor_t)PIC(pdev->pDesc->GetBOSDescriptor))(pdev->dev_speed, &len);
    break;
#endif    
  case USB_DESC_TYPE_DEVICE:
    pbuf = ((GetDeviceDescriptor_t)PIC(pdev->pDesc->GetDeviceDescriptor))(pdev->dev_speed, &len);
c0d01dac:	2011      	movs	r0, #17
c0d01dae:	0100      	lsls	r0, r0, #4
c0d01db0:	5820      	ldr	r0, [r4, r0]
c0d01db2:	6800      	ldr	r0, [r0, #0]
c0d01db4:	e012      	b.n	c0d01ddc <USBD_GetDescriptor+0x60>
      //pbuf[1] = USB_DESC_TYPE_CONFIGURATION; CONST BUFFER KTHX
    }
    break;
    
  case USB_DESC_TYPE_STRING:
    switch ((uint8_t)(req->wValue))
c0d01db6:	b2c0      	uxtb	r0, r0
c0d01db8:	2805      	cmp	r0, #5
c0d01dba:	d829      	bhi.n	c0d01e10 <USBD_GetDescriptor+0x94>
c0d01dbc:	4478      	add	r0, pc
c0d01dbe:	7900      	ldrb	r0, [r0, #4]
c0d01dc0:	0040      	lsls	r0, r0, #1
c0d01dc2:	4487      	add	pc, r0
c0d01dc4:	544f4a02 	.word	0x544f4a02
c0d01dc8:	5e59      	.short	0x5e59
    {
    case USBD_IDX_LANGID_STR:
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
c0d01dca:	2011      	movs	r0, #17
c0d01dcc:	0100      	lsls	r0, r0, #4
c0d01dce:	5820      	ldr	r0, [r4, r0]
c0d01dd0:	6840      	ldr	r0, [r0, #4]
c0d01dd2:	e003      	b.n	c0d01ddc <USBD_GetDescriptor+0x60>
    
  switch (req->wValue >> 8)
  { 
#if (USBD_LPM_ENABLED == 1)
  case USB_DESC_TYPE_BOS:
    pbuf = ((GetBOSDescriptor_t)PIC(pdev->pDesc->GetBOSDescriptor))(pdev->dev_speed, &len);
c0d01dd4:	2011      	movs	r0, #17
c0d01dd6:	0100      	lsls	r0, r0, #4
c0d01dd8:	5820      	ldr	r0, [r4, r0]
c0d01dda:	69c0      	ldr	r0, [r0, #28]
c0d01ddc:	f7ff faf6 	bl	c0d013cc <pic>
c0d01de0:	4602      	mov	r2, r0
c0d01de2:	7c20      	ldrb	r0, [r4, #16]
c0d01de4:	a901      	add	r1, sp, #4
c0d01de6:	4790      	blx	r2
c0d01de8:	e025      	b.n	c0d01e36 <USBD_GetDescriptor+0xba>
c0d01dea:	2045      	movs	r0, #69	; 0x45
c0d01dec:	0080      	lsls	r0, r0, #2
c0d01dee:	5820      	ldr	r0, [r4, r0]
  case USB_DESC_TYPE_DEVICE:
    pbuf = ((GetDeviceDescriptor_t)PIC(pdev->pDesc->GetDeviceDescriptor))(pdev->dev_speed, &len);
    break;
    
  case USB_DESC_TYPE_CONFIGURATION:     
    if(pdev->dev_speed == USBD_SPEED_HIGH )   
c0d01df0:	7c21      	ldrb	r1, [r4, #16]
c0d01df2:	2900      	cmp	r1, #0
c0d01df4:	d014      	beq.n	c0d01e20 <USBD_GetDescriptor+0xa4>
      pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->pClass->GetHSConfigDescriptor))(&len);
      //pbuf[1] = USB_DESC_TYPE_CONFIGURATION; CONST BUFFER KTHX
    }
    else
    {
      pbuf   = (uint8_t *)((GetFSConfigDescriptor_t)PIC(pdev->pClass->GetFSConfigDescriptor))(&len);
c0d01df6:	6ac0      	ldr	r0, [r0, #44]	; 0x2c
c0d01df8:	e018      	b.n	c0d01e2c <USBD_GetDescriptor+0xb0>
#endif   
    }
    break;
  case USB_DESC_TYPE_DEVICE_QUALIFIER:                   

    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
c0d01dfa:	7c20      	ldrb	r0, [r4, #16]
c0d01dfc:	2800      	cmp	r0, #0
c0d01dfe:	d107      	bne.n	c0d01e10 <USBD_GetDescriptor+0x94>
    {
      pbuf   = (uint8_t *)((GetDeviceQualifierDescriptor_t)PIC(pdev->pClass->GetDeviceQualifierDescriptor))(&len);
c0d01e00:	2045      	movs	r0, #69	; 0x45
c0d01e02:	0080      	lsls	r0, r0, #2
c0d01e04:	5820      	ldr	r0, [r4, r0]
c0d01e06:	6b40      	ldr	r0, [r0, #52]	; 0x34
c0d01e08:	e010      	b.n	c0d01e2c <USBD_GetDescriptor+0xb0>
      USBD_CtlError(pdev , req);
      return;
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
c0d01e0a:	7c20      	ldrb	r0, [r4, #16]
c0d01e0c:	2800      	cmp	r0, #0
c0d01e0e:	d009      	beq.n	c0d01e24 <USBD_GetDescriptor+0xa8>
c0d01e10:	4620      	mov	r0, r4
c0d01e12:	f7ff fd5d 	bl	c0d018d0 <USBD_LL_StallEP>
c0d01e16:	2100      	movs	r1, #0
c0d01e18:	4620      	mov	r0, r4
c0d01e1a:	f7ff fd59 	bl	c0d018d0 <USBD_LL_StallEP>
c0d01e1e:	e01a      	b.n	c0d01e56 <USBD_GetDescriptor+0xda>
    break;
    
  case USB_DESC_TYPE_CONFIGURATION:     
    if(pdev->dev_speed == USBD_SPEED_HIGH )   
    {
      pbuf   = (uint8_t *)((GetHSConfigDescriptor_t)PIC(pdev->pClass->GetHSConfigDescriptor))(&len);
c0d01e20:	6a80      	ldr	r0, [r0, #40]	; 0x28
c0d01e22:	e003      	b.n	c0d01e2c <USBD_GetDescriptor+0xb0>
    } 

  case USB_DESC_TYPE_OTHER_SPEED_CONFIGURATION:
    if(pdev->dev_speed == USBD_SPEED_HIGH  )   
    {
      pbuf   = (uint8_t *)((GetOtherSpeedConfigDescriptor_t)PIC(pdev->pClass->GetOtherSpeedConfigDescriptor))(&len);
c0d01e24:	2045      	movs	r0, #69	; 0x45
c0d01e26:	0080      	lsls	r0, r0, #2
c0d01e28:	5820      	ldr	r0, [r4, r0]
c0d01e2a:	6b00      	ldr	r0, [r0, #48]	; 0x30
c0d01e2c:	f7ff face 	bl	c0d013cc <pic>
c0d01e30:	4601      	mov	r1, r0
c0d01e32:	a801      	add	r0, sp, #4
c0d01e34:	4788      	blx	r1
c0d01e36:	4601      	mov	r1, r0
c0d01e38:	a801      	add	r0, sp, #4
  default: 
     USBD_CtlError(pdev , req);
    return;
  }
  
  if((len != 0)&& (req->wLength != 0))
c0d01e3a:	8802      	ldrh	r2, [r0, #0]
c0d01e3c:	2a00      	cmp	r2, #0
c0d01e3e:	d00a      	beq.n	c0d01e56 <USBD_GetDescriptor+0xda>
c0d01e40:	88e8      	ldrh	r0, [r5, #6]
c0d01e42:	2800      	cmp	r0, #0
c0d01e44:	d007      	beq.n	c0d01e56 <USBD_GetDescriptor+0xda>
  {
    
    len = MIN(len , req->wLength);
c0d01e46:	4282      	cmp	r2, r0
c0d01e48:	d300      	bcc.n	c0d01e4c <USBD_GetDescriptor+0xd0>
c0d01e4a:	4602      	mov	r2, r0
c0d01e4c:	a801      	add	r0, sp, #4
c0d01e4e:	8002      	strh	r2, [r0, #0]
    
    // prepare abort if host does not read the whole data
    //USBD_CtlReceiveStatus(pdev);

    // start transfer
    USBD_CtlSendData (pdev, 
c0d01e50:	4620      	mov	r0, r4
c0d01e52:	f000 faf9 	bl	c0d02448 <USBD_CtlSendData>
                      pbuf,
                      len);
  }
  
}
c0d01e56:	b002      	add	sp, #8
c0d01e58:	bdb0      	pop	{r4, r5, r7, pc}
    case USBD_IDX_LANGID_STR:
     pbuf = ((GetLangIDStrDescriptor_t)PIC(pdev->pDesc->GetLangIDStrDescriptor))(pdev->dev_speed, &len);        
      break;
      
    case USBD_IDX_MFC_STR:
      pbuf = ((GetManufacturerStrDescriptor_t)PIC(pdev->pDesc->GetManufacturerStrDescriptor))(pdev->dev_speed, &len);
c0d01e5a:	2011      	movs	r0, #17
c0d01e5c:	0100      	lsls	r0, r0, #4
c0d01e5e:	5820      	ldr	r0, [r4, r0]
c0d01e60:	6880      	ldr	r0, [r0, #8]
c0d01e62:	e7bb      	b.n	c0d01ddc <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_PRODUCT_STR:
      pbuf = ((GetProductStrDescriptor_t)PIC(pdev->pDesc->GetProductStrDescriptor))(pdev->dev_speed, &len);
c0d01e64:	2011      	movs	r0, #17
c0d01e66:	0100      	lsls	r0, r0, #4
c0d01e68:	5820      	ldr	r0, [r4, r0]
c0d01e6a:	68c0      	ldr	r0, [r0, #12]
c0d01e6c:	e7b6      	b.n	c0d01ddc <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_SERIAL_STR:
      pbuf = ((GetSerialStrDescriptor_t)PIC(pdev->pDesc->GetSerialStrDescriptor))(pdev->dev_speed, &len);
c0d01e6e:	2011      	movs	r0, #17
c0d01e70:	0100      	lsls	r0, r0, #4
c0d01e72:	5820      	ldr	r0, [r4, r0]
c0d01e74:	6900      	ldr	r0, [r0, #16]
c0d01e76:	e7b1      	b.n	c0d01ddc <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_CONFIG_STR:
      pbuf = ((GetConfigurationStrDescriptor_t)PIC(pdev->pDesc->GetConfigurationStrDescriptor))(pdev->dev_speed, &len);
c0d01e78:	2011      	movs	r0, #17
c0d01e7a:	0100      	lsls	r0, r0, #4
c0d01e7c:	5820      	ldr	r0, [r4, r0]
c0d01e7e:	6940      	ldr	r0, [r0, #20]
c0d01e80:	e7ac      	b.n	c0d01ddc <USBD_GetDescriptor+0x60>
      break;
      
    case USBD_IDX_INTERFACE_STR:
      pbuf = ((GetInterfaceStrDescriptor_t)PIC(pdev->pDesc->GetInterfaceStrDescriptor))(pdev->dev_speed, &len);
c0d01e82:	2011      	movs	r0, #17
c0d01e84:	0100      	lsls	r0, r0, #4
c0d01e86:	5820      	ldr	r0, [r4, r0]
c0d01e88:	6980      	ldr	r0, [r0, #24]
c0d01e8a:	e7a7      	b.n	c0d01ddc <USBD_GetDescriptor+0x60>

c0d01e8c <USBD_SetAddress>:
* @param  req: usb request
* @retval status
*/
void USBD_SetAddress(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d01e8c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01e8e:	af03      	add	r7, sp, #12
c0d01e90:	b081      	sub	sp, #4
c0d01e92:	460a      	mov	r2, r1
c0d01e94:	4604      	mov	r4, r0
  uint8_t  dev_addr; 
  
  if ((req->wIndex == 0) && (req->wLength == 0)) 
c0d01e96:	8890      	ldrh	r0, [r2, #4]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d01e98:	2180      	movs	r1, #128	; 0x80
void USBD_SetAddress(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
  uint8_t  dev_addr; 
  
  if ((req->wIndex == 0) && (req->wLength == 0)) 
c0d01e9a:	2800      	cmp	r0, #0
c0d01e9c:	d10b      	bne.n	c0d01eb6 <USBD_SetAddress+0x2a>
c0d01e9e:	88d0      	ldrh	r0, [r2, #6]
c0d01ea0:	2800      	cmp	r0, #0
c0d01ea2:	d108      	bne.n	c0d01eb6 <USBD_SetAddress+0x2a>
  {
    dev_addr = (uint8_t)(req->wValue) & 0x7F;     
c0d01ea4:	8850      	ldrh	r0, [r2, #2]
c0d01ea6:	267f      	movs	r6, #127	; 0x7f
c0d01ea8:	4006      	ands	r6, r0
    
    if (pdev->dev_state == USBD_STATE_CONFIGURED) 
c0d01eaa:	20fc      	movs	r0, #252	; 0xfc
c0d01eac:	5c20      	ldrb	r0, [r4, r0]
c0d01eae:	4625      	mov	r5, r4
c0d01eb0:	35fc      	adds	r5, #252	; 0xfc
c0d01eb2:	2803      	cmp	r0, #3
c0d01eb4:	d108      	bne.n	c0d01ec8 <USBD_SetAddress+0x3c>
c0d01eb6:	4620      	mov	r0, r4
c0d01eb8:	f7ff fd0a 	bl	c0d018d0 <USBD_LL_StallEP>
c0d01ebc:	2100      	movs	r1, #0
c0d01ebe:	4620      	mov	r0, r4
c0d01ec0:	f7ff fd06 	bl	c0d018d0 <USBD_LL_StallEP>
  } 
  else 
  {
     USBD_CtlError(pdev , req);                        
  } 
}
c0d01ec4:	b001      	add	sp, #4
c0d01ec6:	bdf0      	pop	{r4, r5, r6, r7, pc}
    {
      USBD_CtlError(pdev , req);
    } 
    else 
    {
      pdev->dev_address = dev_addr;
c0d01ec8:	20fe      	movs	r0, #254	; 0xfe
c0d01eca:	5426      	strb	r6, [r4, r0]
      USBD_LL_SetUSBAddress(pdev, dev_addr);               
c0d01ecc:	b2f1      	uxtb	r1, r6
c0d01ece:	4620      	mov	r0, r4
c0d01ed0:	f7ff fd5c 	bl	c0d0198c <USBD_LL_SetUSBAddress>
      USBD_CtlSendStatus(pdev);                         
c0d01ed4:	4620      	mov	r0, r4
c0d01ed6:	f000 fae5 	bl	c0d024a4 <USBD_CtlSendStatus>
      
      if (dev_addr != 0) 
c0d01eda:	2002      	movs	r0, #2
c0d01edc:	2101      	movs	r1, #1
c0d01ede:	2e00      	cmp	r6, #0
c0d01ee0:	d100      	bne.n	c0d01ee4 <USBD_SetAddress+0x58>
c0d01ee2:	4608      	mov	r0, r1
c0d01ee4:	7028      	strb	r0, [r5, #0]
c0d01ee6:	e7ed      	b.n	c0d01ec4 <USBD_SetAddress+0x38>

c0d01ee8 <USBD_SetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_SetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d01ee8:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d01eea:	af03      	add	r7, sp, #12
c0d01eec:	b081      	sub	sp, #4
c0d01eee:	4604      	mov	r4, r0
  
  uint8_t  cfgidx;
  
  cfgidx = (uint8_t)(req->wValue);                 
c0d01ef0:	788e      	ldrb	r6, [r1, #2]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d01ef2:	2580      	movs	r5, #128	; 0x80
  
  uint8_t  cfgidx;
  
  cfgidx = (uint8_t)(req->wValue);                 
  
  if (cfgidx > USBD_MAX_NUM_CONFIGURATION ) 
c0d01ef4:	2e02      	cmp	r6, #2
c0d01ef6:	d21d      	bcs.n	c0d01f34 <USBD_SetConfig+0x4c>
  {            
     USBD_CtlError(pdev , req);                              
  } 
  else 
  {
    switch (pdev->dev_state) 
c0d01ef8:	20fc      	movs	r0, #252	; 0xfc
c0d01efa:	5c21      	ldrb	r1, [r4, r0]
c0d01efc:	4620      	mov	r0, r4
c0d01efe:	30fc      	adds	r0, #252	; 0xfc
c0d01f00:	2903      	cmp	r1, #3
c0d01f02:	d007      	beq.n	c0d01f14 <USBD_SetConfig+0x2c>
c0d01f04:	2902      	cmp	r1, #2
c0d01f06:	d115      	bne.n	c0d01f34 <USBD_SetConfig+0x4c>
    {
    case USBD_STATE_ADDRESSED:
      if (cfgidx) 
c0d01f08:	2e00      	cmp	r6, #0
c0d01f0a:	d026      	beq.n	c0d01f5a <USBD_SetConfig+0x72>
      {                                			   							   							   				
        pdev->dev_config = cfgidx;
c0d01f0c:	6066      	str	r6, [r4, #4]
        pdev->dev_state = USBD_STATE_CONFIGURED;
c0d01f0e:	2103      	movs	r1, #3
c0d01f10:	7001      	strb	r1, [r0, #0]
c0d01f12:	e009      	b.n	c0d01f28 <USBD_SetConfig+0x40>
      }
      USBD_CtlSendStatus(pdev);
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
c0d01f14:	2e00      	cmp	r6, #0
c0d01f16:	d016      	beq.n	c0d01f46 <USBD_SetConfig+0x5e>
        pdev->dev_state = USBD_STATE_ADDRESSED;
        pdev->dev_config = cfgidx;          
        USBD_ClrClassConfig(pdev , cfgidx);
        USBD_CtlSendStatus(pdev);
      } 
      else  if (cfgidx != pdev->dev_config) 
c0d01f18:	6860      	ldr	r0, [r4, #4]
c0d01f1a:	4286      	cmp	r6, r0
c0d01f1c:	d01d      	beq.n	c0d01f5a <USBD_SetConfig+0x72>
      {
        /* Clear old configuration */
        USBD_ClrClassConfig(pdev , pdev->dev_config);
c0d01f1e:	b2c1      	uxtb	r1, r0
c0d01f20:	4620      	mov	r0, r4
c0d01f22:	f7ff fdd3 	bl	c0d01acc <USBD_ClrClassConfig>
        
        /* set new configuration */
        pdev->dev_config = cfgidx;
c0d01f26:	6066      	str	r6, [r4, #4]
c0d01f28:	4620      	mov	r0, r4
c0d01f2a:	4631      	mov	r1, r6
c0d01f2c:	f7ff fdb6 	bl	c0d01a9c <USBD_SetClassConfig>
c0d01f30:	2802      	cmp	r0, #2
c0d01f32:	d112      	bne.n	c0d01f5a <USBD_SetConfig+0x72>
c0d01f34:	4620      	mov	r0, r4
c0d01f36:	4629      	mov	r1, r5
c0d01f38:	f7ff fcca 	bl	c0d018d0 <USBD_LL_StallEP>
c0d01f3c:	2100      	movs	r1, #0
c0d01f3e:	4620      	mov	r0, r4
c0d01f40:	f7ff fcc6 	bl	c0d018d0 <USBD_LL_StallEP>
c0d01f44:	e00c      	b.n	c0d01f60 <USBD_SetConfig+0x78>
      break;
      
    case USBD_STATE_CONFIGURED:
      if (cfgidx == 0) 
      {                           
        pdev->dev_state = USBD_STATE_ADDRESSED;
c0d01f46:	2102      	movs	r1, #2
c0d01f48:	7001      	strb	r1, [r0, #0]
        pdev->dev_config = cfgidx;          
c0d01f4a:	6066      	str	r6, [r4, #4]
        USBD_ClrClassConfig(pdev , cfgidx);
c0d01f4c:	4620      	mov	r0, r4
c0d01f4e:	4631      	mov	r1, r6
c0d01f50:	f7ff fdbc 	bl	c0d01acc <USBD_ClrClassConfig>
        USBD_CtlSendStatus(pdev);
c0d01f54:	4620      	mov	r0, r4
c0d01f56:	f000 faa5 	bl	c0d024a4 <USBD_CtlSendStatus>
c0d01f5a:	4620      	mov	r0, r4
c0d01f5c:	f000 faa2 	bl	c0d024a4 <USBD_CtlSendStatus>
    default:					
       USBD_CtlError(pdev , req);                     
      break;
    }
  }
}
c0d01f60:	b001      	add	sp, #4
c0d01f62:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d01f64 <USBD_GetConfig>:
* @param  req: usb request
* @retval status
*/
void USBD_GetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d01f64:	b5d0      	push	{r4, r6, r7, lr}
c0d01f66:	af02      	add	r7, sp, #8
c0d01f68:	4604      	mov	r4, r0

  if (req->wLength != 1) 
c0d01f6a:	88c8      	ldrh	r0, [r1, #6]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d01f6c:	2180      	movs	r1, #128	; 0x80
*/
void USBD_GetConfig(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{

  if (req->wLength != 1) 
c0d01f6e:	2801      	cmp	r0, #1
c0d01f70:	d10a      	bne.n	c0d01f88 <USBD_GetConfig+0x24>
  {                   
     USBD_CtlError(pdev , req);
  }
  else 
  {
    switch (pdev->dev_state )  
c0d01f72:	20fc      	movs	r0, #252	; 0xfc
c0d01f74:	5c20      	ldrb	r0, [r4, r0]
c0d01f76:	2803      	cmp	r0, #3
c0d01f78:	d00e      	beq.n	c0d01f98 <USBD_GetConfig+0x34>
c0d01f7a:	2802      	cmp	r0, #2
c0d01f7c:	d104      	bne.n	c0d01f88 <USBD_GetConfig+0x24>
    {
    case USBD_STATE_ADDRESSED:                     
      pdev->dev_default_config = 0;
c0d01f7e:	2000      	movs	r0, #0
c0d01f80:	60a0      	str	r0, [r4, #8]
c0d01f82:	4621      	mov	r1, r4
c0d01f84:	3108      	adds	r1, #8
c0d01f86:	e008      	b.n	c0d01f9a <USBD_GetConfig+0x36>
c0d01f88:	4620      	mov	r0, r4
c0d01f8a:	f7ff fca1 	bl	c0d018d0 <USBD_LL_StallEP>
c0d01f8e:	2100      	movs	r1, #0
c0d01f90:	4620      	mov	r0, r4
c0d01f92:	f7ff fc9d 	bl	c0d018d0 <USBD_LL_StallEP>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d01f96:	bdd0      	pop	{r4, r6, r7, pc}
                        1);
      break;
      
    case USBD_STATE_CONFIGURED:   
      USBD_CtlSendData (pdev, 
                        (uint8_t *)&pdev->dev_config,
c0d01f98:	1d21      	adds	r1, r4, #4
c0d01f9a:	2201      	movs	r2, #1
c0d01f9c:	4620      	mov	r0, r4
c0d01f9e:	f000 fa53 	bl	c0d02448 <USBD_CtlSendData>
    default:
       USBD_CtlError(pdev , req);
      break;
    }
  }
}
c0d01fa2:	bdd0      	pop	{r4, r6, r7, pc}

c0d01fa4 <USBD_GetStatus>:
* @param  req: usb request
* @retval status
*/
void USBD_GetStatus(USBD_HandleTypeDef *pdev , 
                           USBD_SetupReqTypedef *req)
{
c0d01fa4:	b5b0      	push	{r4, r5, r7, lr}
c0d01fa6:	af02      	add	r7, sp, #8
c0d01fa8:	4604      	mov	r4, r0
  
    
  switch (pdev->dev_state) 
c0d01faa:	20fc      	movs	r0, #252	; 0xfc
c0d01fac:	5c20      	ldrb	r0, [r4, r0]
c0d01fae:	21fe      	movs	r1, #254	; 0xfe
c0d01fb0:	4001      	ands	r1, r0
c0d01fb2:	2902      	cmp	r1, #2
c0d01fb4:	d116      	bne.n	c0d01fe4 <USBD_GetStatus+0x40>
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d01fb6:	2001      	movs	r0, #1
c0d01fb8:	60e0      	str	r0, [r4, #12]
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d01fba:	2041      	movs	r0, #65	; 0x41
c0d01fbc:	0080      	lsls	r0, r0, #2
c0d01fbe:	5821      	ldr	r1, [r4, r0]
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    
#if ( USBD_SELF_POWERED == 1)
    pdev->dev_config_status = USB_CONFIG_SELF_POWERED;                                  
c0d01fc0:	4625      	mov	r5, r4
c0d01fc2:	350c      	adds	r5, #12
c0d01fc4:	2003      	movs	r0, #3
#else
    pdev->dev_config_status = 0;                                   
#endif
                      
    if (pdev->dev_remote_wakeup) USBD_CtlReceiveStatus(pdev);
c0d01fc6:	2900      	cmp	r1, #0
c0d01fc8:	d005      	beq.n	c0d01fd6 <USBD_GetStatus+0x32>
c0d01fca:	4620      	mov	r0, r4
c0d01fcc:	f000 fa77 	bl	c0d024be <USBD_CtlReceiveStatus>
c0d01fd0:	68e1      	ldr	r1, [r4, #12]
c0d01fd2:	2002      	movs	r0, #2
c0d01fd4:	4308      	orrs	r0, r1
    {
       pdev->dev_config_status |= USB_CONFIG_REMOTE_WAKEUP;                                
c0d01fd6:	60e0      	str	r0, [r4, #12]
    }
    
    USBD_CtlSendData (pdev, 
c0d01fd8:	2202      	movs	r2, #2
c0d01fda:	4620      	mov	r0, r4
c0d01fdc:	4629      	mov	r1, r5
c0d01fde:	f000 fa33 	bl	c0d02448 <USBD_CtlSendData>
    
  default :
    USBD_CtlError(pdev , req);                        
    break;
  }
}
c0d01fe2:	bdb0      	pop	{r4, r5, r7, pc}

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d01fe4:	2180      	movs	r1, #128	; 0x80
c0d01fe6:	4620      	mov	r0, r4
c0d01fe8:	f7ff fc72 	bl	c0d018d0 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d01fec:	2100      	movs	r1, #0
c0d01fee:	4620      	mov	r0, r4
c0d01ff0:	f7ff fc6e 	bl	c0d018d0 <USBD_LL_StallEP>
    
  default :
    USBD_CtlError(pdev , req);                        
    break;
  }
}
c0d01ff4:	bdb0      	pop	{r4, r5, r7, pc}

c0d01ff6 <USBD_SetFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_SetFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d01ff6:	b5b0      	push	{r4, r5, r7, lr}
c0d01ff8:	af02      	add	r7, sp, #8
c0d01ffa:	460d      	mov	r5, r1
c0d01ffc:	4604      	mov	r4, r0

  if (req->wValue == USB_FEATURE_REMOTE_WAKEUP)
c0d01ffe:	8868      	ldrh	r0, [r5, #2]
c0d02000:	2801      	cmp	r0, #1
c0d02002:	d110      	bne.n	c0d02026 <USBD_SetFeature+0x30>
  {
    pdev->dev_remote_wakeup = 1;  
c0d02004:	2041      	movs	r0, #65	; 0x41
c0d02006:	0080      	lsls	r0, r0, #2
c0d02008:	2101      	movs	r1, #1
c0d0200a:	5021      	str	r1, [r4, r0]
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);   
c0d0200c:	2045      	movs	r0, #69	; 0x45
c0d0200e:	0080      	lsls	r0, r0, #2
c0d02010:	5820      	ldr	r0, [r4, r0]
c0d02012:	6880      	ldr	r0, [r0, #8]
c0d02014:	f7ff f9da 	bl	c0d013cc <pic>
c0d02018:	4602      	mov	r2, r0
c0d0201a:	4620      	mov	r0, r4
c0d0201c:	4629      	mov	r1, r5
c0d0201e:	4790      	blx	r2
    USBD_CtlSendStatus(pdev);
c0d02020:	4620      	mov	r0, r4
c0d02022:	f000 fa3f 	bl	c0d024a4 <USBD_CtlSendStatus>
  }

}
c0d02026:	bdb0      	pop	{r4, r5, r7, pc}

c0d02028 <USBD_ClrFeature>:
* @param  req: usb request
* @retval status
*/
void USBD_ClrFeature(USBD_HandleTypeDef *pdev , 
                            USBD_SetupReqTypedef *req)
{
c0d02028:	b5b0      	push	{r4, r5, r7, lr}
c0d0202a:	af02      	add	r7, sp, #8
c0d0202c:	460d      	mov	r5, r1
c0d0202e:	4604      	mov	r4, r0
  switch (pdev->dev_state)
c0d02030:	20fc      	movs	r0, #252	; 0xfc
c0d02032:	5c20      	ldrb	r0, [r4, r0]
c0d02034:	21fe      	movs	r1, #254	; 0xfe
c0d02036:	4001      	ands	r1, r0
c0d02038:	2902      	cmp	r1, #2
c0d0203a:	d114      	bne.n	c0d02066 <USBD_ClrFeature+0x3e>
  {
  case USBD_STATE_ADDRESSED:
  case USBD_STATE_CONFIGURED:
    if (req->wValue == USB_FEATURE_REMOTE_WAKEUP) 
c0d0203c:	8868      	ldrh	r0, [r5, #2]
c0d0203e:	2801      	cmp	r0, #1
c0d02040:	d119      	bne.n	c0d02076 <USBD_ClrFeature+0x4e>
    {
      pdev->dev_remote_wakeup = 0; 
c0d02042:	2041      	movs	r0, #65	; 0x41
c0d02044:	0080      	lsls	r0, r0, #2
c0d02046:	2100      	movs	r1, #0
c0d02048:	5021      	str	r1, [r4, r0]
      ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);   
c0d0204a:	2045      	movs	r0, #69	; 0x45
c0d0204c:	0080      	lsls	r0, r0, #2
c0d0204e:	5820      	ldr	r0, [r4, r0]
c0d02050:	6880      	ldr	r0, [r0, #8]
c0d02052:	f7ff f9bb 	bl	c0d013cc <pic>
c0d02056:	4602      	mov	r2, r0
c0d02058:	4620      	mov	r0, r4
c0d0205a:	4629      	mov	r1, r5
c0d0205c:	4790      	blx	r2
      USBD_CtlSendStatus(pdev);
c0d0205e:	4620      	mov	r0, r4
c0d02060:	f000 fa20 	bl	c0d024a4 <USBD_CtlSendStatus>
    
  default :
     USBD_CtlError(pdev , req);
    break;
  }
}
c0d02064:	bdb0      	pop	{r4, r5, r7, pc}

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d02066:	2180      	movs	r1, #128	; 0x80
c0d02068:	4620      	mov	r0, r4
c0d0206a:	f7ff fc31 	bl	c0d018d0 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d0206e:	2100      	movs	r1, #0
c0d02070:	4620      	mov	r0, r4
c0d02072:	f7ff fc2d 	bl	c0d018d0 <USBD_LL_StallEP>
    
  default :
     USBD_CtlError(pdev , req);
    break;
  }
}
c0d02076:	bdb0      	pop	{r4, r5, r7, pc}

c0d02078 <USBD_CtlError>:
* @retval None
*/

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
c0d02078:	b5d0      	push	{r4, r6, r7, lr}
c0d0207a:	af02      	add	r7, sp, #8
c0d0207c:	4604      	mov	r4, r0
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d0207e:	2180      	movs	r1, #128	; 0x80
c0d02080:	f7ff fc26 	bl	c0d018d0 <USBD_LL_StallEP>
  USBD_LL_StallEP(pdev , 0);
c0d02084:	2100      	movs	r1, #0
c0d02086:	4620      	mov	r0, r4
c0d02088:	f7ff fc22 	bl	c0d018d0 <USBD_LL_StallEP>
}
c0d0208c:	bdd0      	pop	{r4, r6, r7, pc}

c0d0208e <USBD_StdItfReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdItfReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d0208e:	b5b0      	push	{r4, r5, r7, lr}
c0d02090:	af02      	add	r7, sp, #8
c0d02092:	460d      	mov	r5, r1
c0d02094:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK; 
  
  switch (pdev->dev_state) 
c0d02096:	20fc      	movs	r0, #252	; 0xfc
c0d02098:	5c20      	ldrb	r0, [r4, r0]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d0209a:	2180      	movs	r1, #128	; 0x80
*/
USBD_StatusTypeDef  USBD_StdItfReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
  USBD_StatusTypeDef ret = USBD_OK; 
  
  switch (pdev->dev_state) 
c0d0209c:	2803      	cmp	r0, #3
c0d0209e:	d115      	bne.n	c0d020cc <USBD_StdItfReq+0x3e>
  {
  case USBD_STATE_CONFIGURED:
    
    if (LOBYTE(req->wIndex) <= USBD_MAX_NUM_INTERFACES) 
c0d020a0:	88a8      	ldrh	r0, [r5, #4]
c0d020a2:	22fe      	movs	r2, #254	; 0xfe
c0d020a4:	4002      	ands	r2, r0
c0d020a6:	2a01      	cmp	r2, #1
c0d020a8:	d810      	bhi.n	c0d020cc <USBD_StdItfReq+0x3e>
    {
      ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req); 
c0d020aa:	2045      	movs	r0, #69	; 0x45
c0d020ac:	0080      	lsls	r0, r0, #2
c0d020ae:	5820      	ldr	r0, [r4, r0]
c0d020b0:	6880      	ldr	r0, [r0, #8]
c0d020b2:	f7ff f98b 	bl	c0d013cc <pic>
c0d020b6:	4602      	mov	r2, r0
c0d020b8:	4620      	mov	r0, r4
c0d020ba:	4629      	mov	r1, r5
c0d020bc:	4790      	blx	r2
      
      if((req->wLength == 0)&& (ret == USBD_OK))
c0d020be:	88e8      	ldrh	r0, [r5, #6]
c0d020c0:	2800      	cmp	r0, #0
c0d020c2:	d10a      	bne.n	c0d020da <USBD_StdItfReq+0x4c>
      {
         USBD_CtlSendStatus(pdev);
c0d020c4:	4620      	mov	r0, r4
c0d020c6:	f000 f9ed 	bl	c0d024a4 <USBD_CtlSendStatus>
c0d020ca:	e006      	b.n	c0d020da <USBD_StdItfReq+0x4c>
c0d020cc:	4620      	mov	r0, r4
c0d020ce:	f7ff fbff 	bl	c0d018d0 <USBD_LL_StallEP>
c0d020d2:	2100      	movs	r1, #0
c0d020d4:	4620      	mov	r0, r4
c0d020d6:	f7ff fbfb 	bl	c0d018d0 <USBD_LL_StallEP>
    
  default:
     USBD_CtlError(pdev , req);
    break;
  }
  return USBD_OK;
c0d020da:	2000      	movs	r0, #0
c0d020dc:	bdb0      	pop	{r4, r5, r7, pc}

c0d020de <USBD_StdEPReq>:
* @param  pdev: device instance
* @param  req: usb request
* @retval status
*/
USBD_StatusTypeDef  USBD_StdEPReq (USBD_HandleTypeDef *pdev , USBD_SetupReqTypedef  *req)
{
c0d020de:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d020e0:	af03      	add	r7, sp, #12
c0d020e2:	b081      	sub	sp, #4
c0d020e4:	460e      	mov	r6, r1
c0d020e6:	4604      	mov	r4, r0
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
  
  /* Check if it is a class request */
  if ((req->bmRequest & 0x60) == 0x20)
c0d020e8:	7830      	ldrb	r0, [r6, #0]
c0d020ea:	2160      	movs	r1, #96	; 0x60
c0d020ec:	4001      	ands	r1, r0
c0d020ee:	2920      	cmp	r1, #32
c0d020f0:	d10a      	bne.n	c0d02108 <USBD_StdEPReq+0x2a>
  {
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
c0d020f2:	2045      	movs	r0, #69	; 0x45
c0d020f4:	0080      	lsls	r0, r0, #2
c0d020f6:	5820      	ldr	r0, [r4, r0]
c0d020f8:	6880      	ldr	r0, [r0, #8]
c0d020fa:	f7ff f967 	bl	c0d013cc <pic>
c0d020fe:	4602      	mov	r2, r0
c0d02100:	4620      	mov	r0, r4
c0d02102:	4631      	mov	r1, r6
c0d02104:	4790      	blx	r2
c0d02106:	e063      	b.n	c0d021d0 <USBD_StdEPReq+0xf2>
{
  
  uint8_t   ep_addr;
  USBD_StatusTypeDef ret = USBD_OK; 
  USBD_EndpointTypeDef   *pep;
  ep_addr  = LOBYTE(req->wIndex);   
c0d02108:	7935      	ldrb	r5, [r6, #4]
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
    
    return USBD_OK;
  }
  
  switch (req->bRequest) 
c0d0210a:	7870      	ldrb	r0, [r6, #1]

void USBD_CtlError( USBD_HandleTypeDef *pdev ,
                            USBD_SetupReqTypedef *req)
{
  UNUSED(req);
  USBD_LL_StallEP(pdev , 0x80);
c0d0210c:	2180      	movs	r1, #128	; 0x80
    ((Setup_t)PIC(pdev->pClass->Setup)) (pdev, req);
    
    return USBD_OK;
  }
  
  switch (req->bRequest) 
c0d0210e:	2800      	cmp	r0, #0
c0d02110:	d012      	beq.n	c0d02138 <USBD_StdEPReq+0x5a>
c0d02112:	2801      	cmp	r0, #1
c0d02114:	d019      	beq.n	c0d0214a <USBD_StdEPReq+0x6c>
c0d02116:	2803      	cmp	r0, #3
c0d02118:	d15a      	bne.n	c0d021d0 <USBD_StdEPReq+0xf2>
  {
    
  case USB_REQ_SET_FEATURE :
    
    switch (pdev->dev_state) 
c0d0211a:	20fc      	movs	r0, #252	; 0xfc
c0d0211c:	5c20      	ldrb	r0, [r4, r0]
c0d0211e:	2803      	cmp	r0, #3
c0d02120:	d117      	bne.n	c0d02152 <USBD_StdEPReq+0x74>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:   
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d02122:	8870      	ldrh	r0, [r6, #2]
c0d02124:	2800      	cmp	r0, #0
c0d02126:	d12d      	bne.n	c0d02184 <USBD_StdEPReq+0xa6>
      {
        if ((ep_addr != 0x00) && (ep_addr != 0x80)) 
c0d02128:	4329      	orrs	r1, r5
c0d0212a:	2980      	cmp	r1, #128	; 0x80
c0d0212c:	d02a      	beq.n	c0d02184 <USBD_StdEPReq+0xa6>
        { 
          USBD_LL_StallEP(pdev , ep_addr);
c0d0212e:	4620      	mov	r0, r4
c0d02130:	4629      	mov	r1, r5
c0d02132:	f7ff fbcd 	bl	c0d018d0 <USBD_LL_StallEP>
c0d02136:	e025      	b.n	c0d02184 <USBD_StdEPReq+0xa6>
      break;    
    }
    break;
    
  case USB_REQ_GET_STATUS:                  
    switch (pdev->dev_state) 
c0d02138:	20fc      	movs	r0, #252	; 0xfc
c0d0213a:	5c20      	ldrb	r0, [r4, r0]
c0d0213c:	2803      	cmp	r0, #3
c0d0213e:	d02f      	beq.n	c0d021a0 <USBD_StdEPReq+0xc2>
c0d02140:	2802      	cmp	r0, #2
c0d02142:	d10e      	bne.n	c0d02162 <USBD_StdEPReq+0x84>
    {
    case USBD_STATE_ADDRESSED:          
      if ((ep_addr & 0x7F) != 0x00) 
c0d02144:	0668      	lsls	r0, r5, #25
c0d02146:	d109      	bne.n	c0d0215c <USBD_StdEPReq+0x7e>
c0d02148:	e042      	b.n	c0d021d0 <USBD_StdEPReq+0xf2>
    }
    break;
    
  case USB_REQ_CLEAR_FEATURE :
    
    switch (pdev->dev_state) 
c0d0214a:	20fc      	movs	r0, #252	; 0xfc
c0d0214c:	5c20      	ldrb	r0, [r4, r0]
c0d0214e:	2803      	cmp	r0, #3
c0d02150:	d00f      	beq.n	c0d02172 <USBD_StdEPReq+0x94>
c0d02152:	2802      	cmp	r0, #2
c0d02154:	d105      	bne.n	c0d02162 <USBD_StdEPReq+0x84>
c0d02156:	4329      	orrs	r1, r5
c0d02158:	2980      	cmp	r1, #128	; 0x80
c0d0215a:	d039      	beq.n	c0d021d0 <USBD_StdEPReq+0xf2>
c0d0215c:	4620      	mov	r0, r4
c0d0215e:	4629      	mov	r1, r5
c0d02160:	e004      	b.n	c0d0216c <USBD_StdEPReq+0x8e>
c0d02162:	4620      	mov	r0, r4
c0d02164:	f7ff fbb4 	bl	c0d018d0 <USBD_LL_StallEP>
c0d02168:	2100      	movs	r1, #0
c0d0216a:	4620      	mov	r0, r4
c0d0216c:	f7ff fbb0 	bl	c0d018d0 <USBD_LL_StallEP>
c0d02170:	e02e      	b.n	c0d021d0 <USBD_StdEPReq+0xf2>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:   
      if (req->wValue == USB_FEATURE_EP_HALT)
c0d02172:	8870      	ldrh	r0, [r6, #2]
c0d02174:	2800      	cmp	r0, #0
c0d02176:	d12b      	bne.n	c0d021d0 <USBD_StdEPReq+0xf2>
      {
        if ((ep_addr & 0x7F) != 0x00) 
c0d02178:	0668      	lsls	r0, r5, #25
c0d0217a:	d00d      	beq.n	c0d02198 <USBD_StdEPReq+0xba>
        {        
          USBD_LL_ClearStallEP(pdev , ep_addr);
c0d0217c:	4620      	mov	r0, r4
c0d0217e:	4629      	mov	r1, r5
c0d02180:	f7ff fbcc 	bl	c0d0191c <USBD_LL_ClearStallEP>
c0d02184:	2045      	movs	r0, #69	; 0x45
c0d02186:	0080      	lsls	r0, r0, #2
c0d02188:	5820      	ldr	r0, [r4, r0]
c0d0218a:	6880      	ldr	r0, [r0, #8]
c0d0218c:	f7ff f91e 	bl	c0d013cc <pic>
c0d02190:	4602      	mov	r2, r0
c0d02192:	4620      	mov	r0, r4
c0d02194:	4631      	mov	r1, r6
c0d02196:	4790      	blx	r2
c0d02198:	4620      	mov	r0, r4
c0d0219a:	f000 f983 	bl	c0d024a4 <USBD_CtlSendStatus>
c0d0219e:	e017      	b.n	c0d021d0 <USBD_StdEPReq+0xf2>
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:
      pep = ((ep_addr & 0x80) == 0x80) ? &pdev->ep_in[ep_addr & 0x7F]:\
c0d021a0:	4626      	mov	r6, r4
c0d021a2:	3614      	adds	r6, #20
                                         &pdev->ep_out[ep_addr & 0x7F];
c0d021a4:	4620      	mov	r0, r4
c0d021a6:	3084      	adds	r0, #132	; 0x84
        USBD_LL_StallEP(pdev , ep_addr);
      }
      break;	
      
    case USBD_STATE_CONFIGURED:
      pep = ((ep_addr & 0x80) == 0x80) ? &pdev->ep_in[ep_addr & 0x7F]:\
c0d021a8:	420d      	tst	r5, r1
c0d021aa:	d100      	bne.n	c0d021ae <USBD_StdEPReq+0xd0>
c0d021ac:	4606      	mov	r6, r0
                                         &pdev->ep_out[ep_addr & 0x7F];
      if(USBD_LL_IsStallEP(pdev, ep_addr))
c0d021ae:	4620      	mov	r0, r4
c0d021b0:	4629      	mov	r1, r5
c0d021b2:	f7ff fbd9 	bl	c0d01968 <USBD_LL_IsStallEP>
c0d021b6:	2101      	movs	r1, #1
c0d021b8:	2800      	cmp	r0, #0
c0d021ba:	d100      	bne.n	c0d021be <USBD_StdEPReq+0xe0>
c0d021bc:	4601      	mov	r1, r0
c0d021be:	207f      	movs	r0, #127	; 0x7f
c0d021c0:	4005      	ands	r5, r0
c0d021c2:	0128      	lsls	r0, r5, #4
c0d021c4:	5031      	str	r1, [r6, r0]
c0d021c6:	1831      	adds	r1, r6, r0
      else
      {
        pep->status = 0x0000;  
      }
      
      USBD_CtlSendData (pdev,
c0d021c8:	2202      	movs	r2, #2
c0d021ca:	4620      	mov	r0, r4
c0d021cc:	f000 f93c 	bl	c0d02448 <USBD_CtlSendData>
    
  default:
    break;
  }
  return ret;
}
c0d021d0:	2000      	movs	r0, #0
c0d021d2:	b001      	add	sp, #4
c0d021d4:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d021d6 <USBD_ParseSetupRequest>:
* @retval None
*/

void USBD_ParseSetupRequest(USBD_SetupReqTypedef *req, uint8_t *pdata)
{
  req->bmRequest     = *(uint8_t *)  (pdata);
c0d021d6:	780a      	ldrb	r2, [r1, #0]
c0d021d8:	7002      	strb	r2, [r0, #0]
  req->bRequest      = *(uint8_t *)  (pdata +  1);
c0d021da:	784a      	ldrb	r2, [r1, #1]
c0d021dc:	7042      	strb	r2, [r0, #1]
  req->wValue        = SWAPBYTE      (pdata +  2);
c0d021de:	788a      	ldrb	r2, [r1, #2]
c0d021e0:	78cb      	ldrb	r3, [r1, #3]
c0d021e2:	021b      	lsls	r3, r3, #8
c0d021e4:	4313      	orrs	r3, r2
c0d021e6:	8043      	strh	r3, [r0, #2]
  req->wIndex        = SWAPBYTE      (pdata +  4);
c0d021e8:	790a      	ldrb	r2, [r1, #4]
c0d021ea:	794b      	ldrb	r3, [r1, #5]
c0d021ec:	021b      	lsls	r3, r3, #8
c0d021ee:	4313      	orrs	r3, r2
c0d021f0:	8083      	strh	r3, [r0, #4]
  req->wLength       = SWAPBYTE      (pdata +  6);
c0d021f2:	798a      	ldrb	r2, [r1, #6]
c0d021f4:	79c9      	ldrb	r1, [r1, #7]
c0d021f6:	0209      	lsls	r1, r1, #8
c0d021f8:	4311      	orrs	r1, r2
c0d021fa:	80c1      	strh	r1, [r0, #6]

}
c0d021fc:	4770      	bx	lr

c0d021fe <USBD_HID_Setup>:
  * @param  req: usb requests
  * @retval status
  */
uint8_t  USBD_HID_Setup (USBD_HandleTypeDef *pdev, 
                                USBD_SetupReqTypedef *req)
{
c0d021fe:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d02200:	af03      	add	r7, sp, #12
c0d02202:	b083      	sub	sp, #12
c0d02204:	460d      	mov	r5, r1
c0d02206:	4604      	mov	r4, r0
c0d02208:	a802      	add	r0, sp, #8
c0d0220a:	2600      	movs	r6, #0
  uint16_t len = 0;
c0d0220c:	8006      	strh	r6, [r0, #0]
c0d0220e:	a801      	add	r0, sp, #4
  uint8_t  *pbuf = NULL;

  uint8_t val = 0;
c0d02210:	7006      	strb	r6, [r0, #0]

  switch (req->bmRequest & USB_REQ_TYPE_MASK)
c0d02212:	7829      	ldrb	r1, [r5, #0]
c0d02214:	2060      	movs	r0, #96	; 0x60
c0d02216:	4008      	ands	r0, r1
c0d02218:	2800      	cmp	r0, #0
c0d0221a:	d010      	beq.n	c0d0223e <USBD_HID_Setup+0x40>
c0d0221c:	2820      	cmp	r0, #32
c0d0221e:	d139      	bne.n	c0d02294 <USBD_HID_Setup+0x96>
c0d02220:	7868      	ldrb	r0, [r5, #1]
  {
  case USB_REQ_TYPE_CLASS :  
    switch (req->bRequest)
c0d02222:	4601      	mov	r1, r0
c0d02224:	390a      	subs	r1, #10
c0d02226:	2902      	cmp	r1, #2
c0d02228:	d334      	bcc.n	c0d02294 <USBD_HID_Setup+0x96>
c0d0222a:	2802      	cmp	r0, #2
c0d0222c:	d01c      	beq.n	c0d02268 <USBD_HID_Setup+0x6a>
c0d0222e:	2803      	cmp	r0, #3
c0d02230:	d01a      	beq.n	c0d02268 <USBD_HID_Setup+0x6a>
                        (uint8_t *)&val,
                        1);      
      break;      
      
    default:
      USBD_CtlError (pdev, req);
c0d02232:	4620      	mov	r0, r4
c0d02234:	4629      	mov	r1, r5
c0d02236:	f7ff ff1f 	bl	c0d02078 <USBD_CtlError>
c0d0223a:	2602      	movs	r6, #2
c0d0223c:	e02a      	b.n	c0d02294 <USBD_HID_Setup+0x96>
      return USBD_FAIL; 
    }
    break;
    
  case USB_REQ_TYPE_STANDARD:
    switch (req->bRequest)
c0d0223e:	7868      	ldrb	r0, [r5, #1]
c0d02240:	280b      	cmp	r0, #11
c0d02242:	d014      	beq.n	c0d0226e <USBD_HID_Setup+0x70>
c0d02244:	280a      	cmp	r0, #10
c0d02246:	d00f      	beq.n	c0d02268 <USBD_HID_Setup+0x6a>
c0d02248:	2806      	cmp	r0, #6
c0d0224a:	d123      	bne.n	c0d02294 <USBD_HID_Setup+0x96>
    {
    case USB_REQ_GET_DESCRIPTOR: 
      // 0x22
      if( req->wValue >> 8 == HID_REPORT_DESC)
c0d0224c:	8868      	ldrh	r0, [r5, #2]
c0d0224e:	0a00      	lsrs	r0, r0, #8
c0d02250:	2600      	movs	r6, #0
c0d02252:	2821      	cmp	r0, #33	; 0x21
c0d02254:	d00f      	beq.n	c0d02276 <USBD_HID_Setup+0x78>
c0d02256:	2822      	cmp	r0, #34	; 0x22
      
      //USBD_CtlReceiveStatus(pdev);
      
      USBD_CtlSendData (pdev, 
                        pbuf,
                        len);
c0d02258:	4632      	mov	r2, r6
c0d0225a:	4631      	mov	r1, r6
c0d0225c:	d117      	bne.n	c0d0228e <USBD_HID_Setup+0x90>
c0d0225e:	a802      	add	r0, sp, #8
    {
    case USB_REQ_GET_DESCRIPTOR: 
      // 0x22
      if( req->wValue >> 8 == HID_REPORT_DESC)
      {
        pbuf =  USBD_HID_GetReportDescriptor_impl(&len);
c0d02260:	9000      	str	r0, [sp, #0]
c0d02262:	f000 f847 	bl	c0d022f4 <USBD_HID_GetReportDescriptor_impl>
c0d02266:	e00a      	b.n	c0d0227e <USBD_HID_Setup+0x80>
c0d02268:	a901      	add	r1, sp, #4
c0d0226a:	2201      	movs	r2, #1
c0d0226c:	e00f      	b.n	c0d0228e <USBD_HID_Setup+0x90>
                        len);
      break;

    case USB_REQ_SET_INTERFACE :
      //hhid->AltSetting = (uint8_t)(req->wValue);
      USBD_CtlSendStatus(pdev);
c0d0226e:	4620      	mov	r0, r4
c0d02270:	f000 f918 	bl	c0d024a4 <USBD_CtlSendStatus>
c0d02274:	e00e      	b.n	c0d02294 <USBD_HID_Setup+0x96>
c0d02276:	a802      	add	r0, sp, #8
        len = MIN(len , req->wLength);
      }
      // 0x21
      else if( req->wValue >> 8 == HID_DESCRIPTOR_TYPE)
      {
        pbuf = USBD_HID_GetHidDescriptor_impl(&len);
c0d02278:	9000      	str	r0, [sp, #0]
c0d0227a:	f000 f833 	bl	c0d022e4 <USBD_HID_GetHidDescriptor_impl>
c0d0227e:	9b00      	ldr	r3, [sp, #0]
c0d02280:	4601      	mov	r1, r0
c0d02282:	881a      	ldrh	r2, [r3, #0]
c0d02284:	88e8      	ldrh	r0, [r5, #6]
c0d02286:	4282      	cmp	r2, r0
c0d02288:	d300      	bcc.n	c0d0228c <USBD_HID_Setup+0x8e>
c0d0228a:	4602      	mov	r2, r0
c0d0228c:	801a      	strh	r2, [r3, #0]
c0d0228e:	4620      	mov	r0, r4
c0d02290:	f000 f8da 	bl	c0d02448 <USBD_CtlSendData>
      
    }
  }

  return USBD_OK;
}
c0d02294:	b2f0      	uxtb	r0, r6
c0d02296:	b003      	add	sp, #12
c0d02298:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d0229a <USBD_HID_Init>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_Init (USBD_HandleTypeDef *pdev, 
                               uint8_t cfgidx)
{
c0d0229a:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0229c:	af03      	add	r7, sp, #12
c0d0229e:	b081      	sub	sp, #4
c0d022a0:	4604      	mov	r4, r0
  UNUSED(cfgidx);

  /* Open EP IN */
  USBD_LL_OpenEP(pdev,
c0d022a2:	2182      	movs	r1, #130	; 0x82
c0d022a4:	2502      	movs	r5, #2
c0d022a6:	2640      	movs	r6, #64	; 0x40
c0d022a8:	462a      	mov	r2, r5
c0d022aa:	4633      	mov	r3, r6
c0d022ac:	f7ff fad0 	bl	c0d01850 <USBD_LL_OpenEP>
                 HID_EPIN_ADDR,
                 USBD_EP_TYPE_BULK,
                 HID_EPIN_SIZE);
  
  /* Open EP OUT */
  USBD_LL_OpenEP(pdev,
c0d022b0:	4620      	mov	r0, r4
c0d022b2:	4629      	mov	r1, r5
c0d022b4:	462a      	mov	r2, r5
c0d022b6:	4633      	mov	r3, r6
c0d022b8:	f7ff faca 	bl	c0d01850 <USBD_LL_OpenEP>
                 HID_EPOUT_ADDR,
                 USBD_EP_TYPE_BULK,
                 HID_EPOUT_SIZE);

        /* Prepare Out endpoint to receive 1st packet */ 
  USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR, HID_EPOUT_SIZE);
c0d022bc:	4620      	mov	r0, r4
c0d022be:	4629      	mov	r1, r5
c0d022c0:	4632      	mov	r2, r6
c0d022c2:	f7ff fb90 	bl	c0d019e6 <USBD_LL_PrepareReceive>
  USBD_LL_Transmit (pdev, 
                    HID_EPIN_ADDR,                                      
                    NULL,
                    0);
  */
  return USBD_OK;
c0d022c6:	2000      	movs	r0, #0
c0d022c8:	b001      	add	sp, #4
c0d022ca:	bdf0      	pop	{r4, r5, r6, r7, pc}

c0d022cc <USBD_HID_DeInit>:
  * @param  cfgidx: Configuration index
  * @retval status
  */
uint8_t  USBD_HID_DeInit (USBD_HandleTypeDef *pdev, 
                                 uint8_t cfgidx)
{
c0d022cc:	b5d0      	push	{r4, r6, r7, lr}
c0d022ce:	af02      	add	r7, sp, #8
c0d022d0:	4604      	mov	r4, r0
  UNUSED(cfgidx);
  /* Close HID EP IN */
  USBD_LL_CloseEP(pdev,
c0d022d2:	2182      	movs	r1, #130	; 0x82
c0d022d4:	f7ff fae4 	bl	c0d018a0 <USBD_LL_CloseEP>
                  HID_EPIN_ADDR);
  
  /* Close HID EP OUT */
  USBD_LL_CloseEP(pdev,
c0d022d8:	2102      	movs	r1, #2
c0d022da:	4620      	mov	r0, r4
c0d022dc:	f7ff fae0 	bl	c0d018a0 <USBD_LL_CloseEP>
                  HID_EPOUT_ADDR);
  
  return USBD_OK;
c0d022e0:	2000      	movs	r0, #0
c0d022e2:	bdd0      	pop	{r4, r6, r7, pc}

c0d022e4 <USBD_HID_GetHidDescriptor_impl>:
  *length = sizeof (USBD_CfgDesc);
  return (uint8_t*)USBD_CfgDesc;
}

uint8_t* USBD_HID_GetHidDescriptor_impl(uint16_t* len) {
  *len = sizeof(USBD_HID_Desc);
c0d022e4:	2109      	movs	r1, #9
c0d022e6:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_HID_Desc; 
c0d022e8:	4801      	ldr	r0, [pc, #4]	; (c0d022f0 <USBD_HID_GetHidDescriptor_impl+0xc>)
c0d022ea:	4478      	add	r0, pc
c0d022ec:	4770      	bx	lr
c0d022ee:	46c0      	nop			; (mov r8, r8)
c0d022f0:	00000596 	.word	0x00000596

c0d022f4 <USBD_HID_GetReportDescriptor_impl>:
}

uint8_t* USBD_HID_GetReportDescriptor_impl(uint16_t* len) {
  *len = sizeof(HID_ReportDesc);
c0d022f4:	2122      	movs	r1, #34	; 0x22
c0d022f6:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)HID_ReportDesc;
c0d022f8:	4801      	ldr	r0, [pc, #4]	; (c0d02300 <USBD_HID_GetReportDescriptor_impl+0xc>)
c0d022fa:	4478      	add	r0, pc
c0d022fc:	4770      	bx	lr
c0d022fe:	46c0      	nop			; (mov r8, r8)
c0d02300:	00000564 	.word	0x00000564

c0d02304 <USBD_HID_DataOut_impl>:
  */
extern volatile unsigned short G_io_apdu_length;

uint8_t  USBD_HID_DataOut_impl (USBD_HandleTypeDef *pdev, 
                              uint8_t epnum, uint8_t* buffer)
{
c0d02304:	b5b0      	push	{r4, r5, r7, lr}
c0d02306:	af02      	add	r7, sp, #8
c0d02308:	4614      	mov	r4, r2
  UNUSED(epnum);

  // prepare receiving the next chunk (masked time)
  USBD_LL_PrepareReceive(pdev, HID_EPOUT_ADDR , HID_EPOUT_SIZE);
c0d0230a:	2102      	movs	r1, #2
c0d0230c:	2240      	movs	r2, #64	; 0x40
c0d0230e:	f7ff fb6a 	bl	c0d019e6 <USBD_LL_PrepareReceive>

  // avoid troubles when an apdu has not been replied yet
  if (G_io_apdu_media == IO_APDU_MEDIA_NONE) {
c0d02312:	4d0d      	ldr	r5, [pc, #52]	; (c0d02348 <USBD_HID_DataOut_impl+0x44>)
c0d02314:	7828      	ldrb	r0, [r5, #0]
c0d02316:	2800      	cmp	r0, #0
c0d02318:	d113      	bne.n	c0d02342 <USBD_HID_DataOut_impl+0x3e>
    
    // add to the hid transport
    switch(io_usb_hid_receive(io_usb_send_apdu_data, buffer, io_seproxyhal_get_ep_rx_size(HID_EPOUT_ADDR))) {
c0d0231a:	2002      	movs	r0, #2
c0d0231c:	f7fe fc96 	bl	c0d00c4c <io_seproxyhal_get_ep_rx_size>
c0d02320:	4602      	mov	r2, r0
c0d02322:	480d      	ldr	r0, [pc, #52]	; (c0d02358 <USBD_HID_DataOut_impl+0x54>)
c0d02324:	4478      	add	r0, pc
c0d02326:	4621      	mov	r1, r4
c0d02328:	f7fe faf4 	bl	c0d00914 <io_usb_hid_receive>
c0d0232c:	2802      	cmp	r0, #2
c0d0232e:	d108      	bne.n	c0d02342 <USBD_HID_DataOut_impl+0x3e>
      default:
        break;

      case IO_USB_APDU_RECEIVED:
        G_io_apdu_media = IO_APDU_MEDIA_USB_HID; // for application code
c0d02330:	2001      	movs	r0, #1
c0d02332:	7028      	strb	r0, [r5, #0]
        G_io_apdu_state = APDU_USB_HID; // for next call to io_exchange
c0d02334:	4805      	ldr	r0, [pc, #20]	; (c0d0234c <USBD_HID_DataOut_impl+0x48>)
c0d02336:	2107      	movs	r1, #7
c0d02338:	7001      	strb	r1, [r0, #0]
        G_io_apdu_length = G_io_usb_hid_total_length;
c0d0233a:	4805      	ldr	r0, [pc, #20]	; (c0d02350 <USBD_HID_DataOut_impl+0x4c>)
c0d0233c:	6800      	ldr	r0, [r0, #0]
c0d0233e:	4905      	ldr	r1, [pc, #20]	; (c0d02354 <USBD_HID_DataOut_impl+0x50>)
c0d02340:	8008      	strh	r0, [r1, #0]
        break;
    }

  }
  return USBD_OK;
c0d02342:	2000      	movs	r0, #0
c0d02344:	bdb0      	pop	{r4, r5, r7, pc}
c0d02346:	46c0      	nop			; (mov r8, r8)
c0d02348:	20001b00 	.word	0x20001b00
c0d0234c:	20001b08 	.word	0x20001b08
c0d02350:	200019f0 	.word	0x200019f0
c0d02354:	20001b0c 	.word	0x20001b0c
c0d02358:	ffffea7d 	.word	0xffffea7d

c0d0235c <USB_power>:
  USBD_GetCfgDesc_impl, 
  USBD_GetCfgDesc_impl,
  USBD_GetDeviceQualifierDesc_impl,
};

void USB_power(unsigned char enabled) {
c0d0235c:	b5f0      	push	{r4, r5, r6, r7, lr}
c0d0235e:	af03      	add	r7, sp, #12
c0d02360:	b081      	sub	sp, #4
c0d02362:	4604      	mov	r4, r0
c0d02364:	2049      	movs	r0, #73	; 0x49
c0d02366:	0085      	lsls	r5, r0, #2
  os_memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d02368:	4810      	ldr	r0, [pc, #64]	; (c0d023ac <USB_power+0x50>)
c0d0236a:	2100      	movs	r1, #0
c0d0236c:	462a      	mov	r2, r5
c0d0236e:	f7fe fb7d 	bl	c0d00a6c <os_memset>

  if (enabled) {
c0d02372:	2c00      	cmp	r4, #0
c0d02374:	d015      	beq.n	c0d023a2 <USB_power+0x46>
    os_memset(&USBD_Device, 0, sizeof(USBD_Device));
c0d02376:	4c0d      	ldr	r4, [pc, #52]	; (c0d023ac <USB_power+0x50>)
c0d02378:	2600      	movs	r6, #0
c0d0237a:	4620      	mov	r0, r4
c0d0237c:	4631      	mov	r1, r6
c0d0237e:	462a      	mov	r2, r5
c0d02380:	f7fe fb74 	bl	c0d00a6c <os_memset>
    /* Init Device Library */
    USBD_Init(&USBD_Device, (USBD_DescriptorsTypeDef*)&HID_Desc, 0);
c0d02384:	490a      	ldr	r1, [pc, #40]	; (c0d023b0 <USB_power+0x54>)
c0d02386:	4479      	add	r1, pc
c0d02388:	4620      	mov	r0, r4
c0d0238a:	4632      	mov	r2, r6
c0d0238c:	f7ff fb3f 	bl	c0d01a0e <USBD_Init>
    
    /* Register the HID class */
    USBD_RegisterClass(&USBD_Device, (USBD_ClassTypeDef*)&USBD_HID);
c0d02390:	4908      	ldr	r1, [pc, #32]	; (c0d023b4 <USB_power+0x58>)
c0d02392:	4479      	add	r1, pc
c0d02394:	4620      	mov	r0, r4
c0d02396:	f7ff fb72 	bl	c0d01a7e <USBD_RegisterClass>

    /* Start Device Process */
    USBD_Start(&USBD_Device);
c0d0239a:	4620      	mov	r0, r4
c0d0239c:	f7ff fb78 	bl	c0d01a90 <USBD_Start>
c0d023a0:	e002      	b.n	c0d023a8 <USB_power+0x4c>
  }
  else {
    USBD_DeInit(&USBD_Device);
c0d023a2:	4802      	ldr	r0, [pc, #8]	; (c0d023ac <USB_power+0x50>)
c0d023a4:	f7ff fb51 	bl	c0d01a4a <USBD_DeInit>
  }
}
c0d023a8:	b001      	add	sp, #4
c0d023aa:	bdf0      	pop	{r4, r5, r6, r7, pc}
c0d023ac:	20001b24 	.word	0x20001b24
c0d023b0:	00000516 	.word	0x00000516
c0d023b4:	00000546 	.word	0x00000546

c0d023b8 <USBD_DeviceDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_DeviceDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_DeviceDesc);
c0d023b8:	2012      	movs	r0, #18
c0d023ba:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_DeviceDesc;
c0d023bc:	4801      	ldr	r0, [pc, #4]	; (c0d023c4 <USBD_DeviceDescriptor+0xc>)
c0d023be:	4478      	add	r0, pc
c0d023c0:	4770      	bx	lr
c0d023c2:	46c0      	nop			; (mov r8, r8)
c0d023c4:	000004cb 	.word	0x000004cb

c0d023c8 <USBD_LangIDStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_LangIDStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_LangIDDesc);  
c0d023c8:	2004      	movs	r0, #4
c0d023ca:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_LangIDDesc;
c0d023cc:	4801      	ldr	r0, [pc, #4]	; (c0d023d4 <USBD_LangIDStrDescriptor+0xc>)
c0d023ce:	4478      	add	r0, pc
c0d023d0:	4770      	bx	lr
c0d023d2:	46c0      	nop			; (mov r8, r8)
c0d023d4:	000004ee 	.word	0x000004ee

c0d023d8 <USBD_ManufacturerStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ManufacturerStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_MANUFACTURER_STRING);
c0d023d8:	200e      	movs	r0, #14
c0d023da:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_MANUFACTURER_STRING;
c0d023dc:	4801      	ldr	r0, [pc, #4]	; (c0d023e4 <USBD_ManufacturerStrDescriptor+0xc>)
c0d023de:	4478      	add	r0, pc
c0d023e0:	4770      	bx	lr
c0d023e2:	46c0      	nop			; (mov r8, r8)
c0d023e4:	000004e2 	.word	0x000004e2

c0d023e8 <USBD_ProductStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ProductStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_PRODUCT_FS_STRING);
c0d023e8:	200e      	movs	r0, #14
c0d023ea:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_PRODUCT_FS_STRING;
c0d023ec:	4801      	ldr	r0, [pc, #4]	; (c0d023f4 <USBD_ProductStrDescriptor+0xc>)
c0d023ee:	4478      	add	r0, pc
c0d023f0:	4770      	bx	lr
c0d023f2:	46c0      	nop			; (mov r8, r8)
c0d023f4:	00000462 	.word	0x00000462

c0d023f8 <USBD_SerialStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_SerialStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USB_SERIAL_STRING);
c0d023f8:	200a      	movs	r0, #10
c0d023fa:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USB_SERIAL_STRING;
c0d023fc:	4801      	ldr	r0, [pc, #4]	; (c0d02404 <USBD_SerialStrDescriptor+0xc>)
c0d023fe:	4478      	add	r0, pc
c0d02400:	4770      	bx	lr
c0d02402:	46c0      	nop			; (mov r8, r8)
c0d02404:	000004d0 	.word	0x000004d0

c0d02408 <USBD_ConfigStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_ConfigStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_CONFIGURATION_FS_STRING);
c0d02408:	200e      	movs	r0, #14
c0d0240a:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_CONFIGURATION_FS_STRING;
c0d0240c:	4801      	ldr	r0, [pc, #4]	; (c0d02414 <USBD_ConfigStrDescriptor+0xc>)
c0d0240e:	4478      	add	r0, pc
c0d02410:	4770      	bx	lr
c0d02412:	46c0      	nop			; (mov r8, r8)
c0d02414:	00000442 	.word	0x00000442

c0d02418 <USBD_InterfaceStrDescriptor>:
  * @retval Pointer to descriptor buffer
  */
static uint8_t *USBD_InterfaceStrDescriptor(USBD_SpeedTypeDef speed, uint16_t *length)
{
  UNUSED(speed);
  *length = sizeof(USBD_INTERFACE_FS_STRING);
c0d02418:	200e      	movs	r0, #14
c0d0241a:	8008      	strh	r0, [r1, #0]
  return (uint8_t*)USBD_INTERFACE_FS_STRING;
c0d0241c:	4801      	ldr	r0, [pc, #4]	; (c0d02424 <USBD_InterfaceStrDescriptor+0xc>)
c0d0241e:	4478      	add	r0, pc
c0d02420:	4770      	bx	lr
c0d02422:	46c0      	nop			; (mov r8, r8)
c0d02424:	00000432 	.word	0x00000432

c0d02428 <USBD_GetCfgDesc_impl>:
  * @param  length : pointer data length
  * @retval pointer to descriptor buffer
  */
static uint8_t  *USBD_GetCfgDesc_impl (uint16_t *length)
{
  *length = sizeof (USBD_CfgDesc);
c0d02428:	2129      	movs	r1, #41	; 0x29
c0d0242a:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_CfgDesc;
c0d0242c:	4801      	ldr	r0, [pc, #4]	; (c0d02434 <USBD_GetCfgDesc_impl+0xc>)
c0d0242e:	4478      	add	r0, pc
c0d02430:	4770      	bx	lr
c0d02432:	46c0      	nop			; (mov r8, r8)
c0d02434:	000004e2 	.word	0x000004e2

c0d02438 <USBD_GetDeviceQualifierDesc_impl>:
* @param  length : pointer data length
* @retval pointer to descriptor buffer
*/
static uint8_t  *USBD_GetDeviceQualifierDesc_impl (uint16_t *length)
{
  *length = sizeof (USBD_DeviceQualifierDesc);
c0d02438:	210a      	movs	r1, #10
c0d0243a:	8001      	strh	r1, [r0, #0]
  return (uint8_t*)USBD_DeviceQualifierDesc;
c0d0243c:	4801      	ldr	r0, [pc, #4]	; (c0d02444 <USBD_GetDeviceQualifierDesc_impl+0xc>)
c0d0243e:	4478      	add	r0, pc
c0d02440:	4770      	bx	lr
c0d02442:	46c0      	nop			; (mov r8, r8)
c0d02444:	000004fe 	.word	0x000004fe

c0d02448 <USBD_CtlSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendData (USBD_HandleTypeDef  *pdev, 
                               uint8_t *pbuf,
                               uint16_t len)
{
c0d02448:	b5b0      	push	{r4, r5, r7, lr}
c0d0244a:	af02      	add	r7, sp, #8
c0d0244c:	460c      	mov	r4, r1
  /* Set EP0 State */
  pdev->ep0_state          = USBD_EP0_DATA_IN;                                      
c0d0244e:	21f4      	movs	r1, #244	; 0xf4
c0d02450:	2302      	movs	r3, #2
c0d02452:	5043      	str	r3, [r0, r1]
  pdev->ep_in[0].total_length = len;
c0d02454:	6182      	str	r2, [r0, #24]
  pdev->ep_in[0].rem_length   = len;
c0d02456:	61c2      	str	r2, [r0, #28]
  // store the continuation data if needed
  pdev->pData = pbuf;
c0d02458:	2109      	movs	r1, #9
c0d0245a:	0149      	lsls	r1, r1, #5
c0d0245c:	5044      	str	r4, [r0, r1]
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));  
c0d0245e:	6a01      	ldr	r1, [r0, #32]
c0d02460:	428a      	cmp	r2, r1
c0d02462:	d300      	bcc.n	c0d02466 <USBD_CtlSendData+0x1e>
c0d02464:	460a      	mov	r2, r1
c0d02466:	b293      	uxth	r3, r2
c0d02468:	2500      	movs	r5, #0
c0d0246a:	4629      	mov	r1, r5
c0d0246c:	4622      	mov	r2, r4
c0d0246e:	f7ff faa0 	bl	c0d019b2 <USBD_LL_Transmit>
  
  return USBD_OK;
c0d02472:	4628      	mov	r0, r5
c0d02474:	bdb0      	pop	{r4, r5, r7, pc}

c0d02476 <USBD_CtlContinueSendData>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueSendData (USBD_HandleTypeDef  *pdev, 
                                       uint8_t *pbuf,
                                       uint16_t len)
{
c0d02476:	b5b0      	push	{r4, r5, r7, lr}
c0d02478:	af02      	add	r7, sp, #8
c0d0247a:	460c      	mov	r4, r1
 /* Start the next transfer */
  USBD_LL_Transmit (pdev, 0x00, pbuf, MIN(len, pdev->ep_in[0].maxpacket));   
c0d0247c:	6a01      	ldr	r1, [r0, #32]
c0d0247e:	428a      	cmp	r2, r1
c0d02480:	d300      	bcc.n	c0d02484 <USBD_CtlContinueSendData+0xe>
c0d02482:	460a      	mov	r2, r1
c0d02484:	b293      	uxth	r3, r2
c0d02486:	2500      	movs	r5, #0
c0d02488:	4629      	mov	r1, r5
c0d0248a:	4622      	mov	r2, r4
c0d0248c:	f7ff fa91 	bl	c0d019b2 <USBD_LL_Transmit>
  return USBD_OK;
c0d02490:	4628      	mov	r0, r5
c0d02492:	bdb0      	pop	{r4, r5, r7, pc}

c0d02494 <USBD_CtlContinueRx>:
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlContinueRx (USBD_HandleTypeDef  *pdev, 
                                          uint8_t *pbuf,                                          
                                          uint16_t len)
{
c0d02494:	b5d0      	push	{r4, r6, r7, lr}
c0d02496:	af02      	add	r7, sp, #8
c0d02498:	2400      	movs	r4, #0
  UNUSED(pbuf);
  USBD_LL_PrepareReceive (pdev,
c0d0249a:	4621      	mov	r1, r4
c0d0249c:	f7ff faa3 	bl	c0d019e6 <USBD_LL_PrepareReceive>
                          0,                                            
                          len);
  return USBD_OK;
c0d024a0:	4620      	mov	r0, r4
c0d024a2:	bdd0      	pop	{r4, r6, r7, pc}

c0d024a4 <USBD_CtlSendStatus>:
*         send zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlSendStatus (USBD_HandleTypeDef  *pdev)
{
c0d024a4:	b5d0      	push	{r4, r6, r7, lr}
c0d024a6:	af02      	add	r7, sp, #8

  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_IN;
c0d024a8:	21f4      	movs	r1, #244	; 0xf4
c0d024aa:	2204      	movs	r2, #4
c0d024ac:	5042      	str	r2, [r0, r1]
c0d024ae:	2400      	movs	r4, #0
  
 /* Start the transfer */
  USBD_LL_Transmit (pdev, 0x00, NULL, 0);   
c0d024b0:	4621      	mov	r1, r4
c0d024b2:	4622      	mov	r2, r4
c0d024b4:	4623      	mov	r3, r4
c0d024b6:	f7ff fa7c 	bl	c0d019b2 <USBD_LL_Transmit>
  
  return USBD_OK;
c0d024ba:	4620      	mov	r0, r4
c0d024bc:	bdd0      	pop	{r4, r6, r7, pc}

c0d024be <USBD_CtlReceiveStatus>:
*         receive zero lzngth packet on the ctl pipe
* @param  pdev: device instance
* @retval status
*/
USBD_StatusTypeDef  USBD_CtlReceiveStatus (USBD_HandleTypeDef  *pdev)
{
c0d024be:	b5d0      	push	{r4, r6, r7, lr}
c0d024c0:	af02      	add	r7, sp, #8
  /* Set EP0 State */
  pdev->ep0_state = USBD_EP0_STATUS_OUT; 
c0d024c2:	21f4      	movs	r1, #244	; 0xf4
c0d024c4:	2205      	movs	r2, #5
c0d024c6:	5042      	str	r2, [r0, r1]
c0d024c8:	2400      	movs	r4, #0
  
 /* Start the transfer */  
  USBD_LL_PrepareReceive ( pdev,
c0d024ca:	4621      	mov	r1, r4
c0d024cc:	4622      	mov	r2, r4
c0d024ce:	f7ff fa8a 	bl	c0d019e6 <USBD_LL_PrepareReceive>
                    0,
                    0);  

  return USBD_OK;
c0d024d2:	4620      	mov	r0, r4
c0d024d4:	bdd0      	pop	{r4, r6, r7, pc}
	...

c0d024d8 <__aeabi_uidiv>:
c0d024d8:	2200      	movs	r2, #0
c0d024da:	0843      	lsrs	r3, r0, #1
c0d024dc:	428b      	cmp	r3, r1
c0d024de:	d374      	bcc.n	c0d025ca <__aeabi_uidiv+0xf2>
c0d024e0:	0903      	lsrs	r3, r0, #4
c0d024e2:	428b      	cmp	r3, r1
c0d024e4:	d35f      	bcc.n	c0d025a6 <__aeabi_uidiv+0xce>
c0d024e6:	0a03      	lsrs	r3, r0, #8
c0d024e8:	428b      	cmp	r3, r1
c0d024ea:	d344      	bcc.n	c0d02576 <__aeabi_uidiv+0x9e>
c0d024ec:	0b03      	lsrs	r3, r0, #12
c0d024ee:	428b      	cmp	r3, r1
c0d024f0:	d328      	bcc.n	c0d02544 <__aeabi_uidiv+0x6c>
c0d024f2:	0c03      	lsrs	r3, r0, #16
c0d024f4:	428b      	cmp	r3, r1
c0d024f6:	d30d      	bcc.n	c0d02514 <__aeabi_uidiv+0x3c>
c0d024f8:	22ff      	movs	r2, #255	; 0xff
c0d024fa:	0209      	lsls	r1, r1, #8
c0d024fc:	ba12      	rev	r2, r2
c0d024fe:	0c03      	lsrs	r3, r0, #16
c0d02500:	428b      	cmp	r3, r1
c0d02502:	d302      	bcc.n	c0d0250a <__aeabi_uidiv+0x32>
c0d02504:	1212      	asrs	r2, r2, #8
c0d02506:	0209      	lsls	r1, r1, #8
c0d02508:	d065      	beq.n	c0d025d6 <__aeabi_uidiv+0xfe>
c0d0250a:	0b03      	lsrs	r3, r0, #12
c0d0250c:	428b      	cmp	r3, r1
c0d0250e:	d319      	bcc.n	c0d02544 <__aeabi_uidiv+0x6c>
c0d02510:	e000      	b.n	c0d02514 <__aeabi_uidiv+0x3c>
c0d02512:	0a09      	lsrs	r1, r1, #8
c0d02514:	0bc3      	lsrs	r3, r0, #15
c0d02516:	428b      	cmp	r3, r1
c0d02518:	d301      	bcc.n	c0d0251e <__aeabi_uidiv+0x46>
c0d0251a:	03cb      	lsls	r3, r1, #15
c0d0251c:	1ac0      	subs	r0, r0, r3
c0d0251e:	4152      	adcs	r2, r2
c0d02520:	0b83      	lsrs	r3, r0, #14
c0d02522:	428b      	cmp	r3, r1
c0d02524:	d301      	bcc.n	c0d0252a <__aeabi_uidiv+0x52>
c0d02526:	038b      	lsls	r3, r1, #14
c0d02528:	1ac0      	subs	r0, r0, r3
c0d0252a:	4152      	adcs	r2, r2
c0d0252c:	0b43      	lsrs	r3, r0, #13
c0d0252e:	428b      	cmp	r3, r1
c0d02530:	d301      	bcc.n	c0d02536 <__aeabi_uidiv+0x5e>
c0d02532:	034b      	lsls	r3, r1, #13
c0d02534:	1ac0      	subs	r0, r0, r3
c0d02536:	4152      	adcs	r2, r2
c0d02538:	0b03      	lsrs	r3, r0, #12
c0d0253a:	428b      	cmp	r3, r1
c0d0253c:	d301      	bcc.n	c0d02542 <__aeabi_uidiv+0x6a>
c0d0253e:	030b      	lsls	r3, r1, #12
c0d02540:	1ac0      	subs	r0, r0, r3
c0d02542:	4152      	adcs	r2, r2
c0d02544:	0ac3      	lsrs	r3, r0, #11
c0d02546:	428b      	cmp	r3, r1
c0d02548:	d301      	bcc.n	c0d0254e <__aeabi_uidiv+0x76>
c0d0254a:	02cb      	lsls	r3, r1, #11
c0d0254c:	1ac0      	subs	r0, r0, r3
c0d0254e:	4152      	adcs	r2, r2
c0d02550:	0a83      	lsrs	r3, r0, #10
c0d02552:	428b      	cmp	r3, r1
c0d02554:	d301      	bcc.n	c0d0255a <__aeabi_uidiv+0x82>
c0d02556:	028b      	lsls	r3, r1, #10
c0d02558:	1ac0      	subs	r0, r0, r3
c0d0255a:	4152      	adcs	r2, r2
c0d0255c:	0a43      	lsrs	r3, r0, #9
c0d0255e:	428b      	cmp	r3, r1
c0d02560:	d301      	bcc.n	c0d02566 <__aeabi_uidiv+0x8e>
c0d02562:	024b      	lsls	r3, r1, #9
c0d02564:	1ac0      	subs	r0, r0, r3
c0d02566:	4152      	adcs	r2, r2
c0d02568:	0a03      	lsrs	r3, r0, #8
c0d0256a:	428b      	cmp	r3, r1
c0d0256c:	d301      	bcc.n	c0d02572 <__aeabi_uidiv+0x9a>
c0d0256e:	020b      	lsls	r3, r1, #8
c0d02570:	1ac0      	subs	r0, r0, r3
c0d02572:	4152      	adcs	r2, r2
c0d02574:	d2cd      	bcs.n	c0d02512 <__aeabi_uidiv+0x3a>
c0d02576:	09c3      	lsrs	r3, r0, #7
c0d02578:	428b      	cmp	r3, r1
c0d0257a:	d301      	bcc.n	c0d02580 <__aeabi_uidiv+0xa8>
c0d0257c:	01cb      	lsls	r3, r1, #7
c0d0257e:	1ac0      	subs	r0, r0, r3
c0d02580:	4152      	adcs	r2, r2
c0d02582:	0983      	lsrs	r3, r0, #6
c0d02584:	428b      	cmp	r3, r1
c0d02586:	d301      	bcc.n	c0d0258c <__aeabi_uidiv+0xb4>
c0d02588:	018b      	lsls	r3, r1, #6
c0d0258a:	1ac0      	subs	r0, r0, r3
c0d0258c:	4152      	adcs	r2, r2
c0d0258e:	0943      	lsrs	r3, r0, #5
c0d02590:	428b      	cmp	r3, r1
c0d02592:	d301      	bcc.n	c0d02598 <__aeabi_uidiv+0xc0>
c0d02594:	014b      	lsls	r3, r1, #5
c0d02596:	1ac0      	subs	r0, r0, r3
c0d02598:	4152      	adcs	r2, r2
c0d0259a:	0903      	lsrs	r3, r0, #4
c0d0259c:	428b      	cmp	r3, r1
c0d0259e:	d301      	bcc.n	c0d025a4 <__aeabi_uidiv+0xcc>
c0d025a0:	010b      	lsls	r3, r1, #4
c0d025a2:	1ac0      	subs	r0, r0, r3
c0d025a4:	4152      	adcs	r2, r2
c0d025a6:	08c3      	lsrs	r3, r0, #3
c0d025a8:	428b      	cmp	r3, r1
c0d025aa:	d301      	bcc.n	c0d025b0 <__aeabi_uidiv+0xd8>
c0d025ac:	00cb      	lsls	r3, r1, #3
c0d025ae:	1ac0      	subs	r0, r0, r3
c0d025b0:	4152      	adcs	r2, r2
c0d025b2:	0883      	lsrs	r3, r0, #2
c0d025b4:	428b      	cmp	r3, r1
c0d025b6:	d301      	bcc.n	c0d025bc <__aeabi_uidiv+0xe4>
c0d025b8:	008b      	lsls	r3, r1, #2
c0d025ba:	1ac0      	subs	r0, r0, r3
c0d025bc:	4152      	adcs	r2, r2
c0d025be:	0843      	lsrs	r3, r0, #1
c0d025c0:	428b      	cmp	r3, r1
c0d025c2:	d301      	bcc.n	c0d025c8 <__aeabi_uidiv+0xf0>
c0d025c4:	004b      	lsls	r3, r1, #1
c0d025c6:	1ac0      	subs	r0, r0, r3
c0d025c8:	4152      	adcs	r2, r2
c0d025ca:	1a41      	subs	r1, r0, r1
c0d025cc:	d200      	bcs.n	c0d025d0 <__aeabi_uidiv+0xf8>
c0d025ce:	4601      	mov	r1, r0
c0d025d0:	4152      	adcs	r2, r2
c0d025d2:	4610      	mov	r0, r2
c0d025d4:	4770      	bx	lr
c0d025d6:	e7ff      	b.n	c0d025d8 <__aeabi_uidiv+0x100>
c0d025d8:	b501      	push	{r0, lr}
c0d025da:	2000      	movs	r0, #0
c0d025dc:	f000 f806 	bl	c0d025ec <__aeabi_idiv0>
c0d025e0:	bd02      	pop	{r1, pc}
c0d025e2:	46c0      	nop			; (mov r8, r8)

c0d025e4 <__aeabi_uidivmod>:
c0d025e4:	2900      	cmp	r1, #0
c0d025e6:	d0f7      	beq.n	c0d025d8 <__aeabi_uidiv+0x100>
c0d025e8:	e776      	b.n	c0d024d8 <__aeabi_uidiv>
c0d025ea:	4770      	bx	lr

c0d025ec <__aeabi_idiv0>:
c0d025ec:	4770      	bx	lr
c0d025ee:	46c0      	nop			; (mov r8, r8)

c0d025f0 <__aeabi_memclr>:
c0d025f0:	b510      	push	{r4, lr}
c0d025f2:	2200      	movs	r2, #0
c0d025f4:	f000 f802 	bl	c0d025fc <__aeabi_memset>
c0d025f8:	bd10      	pop	{r4, pc}
c0d025fa:	46c0      	nop			; (mov r8, r8)

c0d025fc <__aeabi_memset>:
c0d025fc:	0013      	movs	r3, r2
c0d025fe:	b510      	push	{r4, lr}
c0d02600:	000a      	movs	r2, r1
c0d02602:	0019      	movs	r1, r3
c0d02604:	f000 f802 	bl	c0d0260c <memset>
c0d02608:	bd10      	pop	{r4, pc}
c0d0260a:	46c0      	nop			; (mov r8, r8)

c0d0260c <memset>:
c0d0260c:	b570      	push	{r4, r5, r6, lr}
c0d0260e:	0783      	lsls	r3, r0, #30
c0d02610:	d03f      	beq.n	c0d02692 <memset+0x86>
c0d02612:	1e54      	subs	r4, r2, #1
c0d02614:	2a00      	cmp	r2, #0
c0d02616:	d03b      	beq.n	c0d02690 <memset+0x84>
c0d02618:	b2ce      	uxtb	r6, r1
c0d0261a:	0003      	movs	r3, r0
c0d0261c:	2503      	movs	r5, #3
c0d0261e:	e003      	b.n	c0d02628 <memset+0x1c>
c0d02620:	1e62      	subs	r2, r4, #1
c0d02622:	2c00      	cmp	r4, #0
c0d02624:	d034      	beq.n	c0d02690 <memset+0x84>
c0d02626:	0014      	movs	r4, r2
c0d02628:	3301      	adds	r3, #1
c0d0262a:	1e5a      	subs	r2, r3, #1
c0d0262c:	7016      	strb	r6, [r2, #0]
c0d0262e:	422b      	tst	r3, r5
c0d02630:	d1f6      	bne.n	c0d02620 <memset+0x14>
c0d02632:	2c03      	cmp	r4, #3
c0d02634:	d924      	bls.n	c0d02680 <memset+0x74>
c0d02636:	25ff      	movs	r5, #255	; 0xff
c0d02638:	400d      	ands	r5, r1
c0d0263a:	022a      	lsls	r2, r5, #8
c0d0263c:	4315      	orrs	r5, r2
c0d0263e:	042a      	lsls	r2, r5, #16
c0d02640:	4315      	orrs	r5, r2
c0d02642:	2c0f      	cmp	r4, #15
c0d02644:	d911      	bls.n	c0d0266a <memset+0x5e>
c0d02646:	0026      	movs	r6, r4
c0d02648:	3e10      	subs	r6, #16
c0d0264a:	0936      	lsrs	r6, r6, #4
c0d0264c:	3601      	adds	r6, #1
c0d0264e:	0136      	lsls	r6, r6, #4
c0d02650:	001a      	movs	r2, r3
c0d02652:	199b      	adds	r3, r3, r6
c0d02654:	6015      	str	r5, [r2, #0]
c0d02656:	6055      	str	r5, [r2, #4]
c0d02658:	6095      	str	r5, [r2, #8]
c0d0265a:	60d5      	str	r5, [r2, #12]
c0d0265c:	3210      	adds	r2, #16
c0d0265e:	4293      	cmp	r3, r2
c0d02660:	d1f8      	bne.n	c0d02654 <memset+0x48>
c0d02662:	220f      	movs	r2, #15
c0d02664:	4014      	ands	r4, r2
c0d02666:	2c03      	cmp	r4, #3
c0d02668:	d90a      	bls.n	c0d02680 <memset+0x74>
c0d0266a:	1f26      	subs	r6, r4, #4
c0d0266c:	08b6      	lsrs	r6, r6, #2
c0d0266e:	3601      	adds	r6, #1
c0d02670:	00b6      	lsls	r6, r6, #2
c0d02672:	001a      	movs	r2, r3
c0d02674:	199b      	adds	r3, r3, r6
c0d02676:	c220      	stmia	r2!, {r5}
c0d02678:	4293      	cmp	r3, r2
c0d0267a:	d1fc      	bne.n	c0d02676 <memset+0x6a>
c0d0267c:	2203      	movs	r2, #3
c0d0267e:	4014      	ands	r4, r2
c0d02680:	2c00      	cmp	r4, #0
c0d02682:	d005      	beq.n	c0d02690 <memset+0x84>
c0d02684:	b2c9      	uxtb	r1, r1
c0d02686:	191c      	adds	r4, r3, r4
c0d02688:	7019      	strb	r1, [r3, #0]
c0d0268a:	3301      	adds	r3, #1
c0d0268c:	429c      	cmp	r4, r3
c0d0268e:	d1fb      	bne.n	c0d02688 <memset+0x7c>
c0d02690:	bd70      	pop	{r4, r5, r6, pc}
c0d02692:	0014      	movs	r4, r2
c0d02694:	0003      	movs	r3, r0
c0d02696:	e7cc      	b.n	c0d02632 <memset+0x26>

c0d02698 <setjmp>:
c0d02698:	c0f0      	stmia	r0!, {r4, r5, r6, r7}
c0d0269a:	4641      	mov	r1, r8
c0d0269c:	464a      	mov	r2, r9
c0d0269e:	4653      	mov	r3, sl
c0d026a0:	465c      	mov	r4, fp
c0d026a2:	466d      	mov	r5, sp
c0d026a4:	4676      	mov	r6, lr
c0d026a6:	c07e      	stmia	r0!, {r1, r2, r3, r4, r5, r6}
c0d026a8:	3828      	subs	r0, #40	; 0x28
c0d026aa:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d026ac:	2000      	movs	r0, #0
c0d026ae:	4770      	bx	lr

c0d026b0 <longjmp>:
c0d026b0:	3010      	adds	r0, #16
c0d026b2:	c87c      	ldmia	r0!, {r2, r3, r4, r5, r6}
c0d026b4:	4690      	mov	r8, r2
c0d026b6:	4699      	mov	r9, r3
c0d026b8:	46a2      	mov	sl, r4
c0d026ba:	46ab      	mov	fp, r5
c0d026bc:	46b5      	mov	sp, r6
c0d026be:	c808      	ldmia	r0!, {r3}
c0d026c0:	3828      	subs	r0, #40	; 0x28
c0d026c2:	c8f0      	ldmia	r0!, {r4, r5, r6, r7}
c0d026c4:	1c08      	adds	r0, r1, #0
c0d026c6:	d100      	bne.n	c0d026ca <longjmp+0x1a>
c0d026c8:	2001      	movs	r0, #1
c0d026ca:	4718      	bx	r3

c0d026cc <strlen>:
c0d026cc:	b510      	push	{r4, lr}
c0d026ce:	0783      	lsls	r3, r0, #30
c0d026d0:	d027      	beq.n	c0d02722 <strlen+0x56>
c0d026d2:	7803      	ldrb	r3, [r0, #0]
c0d026d4:	2b00      	cmp	r3, #0
c0d026d6:	d026      	beq.n	c0d02726 <strlen+0x5a>
c0d026d8:	0003      	movs	r3, r0
c0d026da:	2103      	movs	r1, #3
c0d026dc:	e002      	b.n	c0d026e4 <strlen+0x18>
c0d026de:	781a      	ldrb	r2, [r3, #0]
c0d026e0:	2a00      	cmp	r2, #0
c0d026e2:	d01c      	beq.n	c0d0271e <strlen+0x52>
c0d026e4:	3301      	adds	r3, #1
c0d026e6:	420b      	tst	r3, r1
c0d026e8:	d1f9      	bne.n	c0d026de <strlen+0x12>
c0d026ea:	6819      	ldr	r1, [r3, #0]
c0d026ec:	4a0f      	ldr	r2, [pc, #60]	; (c0d0272c <strlen+0x60>)
c0d026ee:	4c10      	ldr	r4, [pc, #64]	; (c0d02730 <strlen+0x64>)
c0d026f0:	188a      	adds	r2, r1, r2
c0d026f2:	438a      	bics	r2, r1
c0d026f4:	4222      	tst	r2, r4
c0d026f6:	d10f      	bne.n	c0d02718 <strlen+0x4c>
c0d026f8:	3304      	adds	r3, #4
c0d026fa:	6819      	ldr	r1, [r3, #0]
c0d026fc:	4a0b      	ldr	r2, [pc, #44]	; (c0d0272c <strlen+0x60>)
c0d026fe:	188a      	adds	r2, r1, r2
c0d02700:	438a      	bics	r2, r1
c0d02702:	4222      	tst	r2, r4
c0d02704:	d108      	bne.n	c0d02718 <strlen+0x4c>
c0d02706:	3304      	adds	r3, #4
c0d02708:	6819      	ldr	r1, [r3, #0]
c0d0270a:	4a08      	ldr	r2, [pc, #32]	; (c0d0272c <strlen+0x60>)
c0d0270c:	188a      	adds	r2, r1, r2
c0d0270e:	438a      	bics	r2, r1
c0d02710:	4222      	tst	r2, r4
c0d02712:	d0f1      	beq.n	c0d026f8 <strlen+0x2c>
c0d02714:	e000      	b.n	c0d02718 <strlen+0x4c>
c0d02716:	3301      	adds	r3, #1
c0d02718:	781a      	ldrb	r2, [r3, #0]
c0d0271a:	2a00      	cmp	r2, #0
c0d0271c:	d1fb      	bne.n	c0d02716 <strlen+0x4a>
c0d0271e:	1a18      	subs	r0, r3, r0
c0d02720:	bd10      	pop	{r4, pc}
c0d02722:	0003      	movs	r3, r0
c0d02724:	e7e1      	b.n	c0d026ea <strlen+0x1e>
c0d02726:	2000      	movs	r0, #0
c0d02728:	e7fa      	b.n	c0d02720 <strlen+0x54>
c0d0272a:	46c0      	nop			; (mov r8, r8)
c0d0272c:	fefefeff 	.word	0xfefefeff
c0d02730:	80808080 	.word	0x80808080

c0d02734 <bagl_ui_sample_nanos>:
c0d02734:	00000003 00800000 00000020 00000001     ........ .......
c0d02744:	00000000 00ffffff 00000000 00000000     ................
	...
c0d0276c:	00000207 0080000c 0000000b 00000000     ................
c0d0277c:	00ffffff 00000000 0000800a c0d0284c     ............L(..
	...
c0d027a4:	00170207 0052001a 008a000b 00000000     ......R.........
c0d027b4:	00ffffff 00000000 001a8008 20001944     ............D.. 
	...
c0d027dc:	00030005 0007000c 00000007 00000000     ................
c0d027ec:	00ffffff 00000000 00070000 00000000     ................
	...
c0d02814:	00750005 0008000d 00000006 00000000     ..u.............
c0d02824:	00ffffff 00000000 00060000 00000000     ................
	...
c0d0284c:	72646441 00737365                       Address.

c0d02854 <USBD_PRODUCT_FS_STRING>:
c0d02854:	004e030e 006e0061 0020006f a0060053              ..N.a.n.o. .S.

c0d02862 <HID_ReportDesc>:
c0d02862:	09ffa006 0901a101 26001503 087500ff     ...........&..u.
c0d02872:	08814095 00150409 7500ff26 91409508     .@......&..u..@.
c0d02882:	2109c008                                         ..

c0d02884 <USBD_HID_Desc>:
c0d02884:	01112109 22220100 00011200                       .!...."".

c0d0288d <USBD_DeviceDesc>:
c0d0288d:	02000112 40000000 00012c97 02010200     .......@.,......
c0d0289d:	b9000103                                         ...

c0d028a0 <HID_Desc>:
c0d028a0:	c0d023b9 c0d023c9 c0d023d9 c0d023e9     .#...#...#...#..
c0d028b0:	c0d023f9 c0d02409 c0d02419 00000000     .#...$...$......

c0d028c0 <USBD_LangIDDesc>:
c0d028c0:	04090304                                ....

c0d028c4 <USBD_MANUFACTURER_STRING>:
c0d028c4:	004c030e 00640065 00650067 030a0072              ..L.e.d.g.e.r.

c0d028d2 <USB_SERIAL_STRING>:
c0d028d2:	0030030a 00300030 229b0031                       ..0.0.0.1.

c0d028dc <USBD_HID>:
c0d028dc:	c0d0229b c0d022cd c0d021ff 00000000     ."..."...!......
	...
c0d028f4:	c0d02305 00000000 00000000 00000000     .#..............
c0d02904:	c0d02429 c0d02429 c0d02429 c0d02439     )$..)$..)$..9$..

c0d02914 <USBD_CfgDesc>:
c0d02914:	00290209 c0020101 00040932 00030200     ..).....2.......
c0d02924:	21090200 01000111 07002222 40038205     ...!...."".....@
c0d02934:	05070100 00400302 00000001              ......@.....

c0d02940 <USBD_DeviceQualifierDesc>:
c0d02940:	0200060a 40000000 6f4e0001                       .......@..

c0d0294a <NOT_AVAILABLE>:
c0d0294a:	20746f4e 69617661 6c62616c 00000065              Not available.

c0d02958 <_etext>:
	...
