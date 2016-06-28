#include 'protheus.ch'
#include 'totvs.ch'
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³MsgItNfe  ³ Autor ³ Elton Teodoro Alves   ³ Data ³16.12.2013³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Funcao que monta a mensagem da NF-e para cada item da NF-e. ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Caracter: Mensagem montada para o Item posicionado da NF-e. ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MsgItNfe()

//Local	aLote	:=	{}
//Local	cPedido	:=	''
Local	cRet	:=	''
//Local	nX		:=	0
//Local	aArea	:=	GetArea()
//Local	cSeek	:=	XFILIAL('SD2')+SC6->C6_NUM+SC6->C6_ITEM
/*
DbSelectArea('SD2')
DbSetOrder(8)

If DbSeek(cSeek)
	
	Do While !EOF() .And. cSeek == XFILIAL('SD2')+SD2->D2_PEDIDO+SD2->D2_ITEMPV
		
		If(Empty(SD2->D2_LOTECTL),nil,aAdd(aLote,SD2->D2_LOTECTL))
		
		DbSkip()
		
	End Do
	
End If

RestArea(aArea)

cPedido	:=	AllTrim(SC6->C6_PEDCLI)

For nX := 1 To Len(aLote)
	
	cRet	+=	'LOTE PRODUTO ' 	+ AllTrim(SC6->C6_PRODUTO) + ': ' + aLote[nX] + '/'
	
Next nX

cRet	+=	IF(Empty(cPedido)	,'','PEDIDO PRODUTO ' 	+ AllTrim(SC6->C6_PRODUTO) + ': ' + cPedido) + '/'
cRet	+=	MSMM(Posicione('SB1',1,xFilial('SB1')+SC6->C6_PRODUTO,'B1_CODOBS')) + '/'
cRet	+=	Posicione('SF4',1,xFilial('SF4')+SC6->C6_TES,'F4_XOBS') + '/'
*/
Return cRet
