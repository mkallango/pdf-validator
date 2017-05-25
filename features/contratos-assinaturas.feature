#language: pt
@contratos @assinaturas
Funcionalidade: Contratos - Assinaturas
  Validação dos dados da seção Assinaturas
  #TODO: Avaliar situações de Pacto Adjeto 

Contexto:
Dado as informações de 'Assinaturas' para cruzamento de dados com contrato  
Dado um contrato 'c.05 - Contrato2017900074.pdf' em PDF
E a seção 'Assinaturas' do contrato extraída em texto

Cenário: Validar assinatura do Emitente
Dado as informações do emitente no contrato
Então a seção Assinaturas deve conter o Nome
E o CPF/CNPJ do Emitente

Cenário: Validar assinatura do Cônjuge do Emitente
Quando o emitente possuir estado civil Casado
E existir um regime de bens 
Então o Nome e o CPF do Cônjuge devem constar na seção de Assinaturas

Cenário: Validar assinatura dos Avalistas
Dado as informações dos avalistas no contrato
Então a seção Assinaturas deve conter os Nomes dos Avalistas
E os CPFs dos Avalistas

Cenário: Validar assinatura do Cônjuge do Avalista
Quando o avalista possuir estado civil Casado
E existir um regime de bens 
Então o Nome e o CPF dos Cônjuges dos Avalistas devem constar na seção de Assinaturas
