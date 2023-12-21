;; -----------------------------------------------------------------
;; 
;; Call Back Function Skill File for Capacitor PCell
;; Written by Tetsuya Iizuka, Tue Sep 15 22:07:53 JST 2009
;;
;; Copyright (C) Tetsuya Iizuka <iizuka@vdec.u-tokyo.ac.jp>
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
;;
;; $Id: VdecCapCB.il,v 1.2 2009/10/21 10:38:02 iizuka Exp $
;;
;; -----------------------------------------------------------------

;;;;;
;;;;; This plocedure is loaded each time.
;;;;;
procedure( VdecCapCB( param min max step )
let((
	val prompt
	fval fmin fmax fstep
	uval umin umax
	cInput_val cInput_fval w_val w_fval Csq_val 
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
	;-- Calculate l and c value
	;
	flength_step = cdfParseFloatString( "40n" ) ;; get length step
	when( param == 'w
		cInput_val  = get( cdfgData 'cInput )->value  ;; get cInput value
		cInput_fval = cdfParseFloatString( cInput_val )  
		Csq_val = get( cdfgData 'Csq )->value        ;; get Csq value
		min_length = get( cdfgData 'Lmin )->value    ;; get Lmin value
		min_flength = cdfParseFloatString( min_length )

		ulength = round( (cInput_fval / fval / Csq_val) / flength_step )
		length_val = sprintf( nil "%L" ulength * flength_step )
		length_fval = cdfParseFloatString( length_val )

		when( length_fval < min_flength
			warn( "Length (l) parameter: %s exceeds the lower limit of %s!\n\tParameter value is set to its lower limit!"
			length_val min_length )
			length_val = min_length
		)

		get( cdfgData 'l )->value = length_val
		length_fval = cdfParseFloatString( length_val )

		get( cdfgData 'c )->value = sprintf( nil "%L" Csq_val * length_fval * fval )
	)
	when( param == 'cInput
		w_val = get( cdfgData 'w )->value  ;; get w value
		w_fval = cdfParseFloatString( w_val )  
		Csq_val = get( cdfgData 'Csq )->value        ;; get Csq value
		min_length = get( cdfgData 'Lmin )->value    ;; get Lmin value
		min_flength = cdfParseFloatString( min_length )

		ulength = round( (fval / w_fval / Csq_val) / flength_step )
		length_val = sprintf( nil "%L" ulength * flength_step )
		length_fval = cdfParseFloatString( length_val )

		when( length_fval < min_flength
			warn( "Length (l) parameter: %s exceeds the lower limit of %s!\n\tParameter value is set to its lower limit!"
			length_val min_length )
			length_val = min_length
		)

		get( cdfgData 'l )->value = length_val
		length_fval = cdfParseFloatString( length_val )

		get( cdfgData 'c )->value = sprintf( nil "%L" Csq_val * length_fval * w_fval )
	)

)
)
