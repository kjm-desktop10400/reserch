;; -----------------------------------------------------------------
;; 
;; NMOS33 PCELL Creation Skill file for RO018 PDK
;; Written by Tetsuya Iizuka, Mon Sep 14 18:09:35 JST 2009
;;
;; Copyright (C) Tetsuya Iizuka <iizuka@vdec.u-tokyo.ac.jp>
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
;;
;; $Id: VdecPcDefinePCell.il,v 1.2 2009/10/19 06:14:27 iizuka Exp $
;;
;; -----------------------------------------------------------------

;;;;;
;;;;; This procedure is executed once at creating target cell.
;;;;;
let((
	( libName	"vdecRO180PDK" )
	( cellName	"nmos33" )
	( viewName	"layout" )
	cellViewList
	baseCellCdf
)

	baseCellCdf	= cdfGetBaseCellCDF( ddGetObj( libName cellName ))
	cellViewList	= list( ddGetObj( libName ) cellName viewName )

	pcDefinePCell(

		; Indentify the target cellview
		cellViewList

		; Declare formal "parameter name" - "value" pairs
		(
			( model	baseCellCdf~>model~>defValue )
			( l			baseCellCdf~>l~>defValue )
			( w			baseCellCdf~>w~>defValue )
			( leftSt	baseCellCdf~>leftSt~>defValue )
			( rightSt	baseCellCdf~>rightSt~>defValue )
			( leftCnt	baseCellCdf~>leftCnt~>defValue )
			( rightCnt	baseCellCdf~>rightCnt~>defValue )
		)

		; Define the contents of the cellview
		let(()

			l	= cdfParseFloatString( l )* 1e6
			w	= cdfParseFloatString( w )* 1e6
			when( leftCnt == "FALSE"	leftCnt = nil )
			when( rightCnt == "FALSE"	rightCnt = nil )

			;;VdecMosBody( pcCellView l w leftSt rightSt leftCnt rightCnt
			;;	nil						;; Well
			;;	'( "ACTIVE" "drawing" )
			;;	'( "DIFF2" "drawing" ) ;; Diff2
			;;	'( "GATE" "drawing" )
			;;	'( "NSD" "drawing" )
			;;	'( "CONT" "drawing" )
			;;	'( "METAL1" "drawing" )
			;;)
			VdecMosBody( pcCellView l w leftSt rightSt leftCnt rightCnt
				nil						;; Well
				'( "ACTIVE" "drawing" )
				nil 					;; Diff2
				'( "GATE" "drawing" )
				'( "NSD" "drawing" )
				'( "CONT" "drawing" )
				'( "METAL1" "drawing" )
			)
		)
	)
)

