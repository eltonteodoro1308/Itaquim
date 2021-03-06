#include "protheus.ch"
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  �GetComis  � Autor � Elton Teodoro Alves   � Data �16.12.2013���
�������������������������������������������������������������������������Ĵ��
���Descri��o �Funcao utilizada nos gatilhos 004 a 008 do campo C6_PRODUTO ���
���          �para buscar da tabela ZA1 a comissao da relacao vendedor x  ���
���          �grupo de produtos x cliente.                                ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
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
