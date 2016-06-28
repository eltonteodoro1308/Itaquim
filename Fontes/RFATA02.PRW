#Include 'Protheus.ch'
#Include 'Totvs.ch'

#Define CRLF Chr(13) + Chr(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRFATA02   บAutor  ณMicrosiga           บ Data ณ  04/26/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rotina que gera planilha de comissoes por item de nota fis-บฑฑ
ฑฑบ          ณ cal.                                                       บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function RFATA02()
	
	MsgRun('Gerando Planilha ....','Aguarde',{||RunProc()})
	
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRunProc   บAutor  ณMicrosiga           บ Data ณ  04/03/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Processamnto da planilha de comissoes.                     บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function	RunProc()
	
	Local cQuery	:=	""
	Local cTrab		:=	CriaTrab(,.F.)
	Local aParam	:=	GetParam()
	Local aArea		:=	{}
	Local nX		:=	001
	Local nY		:=	001
	Local nVend		:=	005
	Local aParcelas	:=	{}
	Local cPlanilha	:=	''
	Local aPlanilha	:=	{}
	
	If Len(aParam) > 0
		
		For nX := 1 To nVend
			
			cQuery += "SELECT " + CRLF
			cQuery += "SF2.F2_SERIE, "  + CRLF
			cQuery += "SF2.F2_DOC, " + CRLF
			cQuery += "SF2.F2_EMISSAO, " + CRLF
			cQuery += "SD2.D2_TES, " + CRLF
			cQuery += "SF4.F4_TEXTO, " + CRLF
			cQuery += "SF2.F2_COND, " + CRLF
			cQuery += "SE4.E4_DESCRI, " + CRLF
			cQuery += "SF2.F2_CLIENTE, " + CRLF
			cQuery += "SF2.F2_LOJA, " + CRLF
			cQuery += "SA1.A1_NOME, " + CRLF
			cQuery += "SF2.F2_VEND" + AllTrim(Str(nX)) + " 'E3_VEND', " + CRLF
			cQuery += "SA3.A3_NOME, " + CRLF
			cQuery += "SD2.D2_ITEM, " + CRLF
			cQuery += "SD2.D2_COD, " + CRLF
			cQuery += "SB1.B1_DESC, " + CRLF
			cQuery += "SD2.D2_QUANT, " + CRLF
			cQuery += "SD2.D2_PRCVEN, " + CRLF
			cQuery += "SD2.D2_TOTAL, " + CRLF
			cQuery += "SA3.A3_FRETE, " + CRLF
			cQuery += "SD2.D2_VALFRE, " + CRLF
			cQuery += "SA3.A3_ACREFIN, " + CRLF
			cQuery += "SD2.D2_VALACRS, " + CRLF
			cQuery += "SA3.A3_ICM, " + CRLF
			cQuery += "SD2.D2_PICM, " + CRLF
			cQuery += "SD2.D2_VALICM, " + CRLF
			cQuery += "SA3.A3_ICMSRET, " + CRLF
			cQuery += "SD2.D2_ICMSRET, " + CRLF
			cQuery += "SA3.A3_IPI, " + CRLF
			cQuery += "SD2.D2_IPI, " + CRLF
			cQuery += "SD2.D2_VALIPI, " + CRLF
			cQuery += "SA3.A3_PISCOF, " + CRLF
			cQuery += "SD2.D2_ALQIMP5 'FT_ALIQCOF', " + CRLF
			cQuery += "SD2.D2_VALIMP5 'FT_VALCOF', " + CRLF
			cQuery += "SD2.D2_ALQIMP6 'FT_ALIQPIS', " + CRLF
			cQuery += "SD2.D2_VALIMP6 'FT_VALPIS', " + CRLF
			cQuery += "SD2.D2_VALBRUT, " + CRLF
			cQuery += "SD2.D2_VALBRUT - " + CRLF
			cQuery += "CASE SA3.A3_ICM " + CRLF
			cQuery += "WHEN 'N' THEN SD2.D2_VALICM " + CRLF
			cQuery += "ELSE 0 " + CRLF
			cQuery += "END - " + CRLF
			cQuery += "CASE SA3.A3_ICMSRET  " + CRLF
			cQuery += "WHEN 'N' THEN SD2.D2_ICMSRET " + CRLF
			cQuery += "ELSE 0 " + CRLF
			cQuery += "END - " + CRLF
			cQuery += "CASE SA3.A3_IPI " + CRLF
			cQuery += "WHEN 'N' THEN SD2.D2_VALIPI " + CRLF
			cQuery += "ELSE 0 " + CRLF
			cQuery += "END - " + CRLF
			cQuery += "CASE SA3.A3_FRETE " + CRLF
			cQuery += "WHEN 'N' THEN SD2.D2_VALFRE " + CRLF
			cQuery += "ELSE 0 " + CRLF
			cQuery += "END - " + CRLF
			cQuery += "CASE SA3.A3_ACREFIN " + CRLF
			cQuery += "WHEN 'N' THEN SD2.D2_VALACRS " + CRLF
			cQuery += "ELSE 0 " + CRLF
			cQuery += "END - " + CRLF
			cQuery += "CASE SA3.A3_PISCOF " + CRLF
			cQuery += "WHEN '1' THEN 0 " + CRLF
			cQuery += "WHEN '2' THEN SD2.D2_VALIMP5 " + CRLF
			cQuery += "WHEN '3' THEN SD2.D2_VALIMP6 " + CRLF
			cQuery += "ELSE SD2.D2_VALIMP5 + SD2.D2_VALIMP6 " + CRLF
			cQuery += "END 'E3_BASE', " + CRLF
			cQuery += "SD2.D2_COMIS" + AllTrim(Str(nX)) + " 'E3_PORC', " + CRLF
			cQuery += "SA3.A3_ALEMISS, " + CRLF
			cQuery += "SA3.A3_ALBAIXA " + CRLF
			cQuery += "FROM " + CRLF
			cQuery += RetSqlName("SF2") + " SF2 " + CRLF
			cQuery += "LEFT JOIN " + RetSqlName("SD2") + " SD2 " + CRLF
			cQuery += "ON  " + CRLF
			cQuery += "SF2.F2_FILIAL = SD2.D2_FILIAL " + CRLF
			cQuery += "AND " + CRLF
			cQuery += "SF2.F2_EMISSAO = SD2.D2_EMISSAO " + CRLF
			cQuery += "AND " + CRLF
			cQuery += "SF2.F2_SERIE = SD2.D2_SERIE " + CRLF
			cQuery += "AND " + CRLF
			cQuery += "SF2.F2_DOC = SD2.D2_DOC " + CRLF
			cQuery += "LEFT JOIN " + RetSqlName("SF4") + " SF4 " + CRLF
			cQuery += "ON  " + CRLF
			cQuery += "SF2.F2_FILIAL = SF4.F4_FILIAL " + CRLF
			cQuery += "AND " + CRLF
			cQuery += "SD2.D2_TES = SF4.F4_CODIGO " + CRLF
			cQuery += "LEFT JOIN " + RetSqlName("SA1") + " SA1 " + CRLF
			cQuery += "ON " + CRLF
			cQuery += "SF2.F2_CLIENTE = SA1.A1_COD " + CRLF
			cQuery += "AND " + CRLF
			cQuery += "SF2.F2_LOJA = SA1.A1_LOJA " + CRLF
			cQuery += "LEFT JOIN " + RetSqlName("SA3") + " SA3 " + CRLF
			cQuery += "ON " + CRLF
			cQuery += "SA3.A3_COD = SF2.F2_VEND" + AllTrim(Str(nX)) + " " + CRLF
			cQuery += "LEFT JOIN " + RetSqlName("SB1") + " SB1 " + CRLF
			cQuery += "ON " + CRLF
			cQuery += "SF2.F2_FILIAL = SB1.B1_FILIAL " + CRLF
			cQuery += "AND " + CRLF
			cQuery += "SB1.B1_COD = SD2.D2_COD " + CRLF
			cQuery += "LEFT JOIN " + RetSqlName("SE4") + " SE4 " + CRLF
			cQuery += "ON " + CRLF
			cQuery += "SF2.F2_FILIAL = SE4.E4_FILIAL " + CRLF
			cQuery += "AND " + CRLF
			cQuery += "SE4.E4_CODIGO = SF2.F2_COND " + CRLF
			cQuery += "WHERE " + CRLF
			cQuery += "SF2.D_E_L_E_T_ <> '*' " + CRLF
			cQuery += "AND " + CRLF
			cQuery += "SF2.F2_TIPO = 'N' " + CRLF
			cQuery += "AND " + CRLF
			cQuery += "SD2.D2_COMIS" + AllTrim(Str(nX)) + " > 0" + CRLF
			cQuery += "AND " + CRLF
			cQuery += "SF2.F2_VEND" + AllTrim(Str(nX)) + " <> '' " + CRLF
			cQuery += "AND " + CRLF
			cQuery += "SF4.F4_DUPLIC = 'S' " + CRLF
			cQuery += "AND " + CRLF
			cQuery += "SB1.D_E_L_E_T_ <>'*' " + CRLF
			cQuery += "AND  " + CRLF
			cQuery += "SD2.D_E_L_E_T_ <> '*' " + CRLF
			cQuery += "AND " + CRLF
			cQuery += "SF4.D_E_L_E_T_ <> '*' " + CRLF
			cQuery += "AND " + CRLF
			cQuery += "SA1.D_E_L_E_T_ <> '*' " + CRLF
			cQuery += "AND " + CRLF
			cQuery += "SE4.D_E_L_E_T_ <> '*' " + CRLF
			cQuery += "AND " + CRLF
			cQuery += "SA3.D_E_L_E_T_ <> '*' " + CRLF
			cQuery += "AND " + CRLF
			cQuery += "SF2.F2_FILIAL BETWEEN '" + aParam[1] + "' AND '" + aParam[2] + "' " + CRLF
			cQuery += "AND " + CRLF
			cQuery += "SF2.F2_SERIE BETWEEN '" + aParam[3] + "' AND '" + aParam[4] + "' " + CRLF
			cQuery += "AND " + CRLF
			cQuery += "SF2.F2_DOC BETWEEN '" + aParam[5] + "' AND '" + aParam[6] + "' " + CRLF
			cQuery += "AND " + CRLF
			cQuery += "SF2.F2_EMISSAO BETWEEN '" + dTos(aParam[7]) + "' AND '" + dTos(aParam[8]) + "' " + CRLF
			cQuery += "AND " + CRLF
			cQuery += "SF2.F2_VEND" + AllTrim(Str(nX)) + " BETWEEN '" + aParam[9] + "' AND '" + aParam[10] + "' " + CRLF
			
			If nX < nVend
				
				cQuery += "UNION ALL " + CRLF
				
			End If
			
		Next nX
		
		cQuery += "ORDER BY " + CRLF + "F2_VEND1,F2_EMISSAO,F2_SERIE,F2_DOC,D2_ITEM"
		
		cQuery := ChangeQuery(cQuery)
		
		If TcSqlExec(cQuery) < 0
			
			Return MsgStop(TcSqlError())
			
		Else
			
			dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery), cTrab, .F., .T.)
			
			TCSetField(cTrab,'F2_EMISSAO','D',8,0)
			
			aArea := GetArea()
			
			(cTrab)->(DbGoTop())
			
			For nX := 1 To (cTrab)->(FCount())
				
				cPlanilha +=  AllTrim(GetSx3Cache((cTrab)->(FieldName(nX)),'X3_TITULO'))
				
				If nX < (cTrab)->(FCount())
					
					cPlanilha +=  ';'
					
				End If
				
			Next nX
			
			cPlanilha += ';' + AllTrim(GetSx3Cache('E3_TIPO','X3_TITULO'))
			cPlanilha += ';' + AllTrim(GetSx3Cache('E1_PARCELA','X3_TITULO'))
			cPlanilha += ';' + AllTrim(GetSx3Cache('E1_VENCTO','X3_TITULO'))
			cPlanilha += ';' + AllTrim(GetSx3Cache('E3_COMIS','X3_TITULO'))
			cPlanilha += CRLF
			
			aAdd(aPlanilha,cPlanilha)
			
			cPlanilha := ''
			
			Do While !EOF()
				
				If (cTrab)->A3_ALEMISS > 0
					
					For nX := 1 To (cTrab)->(FCount())
						
						If Valtype((cTrab)->(FieldGet(nX))) == 'N'
							
							cPlanilha +=  Transform((cTrab)->(FieldGet(nX)),X3Picture((cTrab)->(FieldName(nX))))
							
						ElseIf ValType((cTrab)->(FieldGet(nX))) == 'D'
							
							cPlanilha +=  dToc((cTrab)->(FieldGet(nX)))
							
						Else
							
							cPlanilha +=  AllTrim((cTrab)->(FieldGet(nX)))
							
						End IF
						
						If nX < (cTrab)->(FCount())
							
							cPlanilha +=  ';'
							
						End If
						
					Next nX
					
					cPlanilha +=  ';NF;;;' + Transform((cTrab)->E3_BASE * ((cTrab)->E3_PORC/100) * ((cTrab)->A3_ALEMISS/100),X3Picture('E3_COMIS'))
					
					cPlanilha += CRLF
					
					aAdd(aPlanilha,cPlanilha)
					
					cPlanilha := ''
					
				End If
				
				If (cTrab)->A3_ALBAIXA > 0
					
					aParcelas := Condicao((cTrab)->E3_BASE * ((cTrab)->E3_PORC/100) * ((cTrab)->A3_ALBAIXA/100),(cTrab)->F2_COND,,(cTrab)->F2_EMISSAO)
					
					RestArea(aArea)
					
					For nY := 1 To Len(aParcelas)
						
						For nX := 1 To (cTrab)->(FCount())
							
							If Valtype((cTrab)->(FieldGet(nX))) == 'N'
								
								cPlanilha +=  Transform((cTrab)->(FieldGet(nX)),X3Picture((cTrab)->(FieldName(nX))))
								
							ElseIf ValType((cTrab)->(FieldGet(nX))) == 'D'
								
								cPlanilha +=  dToc((cTrab)->(FieldGet(nX)))
								
							Else
								
								cPlanilha +=  AllTrim((cTrab)->(FieldGet(nX)))
								
							End IF
							
							If nX < (cTrab)->(FCount())
								
								cPlanilha +=  ';'
								
							End If
							
						Next nX
						
						cPlanilha +=  ';BOL;' + AllTrim(Str(nY)) + ';' + dToc(aParcelas[nY,1]) + ';' + Transform(aParcelas[nY,2],X3Picture('E3_COMIS'))
						
						cPlanilha += CRLF
						
						aAdd(aPlanilha,cPlanilha)
						
						cPlanilha := ''
						
					Next nY
					
					aParcelas := {}
					
				End If
				
				(cTrab)->(DbSkip())
				
			End Do
			
			(cTrab)->(DbCloseArea())
			
			GerExcel(aPlanilha)
			
		End If
		
	End If
	
Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetParam  บAutor  ณMicrosiga           บ Data ณ  04/26/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao que exibe tela de parametros para gerar planilha.   บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function GetParam()
	
	Local	aParamBox	:=	{}
	Local	aRet		:=	{}
	
	aAdd(aParamBox,{1,'Filial De',Space(LEN(SM0->M0_CODFIL)),'','','SM0EMP','',050,.F.})
	aAdd(aParamBox,{1,'Filial At้',Space(LEN(SM0->M0_CODFIL)),'','','SM0EMP','',050,.F.})
	
	aAdd(aParamBox,{1,'S้tie De',Space(TamSX3('F2_SERIE')[1]),'','','','',050,.F.})
	aAdd(aParamBox,{1,'S้rie At้',Space(TamSX3('F2_SERIE')[1]),'','','','',050,.F.})
	
	aAdd(aParamBox,{1,'NF De',Space(TamSX3('F2_DOC')[1]),'','','','',050,.F.})
	aAdd(aParamBox,{1,'NF At้',Space(TamSX3('F2_DOC')[1]),'','','','',050,.F.})
	
	aAdd(aParamBox,{1,'Emissใo NF De',cToD(''),'','','','',050,.F.})
	aAdd(aParamBox,{1,'Emissใo NF At้',cToD(''),'','','','',050,.F.})
	
	aAdd(aParamBox,{1,'Vendedor De',Space(TamSX3('A3_COD')[1]),'','','SA3','',050,.F.})
	aAdd(aParamBox,{1,'Vendedor At้',Space(TamSX3('A3_COD')[1]),'','','SA3','',050,.F.})
	
	If !ParamBox(aParamBox,'Informe os dados p/ Gera็ใo da Planilha.',@aRet,,,,,,,'RFATA02',.T.,.T.)
		
		aRet	:=	{}
		
	End If
	
