#include "protheus.ch"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³GetComis  ³ Autor ³ Elton Teodoro Alves   ³ Data ³16.12.2013³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Funcao utilizada nos gatilhos 004 a 008 do campo C6_PRODUTO ³±±
±±³          ³para buscar da tabela ZA1 a comissao da relacao vendedor x  ³±±
±±³          ³grupo de produtos x cliente.                                ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function GetComis(cVendedor,cProduto,cCliente,cLojaClien)

Local nRet     := 0
Local cGrpProd := Posicione('SB1',1,xFilial('SB1')+PadR(AllTrim(cProduto),TamSX3('B1_COD')[1],' '),'B1_GRUPO')
Local aArea    := GetArea()

DbSelectArea('ZA1')
DbSetOrder(1)
DbGoTop()

If DbSeek(xFilial('ZA1')+cVendedor+cGrpProd+cCliente+cLojaClien)
	
	nRet := ZA1->ZA1_COMISS
	
ElseIf DbSeek(xFilial('ZA1')+cVendedor+cGrpProd)
	
	nRet := ZA1->ZA1_COMISS
	
End IF

DbCloseArea()

RestArea(aArea)

Return nRet
