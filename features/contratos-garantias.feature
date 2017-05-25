# #language: pt
# @contratos @garantias
# Funcionalidade: Contratos - Alienação Fiduciária/Garantias
#   Validação dos dados da seção Garantias  
#   Requer contrato com Alienação Fiduciária/Garantias

# Contexto:
# Dado as informações de 'Garantias' para cruzamento de dados com contrato  
# Dado um contrato 'Contrato2017000390.pdf' em PDF
# E a seção 'Garantias' do contrato extraída em texto

# Cenário: Verificar garantia(s) com veículos
# Quando existir a label Descrição de Veículo
# Então o campo 'Marca' deve estar populado
# E o campo 'Modelo' deve estar populado
# E o campo 'Ano Modelo' deve estar populado
# E o campo 'Ano Fabricação' deve estar populado
# E o campo 'Placa' deve estar populado
# E o campo 'Valor Veículo' deve estar populado
# E o campo 'Valor Solicitado' deve estar populado
# E o campo 'Chassis' deve estar populado
# E o campo 'Renavam' deve estar populado
# E o campo 'Nr. Nota Fiscal' deve estar populado
# E o campo 'Fornecedor' deve estar populado
# E o campo 'Situação do Veículo' deve estar populado