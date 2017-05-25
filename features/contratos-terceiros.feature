#language: pt
@contratos @terceiros
Funcionalidade: Contratos - Terceiro(s) Garantidore(s)
  Validação dos dados de Terceiro(s) Garantidore(s) dos contratos gerados em PDF
  Requer contrato com Terceiro(s) Garantidore(s)
  
Contexto:
Dado as informações de 'Terceiros' para cruzamento de dados com contrato  
Dado um contrato 'Terceiros_Contrato2017000416.pdf' em PDF
E a seção 'Terceiros' do contrato extraída em texto

@valida_nome_terceiros @vnt
Cenário: Verificar os Nomes do(s) Terceiro(s) Garantidore(s)
Quando existir dados de Terceiro(s) Garantidore(s) para o contrato em questão
Então no contrato deve constar os respectivos nomes na seção Terceiro(s) Garantidore(s) 

@valida_estado_civil_terceiros @valida_conjuge_terceiros
Cenário: Verificar Estado Civil e Cônjuge dos Terceiro(s) Garantidore(s)
Quando o Estado Civil do Terceiro estiver populado  
Então o nome do cônjuge deve estar populado de acordo para cada Terceiro
E o nome do Cônjuge populado deve estar relacionado ao respectivo Terceiro.
