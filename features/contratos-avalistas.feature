#language: pt
@contratos @avalistas
Funcionalidade: Contratos - Avalistas
  Validação dos dados de Avalistas dos contratos gerados em PDF
  Requer contrato com Avalista
  
Contexto:
Dado as informações de 'Avalistas' para cruzamento de dados com contrato  
Dado um contrato 'Avalista_Contrato2017900074.pdf' em PDF
E a seção 'Avalistas' do contrato extraída em texto

@valida_nome_avalistas
Cenário: Verificar os Nomes dos Avalistas
Quando existir dados de AVALISTAS para o contrato em questão
Então no contrato deve constar os respectivos nomes na seção AVALISTAS 

@valida_estado_civil_avalistas @valida_conjuge_avalistas
Cenário: Verificar Estado Civil e Cônjuge dos Avalistas
Quando o Estado Civil do Avalista estiver populado
Então o nome do cônjuge deve estar populado de acordo para cada Avalista
E o nome do Cônjuge populado deve estar relacionado ao respectivo Avalista.
