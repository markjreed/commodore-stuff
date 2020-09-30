valtyp  = $0d
typnum  = $00
typstr  = $ff

fac     = $61
facsgn  = $66

chrget  = $73
chrgot  = $79

temp    = $fe

ieval    = $030a
evalcont = $ce8d
int2fp   = $d391
fpadday  = $d867

.byte <enable, >enable
.org +828
enable:
    lda #<evalhex
    sta ieval
    lda #>evalhex
    sta ieval+1
    rts

evalhex:
    lda #typnum
    sta valtyp
    jsr chrget
    cmp #'$'
    beq ishex
    jsr chrgot
    jmp evalcont

ishex:
    ldx #$02
    ldy #3
    lda (chrgot+1),y
    cmp #'0'
    bcc onebyte
    cmp #':'
    bcc hexloop
    cmp #'A'
    bcc onebyte
    cmp #'G'
    bcc hexloop

onebyte:
    lda #$00
    pha
    dex

hexloop:
    jsr chrget
    cmp #'@'
    bcc skip1
    adc #$08
skip1:
    asl
    asl
    asl
    asl
    sta temp
    jsr chrget
    cmp #'@'
    bcc skip2
    adc #$08
skip2:
    and #$0f
    ora temp
    pha
    dex
    bne hexloop

    pla
    tay
    pla
    jsr int2fp
; int2fp does a signed conversion
; - check for negative and correct
    lda facsgn
    and #$80
    beq positive
    lda #<c65536
    ldy #>c65536
    jsr fpadday
positive:
    jmp chrget

; 65536.0 as fp value
c65536: .byte +145,0,0,0,0,+255 
