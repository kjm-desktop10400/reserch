;; -----------------------------------------------------------------
;; 
;; Call Back Function Skill File for Resistor PCell
;; Written by Tetsuya Iizuka, Tue Sep 15 14:25:32 JST 2009
;;
;; Copyright (C) Tetsuya Iizuka <iizuka@vdec.u-tokyo.ac.jp>
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
;;
;; $Id: VdecResCB.il,v 1.4 2009/10/21 10:38:02 iizuka Exp $
;;
;; -----------------------------------------------------------------

;;;;;
;;;;; This plocedure is loaded each time.
;;;;;
procedure( VdecResCB( param min max step )
let((
	val prompt
	fval fmin fmax fstep
	uval umin umax
	rInput_val rInput_fval w_val w_fval Rsq_val 
	length_val length_step ulength min_length min_flength
	)

	;
	;--	Get & Parse Float String
	;
	val		= get( cdfgData param )->value
	fval	= cdfParseFloatString( val )
	prompt	= get( cdfgData param )->prompt
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
	fval	= cdfParseFloatString( val )

	;
	;-- Limit Check
	;
	when( uval < umin
		warn( "%s (%s) parameter: %s exceeds the lower limit of %s!\n\tParameter value is set to its lower limit!"
			prompt param val min 
		)
		get( cdfgData param )->value	= min
		val		= get( cdfgData param )->value
		fval	= cdfParseFloatString( val )
	)
	when( umax < uval
		warn( "%s (%s) parameter: %s exceeds the upper limit of %s!\n\tParameter value is set to its upper limit!"
			prompt param val max 
		)
		get( cdfgData param )->value	= max
		val		= get( cdfgData param )->value
		fval	= cdfParseFloatString( val )
	)

	;
	;-- Calculate l and r value
	;
	flength_step = cdfParseFloatString( "40n" ) ;; get length step
	when( param == 'w
		rInput_val  = get( cdfgData 'rInput )->value  ;; get rInput value
		rInput_fval = cdfParseFloatString( rInput_val )  
		Rsq_val = get( cdfgData 'Rsq )->value        ;; get Rsq value

		ulength = round( (rInput_fval * fval / Rsq_val) / flength_step )
		length_val = sprintf( nil "%L" ulength * flength_step )

		get( cdfgData 'l )->value = length_val
		length_fval = cdfParseFloatString( length_val )

		get( cdfgData 'r )->value = sprintf( nil "%L" Rsq_val * length_fval / fval )
	)
	when( param == 'rInput
		w_val = get( cdfgData 'w )->value  ;; get w value
		w_fval = cdfParseFloatString( w_val )  
		Rsq_val = get( cdfgData 'Rsq )->value        ;; get Rsq value

		ulength = round( (fval * w_fval / Rsq_val) / flength_step )
		length_val = sprintf( nil "%L" ulength * flength_step )

		get( cdfgData 'l )->value = length_val
		length_fval = cdfParseFloatString( length_val )

		get( cdfgData 'r )->value = sprintf( nil "%L" Rsq_val * length_fval / w_fval )
	)

)
)
