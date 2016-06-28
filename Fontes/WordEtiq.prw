#Include 'Protheus.ch'
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  �MA461ROT  � Autor � Elton Teodoro Alves   � Data �07.01.2014���
�������������������������������������������������������������������������Ĵ��
���Descri��o �Ponto de Entrada que adciona itens ao menu de acoes relacio-���
���          �nadas do MATA461 (Tela de Documentos de Saida)              ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function MA461ROT()

Local aRet := {}

AAdd(aRet,{"Etiqueta do Item","U_WordEtiq",0,2,0,NIL})

Return aRet
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  �WordEtiq  � Autor � Elton Teodoro Alves   � Data �07.01.2014���
�������������������������������������������������������������������������Ĵ��
���Descri��o �Rotina que monta a etiqueta do item selecionado na tela de  ���
���          �documentos de saida, depende do modelo etiqueta.dot salvo na���
���          �pasta do smartclient.                                       ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function WordEtiq()

Local	nHandle		:=	OLE_CreateLink()
Local	cPathDot	:=	GetClientDir()+'etiqueta.dot'
Local	aArea		:=	GetArea()
Local	cPesoBruto	:=	''
Local	lPathDotOk	:=	.T.

//����������������������������������������������������������������������������������������������Ŀ
//�Verifica se o modelo eiqueta.dot existe no smartcliente, se n�o existir copia da pasta System.�
//������������������������������������������������������������������������������������������������

IF !File(cPathDot)
	
	lPathDotOk	:= CpyS2T ('/system/etiqueta.dot',GetClientDir())
	
End IF


If !OLE_WordIsOk (nHandle)
	
	Alert('N�o Foi Poss�vel integrar com o Word.')
	
Else
	
	If !lPathDotOk
		
		Alert('Modelo da Etiqueta nao copiado para a pasta do SmartCliet.')
		
	Else
		
		If Empty(SC9->C9_NFISCAL)
			
			Alert('Documento de Sa�da n�o Gerado.')
			OLE_CloseLink(nHandle)
			
		Else
			
			cPesoBruto	:=	GetPeso()
			
			OLE_NewFile(nHandle,cPathDot)
			
			OLE_SetDocumentVar(nHandle,'B1_DESC'	,AllTrim(Posicione('SB1',1,xFilial('SB1')+SC9->C9_PRODUTO,'B1_DESC')))
			OLE_SetDocumentVar(nHandle,'C9_NFISCAL'	,AllTrim(SC9->C9_NFISCAL))
			OLE_SetDocumentVar(nHandle,'D2_LOTECTL'	,AllTrim(Posicione('SD2',3,xFilial('SD2')+SC9->C9_NFISCAL+SC9->C9_SERIENF+SC9->C9_CLIENTE+SC9->C9_LOJA+SC9->C9_PRODUTO+SC9->C9_ITEM,'D2_LOTECTL')))
			OLE_SetDocumentVar(nHandle,'B1_PESO'	,AllTrim(Str(Posicione('SB1',1,xFilial('SB1')+SC9->C9_PRODUTO,'B1_PESO')*SC9->C9_QTDLIB)))
			OLE_SetDocumentVar(nHandle,'nPesoBruto'	,cPesoBruto)
			OLE_SetDocumentVar(nHandle,'D2_DTVALID'	,Posicione('SD2',3,xFilial('SD2')+SC9->C9_NFISCAL+SC9->C9_SERIENF+SC9->C9_CLIENTE+SC9->C9_LOJA+SC9->C9_PRODUTO+SC9->C9_ITEM,'D2_DTVALID'))
			OLE_SetDocumentVar(nHandle,'A1_NOME'	,AllTrim(Posicione('SA1',1,xFilial('SA1')+SC9->C9_CLIENTE,'A1_NOME')))
			
			OLE_UpdateFields(nHandle)
			
			If MsgYesNo("Imprime o Documento ?")
				
				Ole_PrintFile(nHandle,"ALL",,,1)
				
			EndIf
			
			OLE_CloseFile(nHandle)
			OLE_CloseLink(nHandle)
			
		End IF
		
	End IF
	
End IF

RestArea(aArea)

Return
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  �GetPeso   � Autor � Elton Teodoro Alves   � Data �07.01.2014���
�������������������������������������������������������������������������Ĵ��
���Descri��o �Rotina que monta a janela que solicita o peso bruto do item ���
���          �selecionado para gerar a etiqueta.                          ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function GetPeso()

Local cRet
Local oButton
Local oGet
Local nGet := 0
Static oDlg

DEFINE MSDIALOG oDlg TITLE "Informe o Peso Bruto" FROM 000, 000  TO 075, 250 COLORS 0, 16777215 PIXEL

@ 005, 005 MSGET oGet VAR nGet SIZE 120, 010 OF oDlg COLORS 0, 16777215 PIXEL PICTURE X3Picture('B1_PESBRU')
@ 020, 100 BUTTON oButton PROMPT "Ok" SIZE 020, 010 OF oDlg PIXEL  ACTION {||oDlg:END()}

ACTIVATE MSDIALOG oDlg CENTERED

cRet	:=	AllTrim(Str(nGet))

Return cRet
