;; -----------------------------------------------------------------
;; 
;; CDF Creation Skill File for RO018 PDK Development
;; Written by Tetsuya Iizuka, Mon Sep 14 15:05:30 JST 2009
;;
;; Copyright (C) Tetsuya Iizuka <iizuka@vdec.u-tokyo.ac.jp>
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
;;
;; $Id: VdecCreateMosCDF.il,v 1.7 2010/07/20 00:26:17 iizuka Exp $
;;
;; -----------------------------------------------------------------

;;;;;
;;;;; This procedure is executed once at creating target cell.
;;;;;
procedure( VdecCreateMosCDF( TargetLibName TargetCellName )
let((
	cellDd
	BaseCellCDF
	paramCdf
	oxideSt
)

	cellDd	= ddGetObj( TargetLibName TargetCellName )
	unless( BaseCellCDF = cdfGetBaseCellCDF( cellDd )
		BaseCellCDF	= cdfCreateBaseCellCDF( cellDd )
	)

	;
	;--	Create model
	;		Begin {
	when( paramCdf = cdfFindParamByName( BaseCellCDF "model" )
		cdfDeleteParam( paramCdf )
	)
	case( TargetCellName
	( "nmos18"
		cdfCreateParam( BaseCellCDF
			?name			"model"
			?prompt			"Model Name"
			?type			"string"
			?defValue		"N"
			?display		"t"
			?editable		"t"
			?parseAsCEL		"yes"
		)
	)
	( "pmos18"
		cdfCreateParam( BaseCellCDF
			?name			"model"
			?prompt			"Model Name"
			?type			"string"
			?defValue		"P"
			?display		"t"
			?editable		"t"
			?parseAsCEL		"yes"
		)
	)
	( "nmos33"
		cdfCreateParam( BaseCellCDF
			?name			"model"
			?prompt			"Model Name"
			?type			"string"
			?defValue		"ND"
			?display		"t"
			?editable		"t"
			?parseAsCEL		"yes"
		)
	)
	( "pmos33"
		cdfCreateParam( BaseCellCDF
			?name			"model"
			?prompt			"Model Name"
			?type			"string"
			?defValue		"PD"
			?display		"t"
			?editable		"t"
			?parseAsCEL		"yes"
		)
	))
	;		} End
	;--	Create l
	;

	;
	;--	Create l
	;		Begin {
	when( paramCdf = cdfFindParamByName( BaseCellCDF "l" )
		cdfDeleteParam( paramCdf )
	)
	case( TargetCellName
	( "nmos18"
		cdfCreateParam( BaseCellCDF
			?name			"l"
			?prompt			"Gate Length"
			?callback		"VdecMosCB( 'l \"180n\" \"5u\" \"20n\" )"
			?type			"string"
			?units			"lengthMetric"
			?defValue		"180n"
			?display		"t"
			?editable		"t"
			?parseAsNumber	"yes"
			?parseAsCEL		"yes"
		)
	)
	( "pmos18"
		cdfCreateParam( BaseCellCDF
			?name			"l"
			?prompt			"Gate Length"
			?callback		"VdecMosCB( 'l \"180n\" \"5u\" \"20n\" )"
			?type			"string"
			?units			"lengthMetric"
			?defValue		"180n"
			?display		"t"
			?editable		"t"
			?parseAsNumber	"yes"
			?parseAsCEL		"yes"
		)
	)
	( "nmos33"
		cdfCreateParam( BaseCellCDF
			?name			"l"
			?prompt			"Gate Length"
			?callback		"VdecMosCB( 'l \"360n\" \"5u\" \"20n\" )"
			?type			"string"
			?units			"lengthMetric"
			?defValue		"360n"
			?display		"t"
			?editable		"t"
			?parseAsNumber	"yes"
			?parseAsCEL		"yes"
		)
	)
	( "pmos33"
		cdfCreateParam( BaseCellCDF
			?name			"l"
			?prompt			"Gate Length"
			?callback		"VdecMosCB( 'l \"300n\" \"5u\" \"20n\" )"
			?type			"string"
			?units			"lengthMetric"
			?defValue		"300n"
			?display		"t"
			?editable		"t"
			?parseAsNumber	"yes"
			?parseAsCEL		"yes"
		)
	)
	)
	;		} End
	;--	Create l
	;

	;
	;--	Create w
	;		Begin {
	when( paramCdf = cdfFindParamByName( BaseCellCDF "w" )
		cdfDeleteParam( paramCdf )
	)
	case( TargetCellName
	( "nmos18"
		cdfCreateParam( BaseCellCDF
			?name			"w"
			?prompt			"Width"
			?callback		"VdecMosCB( 'w \"220n\" \"50u\" \"20n\" )"
			?type			"string"
			?units			"lengthMetric"
			?defValue		"1.0u"
			?display		"t"
			?editable		"t"
			?parseAsNumber	"yes"
			?parseAsCEL		"yes"
		)
	)
	( "pmos18"
		cdfCreateParam( BaseCellCDF
			?name			"w"
			?prompt			"Width"
			?callback		"VdecMosCB( 'w \"220n\" \"50u\" \"20n\" )"
			?type			"string"
			?units			"lengthMetric"
			?defValue		"1.0u"
			?display		"t"
			?editable		"t"
			?parseAsNumber	"yes"
			?parseAsCEL		"yes"
		)
	)
	( "nmos33"
		cdfCreateParam( BaseCellCDF
			?name			"w"
			?prompt			"Width"
			?callback		"VdecMosCB( 'w \"220n\" \"50u\" \"20n\" )"
			?type			"string"
			?units			"lengthMetric"
			?defValue		"1.0u"
			?display		"t"
			?editable		"t"
			?parseAsNumber	"yes"
			?parseAsCEL		"yes"
		)
	)
	( "pmos33"
		cdfCreateParam( BaseCellCDF
			?name			"w"
			?prompt			"Width"
			?callback		"VdecMosCB( 'w \"220n\" \"50u\" \"20n\" )"
			?type			"string"
			?units			"lengthMetric"
			?defValue		"1.0u"
			?display		"t"
			?editable		"t"
			?parseAsNumber	"yes"
			?parseAsCEL		"yes"
		)
	)
	)
	;		} End
	;--	Create w
	;

	;
	;--	Create m
	;		Begin {
	when( paramCdf = cdfFindParamByName( BaseCellCDF "m" )
		cdfDeleteParam( paramCdf )
	)
	cdfCreateParam( BaseCellCDF
		?name			"m"
		?prompt			"Multiplier"
		?callback		""
		?type			"string"
		?defValue		""
		?display		"t"
		?editable		"t"
		?parseAsNumber	"yes"
		?parseAsCEL		"yes"
	)
	;		} End
	;--	Create w
	;

	;
	;--	Create leftSt
	;		Begin {
	;; Calculate dimension
	oxideSt	= GlobalDR->CONT_minWidth + GlobalDR->ACTIVE_CONT_minEnclosure + 
						GlobalDR->CONT_ACTIVEGATE_minSpacing

	;; Define
	when( paramCdf = cdfFindParamByName( BaseCellCDF "leftSt" )
		cdfDeleteParam( paramCdf )
	)
	cdfCreateParam( BaseCellCDF
		?name			"leftSt"
		?prompt			"Left side diff. length"
		?type			"float"
		?defValue		oxideSt
		?display		"nil"	;; Normal
		;;?display		"t"		;; DEBUG
		;;?editable		"t"
	)
	;		} End
	;--	Create leftSt
	;

	;
	;--	Create rightSt
	;		Begin {
	;; Define
	when( paramCdf = cdfFindParamByName( BaseCellCDF "rightSt" )
		cdfDeleteParam( paramCdf )
	)
	cdfCreateParam( BaseCellCDF
		?name			"rightSt"
		?prompt			"Right side diff. length"
		?type			"float"
		?defValue		oxideSt
		?display		"nil"	;; Normal
		;;?display		"t"		;; DEBUG
		;;?editable		"t"
	)
	;		} End
	;--	Create rightSt
	;

	;
	;--	Create leftCnt
	;		Begin {
	;; Define
	when( paramCdf = cdfFindParamByName( BaseCellCDF "leftCnt" )
		cdfDeleteParam( paramCdf )
	)
	cdfCreateParam( BaseCellCDF
		?name			"leftCnt"
		?prompt			"Left side contact"
		?type			"boolean"
		?defValue		"t"
	;;	?display		"nil"	;; Normal
		?display		"t"		;; DEBUG
		?editable		"t"
	)
	;		} End
	;--	Create leftCnt
	;

	;
	;--	Create rightCnt
	;		Begin {
	;; Define
	when( paramCdf = cdfFindParamByName( BaseCellCDF "rightCnt" )
		cdfDeleteParam( paramCdf )
	)
	cdfCreateParam( BaseCellCDF
		?name			"rightCnt"
		?prompt			"Right side contact"
		?type			"boolean"
		?defValue		"t"
	;;	?display		"nil"	;; Normal
		?display		"t"		;; DEBUG
		?editable		"t"
	)
	;		} End
	;--	Create rightCnt
	;

	;
	;--	Create ad
	;		Begin {
	;; Define
	when( paramCdf = cdfFindParamByName( BaseCellCDF "ad" )
		cdfDeleteParam( paramCdf )
	)
	cdfCreateParam( BaseCellCDF
		?name			"ad"
		?prompt			"Drain diffusion area"
		?type			"string"
		?defValue		""
		?display		"t"
		?editable		"t"
		?parseAsNumber	"yes"
		?parseAsCEL		"yes"
	)
	;		} End
	;--	Create ad
	;

	;
	;--	Create as
	;		Begin {
	;; Define
	when( paramCdf = cdfFindParamByName( BaseCellCDF "as" )
		cdfDeleteParam( paramCdf )
	)
	cdfCreateParam( BaseCellCDF
		?name			"as"
		?prompt			"Source diffusion area"
		?type			"string"
		?defValue		""
		?display		"t"
		?editable		"t"
		?parseAsNumber	"yes"
		?parseAsCEL		"yes"
	)
	;		} End
	;--	Create as
	;

	;
	;--	Create pd
	;		Begin {
	;; Define
	when( paramCdf = cdfFindParamByName( BaseCellCDF "pd" )
		cdfDeleteParam( paramCdf )
	)
	cdfCreateParam( BaseCellCDF
		?name			"pd"
		?prompt			"Drain diffusion periphery"
		?type			"string"
		?defValue		""
		?display		"t"
		?editable		"t"
		?parseAsNumber	"yes"
		?parseAsCEL		"yes"
	)
	;		} End
	;--	Create pd
	;

	;
	;--	Create ps
	;		Begin {
	;; Define
	when( paramCdf = cdfFindParamByName( BaseCellCDF "ps" )
		cdfDeleteParam( paramCdf )
	)
	cdfCreateParam( BaseCellCDF
		?name			"ps"
		?prompt			"Source diffusion periphery"
		?type			"string"
		?defValue		""
		?display		"t"
		?editable		"t"
		?parseAsNumber	"yes"
		?parseAsCEL		"yes"
	)
	;		} End
	;--	Create ps
	;

	;; BaseCellCDF~>simInfo
	BaseCellCDF~>instDisplayMode	= "instName"
	BaseCellCDF~>instNameType		= "schematic"
	BaseCellCDF~>netNameType		= "schematic"
	BaseCellCDF~>paramDisplayMode	= "parameter"
	BaseCellCDF~>paramLabelSet		= "l w m"
	BaseCellCDF~>paramSimType		= "DC"
	BaseCellCDF~>termDisplayMode	= "netName"
	BaseCellCDF~>termSimType		= "DC"

	/*
	cdfCreateParam( g_cdfDataId
		?name			t_name
		[?prompt		t_prompt]
		[?callback		t_callback]
		?type			t_type
		[?units			t_units]
		[?choices		l_choices]
		[?defValue		g_defValue]
		[?use			t_use]
		[?display		t_display]
		[?editable		t_editable]
		[?parseAsNumber	t_parseAsNumber]
		[?parseAsCEL	t_parseAsCEL]
		[?dontSave		t_dontSave]
		[?storeDefault	t_storeDefault]
	)
	*/

	cdfSaveCDF( BaseCellCDF )
)
)

