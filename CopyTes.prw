#Include 'Protheus.ch'

User Function CopyTes()
	
	Local aArea    := GetArea()
	Local aCpy     := {}
	Local aCabec   := {}
	Local aCpos    := {}
	Local nX       := 0
	Local nY       := 0
	Local nZ       := 0
	Local cFldName := ''
	
	Private	lMsErroAuto    := .F.
	Private	lMsHelpAuto    := .T.
	Private	lAutoErrNoFile := .T.
	
	RpcSetEnv( '01', '01' )
	RpcSetType(3)
	
	//=========================================================================
	
	aadd( aCpy, { '643', { '743', '843', '943' } } )
	aadd( aCpy, { '644', { '744', '844', '944' } } )
	aadd( aCpy, { '645', { '745', '845', '945' } } )
	aadd( aCpy, { '646', { '746', '846', '946' } } )
	
	aadd( aCpy, { '241', { '441', '445', '449' } } )
	aadd( aCpy, { '242', { '442', '446', '450' } } )
	aadd( aCpy, { '243', { '443', '447', '451' } } )
	aadd( aCpy, { '244', { '444', '448', '452' } } )
	
	//=========================================================================
	
	DbSelectArea( 'SF4' )
	DbSetOrder( 1 ) // F4_FILIAL + F4_CODIGO
	
	//=========================================================================
	
	For nX := 1 To Len( aCpy )
		
		If DbSeek( xFilial( 'SF4' ) + aCpy[ nX, 1 ] )
			
			For nY := 1 to Len( aCpy[ nX, 2 ] )
				
				For nZ := 1 To FCount()
					
					cFldName := FieldName( nZ )
					
					If cFldName = 'F4_CODIGO'
						
						aAdd( aCabec, { cFldName, aCpy[ nX, 2, nY ], Nil } )
						
					Else
						
						aAdd( aCabec, { cFldName, SF4->&cFldName, Nil } )
						
					End IF
					
				Next nZ
				
				BeginTran()
					
					MSExecAuto( { | x, y | MATA080( X, Y ) }, aCabec, 3 )
					
					If lMsErroAuto
						
						MostraErro()
						DisarmTransaction()
						
					End If
					
				EndTran()
				
				aCabec := {}
				
			Next nY
			
		End If
		
	Next nX
	
	//=========================================================================
	
	AjustaTes()
	
	RestArea( aArea )
	
	RpcClearEnv()
	
	Alert( 'Processo Concluído !!!!' )
	
Return

