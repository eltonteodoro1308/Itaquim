#include "protheus.ch"
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  �RFATA01   � Autor � Elton Teodoro Alves   � Data �16.12.2013���
�������������������������������������������������������������������������Ĵ��
���Descri��o �Funcao que monta a tela de cadastro de da tabale ZA1 de ca- ���
���          �dastro de relacao comissao X vendedores X grupo de produtos ���
���          �X clientes.                                                 ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
User Function RFATA01()

local cAlias  := "ZA1"
Local cTitulo := "Rela��o Comiss�o x Grupo de Produto x Vendedor x Cliente"
Local cVldExc := ".T."
Local cVldAlt := ".T."
Local bOK     := {||lOk()}

ChkFile(cAlias)

dbSelectArea(cAlias)
dbSetOrder(1)

AxCadastro(cAlias,Ctitulo,CvldExc,cVldAlt,,,bOK)

DBCloseArea()

Return nil
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  �lOk       � Autor � Elton Teodoro Alves   � Data �16.12.2013���
�������������������������������������������������������������������������Ĵ��
���Descri��o �Funcao que valida se a relacao entre vendedor x grupo de    ���
���          �produto x cliente j� existe e bloqueia a inclusao e a alte- ���
���          �racao.                                                      ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function lOk()

Local lRet  := .T.
Local aArea := GetArea()

If Inclui .Or. Altera
	
	If DBSeek(xFilial('ZA1')+M->ZA1_VENDED+M->ZA1_GRPPRD+M->ZA1_CLIENT+M->ZA1_LJCLIE)
		
		If Inclui .Or. (ZA1->(Recno()) # aArea[3]) 
			
			lRet  := .F.
			
			ApMsgStop('J� existe esta comiss�o definida.','Aten��o !!!')
			
		End If
		
	End IF
	
End IF

RestArea(aArea)

Return lRet
