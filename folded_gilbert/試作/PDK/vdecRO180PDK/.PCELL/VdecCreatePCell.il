;; -----------------------------------------------------------------
;; 
;; PCELL Creation Skill File for RO018 PDK Development
;; Written by Tetsuya Iizuka, Mon Sep 14 15:05:30 JST 2009
;;
;; Copyright (C) Tetsuya Iizuka <iizuka@vdec.u-tokyo.ac.jp>
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
;;
;; $Id: VdecCreatePCell.il,v 1.7 2009/11/05 10:27:18 iizuka Exp $
;;
;; -----------------------------------------------------------------


;;;;;
;;;;; This script is executed once at creating target cell.
;;;;;
let((
	( libName	"vdecRO180PDK" ) libPath
	( l_mosName '( "nmos18" "pmos18" "nmos33" "pmos33" ))
	(	l_resName '( "ppres" "ppres_s" "npres" "npres_s" "pdres" "pdres_s" "ndres" "ndres_s" ))
	(	l_capName '( "mimcap" ))
	(	l_lpphName '( "lpph" ))
)

	libPath	= strcat( ddGetObjReadPath( ddGetObj( libName )) "/" )

	; Load runtime files first
	load( strcat( libPath ".PCELL/VdecGetGlobalDR.il" ))
	load( strcat( libPath ".PCELL/VdecMosBody.il" ))
	load( strcat( libPath ".PCELL/VdecMosCB.il" ))
	load( strcat( libPath ".PCELL/VdecResBody.il" ))
	load( strcat( libPath ".PCELL/VdecResCB.il" ))
	load( strcat( libPath ".PCELL/VdecCapBody.il" ))
	load( strcat( libPath ".PCELL/VdecCapCB.il" ))
	load( strcat( libPath ".PCELL/VdecLpphBody.il" ))
	load( strcat( libPath ".PCELL/VdecLpphCB.il" ))

	; Load creation files second
	load( strcat( libPath ".PCELL/VdecCreateMosCDF.il" ))
	load( strcat( libPath ".PCELL/VdecCreateResCDF.il" ))
	load( strcat( libPath ".PCELL/VdecCreateCapCDF.il" ))
	load( strcat( libPath ".PCELL/VdecCreateLpphCDF.il" ))

	; Create MOS CDF & layout cellView
	foreach( cellName l_mosName
		VdecCreateMosCDF( libName cellName )
		load( strcat( libPath ".PCELL/" cellName "/VdecPcDefinePCell.il" ))
	)
	printf( ";;;;\n" )
	printf( ";;;; Library:%L cellName:%L\n" libName l_mosName )

	; Create RES CDF & layout cellView
	foreach( cellName l_resName
		VdecCreateResCDF( libName cellName )
		load( strcat( libPath ".PCELL/" cellName "/VdecPcDefinePCell.il" ))
	)
	printf( ";;;;\n" )
	printf( ";;;; Library:%L cellName:%L\n" libName l_resName )

	; Create CAP CDF & layout cellView
	foreach( cellName l_capName
		VdecCreateCapCDF( libName cellName )
		load( strcat( libPath ".PCELL/" cellName "/VdecPcDefinePCell.il" ))
	)
	printf( ";;;;\n" )
	printf( ";;;; Library:%L cellName:%L\n" libName l_capName )

	; Create LPPH CDF & layout cellView
	foreach( cellName l_lpphName
		VdecCreateLpphCDF( libName cellName )
		load( strcat( libPath ".PCELL/" cellName "/VdecPcDefinePCell.il" ))
	)
	printf( ";;;;\n" )
	printf( ";;;; Library:%L cellName:%L\n" libName l_lpphName )

	printf( ";;;;\tFinished PCell compile !!\n" )
	printf( ";;;;\n" )
)

