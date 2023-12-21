;; -----------------------------------------------------------------
;; 
;; Resistor PCell Body Description Skill File
;; Written by Tetsuya Iizuka, Wed Nov  4 15:57:39 JST 2009
;;
;; Copyright (C) Tetsuya Iizuka <iizuka@vdec.u-tokyo.ac.jp>
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
;;
;; $Id: VdecLpphBody.il,v 1.1 2009/11/04 08:35:01 iizuka Exp $
;;
;; -----------------------------------------------------------------

;;;;;
;;;;; This plocedure is loaded each time.
;;;;;
procedure( VdecLpphBody( cv l w rpoLay lpphLay dumLay polyLay impLay cntLay metalLay )
let((
	mfgGrid
	PolyCenter PolyLower PolyUpper
	MetalLower MetalUpper
	Protect Lpph Dummy ImpUpper ImpLower
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
		?length			l + GlobalDR->PROTECT_PSD_minOverlap * 2
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
	rodAlign(
		?refObj			PolyCenter
		?refHandle		"lowerLeft"
		?alignObj		PolyLower
		?alignHandle	"upperLeft"
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
	rodAlign(
		?refObj			PolyCenter
		?refHandle		"upperLeft"
		?alignObj		PolyUpper
		?alignHandle	"lowerLeft"
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
	ImpUpper	= rodCreateRect(
		?name			"ImpUpper"
		?cvId			cv
		?layer			impLay
		?width			w + GlobalDR->PSD_GATE_minExtension * 2.0
		?length			GlobalDR->GATE_CONT_minEnclosure + GlobalDR->CONT_minWidth +
								GlobalDR->PROTECT_CONT_minSpacing + GlobalDR->PROTECT_PSD_minOverlap +
								GlobalDR->PSD_GATE_minExtension
	)
	rodAlign(
		?refObj			PolyUpper
		?refHandle		"upperCenter"
		?alignObj		ImpUpper
		?alignHandle	"upperCenter"
		?ySep				GlobalDR->PSD_GATE_minExtension
	)
	ImpLower	= rodCreateRect(
		?name			"ImpLower"
		?cvId			cv
		?layer			impLay
		?width			w + GlobalDR->PSD_GATE_minExtension * 2.0
		?length			GlobalDR->GATE_CONT_minEnclosure + GlobalDR->CONT_minWidth +
								GlobalDR->PROTECT_CONT_minSpacing + GlobalDR->PROTECT_PSD_minOverlap +
								GlobalDR->PSD_GATE_minExtension
	)
	rodAlign(
		?refObj			PolyLower
		?refHandle		"lowerCenter"
		?alignObj		ImpLower
		?alignHandle	"lowerCenter"
		?ySep				GlobalDR->PSD_GATE_minExtension * (-1)
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
			?length			l + GlobalDR->PROTECT_PSD_minOverlap * 2.0
		)
		rodAlign(
			?refObj			PolyCenter
			?refHandle		"lowerCenter"
			?alignObj		Protect
			?alignHandle	"lowerCenter"
		)
	)
	;		} End
	;-- Create Protect
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

	;
	;-- Create Lpph
	;		Begin {
	Lpph_Unit = ceiling( GlobalDR->LPPH_GATE_minEnclosure / GlobalDR->LPPH_minGrid )
	Lpph_Enclosure = Lpph_Unit * GlobalDR->LPPH_minGrid

	Lpph	= rodCreateRect(
		?name			"Lpph"
		?cvId			cv
		?layer			lpphLay
		?width			w + Lpph_Enclosure * 2.0
		?length			l + (GlobalDR->GATE_CONT_minEnclosure + GlobalDR->CONT_minWidth +
								GlobalDR->PROTECT_CONT_minSpacing + GlobalDR->PROTECT_PSD_minOverlap + 
								Lpph_Enclosure) * 2.0
	)
	rodAlign(
		?refObj			PolyCenter
		?refHandle		"centerCenter"
		?alignObj		Lpph
		?alignHandle	"centerCenter"
	)
	;		} End
	;-- Create Lpph
	;


)
)
