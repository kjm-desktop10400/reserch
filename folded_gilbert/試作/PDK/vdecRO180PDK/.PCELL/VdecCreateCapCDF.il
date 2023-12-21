;; -----------------------------------------------------------------
;; 
;; Skill File for Capacitor PCell CDF Creation
;; Written by Tetsuya Iizuka, Tue Sep 15 21:44:48 JST 2009
;;
;; Copyright (C) Tetsuya Iizuka <iizuka@vdec.u-tokyo.ac.jp>
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
;;
;; $Id: VdecCreateCapCDF.il,v 1.3 2009/10/21 10:38:02 iizuka Exp $
;;
;; -----------------------------------------------------------------

;;;;;
;;;;; This procedure is executed once at creating target cell.
;;;;;
procedure( VdecCreateCapCDF( TargetLibName TargetCellName )
let((
	cellDd
	defResValue
	maxResValue
	resStep
	resSq
	BaseCellCDF
	paramCdf
)

	cellDd	= ddGetObj( TargetLibName TargetCellName )
	unless( BaseCellCDF = cdfGetBaseCellCDF( cellDd )
		BaseCellCDF	= cdfCreateBaseCellCDF( cellDd )
	)

	;
	;--	Create w
	;		Begin {
	when( paramCdf = cdfFindParamByName( BaseCellCDF "w" )
		cdfDeleteParam( paramCdf )
	)
	cdfCreateParam( BaseCellCDF
		?name			"w"
		?prompt			"Width"
		?callback		"VdecCapCB( 'w \"4u\" \"30u\" \"40n\" )"
		?type			"string"
		?units			"lengthMetric"
		?defValue		"4u"
		?display		"t"
		?editable		"t"
		?parseAsNumber	"yes"
		?parseAsCEL		"yes"
	)
	;		} End
	;--	Create w
	;

	;
	;--	Create cInput
	;		Begin {
	when( paramCdf = cdfFindParamByName( BaseCellCDF "cInput" )
		cdfDeleteParam( paramCdf )
	)
	cdfCreateParam( BaseCellCDF
		?name			"cInput"
		?prompt			"Input Cap. Value"
		?callback		"VdecCapCB( 'cInput \"16f\" \"900f\" \"0.04f\" )"
		?type			"string"
		?units			"capacitance"
		?defValue		"16f"
		?display		"t"
		?editable		"t"
		?parseAsNumber	"yes"
		?parseAsCEL		"yes"
	)
	;		} End
	;--	Create w
	;

	;
	;--	Create l
	;		Begin {
	when( paramCdf = cdfFindParamByName( BaseCellCDF "l" )
		cdfDeleteParam( paramCdf )
	)
	cdfCreateParam( BaseCellCDF
		?name			"l"
		?prompt			"Length"
		?type			"string"
		?units			"lengthMetric"
		?defValue		"4u"
		?display		"t"
		?editable		"nil"
		?parseAsNumber	"yes"
		?parseAsCEL		"yes"
	)
	;		} End
	;--	Create l
	;

	;
	;--	Create c
	;		Begin {
	when( paramCdf = cdfFindParamByName( BaseCellCDF "c" )
		cdfDeleteParam( paramCdf )
	)
	cdfCreateParam( BaseCellCDF
		?name				"c"
		?prompt			"Actual Cap. Value"
		?type			"string"
		?units			"capacitance"
		?defValue		"16f"
		?display		"t"
		?editable		"t"
		?parseAsNumber	"yes"
		?parseAsCEL		"yes"
	)
	;		} End
	;--	Create c
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
	;--	Create m
	;

	;
	;--	Create btmTerm
	;		Begin {
	when( paramCdf = cdfFindParamByName( BaseCellCDF "btmTerm" )
		cdfDeleteParam( paramCdf )
	)
	cdfCreateParam( BaseCellCDF
		?name				"btmTerm"
		?prompt			"Terminal for Bottom Metal"
		?type				"boolean"
		?defValue		"t"
		?display		"t"
		?editable		"t"
	)
	;		} End
	;--	Create btmTerm
	;

	;
	;--	Create Csq
	;		Begin {
	when( paramCdf = cdfFindParamByName( BaseCellCDF "Csq" )
		cdfDeleteParam( paramCdf )
	)
	cdfCreateParam( BaseCellCDF
		?name				"Csq"
		?prompt			"Sheet Capacitance"
		?type				"float"
		?defValue		0.0010
		?display		"t"
		?editable		"nil"
	)
	;		} End
	;--	Create Csq
	;

	;
	;--	Create Lmin
	;		Begin {
	when( paramCdf = cdfFindParamByName( BaseCellCDF "Lmin" )
		cdfDeleteParam( paramCdf )
	)
	cdfCreateParam( BaseCellCDF
		?name				"Lmin"
		?prompt			"Minimum Length"
		?type			"string"
		?units			"lengthMetric"
		?defValue		"4u"
		?display		"t"
		?editable		"nil"
		?parseAsNumber	"yes"
		?parseAsCEL		"yes"
	)
	;		} End
	;--	Create Lmin
	;

	;; BaseCellCDF~>simInfo
	BaseCellCDF~>instDisplayMode	= "instName"
	BaseCellCDF~>instNameType		= "schematic"
	BaseCellCDF~>netNameType		= "schematic"
	BaseCellCDF~>paramDisplayMode	= "parameter"
	BaseCellCDF~>paramLabelSet		= "c m"
	BaseCellCDF~>paramSimType		= "DC"
	BaseCellCDF~>termDisplayMode	= "netName"
	BaseCellCDF~>termSimType		= "DC"

	cdfSaveCDF( BaseCellCDF )
)
)

