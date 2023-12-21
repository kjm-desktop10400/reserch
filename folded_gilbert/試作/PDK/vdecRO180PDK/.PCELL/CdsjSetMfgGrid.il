; (c) 2009 Cadence Design Systems (Japan) B.V. All Rights Reserved.
;-------------------------------------------------------------------------
; @(#) $Id: CdsjSetMfgGrid.il,v 1.2 2009/11/05 07:52:26 iizuka Exp $
;

procedure( CdsjGetMfgGridCB( form )
let((
	cv tech
	mfgResolution mfgResolutionStr
)
	when( cv = geGetEditCellView()
		form->libNameSwitch->value	= cv~>libName
	)

	tech	= techGetTechFile( ddGetObj( form->libNameSwitch->value ))

	foreach( layerSymbol _VDECMfgList->?

		cond(
		( layerSymbol == 'MfgGrid
			mfgResolution	= techGetMfgGridResolution( tech )
		)
		( t
			mfgResolution	= cadr( assoc( symbolToString( layerSymbol ) techGetLayerMfgResolutions( tech )))
		)
		)

		cond(
		( numberp( mfgResolution )
			mfgResolutionStr	= sprintf( nil "%L" mfgResolution )
			get( form concat( "current" layerSymbol ))->value	= mfgResolutionStr

			cond(
			( member( mfgResolutionStr get( form concat( "set" layerSymbol ))->choices )
				get( form concat( "set" layerSymbol ))->value	= mfgResolutionStr
			)
			( t
				get( form concat( "set" layerSymbol ))->value	= ""
			)
			)
		)
		( t
			get( form concat( "current" layerSymbol ))->value	= ""
			get( form concat( "set" layerSymbol ))->value		= ""
		)
		)
	)

	tech
)
)


procedure( CdsjSetMfgGridCB( form layerSymbol )
let((
	tech layerSymbolStr
	mfgResolution mfgResolutionStr
)
	tech	= techGetTechFile( ddGetObj( form->libNameSwitch->value ))

	mfgResolutionStr	= get( form concat( "set" layerSymbol ))->value
	mfgResolution		= cond(
		( atof( mfgResolutionStr )		atof( mfgResolutionStr ))
		( mfgResolutionStr == "Reset"	atof( get( _VDECMfgList layerSymbol )->default ))
		( t		nil )
	)

	layerSymbolStr	= symbolToString( layerSymbol )
	when( mfgResolution
		cond(
		( layerSymbol == 'MfgGrid
			techSetMfgGridResolution( tech mfgResolution )
		)
		( assoc( layerSymbolStr techGetLayerMfgResolutions( tech ))
			techSetLayerMfgResolution( tech layerSymbolStr mfgResolution )
		)
		)
	)

	CdsjGetMfgGridCB( form )
)
)


procedure( CdsjSetMfgForm()
let((
	libNameSwitch
	currentLabel		setLabel
	currentMfgGrid		setMfgGrid
	currentLayerField	setLayerSwitch
	fieldsList
	posY
)

	libNameSwitch	= hiCreateCyclicField(
		?name		'libNameSwitch
		?prompt		"Library"
		?choices	sort( ddGetLibList()~>name nil )
		?callback	"CdsjGetMfgGridCB( CdsjSetMfgForm )"
	)
	currentLabel	= hiCreateLabel(
		?name		'currentLabel
		?labelText	"Current"
	)
	setLabel		= hiCreateLabel(
		?name		'setLabel
		?labelText	"Set Value"
	)
	currentMfgGrid	= hiCreateStringField(
		?name		'currentMfgGrid
		?prompt		"MfgGrid"
		?editable	nil
	)
	setMfgGrid	= hiCreateCyclicField(
		?name		'setMfgGrid
		?prompt		"MfgGrid"
		?choices	cons( "" append1( _VDECMfgList->MfgGrid->choices "Reset" ))
		?callback	"CdsjSetMfgGridCB( CdsjSetMfgForm 'MfgGrid )"
	)

	fieldsList	= list(
		list( libNameSwitch		0:0		300:30 80 )
		list( currentLabel		80:30	80:30 )
		list( setLabel			160:30	80:30 )
		list( currentMfgGrid	0:60	160:30 80 )
		list( setMfgGrid		160:60	80:30 0 )
	)

	posY	= 90

	foreach( layerSymbol sort( _VDECMfgList->? nil )
		unless( layerSymbol == 'MfgGrid
			currentLayerField	= hiCreateStringField(
				?name		concat( "current" layerSymbol )
				?prompt		symbolToString( layerSymbol )
				?editable	nil
			)
			setLayerSwitch		= hiCreateCyclicField(
				?name		concat( "set" layerSymbol )
				?prompt		symbolToString( layerSymbol )
				?choices	cons( "" append1( get( _VDECMfgList layerSymbol )->choices "Reset" ))
				?callback   sprintf( nil "CdsjSetMfgGridCB( CdsjSetMfgForm '%L )" layerSymbol )
			)
			fieldsList	= append(
				list(
					list( currentLayerField	0:posY		160:30	80 )
					list( setLayerSwitch	160:posY	80:30	0 )
				)
				fieldsList
			)
			posY	= posY+30
		)
	)

	CdsjSetMfgForm	= hiCreateAppForm(
		?name		 	'CdsjSetMfgForm
		?formTitle		"Change MfgGridResolution"
		?initialSize	t
		?fields			fieldsList
	)

	CdsjSetMfgForm
)
)


procedure( CdsjResetAllMfgGrid( form )
	foreach( layerSymbol _VDECMfgList->?
		cond(
		( layerSymbol == 'MfgGrid
			form->setMfgGrid->value	= _VDECMfgList->MfgGrid->default
		)
		( t
			get( form concat( "set" layerSymbol ))->value
			= get( _VDECMfgList layerSymbol )->default
		)
		)
	)
/*
let((
	tech
)
	tech	= techGetTechFile( ddGetObj( form->libNameSwitch->value ))
	techRefreshTechFile( tech )
)
*/
)


procedure( CdsjCloseMfgWindow( wid )
	when( geGetEditCellView()
	&& CdsjResetAllMfgGrid( CdsjSetMfgForm )
		printf( "*INFORMATION* The current technology file was refreshed by a close process.\n" )
	)
)


procedure( CdsjOpenMfgWindow()
	CdsjSetMfgWindow	= hiOpenWindow(
		?bBox		list( 170:866 480:(866+94+30*( length( _VDECMfgList )-1 )/2 )) ;; w=300+10 h=30*n+24+10
		?menus		list(
			hiCreatePulldownMenu(
				'CdsjSetMfgWindowMenu1
				"Command"
				list(
					hiCreateMenuItem(
						?name		'CdsjSetMfgWindowMenu1_1
						?itemText	"\"Reset All Value\" and \"Close Window\""
						?callback	"hiCloseWindow( CdsjSetMfgWindow )"
					)
				)
			)
		)
		?closeProc	'CdsjCloseMfgWindow
		?type		"form"
		?form		CdsjSetMfgForm()
	)
	CdsjSetMfgWindow->neverCurrentWindow	= t
	CdsjSetMfgForm->libNameSwitch->choices	= sort( ddGetLibList()~>name nil )
	when( geGetEditCellView()
		CdsjSetMfgForm->libNameSwitch->value	= geGetEditCellView()~>libName
	)
	CdsjGetMfgGridCB( CdsjSetMfgForm )

	CdsjSetMfgWindow
)


procedure( CdsjVDECAllLayoutCreatePulldownMenu()
	unless( boundp( 'CdsjVDECAllLayoutPulldownMenu )
		CdsjVDECAllLayoutPulldownMenu	= hiCreatePulldownMenu(
			'CdsjVDECAllLayoutPulldownMenu
			"Pre-Place"
			list(
				hiCreateMenuItem(
					?name		'CdsjSetMfgGrid
					?itemText	"Change MfgGridResolution ..."
					?callback	"CdsjOpenMfgWindow() CdsjGetMfgGridCB( CdsjSetMfgForm )"
				)
			)
		)
	)

	CdsjVDECAllLayoutPulldownMenu
)


procedure( CdsjVDECAllLayoutPostInstallTrigger( args )
	hiInsertBannerMenu(
		args->window
		CdsjVDECAllLayoutCreatePulldownMenu()
		length(
			hiGetBannerMenus( args->window )
		)
	)
)


;; hiCloseWindow( CdsjSetMfgWindow )
;; CdsjVDECAllLayoutPulldownMenu	= 'unbound
;; CdsjSetMfgForm	= 'unbound
;;
;; foreach( mapcar viewType '( "maskLayout" "maskLayoutCE" "maskLayoutXL" "maskLayoutGXL" )
;;	member( 'CdsjVDECAllLayoutPostInstallTrigger
;;		deGetAppInfo( viewType )->userPostInstallTrigList
;; ))


foreach( viewType '( "maskLayout" "maskLayoutCE" "maskLayoutXL" "maskLayoutGXL" )
	when( fboundp( 'deRegUserTriggers )
	&& ! member(
		'CdsjVDECAllLayoutPostInstallTrigger
		deGetAppInfo( viewType )->userPostInstallTrigList
	)
		deRegUserTriggers( viewType nil nil 'CdsjVDECAllLayoutPostInstallTrigger )
	)
)


_VDECMfgList	= '( nil
	MfgGrid	( nil default "0.01" choices ( "0.01" "0.02" "0.04" ))	;; Requirer
	METAL1	( nil default "0.01" choices ( "0.01" "0.02" ))			;; Optional
;;	METAL2	( nil default "0.02" choices ( "0.02" "0.04" ))			;; Optional
)

