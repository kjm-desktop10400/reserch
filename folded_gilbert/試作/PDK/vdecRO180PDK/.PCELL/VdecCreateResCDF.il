;; -----------------------------------------------------------------
;; 
;; Skill File for Resistor PCell CDF Creation
;; Written by Tetsuya Iizuka, Tue Sep 15 14:24:35 JST 2009
;;
;; Copyright (C) Tetsuya Iizuka <iizuka@vdec.u-tokyo.ac.jp>
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
;;
;; $Id: VdecCreateResCDF.il,v 1.6 2009/11/05 10:27:18 iizuka Exp $
;;
;; -----------------------------------------------------------------

;;;;;
;;;;; This procedure is executed once at creating target cell.
;;;;;
procedure( VdecCreateResCDF( TargetLibName TargetCellName )
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
	case( TargetCellName
	( "ppres" ;; P+ Poly Resistor w/o silicide
		resSq = 380
		defResValue = sprintf( nil "%L" resSq)
		maxResValue = 38000
		resStep = 1
	)
	( "ppres_s" ;; P+ Poly Resistor w/i silicide
		resSq = 8.0
		defResValue = sprintf( nil "%L" resSq)
		maxResValue = 800
		resStep = 0.1
	)
	( "npres" ;; N+ Poly Resistor w/o silicide
		resSq = 530
		defResValue = sprintf( nil "%L" resSq)
		maxResValue = 53000
		resStep = 1
	)
	( "npres_s" ;; N+ Poly Resistor w/i silicide
		resSq = 7.9
		defResValue = sprintf( nil "%L" resSq)
		maxResValue = 790
		resStep = 0.1
	)
	( "pdres" ;; P+ Diffusion Resistor w/o silicide
		resSq = 135
		defResValue = sprintf( nil "%L" resSq)
		maxResValue = 13500
		resStep = 1
	)
	( "pdres_s" ;; P+ Diffusion Resistor w/i silicide
		resSq = 6.8
		defResValue = sprintf( nil "%L" resSq)
		maxResValue = 680
		resStep = 0.1
	)
	( "ndres" ;; N+ Diffusion Resistor w/o silicide
		resSq = 69
		defResValue = sprintf( nil "%L" resSq)
		maxResValue = 6900
		resStep = 1
	)
	( "ndres_s" ;; N+ Diffusion Resistor w/i silicide
		resSq = 7.0
		defResValue = sprintf( nil "%L" resSq)
		maxResValue = 700
		resStep = 0.1
	) )

	;
	;--	Create w
	;		Begin {
	when( paramCdf = cdfFindParamByName( BaseCellCDF "w" )
		cdfDeleteParam( paramCdf )
	)
	case( TargetCellName
	( "ppres" | "ppres_s" | "npres" | "npres_s"
		cdfCreateParam( BaseCellCDF
			?name			"w"
			?prompt			"Width"
			?callback		"VdecResCB( 'w \"0.6u\" \"50u\" \"40n\" )"
			?type			"string"
			?units			"lengthMetric"
			?defValue		"2.0u"
			?display		"t"
			?editable		"t"
			?parseAsNumber	"yes"
			?parseAsCEL		"yes"
		)
	)
	( "pdres" | "pdres_s" | "ndres" | "ndres_s"
		cdfCreateParam( BaseCellCDF
			?name			"w"
			?prompt			"Width"
			?callback		"VdecResCB( 'w \"0.44u\" \"50u\" \"40n\" )"
			?type			"string"
			?units			"lengthMetric"
			?defValue		"2.0u"
			?display		"t"
			?editable		"t"
			?parseAsNumber	"yes"
			?parseAsCEL		"yes"
		)
	) )
	;		} End
	;--	Create w
	;

	;
	;--	Create rInput
	;		Begin {
	when( paramCdf = cdfFindParamByName( BaseCellCDF "rInput" )
		cdfDeleteParam( paramCdf )
	)
	case( TargetCellName
	( "ppres" ;; P+ Poly Resistor w/o silicide
		cdfCreateParam( BaseCellCDF
			?name				"rInput"
			?prompt			"Input Res. Value"
			?callback		"VdecResCB( 'rInput \"380\" \"38000\" \"1\" )"
			?type			"string"
			?units			"resistance"
			?defValue		"380"
			?display		"t"
			?editable		"t"
			?parseAsNumber	"yes"
			?parseAsCEL		"yes"
		)
	)
	( "ppres_s" ;; P+ Poly Resistor w/i silicide
		cdfCreateParam( BaseCellCDF
			?name				"rInput"
			?prompt			"Input Res. Value"
			?callback		"VdecResCB( 'rInput \"8.0\" \"800\" \"0.1\" )"
			?type			"string"
			?units			"resistance"
			?defValue		"8.0"
			?display		"t"
			?editable		"t"
			?parseAsNumber	"yes"
			?parseAsCEL		"yes"
		)
	)
	( "npres" ;; N+ Poly Resistor w/o silicide
		cdfCreateParam( BaseCellCDF
			?name				"rInput"
			?prompt			"Input Res. Value"
			?callback		"VdecResCB( 'rInput \"530\" \"53000\" \"1\" )"
			?type			"string"
			?units			"resistance"
			?defValue		"530"
			?display		"t"
			?editable		"t"
			?parseAsNumber	"yes"
			?parseAsCEL		"yes"
		)
	)
	( "npres_s" ;; N+ Poly Resistor w/i silicide
		cdfCreateParam( BaseCellCDF
			?name				"rInput"
			?prompt			"Input Res. Value"
			?callback		"VdecResCB( 'rInput \"7.9\" \"790\" \"0.1\" )"
			?type			"string"
			?units			"resistance"
			?defValue		"7.9"
			?display		"t"
			?editable		"t"
			?parseAsNumber	"yes"
			?parseAsCEL		"yes"
		)
	)
	( "pdres" ;; P+ Diffusion Resistor w/o silicide
		cdfCreateParam( BaseCellCDF
			?name				"rInput"
			?prompt			"Input Res. Value"
			?callback		"VdecResCB( 'rInput \"135\" \"13500\" \"1\" )"
			?type			"string"
			?units			"resistance"
			?defValue		"135"
			?display		"t"
			?editable		"t"
			?parseAsNumber	"yes"
			?parseAsCEL		"yes"
		)
	)
	( "pdres_s" ;; P+ Diffusion Resistor w/i silicide
		cdfCreateParam( BaseCellCDF
			?name				"rInput"
			?prompt			"Input Res. Value"
			?callback		"VdecResCB( 'rInput \"6.8\" \"680\" \"0.1\" )"
			?type			"string"
			?units			"resistance"
			?defValue		"6.8"
			?display		"t"
			?editable		"t"
			?parseAsNumber	"yes"
			?parseAsCEL		"yes"
		)
	)
	( "ndres" ;; N+ Diffusion Resistor w/o silicide
		cdfCreateParam( BaseCellCDF
			?name				"rInput"
			?prompt			"Input Res. Value"
			?callback		"VdecResCB( 'rInput \"69\" \"6900\" \"1\" )"
			?type			"string"
			?units			"resistance"
			?defValue		"69"
			?display		"t"
			?editable		"t"
			?parseAsNumber	"yes"
			?parseAsCEL		"yes"
		)
	)
	( "ndres_s" ;; N+ Diffusion Resistor w/i silicide
		cdfCreateParam( BaseCellCDF
			?name				"rInput"
			?prompt			"Input Res. Value"
			?callback		"VdecResCB( 'rInput \"7.0\" \"700\" \"0.1\" )"
			?type			"string"
			?units			"resistance"
			?defValue		"7.0"
			?display		"t"
			?editable		"t"
			?parseAsNumber	"yes"
			?parseAsCEL		"yes"
		)
	)
	)
	;		} End
	;--	Create rInput
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
		?defValue		"2.0u"
		?display		"t"
		?editable		"nil"
		?parseAsNumber	"yes"
		?parseAsCEL		"yes"
	)
	;		} End
	;--	Create l
	;

	;
	;--	Create r
	;		Begin {
	when( paramCdf = cdfFindParamByName( BaseCellCDF "r" )
		cdfDeleteParam( paramCdf )
	)
	cdfCreateParam( BaseCellCDF
		?name				"r"
		?prompt			"Actual Res. Value"
		?type			"string"
		?units			"resistance"
		?defValue		defResValue
		?display		"t"
		?editable		"t"
		?parseAsNumber	"yes"
		?parseAsCEL		"yes"
	)
	;		} End
	;--	Create r
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
	;--	Create Rsq
	;		Begin {
	when( paramCdf = cdfFindParamByName( BaseCellCDF "Rsq" )
		cdfDeleteParam( paramCdf )
	)
	cdfCreateParam( BaseCellCDF
		?name				"Rsq"
		?prompt			"Sheet Resistance"
		?type				"float"
		?defValue		resSq
		?display		"t"
		?editable		"nil"
	)
	;		} End
	;--	Create Rsq
	;

	;; BaseCellCDF~>simInfo
	BaseCellCDF~>instDisplayMode	= "instName"
	BaseCellCDF~>instNameType		= "schematic"
	BaseCellCDF~>netNameType		= "schematic"
	BaseCellCDF~>paramDisplayMode	= "parameter"
	BaseCellCDF~>paramLabelSet		= "r w m"
	BaseCellCDF~>paramSimType		= "DC"
	BaseCellCDF~>termDisplayMode	= "netName"
	BaseCellCDF~>termSimType		= "DC"

	cdfSaveCDF( BaseCellCDF )
)
)

