class GarantiaVeiculo
  attr_reader :marca, :modelo, :ano_modelo, :ano_fabricacao,
              :placa, :valor_veiculo, :valor_solicitado, :chassis,
              :renavam, :nr_nota_fiscal, :fornecedor, :situacao_veiculo

  def initialize(dados)
    @marca = dados[:marca]
    @modelo = dados[:modelo]
    @ano_modelo = dados[:ano_modelo]
    @ano_fabricacao = dados[:ano_fabricacao]
    @placa = dados[:placa]
    @valor_veiculo = dados[:valor_veiculo]
    @valor_solicitado = dados[:valor_solicitado]
    @chassis = dados[:chassis]
    @renavam = dados[:renavam]
    @nr_nota_fiscal = dados[:nr_nota_fiscal]
    @fornecedor = dados[:fornecedor]
    @situacao_veiculo = dados[:situacao_veiculo]
  end
  
end