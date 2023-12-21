;; -----------------------------------------------------------------
;; 
;; PCELL Call Back Function Skill File for RO018 PDK Development
;; Written by Tetsuya Iizuka, Mon Sep 14 18:04:56 JST 2009
;;
;; Copyright (C) Tetsuya Iizuka <iizuka@vdec.u-tokyo.ac.jp>
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
;;
;; $Id: VdecMosCB.il,v 1.1.1.1 2009/09/14 10:57:49 iizuka Exp $
;;
;; -----------------------------------------------------------------

;;;;;
;;;;; cdfgData	: "cdfgData" is system-global-variable for CDF callback.
;;;;;			: Please refer;
;;;;;			: "Component Description Format User Guide"
;;;;;			:  + "8. CDF SKILL Summary"
;;;;;			:    + "CDF SKILL Function Elements"
;;;;;			:      + "Global Variables"

;;;;;
;;;;; This plocedure is loaded each time.
;;;;;
procedure( VdecMosCB( param min max step )
let((
	val prompt
	fval fmin fmax fstep
	uval umin umax
)
	;
	;--	Get & Parse Float String
	;
	val		= get( cdfgData param )->value
	prompt	= get( cdfgData param )->prompt
	fval	= cdfParseFloatString( val )
	fmin	= cdfParseFloatString( min )
	fmax	= cdfParseFloatString( max )
	fstep	= cdfParseFloatString( step )

	;
	;-- Unit
	;
	uval	= round( fval / fstep )
	umin	= round( fmin / fstep )
	umax	= round( fmax / fstep )

	get( cdfgData param )->value	= sprintf( nil "%L" uval * fstep )
	val		= get( cdfgData param )->value

	;
	;-- Limit Check
	;
	when( uval < umin
		warn( "%s (%s) parameter: %s exceeds the lower limit of %s!\n\tParameter value is set to its lower limit!"
			prompt param val min 
		)
		get( cdfgData param )->value	= min
	)
	when( umax < uval
		warn( "%s (%s) parameter: %s exceeds the upper limit of %s!\n\tParameter value is set to its upper limit!"
			prompt param val max 
		)
		get( cdfgData param )->value	= max
	)
)
)

