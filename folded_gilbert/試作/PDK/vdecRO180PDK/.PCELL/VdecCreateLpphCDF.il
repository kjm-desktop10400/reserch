;; -----------------------------------------------------------------
;; 
;; Skill File for Resistor LPPH PCell CDF Creation
;; Written by Tetsuya Iizuka, Wed Nov  4 14:52:41 JST 2009
;;
;; Copyright (C) Tetsuya Iizuka <iizuka@vdec.u-tokyo.ac.jp>
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
;;
;; $Id: VdecCreateLpphCDF.il,v 1.4 2009/11/05 12:52:09 iizuka Exp $
;;
;; -----------------------------------------------------------------

;;;;;
;;;;; This procedure is executed once at creating target cell.
;;;;;
procedure( VdecCreateLpphCDF( TargetLibName TargetCellName )
let((
	cellDd
	defRes ;;defRes_val
	defWidth defWidth_val
	defLength defLength_val
	resSq
	deltaWidth
	numCont
	resCont
	resInt
	resSili
	lenSili
	BaseCellCDF
	paramCdf
)

	cellDd	= ddGetObj( TargetLibName TargetCellName )
	unless( BaseCellCDF = cdfGetBaseCellCDF( cellDd )
		BaseCellCDF	= cdfCreateBaseCellCDF( cellDd )
	)

	defWidth = "2.0u"
	defLength = "2.0u"
	resSq = 1050
	deltaWidth = 0.082
	resCont = 7.8
	resSili = 7.8
	lenSili = 0.22
	resInt = 80
	defWidth_val = cdfParseFloatString( defWidth ) * 1e6
	defLength_val = cdfParseFloatString( defLength ) * 1e6
	numCont = fix( (defWidth_val - GlobalDR->CONT_minWidth 
									- GlobalDR->GATE_CONT_minEnclosure * 2) / 
								 (GlobalDR->CONT_minWidth + GlobalDR->CONT_minSpacing) ) + 1
	defRes_val = resCont / numCont * 2 + resSili * lenSili * 2 / defWidth_val + 2 * resInt + resSq * defLength_val / ( defWidth_val - deltaWidth )
	defRes = sprintf( nil "%L" defRes_val )

	;
	;--	Create w
	;		Begin {
	when( paramCdf = cdfFindParamByName( BaseCellCDF "w" )
		cdfDeleteParam( paramCdf )
	)
	cdfCreateParam( BaseCellCDF
		?name			"w"
		?prompt			"Width"
		?callback		"VdecLpphCB( 'w \"2.0u\" \"50u\" \"40n\" )"
		?type			"string"
		?units			"lengthMetric"
		?defValue		defWidth
		?display		"t"
		?editable		"t"
		?parseAsNumber	"yes"
		?parseAsCEL		"yes"
	)
	;		} End
	;--	Create w
	;

	;
	;--	Create rInput
	;		Begin {
	when( paramCdf = cdfFindParamByName( BaseCellCDF "rInput" )
		cdfDeleteParam( paramCdf )
	)
	cdfCreateParam( BaseCellCDF
		?name				"rInput"
		?prompt			"Input Res. Value"
		?callback		"VdecLpphCB( 'rInput \"1050\" \"105000\" \"1\" )"
		?type			"string"
		?units			"resistance"
		?defValue		defRes
		?display		"t"
		?editable		"t"
		?parseAsNumber	"yes"
		?parseAsCEL		"yes"
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
		?defValue		defLength
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
		?defValue		defRes
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

	;
	;--	Create dw
	;		Begin {
	when( paramCdf = cdfFindParamByName( BaseCellCDF "dw" )
		cdfDeleteParam( paramCdf )
	)
	cdfCreateParam( BaseCellCDF
		?name				"dw"
		?prompt			"Delta Width"
		?type				"float"
		?defValue		deltaWidth
		?display		"t"
		?editable		"nil"
	)
	;		} End
	;--	Create dw
	;

	;
	;--	Create Nc
	;		Begin {
	when( paramCdf = cdfFindParamByName( BaseCellCDF "Nc" )
		cdfDeleteParam( paramCdf )
	)
	cdfCreateParam( BaseCellCDF
		?name				"Nc"
		?prompt			"Num. of Contacts"
		?type				"float"
		?defValue		numCont
		?display		"t"
		?editable		"nil"
	)
	;		} End
	;--	Create Nc
	;

	;
	;--	Create Rint
	;		Begin {
	when( paramCdf = cdfFindParamByName( BaseCellCDF "Rint" )
		cdfDeleteParam( paramCdf )
	)
	cdfCreateParam( BaseCellCDF
		?name				"Rint"
		?prompt			"Interface Resistance"
		?type				"float"
		?defValue		resInt
		?display		"t"
		?editable		"nil"
	)
	;		} End
	;--	Create Rint
	;

	;
	;--	Create Rc
	;		Begin {
	when( paramCdf = cdfFindParamByName( BaseCellCDF "Rc" )
		cdfDeleteParam( paramCdf )
	)
	cdfCreateParam( BaseCellCDF
		?name				"Rc"
		?prompt			"Contact Resistance"
		?type				"float"
		?defValue		resCont
		?display		"t"
		?editable		"nil"
	)
	;		} End
	;--	Create Rc
	;

	;
	;--	Create Rsilicide
	;		Begin {
	when( paramCdf = cdfFindParamByName( BaseCellCDF "Rsilicide" )
		cdfDeleteParam( paramCdf )
	)
	cdfCreateParam( BaseCellCDF
		?name				"Rsilicide"
		?prompt			"Silicide Resistance"
		?type				"float"
		?defValue		resSili
		?display		"t"
		?editable		"nil"
	)
	;		} End
	;--	Create Rsilicide
	;

	;
	;--	Create Lsilicide
	;		Begin {
	when( paramCdf = cdfFindParamByName( BaseCellCDF "Lsilicide" )
		cdfDeleteParam( paramCdf )
	)
	cdfCreateParam( BaseCellCDF
		?name				"Lsilicide"
		?prompt			"Silicide Length"
		?type				"float"
		?defValue		lenSili
		?display		"t"
		?editable		"nil"
	)
	;		} End
	;--	Create Rsilicide
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

