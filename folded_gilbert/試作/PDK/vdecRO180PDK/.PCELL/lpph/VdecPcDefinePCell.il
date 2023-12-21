;; -----------------------------------------------------------------
;; 
;; P+ Poly Resistor w/o Silicide PCELL Creation Skill file for RO018 PDK
;; Written by Tetsuya Iizuka, Mon Sep 14 18:09:35 JST 2009
;;
;; Copyright (C) Tetsuya Iizuka <iizuka@vdec.u-tokyo.ac.jp>
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
;;
;; $Id: VdecPcDefinePCell.il,v 1.1 2009/11/04 08:35:01 iizuka Exp $
;;
;; -----------------------------------------------------------------

;;;;;
;;;;; This procedure is executed once at creating target cell.
;;;;;
let((
	( libName	"vdecRO180PDK" )
	( cellName	"lpph" )
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
			( w					baseCellCdf~>w~>defValue )
			( rInput		baseCellCdf~>rInput~>defValue )
			( l					baseCellCdf~>l~>defValue )
			( r					baseCellCdf~>r~>defValue )
		)

		; Define the contents of the cellview
		let(()

			l	= cdfParseFloatString( l )* 1e6
			w	= cdfParseFloatString( w )* 1e6

			VdecLpphBody( pcCellView l w 
				'( "PROTECT" "drawing" )
				'( "LPPH" "drawing" )
				'( "RLPPHDMY" "drawing" )
				'( "GATE" "drawing" )
				'( "PSD" "drawing" )
				'( "CONT" "drawing" )
				'( "METAL1" "drawing" )
			)
		)
	)
)

