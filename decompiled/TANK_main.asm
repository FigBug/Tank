00000000  55                push bp
00000001  89E5              mov bp,sp
00000003  31C0              xor ax,ax
00000005  9A3005C705        call word 0x5c7:word 0x530    ; System+0530
0000000A  803E800306        cmp byte [0x380],0x6
0000000F  7D16              jnl 0x27
00000011  807E0810          cmp byte [bp+0x8],0x10
00000015  7E10              jng 0x27
00000017  807E0818          cmp byte [bp+0x8],0x18
0000001B  7D0A              jnl 0x27
0000001D  8A4608            mov al,[bp+0x8]
00000020  98                cbw
00000021  050800            add ax,0x8
00000024  884608            mov [bp+0x8],al
00000027  803E810306        cmp byte [0x381],0x6
0000002C  7D16              jnl 0x44
0000002E  807E0800          cmp byte [bp+0x8],0x0
00000032  7E10              jng 0x44
00000034  807E0808          cmp byte [bp+0x8],0x8
00000038  7D0A              jnl 0x44
0000003A  8A4608            mov al,[bp+0x8]
0000003D  98                cbw
0000003E  050800            add ax,0x8
00000041  884608            mov [bp+0x8],al
00000044  C47E04            les di,word [bp+0x4]
00000047  268A05            mov al,[es:di]
0000004A  98                cbw
0000004B  40                inc ax
0000004C  268805            mov [es:di],al
0000004F  268A05            mov al,[es:di]
00000052  D0E8              shr al,1
00000054  7308              jnc 0x5e
00000056  8A4608            mov al,[bp+0x8]
00000059  98                cbw
0000005A  40                inc ax
0000005B  884608            mov [bp+0x8],al
0000005E  FF760C            push word [bp+0xc]
00000061  FF760A            push word [bp+0xa]
00000064  8A4608            mov al,[bp+0x8]
00000067  98                cbw
00000068  8BF8              mov di,ax
0000006A  C1E702            shl di,byte 0x2
0000006D  C4BDA002          les di,word [di+0x2a0]
00000071  06                push es
00000072  57                push di
00000073  6A00              push word 0x0
00000075  9A7710E901        call word 0x1e9:word 0x1077    ; Graph+1077
0000007A  C9                leave
0000007B  C20A00            ret word 0xa
0000007E  55                push bp
0000007F  89E5              mov bp,sp
00000081  B81000            mov ax,0x10
00000084  9A3005C705        call word 0x5c7:word 0x530    ; System+0530
00000089  83EC10            sub sp,0x10
0000008C  803E6C0300        cmp byte [0x36c],0x0
00000091  7503              jnz 0x96
00000093  E99501            jmp 0x22b
00000096  837E0600          cmp word [bp+0x6],0x0
0000009A  7507              jnz 0xa3
0000009C  A06503            mov al,[0x365]
0000009F  98                cbw
000000A0  894606            mov [bp+0x6],ax
000000A3  837E0611          cmp word [bp+0x6],0x11
000000A7  7C18              jl 0xc1
000000A9  837E0614          cmp word [bp+0x6],0x14
000000AD  7F12              jg 0xc1
000000AF  8B460E            mov ax,[bp+0xe]
000000B2  051A00            add ax,0x1a
000000B5  8946FE            mov [bp-0x2],ax
000000B8  8B460A            mov ax,[bp+0xa]
000000BB  052200            add ax,0x22
000000BE  8946FC            mov [bp-0x4],ax
000000C1  837E0615          cmp word [bp+0x6],0x15
000000C5  7C18              jl 0xdf
000000C7  837E0618          cmp word [bp+0x6],0x18
000000CB  7F12              jg 0xdf
000000CD  8B460E            mov ax,[bp+0xe]
000000D0  052200            add ax,0x22
000000D3  8946FE            mov [bp-0x2],ax
000000D6  8B460A            mov ax,[bp+0xa]
000000D9  051A00            add ax,0x1a
000000DC  8946FC            mov [bp-0x4],ax
000000DF  A17203            mov ax,[0x372]
000000E2  050300            add ax,0x3
000000E5  8946F6            mov [bp-0xa],ax
000000E8  A17403            mov ax,[0x374]
000000EB  050300            add ax,0x3
000000EE  8946F4            mov [bp-0xc],ax
000000F1  A17203            mov ax,[0x372]
000000F4  3B460E            cmp ax,[bp+0xe]
000000F7  7C1D              jl 0x116
000000F9  A17203            mov ax,[0x372]
000000FC  3B46FE            cmp ax,[bp-0x2]
000000FF  7F15              jg 0x116
00000101  A17403            mov ax,[0x374]
00000104  3B460A            cmp ax,[bp+0xa]
00000107  7C0D              jl 0x116
00000109  A17403            mov ax,[0x374]
0000010C  3B46FC            cmp ax,[bp-0x4]
0000010F  7F05              jg 0x116
00000111  C606820301        mov byte [0x382],0x1
00000116  A17203            mov ax,[0x372]
00000119  3B460E            cmp ax,[bp+0xe]
0000011C  7C1D              jl 0x13b
0000011E  A17203            mov ax,[0x372]
00000121  3B46FE            cmp ax,[bp-0x2]
00000124  7F15              jg 0x13b
00000126  8B46F4            mov ax,[bp-0xc]
00000129  3B460A            cmp ax,[bp+0xa]
0000012C  7C0D              jl 0x13b
0000012E  8B46F4            mov ax,[bp-0xc]
00000131  3B46FC            cmp ax,[bp-0x4]
00000134  7F05              jg 0x13b
00000136  C606820301        mov byte [0x382],0x1
0000013B  8B46F6            mov ax,[bp-0xa]
0000013E  3B460E            cmp ax,[bp+0xe]
00000141  7C1D              jl 0x160
00000143  8B46F6            mov ax,[bp-0xa]
00000146  3B46FE            cmp ax,[bp-0x2]
00000149  7F15              jg 0x160
0000014B  8B46F4            mov ax,[bp-0xc]
0000014E  3B460A            cmp ax,[bp+0xa]
00000151  7C0D              jl 0x160
00000153  8B46F4            mov ax,[bp-0xc]
00000156  3B46FC            cmp ax,[bp-0x4]
00000159  7F05              jg 0x160
0000015B  C606820301        mov byte [0x382],0x1
00000160  8B46F6            mov ax,[bp-0xa]
00000163  3B460E            cmp ax,[bp+0xe]
00000166  7C1D              jl 0x185
00000168  8B46F6            mov ax,[bp-0xa]
0000016B  3B46FE            cmp ax,[bp-0x2]
0000016E  7F15              jg 0x185
00000170  A17403            mov ax,[0x374]
00000173  3B460A            cmp ax,[bp+0xa]
00000176  7C0D              jl 0x185
00000178  A17403            mov ax,[0x374]
0000017B  3B46FC            cmp ax,[bp-0x4]
0000017E  7F05              jg 0x185
00000180  C606820301        mov byte [0x382],0x1
00000185  803E820300        cmp byte [0x382],0x0
0000018A  743E              jz 0x1ca
0000018C  A08003            mov al,[0x380]
0000018F  98                cbw
00000190  48                dec ax
00000191  A28003            mov [0x380],al
00000194  C6066C0300        mov byte [0x36c],0x0
00000199  FF367203          push word [0x372]
0000019D  FF367403          push word [0x374]
000001A1  C43E3C03          les di,word [0x33c]
000001A5  06                push es
000001A6  57                push di
000001A7  6A00              push word 0x0
000001A9  9A7710E901        call word 0x1e9:word 0x1077    ; Graph+1077
000001AE  A06803            mov al,[0x368]
000001B1  98                cbw
000001B2  48                dec ax
000001B3  A26803            mov [0x368],al
000001B6  FF365403          push word [0x354]
000001BA  FF365803          push word [0x358]
000001BE  8A4606            mov al,[bp+0x6]
000001C1  50                push ax
000001C2  BF6803            mov di,0x368
000001C5  1E                push ds
000001C6  57                push di
000001C7  E836FE            call 0x0
000001CA  C606820300        mov byte [0x382],0x0
000001CF  803E800300        cmp byte [0x380],0x0
000001D4  7F05              jg 0x1db
000001D6  C6067E0301        mov byte [0x37e],0x1
000001DB  803E800305        cmp byte [0x380],0x5
000001E0  7549              jnz 0x22b
000001E2  837E0600          cmp word [bp+0x6],0x0
000001E6  7523              jnz 0x20b
000001E8  FF365403          push word [0x354]
000001EC  FF365803          push word [0x358]
000001F0  A06503            mov al,[0x365]
000001F3  98                cbw
000001F4  050800            add ax,0x8
000001F7  8BF8              mov di,ax
000001F9  C1E702            shl di,byte 0x2
000001FC  C4BDA002          les di,word [di+0x2a0]
00000200  06                push es
00000201  57                push di
00000202  6A00              push word 0x0
00000204  9A7710E901        call word 0x1e9:word 0x1077    ; Graph+1077
00000209  EB20              jmp 0x22b
0000020B  FF365403          push word [0x354]
0000020F  FF365803          push word [0x358]
00000213  8B4606            mov ax,[bp+0x6]
00000216  050800            add ax,0x8
00000219  8BF8              mov di,ax
0000021B  C1E702            shl di,byte 0x2
0000021E  C4BDA002          les di,word [di+0x2a0]
00000222  06                push es
00000223  57                push di
00000224  6A00              push word 0x0
00000226  9A7710E901        call word 0x1e9:word 0x1077    ; Graph+1077
0000022B  803E6B0300        cmp byte [0x36b],0x0
00000230  7503              jnz 0x235
00000232  E99501            jmp 0x3ca
00000235  837E0400          cmp word [bp+0x4],0x0
00000239  7507              jnz 0x242
0000023B  A06703            mov al,[0x367]
0000023E  98                cbw
0000023F  894604            mov [bp+0x4],ax
00000242  837E0401          cmp word [bp+0x4],0x1
00000246  7C18              jl 0x260
00000248  837E0404          cmp word [bp+0x4],0x4
0000024C  7F12              jg 0x260
0000024E  8B460C            mov ax,[bp+0xc]
00000251  051A00            add ax,0x1a
00000254  8946FA            mov [bp-0x6],ax
00000257  8B4608            mov ax,[bp+0x8]
0000025A  052200            add ax,0x22
0000025D  8946F8            mov [bp-0x8],ax
00000260  837E0405          cmp word [bp+0x4],0x5
00000264  7C18              jl 0x27e
00000266  837E0408          cmp word [bp+0x4],0x8
0000026A  7F12              jg 0x27e
0000026C  8B460C            mov ax,[bp+0xc]
0000026F  052200            add ax,0x22
00000272  8946FA            mov [bp-0x6],ax
00000275  8B4608            mov ax,[bp+0x8]
00000278  051A00            add ax,0x1a
0000027B  8946F8            mov [bp-0x8],ax
0000027E  A16E03            mov ax,[0x36e]
00000281  050300            add ax,0x3
00000284  8946F2            mov [bp-0xe],ax
00000287  A17003            mov ax,[0x370]
0000028A  050300            add ax,0x3
0000028D  8946F0            mov [bp-0x10],ax
00000290  A16E03            mov ax,[0x36e]
00000293  3B460C            cmp ax,[bp+0xc]
00000296  7C1D              jl 0x2b5
00000298  A16E03            mov ax,[0x36e]
0000029B  3B46FA            cmp ax,[bp-0x6]
0000029E  7F15              jg 0x2b5
000002A0  A17003            mov ax,[0x370]
000002A3  3B4608            cmp ax,[bp+0x8]
000002A6  7C0D              jl 0x2b5
000002A8  A17003            mov ax,[0x370]
000002AB  3B46F8            cmp ax,[bp-0x8]
000002AE  7F05              jg 0x2b5
000002B0  C606830301        mov byte [0x383],0x1
000002B5  A16E03            mov ax,[0x36e]
000002B8  3B460C            cmp ax,[bp+0xc]
000002BB  7C1D              jl 0x2da
000002BD  A16E03            mov ax,[0x36e]
000002C0  3B46FA            cmp ax,[bp-0x6]
000002C3  7F15              jg 0x2da
000002C5  8B46F0            mov ax,[bp-0x10]
000002C8  3B4608            cmp ax,[bp+0x8]
000002CB  7C0D              jl 0x2da
000002CD  8B46F0            mov ax,[bp-0x10]
000002D0  3B46F8            cmp ax,[bp-0x8]
000002D3  7F05              jg 0x2da
000002D5  C606830301        mov byte [0x383],0x1
000002DA  8B46F2            mov ax,[bp-0xe]
000002DD  3B460C            cmp ax,[bp+0xc]
000002E0  7C1D              jl 0x2ff
000002E2  8B46F2            mov ax,[bp-0xe]
000002E5  3B46FA            cmp ax,[bp-0x6]
000002E8  7F15              jg 0x2ff
000002EA  8B46F0            mov ax,[bp-0x10]
000002ED  3B4608            cmp ax,[bp+0x8]
000002F0  7C0D              jl 0x2ff
000002F2  8B46F0            mov ax,[bp-0x10]
000002F5  3B46F8            cmp ax,[bp-0x8]
000002F8  7F05              jg 0x2ff
000002FA  C606830301        mov byte [0x383],0x1
000002FF  8B46F2            mov ax,[bp-0xe]
00000302  3B460C            cmp ax,[bp+0xc]
00000305  7C1D              jl 0x324
00000307  8B46F2            mov ax,[bp-0xe]
0000030A  3B46FA            cmp ax,[bp-0x6]
0000030D  7F15              jg 0x324
0000030F  A17003            mov ax,[0x370]
00000312  3B4608            cmp ax,[bp+0x8]
00000315  7C0D              jl 0x324
00000317  A17003            mov ax,[0x370]
0000031A  3B46F8            cmp ax,[bp-0x8]
0000031D  7F05              jg 0x324
0000031F  C606830301        mov byte [0x383],0x1
00000324  803E830300        cmp byte [0x383],0x0
00000329  743E              jz 0x369
0000032B  A08103            mov al,[0x381]
0000032E  98                cbw
0000032F  48                dec ax
00000330  A28103            mov [0x381],al
00000333  C6066B0300        mov byte [0x36b],0x0
00000338  FF366E03          push word [0x36e]
0000033C  FF367003          push word [0x370]
00000340  C43E3C03          les di,word [0x33c]
00000344  06                push es
00000345  57                push di
00000346  6A00              push word 0x0
00000348  9A7710E901        call word 0x1e9:word 0x1077    ; Graph+1077
0000034D  A06903            mov al,[0x369]
00000350  98                cbw
00000351  48                dec ax
00000352  A26903            mov [0x369],al
00000355  FF365603          push word [0x356]
00000359  FF365A03          push word [0x35a]
0000035D  8A4604            mov al,[bp+0x4]
00000360  50                push ax
00000361  BF6903            mov di,0x369
00000364  1E                push ds
00000365  57                push di
00000366  E897FC            call 0x0
00000369  803E810300        cmp byte [0x381],0x0
0000036E  7F05              jg 0x375
00000370  C6067F0301        mov byte [0x37f],0x1
00000375  C606830300        mov byte [0x383],0x0
0000037A  803E810305        cmp byte [0x381],0x5
0000037F  7549              jnz 0x3ca
00000381  837E0400          cmp word [bp+0x4],0x0
00000385  7523              jnz 0x3aa
00000387  FF365603          push word [0x356]
0000038B  FF365A03          push word [0x35a]
0000038F  A06703            mov al,[0x367]
00000392  98                cbw
00000393  050800            add ax,0x8
00000396  8BF8              mov di,ax
00000398  C1E702            shl di,byte 0x2
0000039B  C4BDA002          les di,word [di+0x2a0]
0000039F  06                push es
000003A0  57                push di
000003A1  6A00              push word 0x0
000003A3  9A7710E901        call word 0x1e9:word 0x1077    ; Graph+1077
000003A8  EB20              jmp 0x3ca
000003AA  FF365603          push word [0x356]
000003AE  FF365A03          push word [0x35a]
000003B2  8B4604            mov ax,[bp+0x4]
000003B5  050800            add ax,0x8
000003B8  8BF8              mov di,ax
000003BA  C1E702            shl di,byte 0x2
000003BD  C4BDA002          les di,word [di+0x2a0]
000003C1  06                push es
000003C2  57                push di
000003C3  6A00              push word 0x0
000003C5  9A7710E901        call word 0x1e9:word 0x1077    ; Graph+1077
000003CA  C9                leave
000003CB  C20C00            ret word 0xc
000003CE  55                push bp
000003CF  89E5              mov bp,sp
000003D1  B80200            mov ax,0x2
000003D4  9A3005C705        call word 0x5c7:word 0x530    ; System+0530
000003D9  83EC02            sub sp,0x2
000003DC  803E640300        cmp byte [0x364],0x0
000003E1  7509              jnz 0x3ec
000003E3  A06503            mov al,[0x365]
000003E6  98                cbw
000003E7  8946FE            mov [bp-0x2],ax
000003EA  EB07              jmp 0x3f3
000003EC  A06403            mov al,[0x364]
000003EF  98                cbw
000003F0  8946FE            mov [bp-0x2],ax
000003F3  C6066B0301        mov byte [0x36b],0x1
000003F8  837EFE11          cmp word [bp-0x2],0x11
000003FC  7528              jnz 0x426
000003FE  31C0              xor ax,ax
00000400  A37603            mov [0x376],ax
00000403  C7067803FEFF      mov word [0x378],0xfffe
00000409  A15403            mov ax,[0x354]
0000040C  03065403          add ax,[0x354]
00000410  051A00            add ax,0x1a
00000413  99                cwd
00000414  B90200            mov cx,0x2
00000417  F7F9              idiv cx
00000419  48                dec ax
0000041A  A36E03            mov [0x36e],ax
0000041D  A15803            mov ax,[0x358]
00000420  2D0300            sub ax,0x3
00000423  A37003            mov [0x370],ax
00000426  837EFE13          cmp word [bp-0x2],0x13
0000042A  7528              jnz 0x454
0000042C  31C0              xor ax,ax
0000042E  A37603            mov [0x376],ax
00000431  C70678030200      mov word [0x378],0x2
00000437  A15403            mov ax,[0x354]
0000043A  03065403          add ax,[0x354]
0000043E  051A00            add ax,0x1a
00000441  99                cwd
00000442  B90200            mov cx,0x2
00000445  F7F9              idiv cx
00000447  48                dec ax
00000448  A36E03            mov [0x36e],ax
0000044B  A15803            mov ax,[0x358]
0000044E  052300            add ax,0x23
00000451  A37003            mov [0x370],ax
00000454  837EFE15          cmp word [bp-0x2],0x15
00000458  7528              jnz 0x482
0000045A  C7067603FEFF      mov word [0x376],0xfffe
00000460  31C0              xor ax,ax
00000462  A37803            mov [0x378],ax
00000465  A15803            mov ax,[0x358]
00000468  03065803          add ax,[0x358]
0000046C  051A00            add ax,0x1a
0000046F  99                cwd
00000470  B90200            mov cx,0x2
00000473  F7F9              idiv cx
00000475  48                dec ax
00000476  A37003            mov [0x370],ax
00000479  A15403            mov ax,[0x354]
0000047C  2D0300            sub ax,0x3
0000047F  A36E03            mov [0x36e],ax
00000482  837EFE17          cmp word [bp-0x2],0x17
00000486  7528              jnz 0x4b0
00000488  C70676030200      mov word [0x376],0x2
0000048E  31C0              xor ax,ax
00000490  A37803            mov [0x378],ax
00000493  A15803            mov ax,[0x358]
00000496  03065803          add ax,[0x358]
0000049A  051A00            add ax,0x1a
0000049D  99                cwd
0000049E  B90200            mov cx,0x2
000004A1  F7F9              idiv cx
000004A3  48                dec ax
000004A4  A37003            mov [0x370],ax
000004A7  A15403            mov ax,[0x354]
000004AA  052300            add ax,0x23
000004AD  A36E03            mov [0x36e],ax
000004B0  FF366E03          push word [0x36e]
000004B4  FF367003          push word [0x370]
000004B8  C43E3803          les di,word [0x338]
000004BC  06                push es
000004BD  57                push di
000004BE  6A00              push word 0x0
000004C0  9A7710E901        call word 0x1e9:word 0x1077    ; Graph+1077
000004C5  C9                leave
000004C6  C3                ret
000004C7  55                push bp
000004C8  89E5              mov bp,sp
000004CA  B80200            mov ax,0x2
000004CD  9A3005C705        call word 0x5c7:word 0x530    ; System+0530
000004D2  83EC02            sub sp,0x2
000004D5  803E660300        cmp byte [0x366],0x0
000004DA  7509              jnz 0x4e5
000004DC  A06703            mov al,[0x367]
000004DF  98                cbw
000004E0  8946FE            mov [bp-0x2],ax
000004E3  EB07              jmp 0x4ec
000004E5  A06603            mov al,[0x366]
000004E8  98                cbw
000004E9  8946FE            mov [bp-0x2],ax
000004EC  C6066C0301        mov byte [0x36c],0x1
000004F1  837EFE01          cmp word [bp-0x2],0x1
000004F5  7528              jnz 0x51f
000004F7  31C0              xor ax,ax
000004F9  A37A03            mov [0x37a],ax
000004FC  C7067C03FEFF      mov word [0x37c],0xfffe
00000502  A15603            mov ax,[0x356]
00000505  03065603          add ax,[0x356]
00000509  051A00            add ax,0x1a
0000050C  99                cwd
0000050D  B90200            mov cx,0x2
00000510  F7F9              idiv cx
00000512  48                dec ax
00000513  A37203            mov [0x372],ax
00000516  A15A03            mov ax,[0x35a]
00000519  2D0300            sub ax,0x3
0000051C  A37403            mov [0x374],ax
0000051F  837EFE03          cmp word [bp-0x2],0x3
00000523  7528              jnz 0x54d
00000525  31C0              xor ax,ax
00000527  A37A03            mov [0x37a],ax
0000052A  C7067C030200      mov word [0x37c],0x2
00000530  A15603            mov ax,[0x356]
00000533  03065603          add ax,[0x356]
00000537  051A00            add ax,0x1a
0000053A  99                cwd
0000053B  B90200            mov cx,0x2
0000053E  F7F9              idiv cx
00000540  48                dec ax
00000541  A37203            mov [0x372],ax
00000544  A15A03            mov ax,[0x35a]
00000547  052300            add ax,0x23
0000054A  A37403            mov [0x374],ax
0000054D  837EFE05          cmp word [bp-0x2],0x5
00000551  7528              jnz 0x57b
00000553  C7067A03FEFF      mov word [0x37a],0xfffe
00000559  31C0              xor ax,ax
0000055B  A37C03            mov [0x37c],ax
0000055E  A15A03            mov ax,[0x35a]
00000561  03065A03          add ax,[0x35a]
00000565  051A00            add ax,0x1a
00000568  99                cwd
00000569  B90200            mov cx,0x2
0000056C  F7F9              idiv cx
0000056E  48                dec ax
0000056F  A37403            mov [0x374],ax
00000572  A15603            mov ax,[0x356]
00000575  2D0300            sub ax,0x3
00000578  A37203            mov [0x372],ax
0000057B  837EFE07          cmp word [bp-0x2],0x7
0000057F  7528              jnz 0x5a9
00000581  C7067A030200      mov word [0x37a],0x2
00000587  31C0              xor ax,ax
00000589  A37C03            mov [0x37c],ax
0000058C  A15A03            mov ax,[0x35a]
0000058F  03065A03          add ax,[0x35a]
00000593  051A00            add ax,0x1a
00000596  99                cwd
00000597  B90200            mov cx,0x2
0000059A  F7F9              idiv cx
0000059C  48                dec ax
0000059D  A37403            mov [0x374],ax
000005A0  A15603            mov ax,[0x356]
000005A3  052300            add ax,0x23
000005A6  A37203            mov [0x372],ax
000005A9  FF367203          push word [0x372]
000005AD  FF367403          push word [0x374]
000005B1  C43E3803          les di,word [0x338]
000005B5  06                push es
000005B6  57                push di
000005B7  6A00              push word 0x0
000005B9  9A7710E901        call word 0x1e9:word 0x1077    ; Graph+1077
000005BE  C9                leave
000005BF  C3                ret
000005C0  55                push bp
000005C1  89E5              mov bp,sp
000005C3  31C0              xor ax,ax
000005C5  9A3005C705        call word 0x5c7:word 0x530    ; System+0530
000005CA  6A00              push word 0x0
000005CC  6A00              push word 0x0
000005CE  6A02              push word 0x2
000005D0  6A02              push word 0x2
000005D2  9A4310E901        call word 0x1e9:word 0x1043    ; Graph+1043
000005D7  A34003            mov [0x340],ax
000005DA  FF364003          push word [0x340]
000005DE  9A8A02C705        call word 0x5c7:word 0x28a    ; System+028a
000005E3  A33803            mov [0x338],ax
000005E6  89163A03          mov [0x33a],dx
000005EA  6A00              push word 0x0
000005EC  6A00              push word 0x0
000005EE  6A02              push word 0x2
000005F0  6A02              push word 0x2
000005F2  C43E3803          les di,word [0x338]
000005F6  06                push es
000005F7  57                push di
000005F8  9A931BE901        call word 0x1e9:word 0x1b93    ; Graph+1b93
000005FD  FF364203          push word [0x342]
00000601  9A8A02C705        call word 0x5c7:word 0x28a    ; System+028a
00000606  A33C03            mov [0x33c],ax
00000609  89163E03          mov [0x33e],dx
0000060D  6A05              push word 0x5
0000060F  6A05              push word 0x5
00000611  6A07              push word 0x7
00000613  6A07              push word 0x7
00000615  C43E3C03          les di,word [0x33c]
00000619  06                push es
0000061A  57                push di
0000061B  9A931BE901        call word 0x1e9:word 0x1b93    ; Graph+1b93
00000620  FF363403          push word [0x334]
00000624  9A8A02C705        call word 0x5c7:word 0x28a    ; System+028a
00000629  A3A402            mov [0x2a4],ax
0000062C  8916A602          mov [0x2a6],dx
00000630  6A03              push word 0x3
00000632  6A02              push word 0x2
00000634  6A1D              push word 0x1d
00000636  6A24              push word 0x24
00000638  C43EA402          les di,word [0x2a4]
0000063C  06                push es
0000063D  57                push di
0000063E  9A931BE901        call word 0x1e9:word 0x1b93    ; Graph+1b93
00000643  FF363403          push word [0x334]
00000647  9A8A02C705        call word 0x5c7:word 0x28a    ; System+028a
0000064C  A3A802            mov [0x2a8],ax
0000064F  8916AA02          mov [0x2aa],dx
00000653  6A22              push word 0x22
00000655  6A02              push word 0x2
00000657  6A3C              push word 0x3c
00000659  6A24              push word 0x24
0000065B  C43EA802          les di,word [0x2a8]
0000065F  06                push es
00000660  57                push di
00000661  9A931BE901        call word 0x1e9:word 0x1b93    ; Graph+1b93
00000666  FF363403          push word [0x334]
0000066A  9A8A02C705        call word 0x5c7:word 0x28a    ; System+028a
0000066F  A3AC02            mov [0x2ac],ax
00000672  8916AE02          mov [0x2ae],dx
00000676  6A03              push word 0x3
00000678  6A31              push word 0x31
0000067A  6A1D              push word 0x1d
0000067C  6A53              push word 0x53
0000067E  C43EAC02          les di,word [0x2ac]
00000682  06                push es
00000683  57                push di
00000684  9A931BE901        call word 0x1e9:word 0x1b93    ; Graph+1b93
00000689  FF363403          push word [0x334]
0000068D  9A8A02C705        call word 0x5c7:word 0x28a    ; System+028a
00000692  A3B002            mov [0x2b0],ax
00000695  8916B202          mov [0x2b2],dx
00000699  6A22              push word 0x22
0000069B  6A31              push word 0x31
0000069D  6A3C              push word 0x3c
0000069F  6A53              push word 0x53
000006A1  C43EB002          les di,word [0x2b0]
000006A5  06                push es
000006A6  57                push di
000006A7  9A931BE901        call word 0x1e9:word 0x1b93    ; Graph+1b93
000006AC  FF363603          push word [0x336]
000006B0  9A8A02C705        call word 0x5c7:word 0x28a    ; System+028a
000006B5  A3B402            mov [0x2b4],ax
000006B8  8916B602          mov [0x2b6],dx
000006BC  688C00            push word 0x8c
000006BF  6A02              push word 0x2
000006C1  68AE00            push word 0xae
000006C4  6A1C              push word 0x1c
000006C6  C43EB402          les di,word [0x2b4]
000006CA  06                push es
000006CB  57                push di
000006CC  9A931BE901        call word 0x1e9:word 0x1b93    ; Graph+1b93
000006D1  FF363603          push word [0x336]
000006D5  9A8A02C705        call word 0x5c7:word 0x28a    ; System+028a
000006DA  A3B802            mov [0x2b8],ax
000006DD  8916BA02          mov [0x2ba],dx
000006E1  688C00            push word 0x8c
000006E4  6A21              push word 0x21
000006E6  68AE00            push word 0xae
000006E9  6A3B              push word 0x3b
000006EB  C43EB802          les di,word [0x2b8]
000006EF  06                push es
000006F0  57                push di
000006F1  9A931BE901        call word 0x1e9:word 0x1b93    ; Graph+1b93
000006F6  FF363603          push word [0x336]
000006FA  9A8A02C705        call word 0x5c7:word 0x28a    ; System+028a
000006FF  A3BC02            mov [0x2bc],ax
00000702  8916BE02          mov [0x2be],dx
00000706  68BB00            push word 0xbb
00000709  6A02              push word 0x2
0000070B  68DD00            push word 0xdd
0000070E  6A1C              push word 0x1c
00000710  C43EBC02          les di,word [0x2bc]
00000714  06                push es
00000715  57                push di
00000716  9A931BE901        call word 0x1e9:word 0x1b93    ; Graph+1b93
0000071B  FF363603          push word [0x336]
0000071F  9A8A02C705        call word 0x5c7:word 0x28a    ; System+028a
00000724  A3C002            mov [0x2c0],ax
00000727  8916C202          mov [0x2c2],dx
0000072B  68BB00            push word 0xbb
0000072E  6A21              push word 0x21
00000730  68DD00            push word 0xdd
00000733  6A3B              push word 0x3b
00000735  C43EC002          les di,word [0x2c0]
00000739  06                push es
0000073A  57                push di
0000073B  9A931BE901        call word 0x1e9:word 0x1b93    ; Graph+1b93
00000740  FF363403          push word [0x334]
00000744  9A8A02C705        call word 0x5c7:word 0x28a    ; System+028a
00000749  A3C402            mov [0x2c4],ax
0000074C  8916C602          mov [0x2c6],dx
00000750  6A48              push word 0x48
00000752  6A02              push word 0x2
00000754  6A62              push word 0x62
00000756  6A24              push word 0x24
00000758  C43EC402          les di,word [0x2c4]
0000075C  06                push es
0000075D  57                push di
0000075E  9A931BE901        call word 0x1e9:word 0x1b93    ; Graph+1b93
00000763  FF363403          push word [0x334]
00000767  9A8A02C705        call word 0x5c7:word 0x28a    ; System+028a
0000076C  A3C802            mov [0x2c8],ax
0000076F  8916CA02          mov [0x2ca],dx
00000773  6A69              push word 0x69
00000775  6A02              push word 0x2
00000777  688300            push word 0x83
0000077A  6A24              push word 0x24
0000077C  C43EC802          les di,word [0x2c8]
00000780  06                push es
00000781  57                push di
00000782  9A931BE901        call word 0x1e9:word 0x1b93    ; Graph+1b93
00000787  FF363403          push word [0x334]
0000078B  9A8A02C705        call word 0x5c7:word 0x28a    ; System+028a
00000790  A3CC02            mov [0x2cc],ax
00000793  8916CE02          mov [0x2ce],dx
00000797  6A48              push word 0x48
00000799  6A31              push word 0x31
0000079B  6A62              push word 0x62
0000079D  6A53              push word 0x53
0000079F  C43ECC02          les di,word [0x2cc]
000007A3  06                push es
000007A4  57                push di
000007A5  9A931BE901        call word 0x1e9:word 0x1b93    ; Graph+1b93
000007AA  FF363403          push word [0x334]
000007AE  9A8A02C705        call word 0x5c7:word 0x28a    ; System+028a
000007B3  A3D002            mov [0x2d0],ax
000007B6  8916D202          mov [0x2d2],dx
000007BA  6A69              push word 0x69
000007BC  6A31              push word 0x31
000007BE  688300            push word 0x83
000007C1  6A53              push word 0x53
000007C3  C43ED002          les di,word [0x2d0]
000007C7  06                push es
000007C8  57                push di
000007C9  9A931BE901        call word 0x1e9:word 0x1b93    ; Graph+1b93
000007CE  FF363603          push word [0x336]
000007D2  9A8A02C705        call word 0x5c7:word 0x28a    ; System+028a
000007D7  A3D402            mov [0x2d4],ax
000007DA  8916D602          mov [0x2d6],dx
000007DE  688C00            push word 0x8c
000007E1  6A47              push word 0x47
000007E3  68AE00            push word 0xae
000007E6  6A61              push word 0x61
000007E8  C43ED402          les di,word [0x2d4]
000007EC  06                push es
000007ED  57                push di
000007EE  9A931BE901        call word 0x1e9:word 0x1b93    ; Graph+1b93
000007F3  FF363603          push word [0x336]
000007F7  9A8A02C705        call word 0x5c7:word 0x28a    ; System+028a
000007FC  A3D802            mov [0x2d8],ax
000007FF  8916DA02          mov [0x2da],dx
00000803  688C00            push word 0x8c
00000806  6A68              push word 0x68
00000808  68AE00            push word 0xae
0000080B  688200            push word 0x82
0000080E  C43ED802          les di,word [0x2d8]
00000812  06                push es
00000813  57                push di
00000814  9A931BE901        call word 0x1e9:word 0x1b93    ; Graph+1b93
00000819  FF363603          push word [0x336]
0000081D  9A8A02C705        call word 0x5c7:word 0x28a    ; System+028a
00000822  A3DC02            mov [0x2dc],ax
00000825  8916DE02          mov [0x2de],dx
00000829  68BB00            push word 0xbb
0000082C  6A47              push word 0x47
0000082E  68DD00            push word 0xdd
00000831  6A61              push word 0x61
00000833  C43EDC02          les di,word [0x2dc]
00000837  06                push es
00000838  57                push di
00000839  9A931BE901        call word 0x1e9:word 0x1b93    ; Graph+1b93
0000083E  FF363603          push word [0x336]
00000842  9A8A02C705        call word 0x5c7:word 0x28a    ; System+028a
00000847  A3E002            mov [0x2e0],ax
0000084A  8916E202          mov [0x2e2],dx
0000084E  68BB00            push word 0xbb
00000851  6A68              push word 0x68
00000853  68DD00            push word 0xdd
00000856  688200            push word 0x82
00000859  C43EE002          les di,word [0x2e0]
0000085D  06                push es
0000085E  57                push di
0000085F  9A931BE901        call word 0x1e9:word 0x1b93    ; Graph+1b93
00000864  FF363403          push word [0x334]
00000868  9A8A02C705        call word 0x5c7:word 0x28a    ; System+028a
0000086D  A3E402            mov [0x2e4],ax
00000870  8916E602          mov [0x2e6],dx
00000874  6A02              push word 0x2
00000876  6A5B              push word 0x5b
00000878  6A1C              push word 0x1c
0000087A  6A7D              push word 0x7d
0000087C  C43EE402          les di,word [0x2e4]
00000880  06                push es
00000881  57                push di
00000882  9A931BE901        call word 0x1e9:word 0x1b93    ; Graph+1b93
00000887  FF363403          push word [0x334]
0000088B  9A8A02C705        call word 0x5c7:word 0x28a    ; System+028a
00000890  A3E802            mov [0x2e8],ax
00000893  8916EA02          mov [0x2ea],dx
00000897  6A21              push word 0x21
00000899  6A5B              push word 0x5b
0000089B  6A3B              push word 0x3b
0000089D  6A7D              push word 0x7d
0000089F  C43EE802          les di,word [0x2e8]
000008A3  06                push es
000008A4  57                push di
000008A5  9A931BE901        call word 0x1e9:word 0x1b93    ; Graph+1b93
000008AA  FF363403          push word [0x334]
000008AE  9A8A02C705        call word 0x5c7:word 0x28a    ; System+028a
000008B3  A3EC02            mov [0x2ec],ax
000008B6  8916EE02          mov [0x2ee],dx
000008BA  6A03              push word 0x3
000008BC  688C00            push word 0x8c
000008BF  6A1D              push word 0x1d
000008C1  68AE00            push word 0xae
000008C4  C43EEC02          les di,word [0x2ec]
000008C8  06                push es
000008C9  57                push di
000008CA  9A931BE901        call word 0x1e9:word 0x1b93    ; Graph+1b93
000008CF  FF363403          push word [0x334]
000008D3  9A8A02C705        call word 0x5c7:word 0x28a    ; System+028a
000008D8  A3F002            mov [0x2f0],ax
000008DB  8916F202          mov [0x2f2],dx
000008DF  6A22              push word 0x22
000008E1  688C00            push word 0x8c
000008E4  6A3C              push word 0x3c
000008E6  68AE00            push word 0xae
000008E9  C43EF002          les di,word [0x2f0]
000008ED  06                push es
000008EE  57                push di
000008EF  9A931BE901        call word 0x1e9:word 0x1b93    ; Graph+1b93
000008F4  FF363603          push word [0x336]
000008F8  9A8A02C705        call word 0x5c7:word 0x28a    ; System+028a
000008FD  A3F402            mov [0x2f4],ax
00000900  8916F602          mov [0x2f6],dx
00000904  68E600            push word 0xe6
00000907  6A01              push word 0x1
00000909  680801            push word 0x108
0000090C  6A1B              push word 0x1b
0000090E  C43EF402          les di,word [0x2f4]
00000912  06                push es
00000913  57                push di
00000914  9A931BE901        call word 0x1e9:word 0x1b93    ; Graph+1b93
00000919  FF363603          push word [0x336]
0000091D  9A8A02C705        call word 0x5c7:word 0x28a    ; System+028a
00000922  A3F802            mov [0x2f8],ax
00000925  8916FA02          mov [0x2fa],dx
00000929  68E600            push word 0xe6
0000092C  6A20              push word 0x20
0000092E  680801            push word 0x108
00000931  6A3A              push word 0x3a
00000933  C43EF802          les di,word [0x2f8]
00000937  06                push es
00000938  57                push di
00000939  9A931BE901        call word 0x1e9:word 0x1b93    ; Graph+1b93
0000093E  FF363603          push word [0x336]
00000942  9A8A02C705        call word 0x5c7:word 0x28a    ; System+028a
00000947  A3FC02            mov [0x2fc],ax
0000094A  8916FE02          mov [0x2fe],dx
0000094E  681701            push word 0x117
00000951  6A01              push word 0x1
00000953  683901            push word 0x139
00000956  6A1B              push word 0x1b
00000958  C43EFC02          les di,word [0x2fc]
0000095C  06                push es
0000095D  57                push di
0000095E  9A931BE901        call word 0x1e9:word 0x1b93    ; Graph+1b93
00000963  FF363603          push word [0x336]
00000967  9A8A02C705        call word 0x5c7:word 0x28a    ; System+028a
0000096C  A30003            mov [0x300],ax
0000096F  89160203          mov [0x302],dx
00000973  681701            push word 0x117
00000976  6A20              push word 0x20
00000978  683901            push word 0x139
0000097B  6A3A              push word 0x3a
0000097D  C43E0003          les di,word [0x300]
00000981  06                push es
00000982  57                push di
00000983  9A931BE901        call word 0x1e9:word 0x1b93    ; Graph+1b93
00000988  FF363403          push word [0x334]
0000098C  9A8A02C705        call word 0x5c7:word 0x28a    ; System+028a
00000991  A30403            mov [0x304],ax
00000994  89160603          mov [0x306],dx
00000998  6A48              push word 0x48
0000099A  6A5B              push word 0x5b
0000099C  6A62              push word 0x62
0000099E  6A7D              push word 0x7d
000009A0  C43E0403          les di,word [0x304]
000009A4  06                push es
000009A5  57                push di
000009A6  9A931BE901        call word 0x1e9:word 0x1b93    ; Graph+1b93
000009AB  FF363403          push word [0x334]
000009AF  9A8A02C705        call word 0x5c7:word 0x28a    ; System+028a
000009B4  A30803            mov [0x308],ax
000009B7  89160A03          mov [0x30a],dx
000009BB  6A69              push word 0x69
000009BD  6A5B              push word 0x5b
000009BF  688300            push word 0x83
000009C2  6A7D              push word 0x7d
000009C4  C43E0803          les di,word [0x308]
000009C8  06                push es
000009C9  57                push di
000009CA  9A931BE901        call word 0x1e9:word 0x1b93    ; Graph+1b93
000009CF  FF363403          push word [0x334]
000009D3  9A8A02C705        call word 0x5c7:word 0x28a    ; System+028a
000009D8  A30C03            mov [0x30c],ax
000009DB  89160E03          mov [0x30e],dx
000009DF  6A48              push word 0x48
000009E1  688C00            push word 0x8c
000009E4  6A62              push word 0x62
000009E6  68AE00            push word 0xae
000009E9  C43E0C03          les di,word [0x30c]
000009ED  06                push es
000009EE  57                push di
000009EF  9A931BE901        call word 0x1e9:word 0x1b93    ; Graph+1b93
000009F4  FF363403          push word [0x334]
000009F8  9A8A02C705        call word 0x5c7:word 0x28a    ; System+028a
000009FD  A31003            mov [0x310],ax
00000A00  89161203          mov [0x312],dx
00000A04  6A69              push word 0x69
00000A06  688C00            push word 0x8c
00000A09  688300            push word 0x83
00000A0C  68AE00            push word 0xae
00000A0F  C43E1003          les di,word [0x310]
00000A13  06                push es
00000A14  57                push di
00000A15  9A931BE901        call word 0x1e9:word 0x1b93    ; Graph+1b93
00000A1A  FF363603          push word [0x336]
00000A1E  9A8A02C705        call word 0x5c7:word 0x28a    ; System+028a
00000A23  A31403            mov [0x314],ax
00000A26  89161603          mov [0x316],dx
00000A2A  68E600            push word 0xe6
00000A2D  6A47              push word 0x47
00000A2F  680801            push word 0x108
00000A32  6A61              push word 0x61
00000A34  C43E1403          les di,word [0x314]
00000A38  06                push es
00000A39  57                push di
00000A3A  9A931BE901        call word 0x1e9:word 0x1b93    ; Graph+1b93
00000A3F  FF363603          push word [0x336]
00000A43  9A8A02C705        call word 0x5c7:word 0x28a    ; System+028a
00000A48  A31803            mov [0x318],ax
00000A4B  89161A03          mov [0x31a],dx
00000A4F  68E600            push word 0xe6
00000A52  6A68              push word 0x68
00000A54  680801            push word 0x108
00000A57  688200            push word 0x82
00000A5A  C43E1803          les di,word [0x318]
00000A5E  06                push es
00000A5F  57                push di
00000A60  9A931BE901        call word 0x1e9:word 0x1b93    ; Graph+1b93
00000A65  FF363603          push word [0x336]
00000A69  9A8A02C705        call word 0x5c7:word 0x28a    ; System+028a
00000A6E  A31C03            mov [0x31c],ax
00000A71  89161E03          mov [0x31e],dx
00000A75  681701            push word 0x117
00000A78  6A47              push word 0x47
00000A7A  683901            push word 0x139
00000A7D  6A61              push word 0x61
00000A7F  C43E1C03          les di,word [0x31c]
00000A83  06                push es
00000A84  57                push di
00000A85  9A931BE901        call word 0x1e9:word 0x1b93    ; Graph+1b93
00000A8A  FF363603          push word [0x336]
00000A8E  9A8A02C705        call word 0x5c7:word 0x28a    ; System+028a
00000A93  A32003            mov [0x320],ax
00000A96  89162203          mov [0x322],dx
00000A9A  681701            push word 0x117
00000A9D  6A68              push word 0x68
00000A9F  683901            push word 0x139
00000AA2  688200            push word 0x82
00000AA5  C43E2003          les di,word [0x320]
00000AA9  06                push es
00000AAA  57                push di
00000AAB  9A931BE901        call word 0x1e9:word 0x1b93    ; Graph+1b93
00000AB0  C9                leave
00000AB1  C3                ret
00000AB2  55                push bp
00000AB3  89E5              mov bp,sp
00000AB5  B80A00            mov ax,0xa
00000AB8  9A3005C705        call word 0x5c7:word 0x530    ; System+0530
00000ABD  83EC0A            sub sp,0xa
00000AC0  837E0600          cmp word [bp+0x6],0x0
00000AC4  7507              jnz 0xacd
00000AC6  A06503            mov al,[0x365]
00000AC9  98                cbw
00000ACA  894606            mov [bp+0x6],ax
00000ACD  837E0400          cmp word [bp+0x4],0x0
00000AD1  7507              jnz 0xada
00000AD3  A06703            mov al,[0x367]
00000AD6  98                cbw
00000AD7  894604            mov [bp+0x4],ax
00000ADA  C646FF00          mov byte [bp-0x1],0x0
00000ADE  837E0611          cmp word [bp+0x6],0x11
00000AE2  7C18              jl 0xafc
00000AE4  837E0614          cmp word [bp+0x6],0x14
00000AE8  7F12              jg 0xafc
00000AEA  8B460E            mov ax,[bp+0xe]
00000AED  051A00            add ax,0x1a
00000AF0  8946FC            mov [bp-0x4],ax
00000AF3  8B460A            mov ax,[bp+0xa]
00000AF6  052200            add ax,0x22
00000AF9  8946FA            mov [bp-0x6],ax
00000AFC  837E0615          cmp word [bp+0x6],0x15
00000B00  7C18              jl 0xb1a
00000B02  837E0618          cmp word [bp+0x6],0x18
00000B06  7F12              jg 0xb1a
00000B08  8B460E            mov ax,[bp+0xe]
00000B0B  052200            add ax,0x22
00000B0E  8946FC            mov [bp-0x4],ax
00000B11  8B460A            mov ax,[bp+0xa]
00000B14  051A00            add ax,0x1a
00000B17  8946FA            mov [bp-0x6],ax
00000B1A  837E0401          cmp word [bp+0x4],0x1
00000B1E  7C18              jl 0xb38
00000B20  837E0404          cmp word [bp+0x4],0x4
00000B24  7F12              jg 0xb38
00000B26  8B460C            mov ax,[bp+0xc]
00000B29  051A00            add ax,0x1a
00000B2C  8946F8            mov [bp-0x8],ax
00000B2F  8B4608            mov ax,[bp+0x8]
00000B32  052200            add ax,0x22
00000B35  8946F6            mov [bp-0xa],ax
00000B38  837E0405          cmp word [bp+0x4],0x5
00000B3C  7C18              jl 0xb56
00000B3E  837E0408          cmp word [bp+0x4],0x8
00000B42  7F12              jg 0xb56
00000B44  8B460C            mov ax,[bp+0xc]
00000B47  052200            add ax,0x22
00000B4A  8946F8            mov [bp-0x8],ax
00000B4D  8B4608            mov ax,[bp+0x8]
00000B50  051A00            add ax,0x1a
00000B53  8946F6            mov [bp-0xa],ax
00000B56  8B460E            mov ax,[bp+0xe]
00000B59  3B460C            cmp ax,[bp+0xc]
00000B5C  7C1C              jl 0xb7a
00000B5E  8B460E            mov ax,[bp+0xe]
00000B61  3B46F8            cmp ax,[bp-0x8]
00000B64  7F14              jg 0xb7a
00000B66  8B460A            mov ax,[bp+0xa]
00000B69  3B4608            cmp ax,[bp+0x8]
00000B6C  7C0C              jl 0xb7a
00000B6E  8B460A            mov ax,[bp+0xa]
00000B71  3B46F6            cmp ax,[bp-0xa]
00000B74  7F04              jg 0xb7a
00000B76  C646FF01          mov byte [bp-0x1],0x1
00000B7A  8B460E            mov ax,[bp+0xe]
00000B7D  3B460C            cmp ax,[bp+0xc]
00000B80  7C1C              jl 0xb9e
00000B82  8B460E            mov ax,[bp+0xe]
00000B85  3B46F8            cmp ax,[bp-0x8]
00000B88  7F14              jg 0xb9e
00000B8A  8B46FA            mov ax,[bp-0x6]
00000B8D  3B4608            cmp ax,[bp+0x8]
00000B90  7C0C              jl 0xb9e
00000B92  8B46FA            mov ax,[bp-0x6]
00000B95  3B46F6            cmp ax,[bp-0xa]
00000B98  7F04              jg 0xb9e
00000B9A  C646FF01          mov byte [bp-0x1],0x1
00000B9E  8B46FC            mov ax,[bp-0x4]
00000BA1  3B460C            cmp ax,[bp+0xc]
00000BA4  7C1C              jl 0xbc2
00000BA6  8B46FC            mov ax,[bp-0x4]
00000BA9  3B46F8            cmp ax,[bp-0x8]
00000BAC  7F14              jg 0xbc2
00000BAE  8B46FA            mov ax,[bp-0x6]
00000BB1  3B4608            cmp ax,[bp+0x8]
00000BB4  7C0C              jl 0xbc2
00000BB6  8B46FA            mov ax,[bp-0x6]
00000BB9  3B46F6            cmp ax,[bp-0xa]
00000BBC  7F04              jg 0xbc2
00000BBE  C646FF01          mov byte [bp-0x1],0x1
00000BC2  8B46FC            mov ax,[bp-0x4]
00000BC5  3B460C            cmp ax,[bp+0xc]
00000BC8  7C1C              jl 0xbe6
00000BCA  8B46FC            mov ax,[bp-0x4]
00000BCD  3B46F8            cmp ax,[bp-0x8]
00000BD0  7F14              jg 0xbe6
00000BD2  8B460A            mov ax,[bp+0xa]
00000BD5  3B4608            cmp ax,[bp+0x8]
00000BD8  7C0C              jl 0xbe6
00000BDA  8B460A            mov ax,[bp+0xa]
00000BDD  3B46F6            cmp ax,[bp-0xa]
00000BE0  7F04              jg 0xbe6
00000BE2  C646FF01          mov byte [bp-0x1],0x1
00000BE6  8A46FF            mov al,[bp-0x1]
00000BE9  C9                leave
00000BEA  C20C00            ret word 0xc
00000BED  55                push bp
00000BEE  89E5              mov bp,sp
00000BF0  31C0              xor ax,ax
00000BF2  9A3005C705        call word 0x5c7:word 0x530    ; System+0530
00000BF7  833E540300        cmp word [0x354],0x0
00000BFC  7D05              jnl 0xc03
00000BFE  31C0              xor ax,ax
00000C00  A35403            mov [0x354],ax
00000C03  833E560300        cmp word [0x356],0x0
00000C08  7D05              jnl 0xc0f
00000C0A  31C0              xor ax,ax
00000C0C  A35603            mov [0x356],ax
00000C0F  833E580300        cmp word [0x358],0x0
00000C14  7D05              jnl 0xc1b
00000C16  31C0              xor ax,ax
00000C18  A35803            mov [0x358],ax
00000C1B  833E5A0300        cmp word [0x35a],0x0
00000C20  7D05              jnl 0xc27
00000C22  31C0              xor ax,ax
00000C24  A35A03            mov [0x35a],ax
00000C27  813E54031C01      cmp word [0x354],0x11c
00000C2D  7E06              jng 0xc35
00000C2F  C70654031C01      mov word [0x354],0x11c
00000C35  813E56031C01      cmp word [0x356],0x11c
00000C3B  7E06              jng 0xc43
00000C3D  C70656031C01      mov word [0x356],0x11c
00000C43  813E5803A400      cmp word [0x358],0xa4
00000C49  7E06              jng 0xc51
00000C4B  C7065803A400      mov word [0x358],0xa4
00000C51  813E5A03A400      cmp word [0x35a],0xa4
00000C57  7E06              jng 0xc5f
00000C59  C7065A03A400      mov word [0x35a],0xa4
00000C5F  C9                leave
00000C60  C3                ret
00000C61  55                push bp
00000C62  89E5              mov bp,sp
00000C64  31C0              xor ax,ax
00000C66  9A3005C705        call word 0x5c7:word 0x530    ; System+0530
00000C6B  803E640300        cmp byte [0x364],0x0
00000C70  7406              jz 0xc78
00000C72  A06403            mov al,[0x364]
00000C75  A26503            mov [0x365],al
00000C78  803E660300        cmp byte [0x366],0x0
00000C7D  7406              jz 0xc85
00000C7F  A06603            mov al,[0x366]
00000C82  A26703            mov [0x367],al
00000C85  9A1A036505        call word 0x565:word 0x31a    ; Crt+031a
00000C8A  A26A03            mov [0x36a],al
00000C8D  A06A03            mov al,[0x36a]
00000C90  50                push ax
00000C91  9A2213C705        call word 0x5c7:word 0x1322    ; System+1322
00000C96  A26A03            mov [0x36a],al
00000C99  A06A03            mov al,[0x36a]
00000C9C  3C38              cmp al,0x38
00000C9E  7508              jnz 0xca8
00000CA0  C606660301        mov byte [0x366],0x1
00000CA5  E98D00            jmp 0xd35
00000CA8  3C34              cmp al,0x34
00000CAA  7508              jnz 0xcb4
00000CAC  C606660305        mov byte [0x366],0x5
00000CB1  E98100            jmp 0xd35
00000CB4  3C36              cmp al,0x36
00000CB6  7507              jnz 0xcbf
00000CB8  C606660307        mov byte [0x366],0x7
00000CBD  EB76              jmp 0xd35
00000CBF  3C32              cmp al,0x32
00000CC1  7507              jnz 0xcca
00000CC3  C606660303        mov byte [0x366],0x3
00000CC8  EB6B              jmp 0xd35
00000CCA  3C35              cmp al,0x35
00000CCC  7507              jnz 0xcd5
00000CCE  C606660300        mov byte [0x366],0x0
00000CD3  EB60              jmp 0xd35
00000CD5  3C57              cmp al,0x57
00000CD7  7507              jnz 0xce0
00000CD9  C606640311        mov byte [0x364],0x11
00000CDE  EB55              jmp 0xd35
00000CE0  3C41              cmp al,0x41
00000CE2  7507              jnz 0xceb
00000CE4  C606640315        mov byte [0x364],0x15
00000CE9  EB4A              jmp 0xd35
00000CEB  3C44              cmp al,0x44
00000CED  7507              jnz 0xcf6
00000CEF  C606640317        mov byte [0x364],0x17
00000CF4  EB3F              jmp 0xd35
00000CF6  3C58              cmp al,0x58
00000CF8  7507              jnz 0xd01
00000CFA  C606640313        mov byte [0x364],0x13
00000CFF  EB34              jmp 0xd35
00000D01  3C53              cmp al,0x53
00000D03  7507              jnz 0xd0c
00000D05  C606640300        mov byte [0x364],0x0
00000D0A  EB29              jmp 0xd35
00000D0C  3C51              cmp al,0x51
00000D0E  7507              jnz 0xd17
00000D10  C606500301        mov byte [0x350],0x1
00000D15  EB1E              jmp 0xd35
00000D17  3C20              cmp al,0x20
00000D19  750C              jnz 0xd27
00000D1B  803E6B0300        cmp byte [0x36b],0x0
00000D20  7503              jnz 0xd25
00000D22  E8A9F6            call 0x3ce
00000D25  EB0E              jmp 0xd35
00000D27  3C30              cmp al,0x30
00000D29  750A              jnz 0xd35
00000D2B  803E6C0300        cmp byte [0x36c],0x0
00000D30  7503              jnz 0xd35
00000D32  E892F7            call 0x4c7
00000D35  C9                leave
00000D36  C3                ret
00000D37  55                push bp
00000D38  89E5              mov bp,sp
00000D3A  31C0              xor ax,ax
00000D3C  9A3005C705        call word 0x5c7:word 0x530    ; System+0530
00000D41  FF366E03          push word [0x36e]
00000D45  FF367003          push word [0x370]
00000D49  C43E3C03          les di,word [0x33c]
00000D4D  06                push es
00000D4E  57                push di
00000D4F  6A00              push word 0x0
00000D51  9A7710E901        call word 0x1e9:word 0x1077    ; Graph+1077
00000D56  A16E03            mov ax,[0x36e]
00000D59  03067603          add ax,[0x376]
00000D5D  A36E03            mov [0x36e],ax
00000D60  A17003            mov ax,[0x370]
00000D63  03067803          add ax,[0x378]
00000D67  A37003            mov [0x370],ax
00000D6A  FF366E03          push word [0x36e]
00000D6E  FF367003          push word [0x370]
00000D72  C43E3803          les di,word [0x338]
00000D76  06                push es
00000D77  57                push di
00000D78  6A00              push word 0x0
00000D7A  9A7710E901        call word 0x1e9:word 0x1077    ; Graph+1077
00000D7F  813E6E034001      cmp word [0x36e],0x140
00000D85  7F07              jg 0xd8e
00000D87  833E6E0300        cmp word [0x36e],0x0
00000D8C  7D05              jnl 0xd93
00000D8E  C6066B0300        mov byte [0x36b],0x0
00000D93  813E7003C800      cmp word [0x370],0xc8
00000D99  7F07              jg 0xda2
00000D9B  833E700300        cmp word [0x370],0x0
00000DA0  7D05              jnl 0xda7
00000DA2  C6066B0300        mov byte [0x36b],0x0
00000DA7  C9                leave
00000DA8  C3                ret
00000DA9  55                push bp
00000DAA  89E5              mov bp,sp
00000DAC  31C0              xor ax,ax
00000DAE  9A3005C705        call word 0x5c7:word 0x530    ; System+0530
00000DB3  FF367203          push word [0x372]
00000DB7  FF367403          push word [0x374]
00000DBB  C43E3C03          les di,word [0x33c]
00000DBF  06                push es
00000DC0  57                push di
00000DC1  6A00              push word 0x0
00000DC3  9A7710E901        call word 0x1e9:word 0x1077    ; Graph+1077
00000DC8  A17203            mov ax,[0x372]
00000DCB  03067A03          add ax,[0x37a]
00000DCF  A37203            mov [0x372],ax
00000DD2  A17403            mov ax,[0x374]
00000DD5  03067C03          add ax,[0x37c]
00000DD9  A37403            mov [0x374],ax
00000DDC  FF367203          push word [0x372]
00000DE0  FF367403          push word [0x374]
00000DE4  C43E3803          les di,word [0x338]
00000DE8  06                push es
00000DE9  57                push di
00000DEA  6A00              push word 0x0
00000DEC  9A7710E901        call word 0x1e9:word 0x1077    ; Graph+1077
00000DF1  813E72034001      cmp word [0x372],0x140
00000DF7  7F07              jg 0xe00
00000DF9  833E720300        cmp word [0x372],0x0
00000DFE  7D05              jnl 0xe05
00000E00  C6066C0300        mov byte [0x36c],0x0
00000E05  813E7403C800      cmp word [0x374],0xc8
00000E0B  7F07              jg 0xe14
00000E0D  833E740300        cmp word [0x374],0x0
00000E12  7D05              jnl 0xe19
00000E14  C6066C0300        mov byte [0x36c],0x0
00000E19  C9                leave
00000E1A  C3                ret
00000E1B  55                push bp
00000E1C  89E5              mov bp,sp
00000E1E  31C0              xor ax,ax
00000E20  9A3005C705        call word 0x5c7:word 0x530    ; System+0530
00000E25  807E0410          cmp byte [bp+0x4],0x10
00000E29  7E0A              jng 0xe35
00000E2B  8A4604            mov al,[bp+0x4]
00000E2E  98                cbw
00000E2F  2D1000            sub ax,0x10
00000E32  884604            mov [bp+0x4],al
00000E35  807E0401          cmp byte [bp+0x4],0x1
00000E39  7406              jz 0xe41
00000E3B  807E0402          cmp byte [bp+0x4],0x2
00000E3F  7517              jnz 0xe58
00000E41  FF7608            push word [bp+0x8]
00000E44  8B4606            mov ax,[bp+0x6]
00000E47  052200            add ax,0x22
00000E4A  50                push ax
00000E4B  C43E2803          les di,word [0x328]
00000E4F  06                push es
00000E50  57                push di
00000E51  6A00              push word 0x0
00000E53  9A7710E901        call word 0x1e9:word 0x1077    ; Graph+1077
00000E58  807E0403          cmp byte [bp+0x4],0x3
00000E5C  7406              jz 0xe64
00000E5E  807E0404          cmp byte [bp+0x4],0x4
00000E62  7515              jnz 0xe79
00000E64  FF7608            push word [bp+0x8]
00000E67  8B4606            mov ax,[bp+0x6]
00000E6A  48                dec ax
00000E6B  50                push ax
00000E6C  C43E2803          les di,word [0x328]
00000E70  06                push es
00000E71  57                push di
00000E72  6A00              push word 0x0
00000E74  9A7710E901        call word 0x1e9:word 0x1077    ; Graph+1077
00000E79  807E0405          cmp byte [bp+0x4],0x5
00000E7D  7406              jz 0xe85
00000E7F  807E0406          cmp byte [bp+0x4],0x6
00000E83  7517              jnz 0xe9c
00000E85  8B4608            mov ax,[bp+0x8]
00000E88  052200            add ax,0x22
00000E8B  50                push ax
00000E8C  FF7606            push word [bp+0x6]
00000E8F  C43E2403          les di,word [0x324]
00000E93  06                push es
00000E94  57                push di
00000E95  6A00              push word 0x0
00000E97  9A7710E901        call word 0x1e9:word 0x1077    ; Graph+1077
00000E9C  807E0407          cmp byte [bp+0x4],0x7
00000EA0  7406              jz 0xea8
00000EA2  807E0408          cmp byte [bp+0x4],0x8
00000EA6  7515              jnz 0xebd
00000EA8  8B4608            mov ax,[bp+0x8]
00000EAB  48                dec ax
00000EAC  50                push ax
00000EAD  FF7606            push word [bp+0x6]
00000EB0  C43E2403          les di,word [0x324]
00000EB4  06                push es
00000EB5  57                push di
00000EB6  6A00              push word 0x0
00000EB8  9A7710E901        call word 0x1e9:word 0x1077    ; Graph+1077
00000EBD  C9                leave
00000EBE  C20600            ret word 0x6
00000EC1  55                push bp
00000EC2  89E5              mov bp,sp
00000EC4  31C0              xor ax,ax
00000EC6  9A3005C705        call word 0x5c7:word 0x530    ; System+0530
00000ECB  807E0411          cmp byte [bp+0x4],0x11
00000ECF  7406              jz 0xed7
00000ED1  807E0413          cmp byte [bp+0x4],0x13
00000ED5  7518              jnz 0xeef
00000ED7  FF365403          push word [0x354]
00000EDB  A15803            mov ax,[0x358]
00000EDE  051A00            add ax,0x1a
00000EE1  50                push ax
00000EE2  C43E3003          les di,word [0x330]
00000EE6  06                push es
00000EE7  57                push di
00000EE8  6A00              push word 0x0
00000EEA  9A7710E901        call word 0x1e9:word 0x1077    ; Graph+1077
00000EEF  807E0415          cmp byte [bp+0x4],0x15
00000EF3  7406              jz 0xefb
00000EF5  807E0417          cmp byte [bp+0x4],0x17
00000EF9  7518              jnz 0xf13
00000EFB  A15403            mov ax,[0x354]
00000EFE  051A00            add ax,0x1a
00000F01  50                push ax
00000F02  FF365803          push word [0x358]
00000F06  C43E2C03          les di,word [0x32c]
00000F0A  06                push es
00000F0B  57                push di
00000F0C  6A00              push word 0x0
00000F0E  9A7710E901        call word 0x1e9:word 0x1077    ; Graph+1077
00000F13  C9                leave
00000F14  C20200            ret word 0x2
00000F17  55                push bp
00000F18  89E5              mov bp,sp
00000F1A  31C0              xor ax,ax
00000F1C  9A3005C705        call word 0x5c7:word 0x530    ; System+0530
00000F21  807E0401          cmp byte [bp+0x4],0x1
00000F25  7406              jz 0xf2d
00000F27  807E0403          cmp byte [bp+0x4],0x3
00000F2B  7518              jnz 0xf45
00000F2D  FF365603          push word [0x356]
00000F31  A15A03            mov ax,[0x35a]
00000F34  051A00            add ax,0x1a
00000F37  50                push ax
00000F38  C43E3003          les di,word [0x330]
00000F3C  06                push es
00000F3D  57                push di
00000F3E  6A00              push word 0x0
00000F40  9A7710E901        call word 0x1e9:word 0x1077    ; Graph+1077
00000F45  807E0405          cmp byte [bp+0x4],0x5
00000F49  7406              jz 0xf51
00000F4B  807E0407          cmp byte [bp+0x4],0x7
00000F4F  7518              jnz 0xf69
00000F51  A15603            mov ax,[0x356]
00000F54  051A00            add ax,0x1a
00000F57  50                push ax
00000F58  FF365A03          push word [0x35a]
00000F5C  C43E2C03          les di,word [0x32c]
00000F60  06                push es
00000F61  57                push di
00000F62  6A00              push word 0x0
00000F64  9A7710E901        call word 0x1e9:word 0x1077    ; Graph+1077
00000F69  C9                leave
00000F6A  C20200            ret word 0x2
00000F6D  0A585F            or bl,[bx+si+0x5f]
00000F70  44                inc sp
00000F71  41                inc cx
00000F72  54                push sp
00000F73  41                inc cx
00000F74  2E50              cs push ax
00000F76  43                inc bx
00000F77  58                pop ax
00000F78  084449            or [si+0x49],al
00000F7B  52                push dx
00000F7C  54                push sp
00000F7D  2E50              cs push ax
00000F7F  43                inc bx
00000F80  58                pop ax
00000F81  9A0000C705        call word 0x5c7:word 0x0    ; System+0000
00000F86  9A0D006505        call word 0x565:word 0xd    ; Crt+000d
00000F8B  9ACC14E901        call word 0x1e9:word 0x14cc    ; Graph+14cc
00000F90  9A5F058F01        call word 0x18f:word 0x55f    ; U_RAM+055f
00000F95  9A00005801        call word 0x158:word 0x0    ; U_PCX+0000
00000F9A  9ABB004B01        call word 0x14b:word 0xbb    ; U_VGA+00bb
00000F9F  55                push bp
00000FA0  89E5              mov bp,sp
00000FA2  31C0              xor ax,ax
00000FA4  9A3005C705        call word 0x5c7:word 0x530    ; System+0530
00000FA9  6A01              push word 0x1
00000FAB  9A5B015801        call word 0x158:word 0x15b    ; U_PCX+015b
00000FB0  6A00              push word 0x0
00000FB2  9ACA005801        call word 0x158:word 0xca    ; U_PCX+00ca
00000FB7  9A43004B01        call word 0x14b:word 0x43    ; U_VGA+0043
00000FBC  9AC40DE901        call word 0x1e9:word 0xdc4    ; Graph+0dc4
00000FC1  9A3D058F01        call word 0x18f:word 0x53d    ; U_RAM+053d
00000FC6  9A63038F01        call word 0x18f:word 0x363    ; U_RAM+0363
00000FCB  BF6D0F            mov di,0xf6d
00000FCE  0E                push cs
00000FCF  57                push di
00000FD0  9AC1008F01        call word 0x18f:word 0xc1    ; U_RAM+00c1
00000FD5  6A03              push word 0x3
00000FD7  6A02              push word 0x2
00000FD9  6A1D              push word 0x1d
00000FDB  6A24              push word 0x24
00000FDD  9A4310E901        call word 0x1e9:word 0x1043    ; Graph+1043
00000FE2  A33403            mov [0x334],ax
00000FE5  688C00            push word 0x8c
00000FE8  6A02              push word 0x2
00000FEA  68AE00            push word 0xae
00000FED  6A1C              push word 0x1c
00000FEF  9A4310E901        call word 0x1e9:word 0x1043    ; Graph+1043
00000FF4  A33603            mov [0x336],ax
00000FF7  E8C6F5            call 0x5c0
00000FFA  689A00            push word 0x9a
00000FFD  689500            push word 0x95
00001000  68CC00            push word 0xcc
00001003  68BA00            push word 0xba
00001006  9A4310E901        call word 0x1e9:word 0x1043    ; Graph+1043
0000100B  A34C03            mov [0x34c],ax
0000100E  FF364C03          push word [0x34c]
00001012  9A8A02C705        call word 0x5c7:word 0x28a    ; System+028a
00001017  A34403            mov [0x344],ax
0000101A  89164603          mov [0x346],dx
0000101E  689B00            push word 0x9b
00001021  689500            push word 0x95
00001024  68CC00            push word 0xcc
00001027  68BA00            push word 0xba
0000102A  C43E4403          les di,word [0x344]
0000102E  06                push es
0000102F  57                push di
00001030  9A931BE901        call word 0x1e9:word 0x1b93    ; Graph+1b93
00001035  FF364C03          push word [0x34c]
00001039  9A8A02C705        call word 0x5c7:word 0x28a    ; System+028a
0000103E  A34803            mov [0x348],ax
00001041  89164A03          mov [0x34a],dx
00001045  68E500            push word 0xe5
00001048  689700            push word 0x97
0000104B  681601            push word 0x116
0000104E  68BC00            push word 0xbc
00001051  C43E4803          les di,word [0x348]
00001055  06                push es
00001056  57                push di
00001057  9A931BE901        call word 0x1e9:word 0x1b93    ; Graph+1b93
0000105C  9AC40DE901        call word 0x1e9:word 0xdc4    ; Graph+0dc4
00001061  BF780F            mov di,0xf78
00001064  0E                push cs
00001065  57                push di
00001066  9AC1008F01        call word 0x18f:word 0xc1    ; U_RAM+00c1
0000106B  6A03              push word 0x3
0000106D  6A02              push word 0x2
0000106F  6A04              push word 0x4
00001071  6A1C              push word 0x1c
00001073  9A4310E901        call word 0x1e9:word 0x1043    ; Graph+1043
00001078  A39C02            mov [0x29c],ax
0000107B  FF369C02          push word [0x29c]
0000107F  9A8A02C705        call word 0x5c7:word 0x28a    ; System+028a
00001084  A32403            mov [0x324],ax
00001087  89162603          mov [0x326],dx
0000108B  6A03              push word 0x3
0000108D  6A02              push word 0x2
0000108F  6A04              push word 0x4
00001091  6A1C              push word 0x1c
00001093  C43E2403          les di,word [0x324]
00001097  06                push es
00001098  57                push di
00001099  9A931BE901        call word 0x1e9:word 0x1b93    ; Graph+1b93
0000109E  6A02              push word 0x2
000010A0  6A02              push word 0x2
000010A2  6A1C              push word 0x1c
000010A4  6A03              push word 0x3
000010A6  9A4310E901        call word 0x1e9:word 0x1043    ; Graph+1043
000010AB  A39E02            mov [0x29e],ax
000010AE  FF369E02          push word [0x29e]
000010B2  9A8A02C705        call word 0x5c7:word 0x28a    ; System+028a
000010B7  A32803            mov [0x328],ax
000010BA  89162A03          mov [0x32a],dx
000010BE  6A02              push word 0x2
000010C0  6A02              push word 0x2
000010C2  6A1C              push word 0x1c
000010C4  6A03              push word 0x3
000010C6  C43E2803          les di,word [0x328]
000010CA  06                push es
000010CB  57                push di
000010CC  9A931BE901        call word 0x1e9:word 0x1b93    ; Graph+1b93
000010D1  6A02              push word 0x2
000010D3  6A02              push word 0x2
000010D5  6A0A              push word 0xa
000010D7  6A1C              push word 0x1c
000010D9  9A4310E901        call word 0x1e9:word 0x1043    ; Graph+1043
000010DE  A3A002            mov [0x2a0],ax
000010E1  FF36A002          push word [0x2a0]
000010E5  9A8A02C705        call word 0x5c7:word 0x28a    ; System+028a
000010EA  A32C03            mov [0x32c],ax
000010ED  89162E03          mov [0x32e],dx
000010F1  6A02              push word 0x2
000010F3  6A02              push word 0x2
000010F5  6A0A              push word 0xa
000010F7  6A1C              push word 0x1c
000010F9  C43E2C03          les di,word [0x32c]
000010FD  06                push es
000010FE  57                push di
000010FF  9A931BE901        call word 0x1e9:word 0x1b93    ; Graph+1b93
00001104  6A02              push word 0x2
00001106  6A02              push word 0x2
00001108  6A1C              push word 0x1c
0000110A  6A0A              push word 0xa
0000110C  9A4310E901        call word 0x1e9:word 0x1043    ; Graph+1043
00001111  A3A202            mov [0x2a2],ax
00001114  FF36A202          push word [0x2a2]
00001118  9A8A02C705        call word 0x5c7:word 0x28a    ; System+028a
0000111D  A33003            mov [0x330],ax
00001120  89163203          mov [0x332],dx
00001124  6A02              push word 0x2
00001126  6A02              push word 0x2
00001128  6A1C              push word 0x1c
0000112A  6A0A              push word 0xa
0000112C  C43E3003          les di,word [0x330]
00001130  06                push es
00001131  57                push di
00001132  9A931BE901        call word 0x1e9:word 0x1b93    ; Graph+1b93
00001137  C70654030A00      mov word [0x354],0xa
0000113D  C70656031401      mov word [0x356],0x114
00001143  C70658035700      mov word [0x358],0x57
00001149  C7065A035700      mov word [0x35a],0x57
0000114F  C606640300        mov byte [0x364],0x0
00001154  C606650317        mov byte [0x365],0x17
00001159  C606660300        mov byte [0x366],0x0
0000115E  C606670305        mov byte [0x367],0x5
00001163  C60680030A        mov byte [0x380],0xa
00001168  C60681030A        mov byte [0x381],0xa
0000116D  FF365403          push word [0x354]
00001171  FF365803          push word [0x358]
00001175  C43EFC02          les di,word [0x2fc]
00001179  06                push es
0000117A  57                push di
0000117B  6A00              push word 0x0
0000117D  9A7710E901        call word 0x1e9:word 0x1077    ; Graph+1077
00001182  FF365603          push word [0x356]
00001186  FF365A03          push word [0x35a]
0000118A  C43EB402          les di,word [0x2b4]
0000118E  06                push es
0000118F  57                push di
00001190  6A00              push word 0x0
00001192  9A7710E901        call word 0x1e9:word 0x1077    ; Graph+1077
00001197  6A32              push word 0x32
00001199  9AAB038F01        call word 0x18f:word 0x3ab    ; U_RAM+03ab
0000119E  9A28005801        call word 0x158:word 0x28    ; U_PCX+0028
000011A3  9A3D058F01        call word 0x18f:word 0x53d    ; U_RAM+053d
000011A8  9A08036505        call word 0x565:word 0x308    ; Crt+0308
000011AD  08C0              or al,al
000011AF  7403              jz 0x11b4
000011B1  E8ADFA            call 0xc61
000011B4  803E650311        cmp byte [0x365],0x11
000011B9  7C1A              jl 0x11d5
000011BB  803E650314        cmp byte [0x365],0x14
000011C0  7F13              jg 0x11d5
000011C2  803E640315        cmp byte [0x364],0x15
000011C7  7C0C              jl 0x11d5
000011C9  803E640318        cmp byte [0x364],0x18
000011CE  7F05              jg 0x11d5
000011D0  C606510301        mov byte [0x351],0x1
000011D5  803E650315        cmp byte [0x365],0x15
000011DA  7C1A              jl 0x11f6
000011DC  803E650318        cmp byte [0x365],0x18
000011E1  7F13              jg 0x11f6
000011E3  803E640311        cmp byte [0x364],0x11
000011E8  7C0C              jl 0x11f6
000011EA  803E640314        cmp byte [0x364],0x14
000011EF  7F05              jg 0x11f6
000011F1  C606510301        mov byte [0x351],0x1
000011F6  803E670301        cmp byte [0x367],0x1
000011FB  7C1A              jl 0x1217
000011FD  803E670304        cmp byte [0x367],0x4
00001202  7F13              jg 0x1217
00001204  803E660305        cmp byte [0x366],0x5
00001209  7C0C              jl 0x1217
0000120B  803E660308        cmp byte [0x366],0x8
00001210  7F05              jg 0x1217
00001212  C606520301        mov byte [0x352],0x1
00001217  803E670305        cmp byte [0x367],0x5
0000121C  7C1A              jl 0x1238
0000121E  803E670308        cmp byte [0x367],0x8
00001223  7F13              jg 0x1238
00001225  803E660301        cmp byte [0x366],0x1
0000122A  7C0C              jl 0x1238
0000122C  803E660304        cmp byte [0x366],0x4
00001231  7F05              jg 0x1238
00001233  C606520301        mov byte [0x352],0x1
00001238  803E510300        cmp byte [0x351],0x0
0000123D  7407              jz 0x1246
0000123F  A06503            mov al,[0x365]
00001242  50                push ax
00001243  E87BFC            call 0xec1
00001246  803E520300        cmp byte [0x352],0x0
0000124B  7407              jz 0x1254
0000124D  A06703            mov al,[0x367]
00001250  50                push ax
00001251  E8C3FC            call 0xf17
00001254  C606510300        mov byte [0x351],0x0
00001259  C606520300        mov byte [0x352],0x0
0000125E  803E640300        cmp byte [0x364],0x0
00001263  740F              jz 0x1274
00001265  FF365403          push word [0x354]
00001269  FF365803          push word [0x358]
0000126D  A06503            mov al,[0x365]
00001270  50                push ax
00001271  E8A7FB            call 0xe1b
00001274  803E640300        cmp byte [0x364],0x0
00001279  7406              jz 0x1281
0000127B  A06403            mov al,[0x364]
0000127E  A26503            mov [0x365],al
00001281  803E660300        cmp byte [0x366],0x0
00001286  740F              jz 0x1297
00001288  FF365603          push word [0x356]
0000128C  FF365A03          push word [0x35a]
00001290  A06703            mov al,[0x367]
00001293  50                push ax
00001294  E884FB            call 0xe1b
00001297  803E660300        cmp byte [0x366],0x0
0000129C  7406              jz 0x12a4
0000129E  A06603            mov al,[0x366]
000012A1  A26703            mov [0x367],al
000012A4  A15403            mov ax,[0x354]
000012A7  A35C03            mov [0x35c],ax
000012AA  A15603            mov ax,[0x356]
000012AD  A35E03            mov [0x35e],ax
000012B0  A15803            mov ax,[0x358]
000012B3  A36003            mov [0x360],ax
000012B6  A15A03            mov ax,[0x35a]
000012B9  A36203            mov [0x362],ax
000012BC  A06403            mov al,[0x364]
000012BF  3C11              cmp al,0x11
000012C1  7509              jnz 0x12cc
000012C3  A15803            mov ax,[0x358]
000012C6  48                dec ax
000012C7  A35803            mov [0x358],ax
000012CA  EB25              jmp 0x12f1
000012CC  3C15              cmp al,0x15
000012CE  7509              jnz 0x12d9
000012D0  A15403            mov ax,[0x354]
000012D3  48                dec ax
000012D4  A35403            mov [0x354],ax
000012D7  EB18              jmp 0x12f1
000012D9  3C17              cmp al,0x17
000012DB  7509              jnz 0x12e6
000012DD  A15403            mov ax,[0x354]
000012E0  40                inc ax
000012E1  A35403            mov [0x354],ax
000012E4  EB0B              jmp 0x12f1
000012E6  3C13              cmp al,0x13
000012E8  7507              jnz 0x12f1
000012EA  A15803            mov ax,[0x358]
000012ED  40                inc ax
000012EE  A35803            mov [0x358],ax
000012F1  A06603            mov al,[0x366]
000012F4  3C01              cmp al,0x1
000012F6  7509              jnz 0x1301
000012F8  A15A03            mov ax,[0x35a]
000012FB  48                dec ax
000012FC  A35A03            mov [0x35a],ax
000012FF  EB25              jmp 0x1326
00001301  3C05              cmp al,0x5
00001303  7509              jnz 0x130e
00001305  A15603            mov ax,[0x356]
00001308  48                dec ax
00001309  A35603            mov [0x356],ax
0000130C  EB18              jmp 0x1326
0000130E  3C07              cmp al,0x7
00001310  7509              jnz 0x131b
00001312  A15603            mov ax,[0x356]
00001315  40                inc ax
00001316  A35603            mov [0x356],ax
00001319  EB0B              jmp 0x1326
0000131B  3C03              cmp al,0x3
0000131D  7507              jnz 0x1326
0000131F  A15A03            mov ax,[0x35a]
00001322  40                inc ax
00001323  A35A03            mov [0x35a],ax
00001326  803E6B0300        cmp byte [0x36b],0x0
0000132B  7403              jz 0x1330
0000132D  E807FA            call 0xd37
00001330  803E6C0300        cmp byte [0x36c],0x0
00001335  7403              jz 0x133a
00001337  E86FFA            call 0xda9
0000133A  803E6B0301        cmp byte [0x36b],0x1
0000133F  7407              jz 0x1348
00001341  803E6C0301        cmp byte [0x36c],0x1
00001346  751D              jnz 0x1365
00001348  FF365403          push word [0x354]
0000134C  FF365603          push word [0x356]
00001350  FF365803          push word [0x358]
00001354  FF365A03          push word [0x35a]
00001358  A06403            mov al,[0x364]
0000135B  98                cbw
0000135C  50                push ax
0000135D  A06603            mov al,[0x366]
00001360  98                cbw
00001361  50                push ax
00001362  E819ED            call 0x7e
00001365  803E7E0300        cmp byte [0x37e],0x0
0000136A  7405              jz 0x1371
0000136C  C606500301        mov byte [0x350],0x1
00001371  803E7F0300        cmp byte [0x37f],0x0
00001376  7405              jz 0x137d
00001378  C606500301        mov byte [0x350],0x1
0000137D  FF365403          push word [0x354]
00001381  FF365603          push word [0x356]
00001385  FF365803          push word [0x358]
00001389  FF365A03          push word [0x35a]
0000138D  A06403            mov al,[0x364]
00001390  98                cbw
00001391  50                push ax
00001392  A06603            mov al,[0x366]
00001395  98                cbw
00001396  50                push ax
00001397  E818F7            call 0xab2
0000139A  3C01              cmp al,0x1
0000139C  7518              jnz 0x13b6
0000139E  A15C03            mov ax,[0x35c]
000013A1  A35403            mov [0x354],ax
000013A4  A15E03            mov ax,[0x35e]
000013A7  A35603            mov [0x356],ax
000013AA  A16003            mov ax,[0x360]
000013AD  A35803            mov [0x358],ax
000013B0  A16203            mov ax,[0x362]
000013B3  A35A03            mov [0x35a],ax
000013B6  E834F8            call 0xbed
000013B9  803E640300        cmp byte [0x364],0x0
000013BE  7414              jz 0x13d4
000013C0  FF365403          push word [0x354]
000013C4  FF365803          push word [0x358]
000013C8  A06403            mov al,[0x364]
000013CB  50                push ax
000013CC  BF6803            mov di,0x368
000013CF  1E                push ds
000013D0  57                push di
000013D1  E82CEC            call 0x0
000013D4  803E660300        cmp byte [0x366],0x0
000013D9  7414              jz 0x13ef
000013DB  FF365603          push word [0x356]
000013DF  FF365A03          push word [0x35a]
000013E3  A06603            mov al,[0x366]
000013E6  50                push ax
000013E7  BF6903            mov di,0x369
000013EA  1E                push ds
000013EB  57                push di
000013EC  E811EC            call 0x0
000013EF  6A14              push word 0x14
000013F1  9AA8026505        call word 0x565:word 0x2a8    ; Crt+02a8
000013F6  803E500300        cmp byte [0x350],0x0
000013FB  7503              jnz 0x1400
000013FD  E9A8FD            jmp 0x11a8
00001400  803E7E0300        cmp byte [0x37e],0x0
00001405  7415              jz 0x141c
00001407  FF365403          push word [0x354]
0000140B  FF365803          push word [0x358]
0000140F  C43E4803          les di,word [0x348]
00001413  06                push es
00001414  57                push di
00001415  6A00              push word 0x0
00001417  9A7710E901        call word 0x1e9:word 0x1077    ; Graph+1077
0000141C  803E7F0300        cmp byte [0x37f],0x0
00001421  7415              jz 0x1438
00001423  FF365603          push word [0x356]
00001427  FF365A03          push word [0x35a]
0000142B  C43E4403          les di,word [0x344]
0000142F  06                push es
00001430  57                push di
00001431  6A00              push word 0x0
00001433  9A7710E901        call word 0x1e9:word 0x1077    ; Graph+1077
00001438  803E6B0300        cmp byte [0x36b],0x0
0000143D  7415              jz 0x1454
0000143F  FF366E03          push word [0x36e]
00001443  FF367003          push word [0x370]
00001447  C43E3C03          les di,word [0x33c]
0000144B  06                push es
0000144C  57                push di
0000144D  6A00              push word 0x0
0000144F  9A7710E901        call word 0x1e9:word 0x1077    ; Graph+1077
00001454  803E6C0300        cmp byte [0x36c],0x0
00001459  7415              jz 0x1470
0000145B  FF367203          push word [0x372]
0000145F  FF367403          push word [0x374]
00001463  C43E3C03          les di,word [0x33c]
00001467  06                push es
00001468  57                push di
00001469  6A00              push word 0x0
0000146B  9A7710E901        call word 0x1e9:word 0x1077    ; Graph+1077
00001470  68D007            push word 0x7d0
00001473  9AA8026505        call word 0x565:word 0x2a8    ; Crt+02a8
00001478  9A28005801        call word 0x158:word 0x28    ; U_PCX+0028
0000147D  9A08036505        call word 0x565:word 0x308    ; Crt+0308
00001482  08C0              or al,al
00001484  74F7              jz 0x147d
00001486  9A3D058F01        call word 0x18f:word 0x53d    ; U_RAM+053d
0000148B  6A63              push word 0x63
0000148D  9A6D048F01        call word 0x18f:word 0x46d    ; U_RAM+046d
00001492  9A3D058F01        call word 0x18f:word 0x53d    ; U_RAM+053d
00001497  9A090DE901        call word 0x1e9:word 0xd09    ; Graph+0d09
0000149C  9ADC0CE901        call word 0x1e9:word 0xcdc    ; Graph+0cdc
000014A1  C9                leave
000014A2  31C0              xor ax,ax
000014A4  9A1601C705        call word 0x5c7:word 0x116    ; System+0116
000014A9  0000              add [bx+si],al
000014AB  0000              add [bx+si],al
000014AD  0000              add [bx+si],al
000014AF  00                db 0x00
