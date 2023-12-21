;; -----------------------------------------------------------------
;; 
;; MIM Cap. PCELL Creation Skill file for RO018 PDK
;; Written by Tetsuya Iizuka, Mon Sep 14 18:09:35 JST 2009
;;
;; Copyright (C) Tetsuya Iizuka <iizuka@vdec.u-tokyo.ac.jp>
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
;;
;; $Id: VdecPcDefinePCell.il,v 1.3 2009/10/21 10:38:02 iizuka Exp $
;;
;; -----------------------------------------------------------------

;;;;;
;;;;; This procedure is executed once at creating target cell.
;;;;;
let((
	( libName	"vdecRO180PDK" )
	( cellName	"mimcap" )
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
			( cInput		baseCellCdf~>cInput~>defValue )
			( l					baseCellCdf~>l~>defValue )
			( c					baseCellCdf~>c~>defValue )
			( btmTerm		baseCellCdf~>btmTerm~>defValue )
			( Csq				baseCellCdf~>Csq~>defValue )
		)

		; Define the contents of the cellview
		let(()

			l	= cdfParseFloatString( l )* 1e6
			w	= cdfParseFloatString( w )* 1e6
			when( btmTerm == "FALSE"	btmTerm = nil )

			VdecCapBody( pcCellView l w btmTerm
				'( "CTM" "drawing" )
				'( "METAL4" "drawing" )
				'( "VIA4" "drawing" )
				'( "METAL5" "drawing" )
			)
		)
	)
)

