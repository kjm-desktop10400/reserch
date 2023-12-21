;; -----------------------------------------------------------------
;; 
;; Resistor PCell Body Description Skill File
;; Written by Tetsuya Iizuka, Tue Sep 15 15:38:31 JST 2009
;;
;; Copyright (C) Tetsuya Iizuka <iizuka@vdec.u-tokyo.ac.jp>
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
;;
;; $Id: VdecResBody.il,v 1.4 2009/11/05 10:27:18 iizuka Exp $
;;
;; -----------------------------------------------------------------

;;;;;
;;;;; This plocedure is loaded each time.
;;;;;
procedure( VdecResBody( cv l w rpoLay dumLay polyLay impLay cntLay metalLay wellLay )
let((
	mfgGrid
	PolyCenter PolyLower PolyUpper
	MetalLower MetalUpper
	Protect Dummy Imp Well
	impLength impExtension
	wellLength
)
	;
	;--	Initialization
	;
	;; Get MfgGridResolution
	mfgGrid	= GlobalDR->mfgGrid

	;
	;-- Create Poly
	;		Begin {
	;; Center
	PolyCenter	= rodCreateRect(
		?name			"PolyCenter"
		?cvId			cv
		?layer			polyLay
		?width			w
		?length			l
	)
	rodAlign(
		?alignObj		PolyCenter
		?alignHandle	"lowerLeft"
		?refPoint		0:0
	)

	;; Lower
	PolyLower	= rodCreateRect(
		?name			"PolyLower"
		?cvId			cv
		?layer			polyLay
		?width			w
		?length			GlobalDR->GATE_CONT_minEnclosure + GlobalDR->CONT_minWidth +
								GlobalDR->PROTECT_CONT_minSpacing

		?termName		"PLUS"
		?termIOType		"inputOutput"
		?pin			t
		?pinAccessDir	list( "right" "left" "bottom" )
	)
	when( rpoLay
		rodAlign(
			?refObj			PolyCenter
			?refHandle		"lowerLeft"
			?alignObj		PolyLower
			?alignHandle	"upperLeft"
		)
	)
	when( !rpoLay
		rodAlign(
			?refObj			PolyCenter
			?refHandle		"lowerLeft"
			?alignObj		PolyLower
			?alignHandle	"lowerLeft"
			?ySep				(GlobalDR->CONT_minWidth * 0.5 + GlobalDR->GATE_CONT_minEnclosure) * (-1.0)
		)
	)
	PolyLower~>dbId~>pin~>name	= "PolyLowerPin"

	;; Upper
	PolyUpper	= rodCreateRect(
		?name			"PolyUpper"
		?cvId			cv
		?layer			polyLay
		?width			w
		?length			GlobalDR->GATE_CONT_minEnclosure + GlobalDR->CONT_minWidth +
								GlobalDR->PROTECT_CONT_minSpacing

		?termName		"MINUS"
		?termIOType		"inputOutput"
		?pin			t
		?pinAccessDir	list( "right" "left" "top" )
	)
	when( rpoLay
		rodAlign(
			?refObj			PolyCenter
			?refHandle		"upperLeft"
			?alignObj		PolyUpper
			?alignHandle	"lowerLeft"
		)
	)
	when( !rpoLay
		rodAlign(
			?refObj			PolyCenter
			?refHandle		"upperLeft"
			?alignObj		PolyUpper
			?alignHandle	"upperLeft"
			?ySep				GlobalDR->CONT_minWidth * 0.5 + GlobalDR->GATE_CONT_minEnclosure
		)
	)
	PolyUpper~>dbId~>pin~>name	= "PolyUpperPin"
	;		} End
	;-- Create Poly
	;

	;
	;-- Create Metal
	;		Begin {
	;; Lower
	MetalLower	= rodCreatePath(
		?name			"MetalLower"
		?cvId			cv
		?layer		metalLay
		?width		GlobalDR->CONT_minWidth
		?pts			list( 0:0 w:0 )
		?endType		"flush"

		?subRect	list( list(
			?layer			cntLay
			?width			GlobalDR->CONT_minWidth
			?length			GlobalDR->CONT_minWidth
			?beginOffset	GlobalDR->GATE_CONT_minEnclosure * (-1.0)
			?endOffset		GlobalDR->GATE_CONT_minEnclosure * (-1.0)
		))
	)
	rodAlign(
		?refObj			PolyLower
		?refHandle		"lowerCenter"
		?alignObj		MetalLower
		?alignHandle	"lowerCenter"
		?ySep				GlobalDR->GATE_CONT_minEnclosure
	)
	pinId	= VdecConnectivity(
		"strong"
		PolyLower~>dbId~>pin
		MetalLower~>dbId
	)
	;; Upper
	MetalUpper	= rodCreatePath(
		?name			"MetalUpper"
		?cvId			cv
		?layer		metalLay
		?width		GlobalDR->CONT_minWidth
		?pts			list( 0:0 w:0 )
		?endType		"flush"

		?subRect	list( list(
			?layer			cntLay
			?width			GlobalDR->CONT_minWidth
			?length			GlobalDR->CONT_minWidth
			?beginOffset	GlobalDR->GATE_CONT_minEnclosure * (-1.0)
			?endOffset		GlobalDR->GATE_CONT_minEnclosure * (-1.0)
		))
	)
	rodAlign(
		?refObj			PolyUpper
		?refHandle		"upperCenter"
		?alignObj		MetalUpper
		?alignHandle	"upperCenter"
		?ySep				GlobalDR->GATE_CONT_minEnclosure * (-1.0)
	)
	pinId	= VdecConnectivity(
		"strong"
		PolyUpper~>dbId~>pin
		MetalUpper~>dbId
	)
	;		} End
	;-- Create Metal
	;

	;
	;-- Create Imp
	;		Begin {
	case( polyLay
	( '( "GATE" "drawing" )
		impExtension = GlobalDR->PSD_GATE_minExtension
	)
	( '( "ACTIVE" "drawing" )
		impExtension = GlobalDR->NSD_NTRSD_minEnclosure
	) )
	when( rpoLay
		Imp	= rodCreateRect(
			?name			"Imp"
			?cvId			cv
			?layer			impLay
			?width			w + impExtension * 2.0
			?length			l + ( GlobalDR->GATE_CONT_minEnclosure + GlobalDR->CONT_minWidth +
									GlobalDR->PROTECT_CONT_minSpacing  + impExtension ) * 2.0
		)
	)
	when( !rpoLay
			impLength = l + (ceiling( (GlobalDR->GATE_CONT_minEnclosure + GlobalDR->CONT_minWidth / 2.0) / GlobalDR->NSD_minGrid ) * GlobalDR->NSD_minGrid + impExtension) * 2.0
		Imp	= rodCreateRect(
			?name			"Imp"
			?cvId			cv
			?layer			impLay
			?width			w + impExtension * 2.0
			?length			impLength
		)
	)
	rodAlign(
		?refObj			PolyCenter
		?refHandle		"centerCenter"
		?alignObj		Imp
		?alignHandle	"centerCenter"
	)
	;		} End
	;-- Create Imp
	;

	;
	;-- Create Protect
	;		Begin {
	when( rpoLay
		Protect	= rodCreateRect(
			?name			"Protect"
			?cvId			cv
			?layer			rpoLay
			?width			w + GlobalDR->PROTECT_GATE_minExtension * 2.0
			?length			l 
		)
		rodAlign(
			?refObj			PolyCenter
			?refHandle		"centerCenter"
			?alignObj		Protect
			?alignHandle	"centerCenter"
		)
	)
	;		} End
	;-- Create Protect
	;

	;
	;-- Create Well
	;		Begin {
	when( wellLay
		when( rpoLay
			wellLength = l + (GlobalDR->GATE_CONT_minEnclosure + GlobalDR->CONT_minWidth +
								GlobalDR->PROTECT_CONT_minSpacing + 
								GlobalDR->NWELL_PACTIVE_minEnclosure) * 2.0
		)
		when( !rpoLay
			wellLength = l + (ceiling( (GlobalDR->GATE_CONT_minEnclosure + GlobalDR->CONT_minWidth / 2.0) / GlobalDR->NSD_minGrid ) * GlobalDR->NSD_minGrid + GlobalDR->NWELL_PACTIVE_minEnclosure) * 2.0
		)
		Well = rodCreateRect(
			?name			"Well"
			?cvId			cv
			?layer			wellLay
			?width			w + GlobalDR->NWELL_PACTIVE_minEnclosure * 2.0
			?length			wellLength

			?termName		"well"
			?termIOType		"inputOutput"
			?pin			t
			?pinAccessDir	list( "right" "left" "top" "bottom" )
		)
		rodAlign(
			?refObj			PolyCenter
			?refHandle		"centerCenter"
			?alignObj		Well
			?alignHandle	"centerCenter"
		)
		Well~>dbId~>pin~>name	= "WellPin"
	)
	;		} End
	;-- Create Well
	;

	;
	;-- Create Dummy
	;		Begin {
	Dummy	= rodCreateRect(
		?name			"Dummy"
		?cvId			cv
		?layer			dumLay
		?width			w + GlobalDR->PROTECT_GATE_minExtension * 2.0
		?length			l 
	)
	rodAlign(
		?refObj			PolyCenter
		?refHandle		"centerCenter"
		?alignObj		Dummy
		?alignHandle	"centerCenter"
	)
	;		} End
	;-- Create Imp
	;


)
)
