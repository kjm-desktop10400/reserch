;; -----------------------------------------------------------------
;; 
;; Call Back Function Skill File for Resistor LPPH PCell
;; Written by Tetsuya Iizuka, Wed Nov  4 15:29:42 JST 2009
;;
;; Copyright (C) Tetsuya Iizuka <iizuka@vdec.u-tokyo.ac.jp>
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
;;
;; $Id: VdecLpphCB.il,v 1.1 2009/11/04 08:35:01 iizuka Exp $
;;
;; -----------------------------------------------------------------

;;;;;
;;;;; This plocedure is loaded each time.
;;;;;
procedure( VdecLpphCB( param min max step )
let((
	val prompt
	fval fmin fmax fstep
	uval umin umax
	rInput_val rInput_fval width_val width_fval Rsq_val 
	length_fval length_val length_step ulength min_length min_flength
	numCont
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
	flength_step = cdfParseFloatString( "40n" ) * 1e6 ;; get length step
	
	Rsq_val = get( cdfgData 'Rsq )->value
	dw_val = get( cdfgData 'dw )->value
	Rint_val = get( cdfgData 'Rint )->value
	Rc_val = get( cdfgData 'Rc )->value
	Rsilicide_val = get( cdfgData 'Rsilicide )->value
	Lsilicide_val = get( cdfgData 'Lsilicide )->value

	;; Get Width
	width_val  = get( cdfgData 'w )->value
	width_fval = cdfParseFloatString( width_val ) * 1e6
	;; Get rInput Value
	rInput_val  = get( cdfgData 'rInput )->value
	rInput_fval = cdfParseFloatString( rInput_val )  

	when( param == 'w
		;; Call-Back Number of Contacts
		numCont = fix( (width_fval - GlobalDR->CONT_minWidth 
										- GlobalDR->GATE_CONT_minEnclosure * 2) / 
									 (GlobalDR->CONT_minWidth + GlobalDR->CONT_minSpacing) ) + 1
		get( cdfgData 'Nc )->value	= numCont
	)
	when( param == 'rInput
		;; Get Number of Contacts
		numCont = get( cdfgData 'Nc )->value
	)

	;; Calculate Length and Snap Length
	length_fval = (rInput_fval - Rc_val/numCont*2 - Rsilicide_val*Lsilicide_val/width_fval*2 
								- 2*Rint_val) * (width_fval - dw_val) / Rsq_val
	ulength = round( length_fval / flength_step )
	length_val = sprintf( nil "%L" ulength * flength_step * 1e-6 )
	get( cdfgData 'l )->value = length_val
	length_fval = cdfParseFloatString( length_val ) * 1e6

	;; Re-Calculate Actual Resistance Value
	r_fval = Rc_val/numCont*2 + Rsilicide_val*Lsilicide_val/width_fval*2 + 2*Rint_val 
					+ Rsq_val * length_fval/(width_fval - dw_val)
	get( cdfgData 'r )->value = sprintf( nil "%L" r_fval )

)
)
