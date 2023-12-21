;;; -----------------------------------------------------------------
;; 
;; Capacitor PCell Body Description Skill File
;; Written by Tetsuya Iizuka, Tue Sep 15 22:30:21 JST 2009
;;
;; Copyright (C) Tetsuya Iizuka <iizuka@vdec.u-tokyo.ac.jp>
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
;;
;; $Id: VdecCapBody.il,v 1.6 2010/05/12 06:21:03 iizuka Exp $
;;
;; -----------------------------------------------------------------

;;;;;
;;;;; This plocedure is loaded each time.
;;;;;
procedure( VdecCapBody( cv l w btmTerm ctmLay metalLay1 viaLay metalLay2 )
let((
	mfgGrid
	CtmCenter MetalCenter MetalLower MetalUpper
	BtmTermUpper BtmTermLower
	m1blklayer m2blklayer m3blklayer
	M1Blk M2Blk M3Blk
	MetalLay2Length viaNum viaOffset
)
	;
	;--	Initialization
	;
	;; Get MfgGridResolution
	mfgGrid	= GlobalDR->mfgGrid

	;; !! NO GRID CHECK IS REQUIRED FOR MIM CAP !! 
	;; Since the input step of w/l size is 
	;; determined by CTM grid resolution (0.04).
	;; Resolutions of the other layers(METAL4,VIA4,METAL5)
	;; are 0.02 which is smaller than 0.04.

	;
	;-- Create CTM
	;		Begin {
	;; Center
	CtmCenter	= rodCreateRect(
		?name			"CtmCenter"
		?cvId			cv
		?layer			ctmLay
		?width			w
		?length			l
	)
	rodAlign(
		?alignObj		CtmCenter
		?alignHandle	"lowerLeft"
		?refPoint		0:0
	)
	;		} End
	;-- Create CTM
	;

	;
	;-- Create Metal Blockages
	;		Begin {
	;; No Via and Metal Layers under CTM region are allowed
	dbCreateLayerBlockage(
												cv
												"GATE"
												"routing"
												list( 0:0 0:l w:l w:0 )
											 )
	dbCreateLayerBlockage(
												cv
												"METAL1"
												"routing"
												list( 0:0 0:l w:l w:0 )
											 )
	dbCreateLayerBlockage(
												cv
												"METAL2"
												"routing"
												list( 0:0 0:l w:l w:0 )
											 )
	dbCreateLayerBlockage(
												cv
												"METAL3"
												"routing"
												list( 0:0 0:l w:l w:0 )
											 )
	;		} End
	;-- Create Metal Blockages
	;

	;
	;-- Create Metal4
	;;
  ;; Calculate the number of VIA4 and begin Offset
	;; 
	MetalLay2Length = w - (GlobalDR->CTM_VIA4_minEnclosure - 
											 	 GlobalDR->METAL5_VIA4_minEnclosure) * 2.0
	viaNum = floor( (w - GlobalDR->CTM_VIA4_minEnclosure - GlobalDR->VIA4_minWidth) / 
					 (GlobalDR->VIA4_minWidth + GlobalDR->VIA4_minSpacing) )
	viaOffset = ( MetalLay2Length - GlobalDR->VIA4_minWidth -
              ( GlobalDR->VIA4_minWidth + GlobalDR->VIA4_minSpacing ) * viaNum ) / 2
	
	;		Begin {
	;; Center
	when( !btmTerm
		;; Bottom Metal Plate
		MetalCenter	= rodCreateRect(
			?name			"MetalCenter"
			?cvId			cv
			?layer			metalLay1
			?width			w + GlobalDR->METAL4_CTM_minEnclosure * 2.0
			?length			l + GlobalDR->METAL4_CTM_minEnclosure * 2.0
	
			?termName		"MINUS"
			?termIOType		"inputOutput"
			?pin			t
			?pinAccessDir	list( "right" "left" "bottom" "top" )
		)
	)
	when( btmTerm
		;; Bottom Metal Plate
		MetalCenter	= rodCreateRect(
			?name			"MetalCenter"
			?cvId			cv
			?layer			metalLay1
			?width			w + GlobalDR->METAL4_CTM_minEnclosure * 2.0
			?length			l + GlobalDR->METAL4_CTM_minEnclosure * 2.0 +
									(GlobalDR->VIA4_minWidth + GlobalDR->METAL5_VIA4_minEnclosure * 2.0 + GlobalDR->METAL5_minSpacing - (GlobalDR->CTM_VIA4_minEnclosure - GlobalDR->METAL5_VIA4_minEnclosure) - GlobalDR->METAL4_CTM_minEnclosure) * 2.0
		)
		;; MINUS Terminal to Upper Metal (Upper Pin)
		BtmTermUpper = rodCreatePath(
			?name			"BtmTermUpper"
			?cvId			cv
			?layer		metalLay2
			?width		GlobalDR->VIA4_minWidth + GlobalDR->METAL5_VIA4_minEnclosure * 2.0
			?pts			list( 0:0 MetalLay2Length:0 )
			?endType		"flush"
	
			?termName		"MINUS"
			?termIOType		"inputOutput"
			?pin			t
			?pinAccessDir	list( "right" "left" "top" )
	
			?subRect	list( list(
				?layer			viaLay
				?width			GlobalDR->VIA4_minWidth
				?length			GlobalDR->VIA4_minWidth
				?gap				'minimum
				?space			GlobalDR->VIA4_minSpacing
				?beginOffset	viaOffset * (-1.0)
			))
			)
		rodAlign(
			?refObj			MetalCenter
			?refHandle		"upperCenter"
			?alignObj		BtmTermUpper
			?alignHandle	"upperCenter"
		)
		BtmTermUpper~>dbId~>pin~>name	= "BtmTermUpperPin"

		;; MINUS Terminal to Upper Metal (Lower Pin)
		BtmTermLower = rodCreatePath(
			?name			"BtmTermLower"
			?cvId			cv
			?layer		metalLay2
			?width		GlobalDR->VIA4_minWidth + GlobalDR->METAL5_VIA4_minEnclosure * 2.0
			?pts			list( 0:0 MetalLay2Length:0 )
			?endType		"flush"
	
			?subRect	list( list(
				?layer			viaLay
				?width			GlobalDR->VIA4_minWidth
				?length			GlobalDR->VIA4_minWidth
				?gap				'minimum
				?space			GlobalDR->VIA4_minSpacing
				?beginOffset	viaOffset * (-1.0)
			))
		)
		rodAlign(
			?refObj			MetalCenter
			?refHandle		"lowerCenter"
			?alignObj		BtmTermLower
			?alignHandle	"lowerCenter"
		)
		pinIdBtm = VdecConnectivity(
			"strong"
			BtmTermUpper~>dbId~>pin
			BtmTermLower~>dbId
		)
		pinIdBtm~>accessDir	= list( "right" "left" "bottom" )
		pinIdBtm~>name	= "BtmTermLowerPin"
	)
	;; Align Top and Bottom Metals
	rodAlign(
		?refObj			CtmCenter
		?refHandle		"centerCenter"
		?alignObj		MetalCenter
		?alignHandle	"centerCenter"
	)
	;		} End
	;-- Create Metal4
	;

	;
	;-- Create Metal5
	;		Begin {
	;; Lower
	MetalLower	= rodCreatePath(
		?name			"MetalLower"
		?cvId			cv
		?layer		metalLay2
		?width		GlobalDR->VIA4_minWidth + GlobalDR->METAL5_VIA4_minEnclosure * 2.0
		?pts			list( 0:0 MetalLay2Length:0 )
		?endType		"flush"

		?termName		"PLUS"
		?termIOType		"inputOutput"
		?pin			t
		?pinAccessDir	list( "right" "left" "bottom" )

		?subRect	list( list(
			?layer			viaLay
			?width			GlobalDR->VIA4_minWidth
			?length			GlobalDR->VIA4_minWidth
			?gap				'minimum
			?space			GlobalDR->VIA4_minSpacing
			?beginOffset	viaOffset * (-1.0)
		))
	)
	rodAlign(
		?refObj			CtmCenter
		?refHandle		"lowerCenter"
		?alignObj		MetalLower
		?alignHandle	"lowerCenter"
		?ySep				GlobalDR->CTM_VIA4_minEnclosure - GlobalDR->METAL5_VIA4_minEnclosure
	)
	MetalLower~>dbId~>pin~>name	= "MetalLowerPin"

	;; Upper
	MetalUpper	= rodCreatePath(
		?name			"MetalUpper"
		?cvId			cv
		?layer		metalLay2
		?width		GlobalDR->VIA4_minWidth + GlobalDR->METAL5_VIA4_minEnclosure * 2.0
		?pts			list( 0:0 MetalLay2Length:0 )
		?endType		"flush"

		?subRect	list( list(
			?layer			viaLay
			?width			GlobalDR->VIA4_minWidth
			?length			GlobalDR->VIA4_minWidth
			?gap				'minimum
			?space			GlobalDR->VIA4_minSpacing
			?beginOffset	viaOffset * (-1.0)
		))
	)
	rodAlign(
		?refObj			CtmCenter
		?refHandle		"upperCenter"
		?alignObj		MetalUpper
		?alignHandle	"upperCenter"
		?ySep				GlobalDR->METAL5_VIA4_minEnclosure - GlobalDR->CTM_VIA4_minEnclosure
	)
	pinId	= VdecConnectivity(
		"strong"
		MetalLower~>dbId~>pin
		MetalUpper~>dbId
	)
	pinId~>accessDir	= list( "right" "left" "top" )
	pinId~>name	= "MetalUpperPin"

	;		} End
	;-- Create Metal
	;

)
)