Return aRet
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGerExcel  บAutor  ณMicrosiga           บ Data ณ  04/03/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao que gera planilha com base em array com as informa- บฑฑ
ฑฑบ          ณ coes                                                       บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GerExcel(aPlanilha)
	
	Local	oExcel	:=	nil
	Local	nX		:=	000
	Local	cFile	:=	GetClientDir () + 'comissoes.csv'
	Local	nHandle	:=	fCreate(cFile)
	
	If Len(aPlanilha) == 0
		
		ApMsgInfo('Nใo hแ dados para gerar a Planilha.','Aten็ใo !!!!')
		
	ElseIf nHandle == -1
		
		ApMsgInfo('Nใo foi possํvel gerar a planilha, verifique se a mesma nใo se encontra aberta.','Aten็ใo !!!!')
		
	Else
		
		For nX := 1 To Len(aPlanilha)
			
			If FWrite (nHandle,aPlanilha[nX],Len(aPlanilha[nX])) != Len(aPlanilha[nX])
				
				If !MsgAlert("Ocorreu um erro na grava็ใo do arquivo."+;
						"Continua?","Aten็ใo!")
					Exit
					
				EndIf
				
			End If
			
		Next nX
		
		fClose(nHandle)
		
		oExcel := MsExcel():New()
		
		oExcel:WorkBooks:Open(cFile)
		
		oExcel:SetVisible(.T.)
		
		oExcel := oExcel:Destroy()
		
	End If
	
Return
