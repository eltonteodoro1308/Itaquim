#include "PROTHEUS.CH"

/*
�������������������������������������������������������������������������������
�������������������������������������������������������������������������������
���������������������������������������������������������������������������ͻ��
���Programa  �PE01NFESEFAZ�Autor  �Totvs               � Data �  04/16/14   ���
���������������������������������������������������������������������������͹��
���Desc.     � Ponto de entrada localizado na funcao XmlNfeSef do rdmake    ���
���          � NFESEFAZ. Atraves deste ponto e possivel realizar manipula-  ���
���          � coes nos dados do produto, mensagens adicionais, destinata-  ���
���          � rio, dados da nota, pedido de venda ou compra, antes da      ���
���          � montagem do XML, no momento da transmiss�o da NFe.           ���
���          �                                                              ���
���          � O retorno deve ser exatamente nesta ordem e passando o       ���
���          � conteudo completo dos arrays, pois no rdmake nfesefaz e      ���
���          � atribuido o retorno completo para as respectivas variaveis.  ���
���          �                                                              ���
���          � Ordem:                                                       ���
���          � aRetorno[1] -> aProd                                         ���
���          � aRetorno[2] -> cMensCli                                      ���
���          � aRetorno[3] -> cMensFis                                      ���
���          � aRetorno[4] -> aDest                                         ���
���          � aRetorno[5] -> aNota                                         ���
���          � aRetorno[6] -> aInfoItem                                     ���
���          � aRetorno[7] -> aDupl                                         ���
���          � aRetorno[8] -> aTransp                                       ���
���          � aRetorno[9] -> aEntrega                                      ���
���          � aRetorno[10] -> aRetirada                                    ���
���          � aRetorno[11] -> aVeiculo                                     ���
���          � aRetorno[11] -> aReboque                                     ���
���������������������������������������������������������������������������͹��
���Uso       � Protheus 11                                                  ���
���������������������������������������������������������������������������ͼ��
�������������������������������������������������������������������������������
�������������������������������������������������������������������������������
*/

