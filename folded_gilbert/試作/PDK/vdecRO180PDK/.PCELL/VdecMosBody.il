;; -----------------------------------------------------------------
;; 
;; MOS Layout Body Creation Skill File for RO018 PDK
;; Written by Tetsuya Iizuka, Mon Sep 14 15:26:33 JST 2009
;;
;; Copyright (C) Tetsuya Iizuka <iizuka@vdec.u-tokyo.ac.jp>
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
;;
;; $Id: VdecMosBody.il,v 1.9 2009/11/16 09:55:04 iizuka Exp $
;;
;; -----------------------------------------------------------------

;;;;;
;;;;; This plocedure is loaded each time.
;;;;;
procedure( VdecMosBody( cv l w leftSt rightSt leftCnt rightCnt
	wellLay oxideLay oxideLay2 polyLay impLay cntLay metalLay )
let((
	mfgGrid
	abutRuleList pinId obj
	minOxide
	GateCenter GateLower GateUpper
	OxideCenter OxideLeft OxideRight
	MetalLeft MetalRight
	MetalExt MetalWidth MetalLength MetalSep
	WellLeft WellRight ImpLeft ImpRight Diff2Left Diff2Right
	Imp_Unit Imp_Enclosure
	Imp_LeftWidth_Unit Imp_LeftWidth
	Imp_RightWidth_Unit Imp_RightWidth
	Well_Unit Well_Enclosure
	leftSt_Unit leftSt_Width Well_LeftWidth
	rightSt_Unit rightSt_Width Well_RightWidth
	pinIdWell
)

	;
	;--	Initialization
	;
	;; Get MfgGridResolution
	mfgGrid	= GlobalDR->mfgGrid

	;; Get Oxide Min Resolution
	minOxide = GlobalDR->ACTIVE_minGrid

	;; Define Value of the conditions for the oxide stretch
	;;*************************************************************************
	;;                                                        
	;;                       E  +-+ B +-+ D                   
	;;                    +-----+-+---+-+--+                  
	;;     E  +-+  C  +-+ | +-+ | |   | |  | +-+   H          
	;;  +-----+-+-----+-+-+ +-+ | |   | |  +-+-+-------+      
	;;  | +-+ | | +-+ | |G      | |   | |   F| |   +-+ | I    
	;;  | +-+ | | +-+ | |       | |   | |  +-+-+-+ +-+ |      
	;;  |     | |     | |       | |   | |  | +-+ +-----+      
	;;  | +-+ | | +-+ | |   +-+ | |   | |  |                  
	;;  | +-+ | | +-+ | |   +-+ | |   | |  |                  
	;;  +-----+-+-----+-+-------+-+---+-+--+                  
	;;        +-+     +-+       +-+   +-+                     
	;;                                                        
	;;  A = "abutFlush" (Not shown)                           
	;;  B = "abutGateSpaceSeries" (gate to gate space)        
	;;  C = "abutGateSpaceParallel" (contact between gates)   
	;;  D = "abutEncloseGate" (minimum diff enclosing gate)   
	;;  E = "abutEncloseContact"                              
	;;  F = "abutSmallerSeries" (field poly to diff.)         
	;;  G = "abutSmallerParallel" (field poly to diff. cont)  
	;;  H = "abutEncloseDogBoneContact"                       
	;;  I = "abutMinContactWidth"                             
	;;                                                        
	;;*************************************************************************
    abutRuleList = list(
		list( "abutFlush"			0.0 )						;; A
		list( "abutGateSpaceSeries"	GlobalDR->GATE_minSpacing )			;; B
		list( "abutGateSpaceParallel" max(						;; C
			( GlobalDR->CONT_minWidth + 
				GlobalDR->CONT_ACTIVEGATE_minSpacing * 2.0 )
			GlobalDR->GATE_minSpacing
		))
		list( "abutEncloseGate"		GlobalDR->ACTIVE_GATE_minExtension )			;; D
		list( "abutEncloseContact"								;; E
			GlobalDR->ACTIVE_CONT_minEnclosure +
			GlobalDR->CONT_minWidth +
			GlobalDR->CONT_ACTIVEGATE_minSpacing )
		list( "abutSmallerSeries"	max(						;; F
			( GlobalDR->GATE_minSpacing - 
				GlobalDR->ACTIVE_GATE_minExtension )
			GlobalDR->GATE_ACTIVE_minSpacing )
		)
		list( "abutSmallerParallel"	max(						;; G
			( GlobalDR->GATE_minSpacing -
				GlobalDR->CONT_minWidth -
				GlobalDR->CONT_ACTIVEGATE_minSpacing -
				GlobalDR->ACTIVE_CONT_minEnclosure )
			( GlobalDR->CONT_ACTIVEGATE_minSpacing -
				GlobalDR->ACTIVE_CONT_minEnclosure )
			GlobalDR->GATE_ACTIVE_minSpacing )
		)
		list( "abutEncloseDogBoneContact"						;; H
			GlobalDR->CONT_minWidth +
			GlobalDR->ACTIVE_CONT_minEnclosure + 
			max(
				( GlobalDR->GATE_ACTIVE_minSpacing +
					GlobalDR->ACTIVE_CONT_minEnclosure )
				GlobalDR->CONT_ACTIVEGATE_minSpacing 
			)
		)
		list( "abutMinContactWidth"                 ;; I
			GlobalDR->CONT_minWidth + GlobalDR->ACTIVE_CONT_minEnclosure
		)
	)

	;
	;-- Create Gate
	;		Begin {
	;; Center
	GateCenter	= rodCreateRect(
		?name			"GateCenter"
		?cvId			cv
		?layer			polyLay
		?width			l
		?length			w
	)
	rodAlign(
		?alignObj		GateCenter
		?alignHandle	"lowerLeft"
		?refPoint		0:0
	)

	;; Lower
	GateLower	= rodCreateRect(
		?name			"GateLower"
		?cvId			cv
		?layer			polyLay
		?width			l
		?length			GlobalDR->GATE_ACTIVE_minExtension

		?termName		"G"
		?termIOType		"inputOutput"
		?pin			t
		?pinAccessDir	"bottom"
	)
	rodAlign(
		?refObj			GateCenter
		?refHandle		"lowerLeft"
		?alignObj		GateLower
		?alignHandle	"upperLeft"
	)
	GateLower~>dbId~>pin~>name	= "GateLowerPin"

	;; Upper
	GateUpper	= rodCreateRect(
		?name			"GateUpper"
		?cvId			cv
		?layer			polyLay
		?width			l
		?length			GlobalDR->GATE_ACTIVE_minExtension
	)
	rodAlign(
		?refObj			GateCenter
		?refHandle		"upperLeft"
		?alignObj		GateUpper
		?alignHandle	"lowerLeft"
	)
	pinId	= VdecConnectivity(
		"weak"
		GateLower~>dbId~>pin
		GateUpper~>dbId
	)
	pinId~>accessDir	= "top"
	pinId~>name	= "GateUpperPin"

	;		} End
	;-- Create Gate
	;

	;
	;-- Create Oxide
	;		Begin {
	;; Center
	OxideCenter	= rodCreateRect(
		?name			"OxideCenter"
		?cvId			cv
		?layer			oxideLay
		?width			l - minOxide * 2.0
		?length			w
	)
	rodAlign(
		?refObj			GateCenter
		?refHandle		"centerCenter"
		?alignObj		OxideCenter
		?alignHandle	"centerCenter"
	)

	;; Left
	;;		Begin {
	OxideLeft	= rodCreateRect(
		?name			"OxideLeft"
		?cvId			cv
		?layer			oxideLay
		?width			leftSt + minOxide
		?length			w

		?termName		"S"
		?termIOType		"inputOutput"
		?pin			t
		?pinAccessDir	list( "left" "top" "bottom" )
	)
	rodAlign(
		?refObj			OxideCenter
		?refHandle		"lowerLeft"
		?alignObj		OxideLeft
		?alignHandle	"lowerRight"
	)

	;;; ********** Add properties for auto abutment on the oxide shape *****
    obj	= OxideLeft~>dbId
    obj~>pin~>name	= "OxideLeftPin"

	;;; property identifing abutment direction
    dbReplaceProp( obj "abutAccessDir" "list" list( "left" ))

	;;; property to identify the parameter name that turns the contacts on or off
    dbReplaceProp( obj "abutCondInclusion" "string" "leftCnt" )

	;;; property to identify the gate so autoabut knows where the gate edge is
    dbReplaceProp( obj "abutGateNet" "string" "G" )

	;;; property to identify the the abutment class for this cell.
    dbReplaceProp( obj "abutClass" "string" obj~>cellView~>cellName )

	;;; property and value of the conditions for the oxide stretch
    dbReplaceProp( obj "abutMosStretchMat" "list" cons( "leftSt" abutRuleList ))

    ;;; first do the spacing tools properties
    dbReplaceProp( obj "vxlInstSpacingDir" "list" list( "left" ))
    ;;; should be a parameter to the function
    dbReplaceProp( obj "vxlInstSpacingRule" "float" max(
		GlobalDR->ACTIVE_minSpacing GlobalDR->METAL1_minSpacing ) )

	;;		} End
	;; Left

	;; Right
	;;		Begin {
	OxideRight	= rodCreateRect(
		?name			"OxideRight"
		?cvId			cv
		?layer			oxideLay
		?width			rightSt + minOxide
		?length			w

		?termName		"D"
		?termIOType		"inputOutput"
		?pin			t
		?pinAccessDir	list( "right" "top" "bottom" )
	)
	rodAlign(
		?refObj			OxideCenter
		?refHandle		"lowerRight"
		?alignObj		OxideRight
		?alignHandle	"lowerLeft"
	)

	;;; ********** Add properties for auto abutment on the oxide shape *****
    obj	= OxideRight~>dbId
    obj~>pin~>name	= "OxideRightPin"

	;;; property identifing abutment direction
    dbReplaceProp( obj "abutAccessDir" "list" list( "right" ))

	;;; property to identify the parameter name that turns the contacts on or off
    dbReplaceProp( obj "abutCondInclusion" "string" "rightCnt" )

	;;; property to identify the gate so autoabut knows where the gate edge is
    dbReplaceProp( obj "abutGateNet" "string" "G" )

	;;; property to identify the the abutment class for this cell.
    dbReplaceProp( obj "abutClass" "string" obj~>cellView~>cellName )

	;;; property and value of the conditions for the oxide stretch
    dbReplaceProp( obj "abutMosStretchMat" "list" cons( "rightSt" abutRuleList ))

    ;;; first do the spacing tools properties
    dbReplaceProp( obj "vxlInstSpacingDir" "list" list( "right" ))
    ;;; should be a parameter to the function
    dbReplaceProp( obj "vxlInstSpacingRule" "float" max(
		GlobalDR->ACTIVE_minSpacing GlobalDR->METAL1_minSpacing ) )

	;;		} End
	;; Right
	;		} End
	;-- Create Oxide
	;

	;
	;-- Create Metal1
	;		Begin {
	;;
	;; Caluculate dimensions
	;;
	MetalExt	= GlobalDR->CONT_minWidth + GlobalDR->METAL1_CONT_minExtension * 2.0

	MetalWidth	= GlobalDR->CONT_minWidth

	MetalLength	= w

	MetalSep	= GlobalDR->CONT_ACTIVEGATE_minSpacing

	;; Left
	when( leftCnt
		MetalLeft	= rodCreatePath(
			?name			"MetalLeft"
			?cvId			cv
			?layer			metalLay
			?width			MetalWidth
			?pts			list( 0:0 0:MetalLength )
			?endType		"flush"

			?subRect	list( list(
				?layer			cntLay
				?width			GlobalDR->CONT_minWidth
				?length			GlobalDR->CONT_minWidth
				?beginOffset	GlobalDR->ACTIVE_CONT_minEnclosure * (-1.0)
				?endOffset		GlobalDR->ACTIVE_CONT_minEnclosure * (-1.0)
			))
		)
		rodAlign(
			?refObj			GateCenter
			?refHandle		"centerLeft"
			?alignObj		MetalLeft
			?alignHandle	"centerRight"
			?xSep			-MetalSep
		)
		pinId	= VdecConnectivity(
			"strong"
			OxideLeft~>dbId~>pin
			MetalLeft~>dbId
		)
	)

	;; Right
	when( rightCnt
		MetalRight	= rodCreatePath(
			?name			"MetalRight"
			?cvId			cv
			?layer			metalLay
			?width			MetalWidth
			?pts			list( 0:0 0:MetalLength )
			?endType		"flush"

			?subRect	list( list(
				?layer			cntLay
				?width			GlobalDR->CONT_minWidth
				?length			GlobalDR->CONT_minWidth
				?beginOffset	GlobalDR->ACTIVE_CONT_minEnclosure * (-1.0)
				?endOffset		GlobalDR->ACTIVE_CONT_minEnclosure * (-1.0)
			))
		)
		rodAlign(
			?refObj			GateCenter
			?refHandle		"centerRight"
			?alignObj		MetalRight
			?alignHandle	"centerLeft"
			?xSep			MetalSep
		)
		pinId	= VdecConnectivity(
			"strong"
			OxideRight~>dbId~>pin
			MetalRight~>dbId
		)
	)

	;		} End
	;-- Create Metal1
	;

	;
	;-- Create Imp
	;		Begin {
	;; Grid Check
	Imp_Unit = ceiling( GlobalDR->NSD_ACTIVEGATENSD_minEnclosure / GlobalDR->NSD_minGrid )
	Imp_Enclosure = Imp_Unit * GlobalDR->NSD_minGrid

	Imp_LeftWidth_Unit = ceiling( (leftSt + GlobalDR->NSD_NTRSD_minEnclosure ) / GlobalDR->NSD_minGrid )
	Imp_LeftWidth = Imp_LeftWidth_Unit * GlobalDR->NSD_minGrid
	Imp_RightWidth_Unit = ceiling( ( l + rightSt + GlobalDR->NSD_NTRSD_minEnclosure ) / GlobalDR->NSD_minGrid )
	Imp_RightWidth = Imp_RightWidth_Unit * GlobalDR->NSD_minGrid

	ImpLeft	= rodCreateRect(
		?name			"ImpLeft"
		?cvId			cv
		?layer			impLay
		?width			Imp_LeftWidth
		?length			w + Imp_Enclosure * 2.0
	)
	rodAlign(
		?refObj			GateCenter
		?refHandle		"centerLeft"
		?alignObj		ImpLeft
		?alignHandle	"centerRight"
	)
	ImpRight = rodCreateRect(
		?name			"ImpRight"
		?cvId			cv
		?layer			impLay
		?width			Imp_RightWidth
		?length			w + Imp_Enclosure * 2.0
	)
	rodAlign(
		?refObj			GateCenter
		?refHandle		"centerLeft"
		?alignObj		ImpRight
		?alignHandle	"centerLeft"
	)
	;		} End
	;-- Create Imp
	;

	;
	;-- Create Well
	;		Begin {
	when( wellLay
		;; Grid Check
		Well_Unit = ceiling( GlobalDR->NWELL_PACTIVE_minEnclosure / GlobalDR->NWELL_minGrid )
		Well_Enclosure = Well_Unit * GlobalDR->NWELL_minGrid

		leftSt_Unit = ceiling( leftSt / GlobalDR->NWELL_minGrid )
		leftSt_Width = leftSt_Unit * GlobalDR->NWELL_minGrid
		Well_LeftWidth = leftSt_Width + GlobalDR->NWELL_PACTIVE_minEnclosure

		rightSt_Unit = ceiling( rightSt / GlobalDR->NWELL_minGrid )
		rightSt_Width = rightSt_Unit * GlobalDR->NWELL_minGrid
		Well_RightWidth = l + rightSt_Width + GlobalDR->NWELL_PACTIVE_minEnclosure

		WellLeft = rodCreateRect(
			?name			"WellLeft"
			?cvId			cv
			?layer		wellLay
			?width		Well_LeftWidth
			?length		w + Well_Enclosure * 2.0

			?termName		"B"
			?termIOType		"inputOutput"
			?pin			t
			?pinAccessDir	list( "right" "top" "bottom" "left" )
		)
		rodAlign(
			?refObj			GateCenter
			?refHandle		"centerLeft"
			?alignObj		WellLeft
			?alignHandle	"centerRight"
		)
		WellLeft~>dbId~>pin~>name	= "WellLeftPin"

		WellRight = rodCreateRect(
			?name			"WellRight"
			?cvId			cv
			?layer		wellLay
			?width		Well_RightWidth
			?length		w + Well_Enclosure * 2.0
		)
		rodAlign(
			?refObj			GateCenter
			?refHandle		"centerLeft"
			?alignObj		WellRight
			?alignHandle	"centerLeft"
		)
		pinIdWell	= VdecConnectivity(
			"strong"
			WellLeft~>dbId~>pin
			WellRight~>dbId
		)
		pinIdWell~>accessDir	= list( "right" "top" "bottom" "left" )
		pinIdWell~>name	= "WellRightPin"
	)
	;		} End
	;-- Create Well
	;

	;
	;-- Create Diff2
	;		Begin {
	when( oxideLay2
		Diff2Left	= rodCreateRect(
			?name		"Diff2Left"
			?cvId		cv
			?layer	oxideLay2
			?width	max( 
							(leftSt + GlobalDR->DIFF2_ACTIVE_minEnclosure)
							GlobalDR->DIFF2_ACTIVEGATE_minEnclosure )
			?length	w + GlobalDR->DIFF2_ACTIVEGATE_minEnclosure * 2.0
		)
		rodAlign(
			?refObj			GateCenter
			?refHandle		"centerLeft"
			?alignObj		Diff2Left
			?alignHandle	"centerRight"
		)
		Diff2Right	= rodCreateRect(
			?name		"Diff2Right"
			?cvId		cv
			?layer	oxideLay2
			?width	max( 
							(l + rightSt + GlobalDR->DIFF2_ACTIVE_minEnclosure)
							(l + GlobalDR->DIFF2_ACTIVEGATE_minEnclosure) )
			?length	w + GlobalDR->DIFF2_ACTIVEGATE_minEnclosure * 2.0
		)
		rodAlign(
			?refObj			GateCenter
			?refHandle		"centerLeft"
			?alignObj		Diff2Right
			?alignHandle	"centerLeft"
		)
	)

	;		} End
	;-- Create Diff2
	;
)
)


;;;;;
;;;;; This procedure change depending on CDB or OA.
;;;;;
procedure( VdecConnectivity( conn pin fig )
	case( conn
	( "weak"
		dbCreatePin( pin~>net fig )
	)
	( "strong"
		dbAddFigToPin( pin fig )
	)
	)
)

