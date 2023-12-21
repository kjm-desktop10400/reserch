;; -----------------------------------------------------------------
;; 
;; Skill File to Get Deign Rule Parameter from Techfile
;; Written by Tetsuya Iizuka, Tue Sep 15 13:37:43 JST 2009
;;
;; Copyright (C) Tetsuya Iizuka <iizuka@vdec.u-tokyo.ac.jp>
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
;;
;; $Id: VdecGetGlobalDR.il,v 1.8 2009/11/04 08:35:01 iizuka Exp $
;;
;; -----------------------------------------------------------------

let( (
			libDd
			techId
		 )
;
;--	Get Technology File ID
libDd	= ddGetObj( "vdecRO180PDK" )
techId = techGetTechFile( libDd )
;--	End Get Technology File ID
;

GlobalDR	= list( nil )
;; Get MfgGridResolution
GlobalDR->mfgGrid	= techGetMfgGridResolution( techId )
;; Get minimum grid resolution for each layer
GlobalDR->ACTIVE_minGrid = techGetLayerMfgResolution( techId "ACTIVE" )
GlobalDR->NWELL_minGrid = techGetLayerMfgResolution( techId "NWELL" )
GlobalDR->DIFF2_minGrid = techGetLayerMfgResolution( techId "DIFF2" )
GlobalDR->GATE_minGrid = techGetLayerMfgResolution( techId "GATE" )
GlobalDR->NSD_minGrid = techGetLayerMfgResolution( techId "NSD" )
GlobalDR->PSD_minGrid = techGetLayerMfgResolution( techId "PSD" )
GlobalDR->PROTECT_minGrid = techGetLayerMfgResolution( techId "PROTECT" )
GlobalDR->CONT_minGrid = techGetLayerMfgResolution( techId "CONT" )
GlobalDR->METAL1_minGrid = techGetLayerMfgResolution( techId "METAL1" )
GlobalDR->METAL4_minGrid = techGetLayerMfgResolution( techId "METAL4" )
GlobalDR->VIA4_minGrid = techGetLayerMfgResolution( techId "VIA4" )
GlobalDR->CTM_minGrid = techGetLayerMfgResolution( techId "CTM" )
GlobalDR->METAL5_minGrid = techGetLayerMfgResolution( techId "METAL5" )
GlobalDR->LPPH_minGrid = techGetLayerMfgResolution( techId "LPPH" )

;; GATE minimum spacing
GlobalDR->GATE_minSpacing	= techGetSpacingRule( techId "minSpacing" "GATE" )
;; CONT minimum width
GlobalDR->CONT_minWidth = techGetSpacingRule( techId "minWidth" "CONT" ) 
;; CONT minimum spacing
GlobalDR->CONT_minSpacing = techGetSpacingRule( techId "minSpacing" "CONT" ) 
;; CONT ACTIVEGATE minimum spacing
GlobalDR->CONT_ACTIVEGATE_minSpacing = techGetSpacingRule( techId "minSpacing" "CONT" "ACTIVEGATE" ) + GlobalDR->mfgGrid ;; To Snap S/D Metal Path Center to 0.02 Grid
;;GlobalDR->CONT_ACTIVEGATE_minSpacing = techGetSpacingRule( techId "minSpacing" "CONT" "ACTIVEGATE" ) 
;; ACTIVE minimum extension from GATE region
GlobalDR->ACTIVE_GATE_minExtension = techGetOrderedSpacingRule( techId "minExtension" "ACTIVE" "GATE" )
;; ACTIVE CONT minimum enclosure
GlobalDR->ACTIVE_CONT_minEnclosure = techGetOrderedSpacingRule( techId "minEnclosure" "ACTIVE" "CONT" ) + GlobalDR->mfgGrid ;; To Snap S/D Metal Path Center to 0.02 Grid
;;GlobalDR->ACTIVE_CONT_minEnclosure = techGetOrderedSpacingRule( techId "minEnclosure" "ACTIVE" "CONT" ) 
;; GATE ACTIVE minimum spacing
GlobalDR->GATE_ACTIVE_minSpacing = techGetSpacingRule( techId "minSpacing" "GATE" "ACTIVE" )
;; GATE minimum extension from ACTIVE region
GlobalDR->GATE_ACTIVE_minExtension = techGetOrderedSpacingRule( techId "minExtension" "GATE" "ACTIVE" )
;; ACTIVE minimum Spacing
GlobalDR->ACTIVE_minSpacing = techGetSpacingRule( techId "minSpacing" "ACTIVE" )
;; METAL1 minimum Spacing
GlobalDR->METAL1_minSpacing = nth( 2 techGetSpacingRuleTable( techId "minSpacing" "METAL1" ) )
;; METAL1 minimum extension from CONT
GlobalDR->METAL1_CONT_minExtension = nth( 1 nth( 2 techGetSpacingRuleTable( techId "minOppExtension" "METAL1" "CONT" ) ) )
;; NSD ACTIVEGATENSD minimun enclosure
GlobalDR->NSD_ACTIVEGATENSD_minEnclosure = techGetOrderedSpacingRule( techId "minEnclosure" "NSD" "ACTIVEGATENSD" )
;; NSD NTRSD minimum enclosure 
GlobalDR->NSD_NTRSD_minEnclosure = techGetOrderedSpacingRule( techId "minEnclosure" "NSD" "NTRSD" )
;; NWELL PACTIVE minimum enclosure
GlobalDR->NWELL_PACTIVE_minEnclosure = techGetOrderedSpacingRule( techId "minEnclosure" "NWELL" "PACTIVE" )
;; DIFF2 ACTIVE minimum enclosure
GlobalDR->DIFF2_ACTIVE_minEnclosure = techGetOrderedSpacingRule( techId "minEnclosure" "DIFF2" "ACTIVE" )
;; DIFF2 ACTIVEGATE minimum enclosure
GlobalDR->DIFF2_ACTIVEGATE_minEnclosure = techGetOrderedSpacingRule( techId "minEnclosure" "DIFF2" "ACTIVEGATE" )

;; GATE CONT minimum enclosure
GlobalDR->GATE_CONT_minEnclosure = techGetOrderedSpacingRule( techId "minEnclosure" "GATE" "CONT" )
;; PROTECT to CONT minimum spacing
GlobalDR->PROTECT_CONT_minSpacing = techGetSpacingRule( techId "minSpacing" "PROTECT" "CONT" )
;; PSD GATE minimum extension
GlobalDR->PSD_GATE_minExtension = techGetOrderedSpacingRule( techId "minExtension" "NSD" "GATE" )
;; PROTECT GATE minimum extension
GlobalDR->PROTECT_GATE_minExtension = techGetOrderedSpacingRule( techId "minExtension" "PROTECT" "GATE" )

;; METAL4 CTM minimum enclosure
GlobalDR->METAL4_CTM_minEnclosure = techGetOrderedSpacingRule( techId "minEnclosure" "METAL4" "CTM" )
;; VIA4 minimum width
GlobalDR->VIA4_minWidth = techGetSpacingRule( techId "minWidth" "VIA4" )
;; VIA4 minimum space on CTM
GlobalDR->VIA4_minSpacing = techGetSpacingRule( techId "minSpacing" "CTMVIA4" )
;; METAL5 VIA4 minimum enclosure
GlobalDR->METAL5_VIA4_minEnclosure = nth( 2 techGetSpacingRuleTable( techId "minEnclosure" "METAL5" "VIA4" ) ) 
;; CTM VIA4 minimum enclosure
GlobalDR->CTM_VIA4_minEnclosure = techGetOrderedSpacingRule( techId "minEnclosure" "CTM" "CTMVIA4" )
;; METAL5 minimum Spacing for Wide Metal
GlobalDR->METAL5_minSpacing = nth( 4 techGetSpacingRuleTable( techId "minSpacing" "METAL5" ) )

;; for LPPH
GlobalDR->PROTECT_PSD_minOverlap = techGetSpacingRule( techId "minOverlap" "PROTECT" "LPPHGATEPSD" )
GlobalDR->LPPH_GATE_minEnclosure = techGetOrderedSpacingRule( techId "minEnclosure" "LPPH" "GATE" )
)
