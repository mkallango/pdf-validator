require './scripts/pdf.rb'


class Avalista
  attr_accessor :avalista, :nome, :cpf_cnpj, :estado_civil, 
              :regimes, :regime_bens, :conjuge              

  @regimes = [
    "Comunhão de Bens".gsub(/[[:space:]]/,'').strip,
    "Comunhão Parcial de Bens ".gsub(/[[:space:]]/,'').strip,
    "Separação Total de Bens".gsub(/[[:space:]]/,'').strip,
    "Part. Final Aqüestos".gsub(/[[:space:]]/,'').strip,
    "Nenhum".gsub(/[[:space:]]/,'').strip
  ]
  @nome = ""
  @cpf_cnpj = ""
  @estado_civil = ""
  @regime_bens = ""
  @conjuge = { 
    :nome => "",
    :cpf => ""
  }
  
  def initialize(avalista, pdf)
    @avalista = avalista

    @nome = pdf.getTagValue(@avalista,"Nome\/Razão Social").to_s
    @cpf_cnpj = pdf.getTagValue(@avalista,"CPF\/CNPJ").to_s
    @estado_civil = pdf.getTagValue(@avalista,"Estado Civil").to_s
    @regime_bens = pdf.getTagValue(@avalista,"Regime de bens").to_s #.gsub(/\p{Space}/, '').strip
    @conjuge = { 
      :nome => pdf.getTagValue(@avalista,"Cônjuge Anuente").to_s, 
      :cpf => pdf.getTagValue(@avalista,"CPF").gsub(/[[:space:]]/,'').strip
    }
  end

end