User Function PE01NFESEFAZ()
	
	Local nX         := 0
	Local aArea      := GetArea()
	Local cMsgIt     := ''
	Local cTemp      := ''
	Local cResSen    := 'Resolucao do Senado Federal n� 13/12'
	Local lIsImport  := .F.
	Local lIsAlq4    := .F.
	Local lIsVdInter := .F.
	Local lIsExist   := .F.
	Local aProd      := PARAMIXB[1]
	Local cMensCli   := PARAMIXB[2]
	Local cMensFis   := PARAMIXB[3]
	Local aDest      := PARAMIXB[4]
	Local aNota      := PARAMIXB[5]
	Local aInfoItem  := PARAMIXB[6]
	Local aDupl      := PARAMIXB[7]
	Local aTransp    := PARAMIXB[8]
	Local aEntrega   := PARAMIXB[9]
	Local aRetirada  := PARAMIXB[10]
	Local aVeiculo   := PARAMIXB[11]
	Local aReboque   := PARAMIXB[12]
	Local aRetorno   := {}
	
	For nX := 1 To Len( aProd )
		
		cMsgIt := ''
		
		//�������������������������������������������������������������Ŀ
		//�Inclui na observa��o do item o n�mero do lote correspondente.�
		//���������������������������������������������������������������
		
		If .Not. Empty( aProd[ nX, 19 ] )
			
			cMsgIt += 'LOTE: ' + AllTrim( aProd[ nX, 19 ] ) + ' - '
			
		End If
		
		//�������������������������������������������������Ŀ
		//�Inclui na observa��o do item o pedido do cliente.�
		//���������������������������������������������������
		
		//D2_FILIAL+D2_DOC+D2_SERIE+DTOS(D2_EMISSAO)+D2_COD+D2_ITEM
		If .Not. Empty( cTemp := Posicione( 'SD2', 13, xFilial( 'SD2' ) + aNota[ 02 ] + aNota[ 01 ] + DToS(aNota[ 03 ]) + aProd[ nX, 02 ] + PadL( aProd[ nX, 01 ], 2, '0' ), 'D2_ITEMPV' ) )
			
			//C6_FILIAL+C6_NUM+C6_ITEM+C6_PRODUTO
			If .Not. Empty( cTemp := Posicione( 'SC6', 1, xFilial( 'SC6' ) + aProd[ nX, 38 ] + cTemp + aProd[ nX, 02 ], 'C6_PEDCLI' ) )
				
				cMsgIt += 'Pedido do Cliente: ' + AllTrim( cTemp ) + ' - '
				
			End If
			
		End If
		
		//���������������������������������������Ŀ
		//�Inclui a observa��o do produto no item.�
		//�����������������������������������������
		
		//B1_FILIAL+B1_COD
		If .Not. Empty( cTemp := MSMM( Posicione( 'SB1', 1, xFilial('SB1') + aProd[ nX, 02 ], 'B1_CODOBS' ) ) )
			
			cMsgIt += AllTrim( cTemp ) + ' - '
			
		End If
		
		//�����������������������������������Ŀ
		//�Inclui a observa��o da TES no item.�
		//�������������������������������������
		
		//F4_FILIAL+F4_CODIGO
		If .Not. Empty( cTemp := Posicione( 'SF4', 1, xFilial('SF4') + aProd[ nX, 27 ], 'F4_XOBS' ) )
			
			cMsgIt += AllTrim( cTemp ) + ' - '
			
		End If
		
		//��������������������������������������������������������������������������������������������������Ŀ
		//�Inclui a Resulu��o do Senado Federal para o item importado com ICMS de 4 % vendido a outro estado.�
		//����������������������������������������������������������������������������������������������������
		
		//B1_FILIAL+B1_COD
		lIsImport  := Posicione( 'SB1', 1, xFilial('SB1') + aProd[ nX, 02 ], 'B1_ORIGEM' ) $ '1267' // Verifica se o produto � importado
		lIsAlq4    := aProd[ nX, 33 ] == 4 // Verifica se foi aplicado a aliquota de 4%
		lIsVdInter := SubStr( aProd[ nX, 07 ], 1, 1) == '6'// Verifica se � venda interestadual
		lIsExist   := cResSen $ aProd[ nX, 25 ]
		
		If lIsImport .And. lIsAlq4 .And. lIsVdInter .And. .Not. lIsExist
			
			cMsgIt += cResSen + ' - '
			
		End If
		
		aProd[ nX, 25 ] := cMsgIt + aProd[ nX, 25 ]
		
	Next nX
	
	RestArea( aArea )
	
	//���������������������������������������������������������������������Ŀ
	//�Exibe tela para digitacao do complemento dos dados adcionais da NF-e.�
	//�����������������������������������������������������������������������
	cMensCli += GetMV('MV_MENNOTA') + Chr(13) + Chr(10) + CompInfAd()
	
	aadd(aRetorno,aProd)
	aadd(aRetorno,cMensCli)
	aadd(aRetorno,cMensFis)
	aadd(aRetorno,aDest)
	aadd(aRetorno,aNota)
	aadd(aRetorno,aInfoItem)
	aadd(aRetorno,aDupl)
	aadd(aRetorno,aTransp)
	aadd(aRetorno,aEntrega)
	aadd(aRetorno,aRetirada)
	aadd(aRetorno,aVeiculo)
	aadd(aRetorno,aReboque)
	
Return aRetorno

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CompInfAd �Autor  �Totvs               � Data �  04/16/14   ���
�������������������������������������������������������������������������͹��
���Desc.     � Static Function que exibe janela para digitacao de comple- ���
���          � mento dos dados adcionais da NF-e.                         ���
�������������������������������������������������������������������������͹��
���Uso       � Protheus                                                   ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function CompInfAd()
	
	Local oDlg    := Nil
	Local oMemo   := Nil
	Local oFont   := Nil
	Local cMemo   := ''
	Local cTitulo := 'Acr�scimo de Mensagem da NF-e.'
	
	
	DEFINE FONT oFont NAME "Courier New" SIZE 5,0
	
	DEFINE MSDIALOG oDlg TITLE cTitulo From 3,0 to 340,417 PIXEL
	
	@ 5,5 GET oMemo  VAR cMemo MEMO SIZE 200,145 OF oDlg PIXEL
	oMemo:oFont:=oFont
	
	DEFINE SBUTTON  FROM 153,115 TYPE  1 ACTION oDlg:End() ENABLE OF oDlg PIXEL
	DEFINE SBUTTON  FROM 153,145 TYPE  2 ACTION {||cMemo := '',oDlg:End()} ENABLE OF oDlg PIXEL
	DEFINE SBUTTON  FROM 153,175 TYPE  3 ACTION {||cMemo := ''} ENABLE OF oDlg PIXEL
	
	ACTIVATE MSDIALOG oDlg CENTER
	
Return cMemo

