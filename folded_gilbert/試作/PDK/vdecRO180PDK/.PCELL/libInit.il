;; -----------------------------------------------------------------
;; 
;; Library Initialization Skill File
;; Written by Tetsuya Iizuka, Mon Sep 14 15:02:17 JST 2009
;;
;; Copyright (C) Tetsuya Iizuka <iizuka@vdec.u-tokyo.ac.jp>
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
;;
;; $Id: libInit.il,v 1.9 2010/05/12 06:21:03 iizuka Exp $
;;
;; -----------------------------------------------------------------

;;;;;
;;;;; libInit.il
;;;;;
let((
	( libName	"vdecRO180PDK" ) libPath
)

	libPath	= strcat( ddGetObjReadPath( ddGetObj( libName )) "/" )

	;
	; Load runtime files
	;
	;; Get Design Rule from Techfile
	load( strcat( libPath ".PCELL/VdecGetGlobalDR.il" ))
	;; Mos common files
	load( strcat( libPath ".PCELL/VdecMosBody.il" ))
	load( strcat( libPath ".PCELL/VdecMosCB.il" ))
	;; Res common files
	load( strcat( libPath ".PCELL/VdecResBody.il" ))
	load( strcat( libPath ".PCELL/VdecResCB.il" ))
	;; Cap common files
	load( strcat( libPath ".PCELL/VdecCapBody.il" ))
	load( strcat( libPath ".PCELL/VdecCapCB.il" ))
	;; Lpph common files
	load( strcat( libPath ".PCELL/VdecLpphBody.il" ))
	load( strcat( libPath ".PCELL/VdecLpphCB.il" ))

	printf( ";;;;\n" )
	printf( ";;;; Library:%L\n" libName )
	printf( ";;;;\tFinished VDEC PDK for RO018 Rev. 0.3 Initialization !!\n" )
	printf( ";;;;\n" )

	printf( ";;;;\tLoading Mfg Grid Control Skill\n" )
	printf( ";;;;\n" )
	load( strcat( libPath ".PCELL/CdsjSetMfgGrid.il" ))
)