Static Function AjustaTes()
	
	Local aTesAlt  := {}
	Local nX       := 0
	Local cFldName := ''
	
	aAdd( aTesAlt, { '743', 'F4_TESDV', '441' } )
	aAdd( aTesAlt, { '746', 'F4_TESDV', '442' } )
	aAdd( aTesAlt, { '744', 'F4_TESDV', '443' } )
	aAdd( aTesAlt, { '745', 'F4_TESDV', '444' } )
	aAdd( aTesAlt, { '843', 'F4_TESDV', '445' } )
	aAdd( aTesAlt, { '846', 'F4_TESDV', '446' } )
	aAdd( aTesAlt, { '844', 'F4_TESDV', '447' } )
	aAdd( aTesAlt, { '845', 'F4_TESDV', '448' } )
	aAdd( aTesAlt, { '943', 'F4_TESDV', '449' } )
	aAdd( aTesAlt, { '946', 'F4_TESDV', '450' } )
	aAdd( aTesAlt, { '944', 'F4_TESDV', '451' } )
	aAdd( aTesAlt, { '945', 'F4_TESDV', '452' } )
	
	aAdd( aTesAlt, { '241', 'F4_FINALID', 'RJ-RECUSA DE RECEBIMENTO DE VENDA FORA DO ESTADO COM CALCULO DO ST COM ALIQUOTA DE IPI IGUAL A ZERO' } )
	aAdd( aTesAlt, { '242', 'F4_FINALID', 'RJ-RECUSA DE RECEBIMENTO DE VENDA FORA DO ESTADO COM CALCULO DO ST COM ALIQUOTA DE IPI DIFERENTE DE ZERO' } )
	aAdd( aTesAlt, { '243', 'F4_FINALID', 'RJ-RECUSA DE RECEBIMENTO DE VENDA FORA DO ESTADO SEM CALCULO DO ST COM ALIQUOTA DE IPI IGUAL A ZERO' } )
	aAdd( aTesAlt, { '244', 'F4_FINALID', 'RJ-RECUSA DE RECEBIMENTO DE VENDA FORA DO ESTADO SEM CALCULO DO ST COM ALIQUOTA DE IPI DIFERENTE DE ZERO' } )
	aAdd( aTesAlt, { '643', 'F4_FINALID', 'RJ-CONDICAO DE SUBSTITUTO VENDA FORA DO ESTADO COM CALCULO DO ST COM ALIQUOTA DE IPI IGUAL A ZERO' } )
	aAdd( aTesAlt, { '644', 'F4_FINALID', 'RJ-VENDA FORA DO ESTADO SEM CALCULO DO ST COM ALIQUOTA DE IPI IGUAL A ZERO' } )
	aAdd( aTesAlt, { '645', 'F4_FINALID', 'RJ-VENDA FORA DO ESTADO SEM CALCULO DO ST COM ALIQUOTA DE IPI DIFERENTE DE ZERO' } )
	aAdd( aTesAlt, { '646', 'F4_FINALID', 'RJ-CONDICAO DE SUBSTITUTO VENDA FORA DO ESTADO COM CALCULO DO ST COM ALIQUOTA DE IPI DIFERENTE DE ZERO' } )
	aAdd( aTesAlt, { '743', 'F4_FINALID', 'MG-CONDICAO DE SUBSTITUTO VENDA FORA DO ESTADO COM CALCULO DO ST COM ALIQUOTA DE IPI IGUAL A ZERO' } )
	aAdd( aTesAlt, { '843', 'F4_FINALID', 'RS-CONDICAO DE SUBSTITUTO VENDA FORA DO ESTADO COM CALCULO DO ST COM ALIQUOTA DE IPI IGUAL A ZERO' } )
	aAdd( aTesAlt, { '943', 'F4_FINALID', 'AL-CONDICAO DE SUBSTITUTO VENDA FORA DO ESTADO COM CALCULO DO ST COM ALIQUOTA DE IPI IGUAL A ZERO' } )
	aAdd( aTesAlt, { '746', 'F4_FINALID', 'MG-CONDICAO DE SUBSTITUTO VENDA FORA DO ESTADO COM CALCULO DO ST COM ALIQUOTA DE IPI DIFERENTE DE ZERO' } )
	aAdd( aTesAlt, { '846', 'F4_FINALID', 'RS-CONDICAO DE SUBSTITUTO VENDA FORA DO ESTADO COM CALCULO DO ST COM ALIQUOTA DE IPI DIFERENTE DE ZERO' } )
	aAdd( aTesAlt, { '946', 'F4_FINALID', 'AL-CONDICAO DE SUBSTITUTO VENDA FORA DO ESTADO COM CALCULO DO ST COM ALIQUOTA DE IPI DIFERENTE DE ZERO' } )
	aAdd( aTesAlt, { '744', 'F4_FINALID', 'MG-VENDA FORA DO ESTADO SEM CALCULO DO ST COM ALIQUOTA DE IPI IGUAL A ZERO' } )
	aAdd( aTesAlt, { '745', 'F4_FINALID', 'MG-VENDA FORA DO ESTADO SEM CALCULO DO ST COM ALIQUOTA DE IPI DIFERENTE DE ZERO' } )
	aAdd( aTesAlt, { '844', 'F4_FINALID', 'RS-VENDA FORA DO ESTADO SEM CALCULO DO ST COM ALIQUOTA DE IPI IGUAL A ZERO' } )
	aAdd( aTesAlt, { '845', 'F4_FINALID', 'RS-VENDA FORA DO ESTADO SEM CALCULO DO ST COM ALIQUOTA DE IPI DIFERENTE DE ZERO' } )
	aAdd( aTesAlt, { '944', 'F4_FINALID', 'AL-VENDA FORA DO ESTADO SEM CALCULO DO ST COM ALIQUOTA DE IPI IGUAL A ZERO' } )
	aAdd( aTesAlt, { '945', 'F4_FINALID', 'AL-VENDA FORA DO ESTADO SEM CALCULO DO ST COM ALIQUOTA DE IPI DIFERENTE DE ZERO' } )
	aAdd( aTesAlt, { '441', 'F4_FINALID', 'MG-RECUSA DE RECEBIMENTO DE VENDA FORA DO ESTADO COM CALCULO DO ST COM ALIQUOTA DE IPI IGUAL A ZERO' } )
	aAdd( aTesAlt, { '442', 'F4_FINALID', 'MG-RECUSA DE RECEBIMENTO DE VENDA FORA DO ESTADO COM CALCULO DO ST COM ALIQUOTA DE IPI DIFERENTE DE ZERO' } )
	aAdd( aTesAlt, { '443', 'F4_FINALID', 'MG-RECUSA DE RECEBIMENTO DE VENDA FORA DO ESTADO SEM CALCULO DO ST COM ALIQUOTA DE IPI IGUAL A ZERO' } )
	aAdd( aTesAlt, { '444', 'F4_FINALID', 'MG-RECUSA DE RECEBIMENTO DE VENDA FORA DO ESTADO SEM CALCULO DO ST COM ALIQUOTA DE IPI DIFERENTE DE ZERO' } )
	aAdd( aTesAlt, { '445', 'F4_FINALID', 'RS-RECUSA DE RECEBIMENTO DE VENDA FORA DO ESTADO COM CALCULO DO ST COM ALIQUOTA DE IPI IGUAL A ZERO' } )
	aAdd( aTesAlt, { '446', 'F4_FINALID', 'RS-RECUSA DE RECEBIMENTO DE VENDA FORA DO ESTADO COM CALCULO DO ST COM ALIQUOTA DE IPI DIFERENTE DE ZERO' } )
	aAdd( aTesAlt, { '447', 'F4_FINALID', 'RS-RECUSA DE RECEBIMENTO DE VENDA FORA DO ESTADO SEM CALCULO DO ST COM ALIQUOTA DE IPI IGUAL A ZERO' } )
	aAdd( aTesAlt, { '448', 'F4_FINALID', 'RS-RECUSA DE RECEBIMENTO DE VENDA FORA DO ESTADO SEM CALCULO DO ST COM ALIQUOTA DE IPI DIFERENTE DE ZERO' } )
	aAdd( aTesAlt, { '449', 'F4_FINALID', 'AL-RECUSA DE RECEBIMENTO DE VENDA FORA DO ESTADO COM CALCULO DO ST COM ALIQUOTA DE IPI IGUAL A ZERO' } )
	aAdd( aTesAlt, { '450', 'F4_FINALID', 'AL-RECUSA DE RECEBIMENTO DE VENDA FORA DO ESTADO COM CALCULO DO ST COM ALIQUOTA DE IPI DIFERENTE DE ZERO' } )
	aAdd( aTesAlt, { '451', 'F4_FINALID', 'AL-RECUSA DE RECEBIMENTO DE VENDA FORA DO ESTADO SEM CALCULO DO ST COM ALIQUOTA DE IPI IGUAL A ZERO' } )
	aAdd( aTesAlt, { '452', 'F4_FINALID', 'AL-RECUSA DE RECEBIMENTO DE VENDA FORA DO ESTADO SEM CALCULO DO ST COM ALIQUOTA DE IPI DIFERENTE DE ZERO' } )
	
	aAdd( aTesAlt, { '141', 'F4_XOBS', 'ICMS Recolhido Anteriormente por Substituição Tributaria Art. 313 K' } )
	aAdd( aTesAlt, { '142', 'F4_XOBS', 'ICMS Recolhido Anteriormente por Substituição Tributaria Art. 313 K' } )
	aAdd( aTesAlt, { '143', 'F4_XOBS', 'ICMS Recolhido Anteriormente por Substituição Tributaria Art. 313 K' } )
	aAdd( aTesAlt, { '241', 'F4_XOBS', 'ICMS ST destacado conforme Protocolo 34/2014' } )
	aAdd( aTesAlt, { '242', 'F4_XOBS', 'ICMS ST destacado conforme Protocolo 34/2014' } )
	aAdd( aTesAlt, { '243', 'F4_XOBS', 'ICM ST Não se aplica conforme item 2 Clausula 2a. - Protocolo 34/2014' } )
	aAdd( aTesAlt, { '244', 'F4_XOBS', 'ICM ST Não se aplica conforme item 2 Clausula 2a. - Protocolo 34/2014' } )
	aAdd( aTesAlt, { '545', 'F4_XOBS', 'ICMS Recolhido Anteriormente por Substituição Tributaria Art. 313 K' } )
	aAdd( aTesAlt, { '546', 'F4_XOBS', 'ICMS Recolhido Anteriormente por Substituição Tributaria Art. 313 K' } )
	aAdd( aTesAlt, { '547', 'F4_XOBS', 'ICMS Recolhido Anteriormente por Substituição Tributaria Art. 313 K' } )
	aAdd( aTesAlt, { '643', 'F4_XOBS', 'ICMS ST destacado conforme Protocolo 34/2014' } )
	aAdd( aTesAlt, { '644', 'F4_XOBS', 'ICM ST Não se aplica conforme item 2 Clausula 2a. - Protocolo 34/2014' } )
	aAdd( aTesAlt, { '645', 'F4_XOBS', 'ICM ST Não se aplica conforme item 2 Clausula 2a. - Protocolo 34/2014' } )
	aAdd( aTesAlt, { '646', 'F4_XOBS', 'ICMS ST destacado conforme Protocolo 34/2014' } )
	aAdd( aTesAlt, { '743', 'F4_XOBS', 'ICMS ST destacado conforme Protocolo 33/2009' } )
	aAdd( aTesAlt, { '843', 'F4_XOBS', 'ICMS ST destacado conforme Protocolo 93/2009' } )
	aAdd( aTesAlt, { '943', 'F4_XOBS', 'ICMS ST destacado conforme Protocolo 105/2008' } )
	aAdd( aTesAlt, { '746', 'F4_XOBS', 'ICMS ST destacado conforme Protocolo 33/2009' } )
	aAdd( aTesAlt, { '846', 'F4_XOBS', 'ICMS ST destacado conforme Protocolo 93/2009' } )
	aAdd( aTesAlt, { '946', 'F4_XOBS', 'ICMS ST destacado conforme Protocolo 105/2008' } )
	aAdd( aTesAlt, { '744', 'F4_XOBS', 'ICM ST Não se aplica conforme item 2 Clausula 2a. - Protocolo 33/2009' } )
	aAdd( aTesAlt, { '745', 'F4_XOBS', 'ICM ST Não se aplica conforme item 2 Clausula 2a. - Protocolo 33/2009' } )
	aAdd( aTesAlt, { '844', 'F4_XOBS', 'ICM ST Não se aplica conforme item 2 Clausula 2a. - Protocolo 93/2009' } )
	aAdd( aTesAlt, { '845', 'F4_XOBS', 'ICM ST Não se aplica conforme item 2 Clausula 2a. - Protocolo 93/2009' } )
	aAdd( aTesAlt, { '944', 'F4_XOBS', 'ICM ST Não se aplica' } )
	aAdd( aTesAlt, { '945', 'F4_XOBS', 'ICM ST Não se aplica' } )
	aAdd( aTesAlt, { '441', 'F4_XOBS', 'ICMS ST destacado conforme Protocolo 33/2009' } )
	aAdd( aTesAlt, { '442', 'F4_XOBS', 'ICMS ST destacado conforme Protocolo 33/2009' } )
	aAdd( aTesAlt, { '443', 'F4_XOBS', 'ICM ST Não se aplica conforme item 2 Clausula 2a. - Protocolo 33/2009' } )
	aAdd( aTesAlt, { '444', 'F4_XOBS', 'ICM ST Não se aplica conforme item 2 Clausula 2a. - Protocolo 33/2009' } )
	aAdd( aTesAlt, { '445', 'F4_XOBS', 'ICMS ST destacado conforme Protocolo 93/2009' } )
	aAdd( aTesAlt, { '446', 'F4_XOBS', 'ICMS ST destacado conforme Protocolo 93/2009' } )
	aAdd( aTesAlt, { '447', 'F4_XOBS', 'ICM ST Não se aplica conforme item 2 Clausula 2a. - Protocolo 93/2009' } )
	aAdd( aTesAlt, { '448', 'F4_XOBS', 'ICM ST Não se aplica conforme item 2 Clausula 2a. - Protocolo 93/2009' } )
	aAdd( aTesAlt, { '449', 'F4_XOBS', 'ICMS ST destacado conforme Protocolo 105/2008' } )
	aAdd( aTesAlt, { '450', 'F4_XOBS', 'ICMS ST destacado conforme Protocolo 105/2008' } )
	aAdd( aTesAlt, { '451', 'F4_XOBS', 'ICM ST Não se aplica' } )
	aAdd( aTesAlt, { '452', 'F4_XOBS', 'ICM ST Não se aplica' } )
	
	For nX := 1 To Len ( aTesAlt )
		
		If DbSeek( xFilial( 'SF4' ) + aTesAlt[ nX, 1 ] )
			
			RecLock( 'SF4', .F. )
			
			cFldName := aTesAlt[ nX, 2 ]
			
			SF4->&cFldName := aTesAlt[ nX, 3 ]
			
			MsUnlock()
			
		End If
		
	Next nX
	
Return
