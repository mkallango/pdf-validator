#language: pt
@contratos @Emitente
Funcionalidade: Contratos - Emitente
  Validação dos dados de Emitente dos contratos gerados em PDF

Contexto:
Dado as informações de 'Emitente' para cruzamento de dados com contrato  
Dado um contrato 'Contrato2017000390.pdf' em PDF
E a seção 'Emitente' do contrato extraída em texto

@valida_nome_emitente @vne
Cenário: Verificar Nome do Emitente na seção '2. EMITENTE'
Então o Nome do Emitente no contrato deve ser igual a 'Cooperado Joao7986'

@valida_estado_civil_e_regime_bens @vec @vrb
Cenário: Verificar Estado Civil e Regime de Bens na seção '2. EMITENTE'
    - Regime de Bens deve vir populado quando o Estado Civil é CASADO, UNIÃO ESTÁVEL
    - Cônjuge e CPF do Cônjuge devem estar populados quando Estado Civil é CASADO ou UNIÃO ESTÁVEL
Quando o campo Estado Civil do emitente estiver populado no contrato
Então o campo Regime de Bens do emitente deve estar populado de acordo
E os campos Cônjuge e CPF do conjuge do emitente devem estar populados de acordo
