
.DEFINE MEM_TEMP $0
.DEFINE MEM_TEMPFUNC $10
.DEFINE MEM_SCROLLINGX $20
.DEFINE MEM_SCROLLINGY $22
.DEFINE MEM_VBLANK 	$44
.DEFINE MEM_STDCTRL $50
.DEFINE MEM_OAM $70


.DEFINE fakezoom $100


.DEFINE s_mode7 $400


;array for OAM
.DEFINE MEM_OAML $D80
.DEFINE MEM_OAMH $F80

;array for MODE7
.DEFINE MODE7S $1100
.DEFINE MODE7A $1400
.DEFINE MODE7D $1700
.DEFINE MODE7B $1A00
.DEFINE MODE7C $1D00

;-----------------------

;MEM_OAM
.DEFINE _sprx	    $4
.DEFINE _spry	    $6
.DEFINE _sprtile	$8
.DEFINE _sprext		$9
.DEFINE _sprsz		$A
.DEFINE _sprtmp1	$C
.DEFINE _sprtmp2	$E


;s_mode7
.DEFINE	_m7a	$00  ;Matrix A
.DEFINE	_m7b	$02  ;Matrix B
.DEFINE	_m7c	$04  ;Matrix C
.DEFINE	_m7d	$06  ;Matrix D
.DEFINE	_m7x	$08  ;Matrix X
.DEFINE	_m7y	$0A  ;Matrix Y
.DEFINE	_m7sx	$0C  ;ScaleX
.DEFINE	_m7sy	$0E  ;ScaleY
.DEFINE	_m7an 	$10  ;angle
.DEFINE	_m7frm 	$12  ;frame (for sending during VBlank)

.DEFINE	_m7vx 	$14  ;speed x
.DEFINE	_m7vy 	$16  ;speed y

.DEFINE	_m7px 	$18  ;position x
.DEFINE	_m7py 	$1B  ;position y

