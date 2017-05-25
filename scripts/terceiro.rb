require './scripts/pdf.rb'

class Terceiro
  attr_accessor :terceiro, :nome, :cpf_cnpj, :estado_civil, 
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
  
  def initialize(terceiro, pdf)
    @terceiro = terceiro
    @nome = pdf.getTagValue(@terceiro,"Nome\/Razão Social").to_s
    @cpf_cnpj = pdf.getTagValue(@terceiro,"CPF\/CNPJ").to_s
    @estado_civil = pdf.getTagValue(@terceiro,"Estado Civil").to_s
    @regime_bens = pdf.getTagValue(@terceiro,"Regime de bens").to_s #.gsub(/\p{Space}/, '').strip
    @conjuge = { 
      :nome => pdf.getTagValue(@terceiro,"Cônjuge Anuente").to_s, 
      :cpf => pdf.getTagValue(@terceiro,"CPF").gsub(/[[:space:]]/,'').strip
    }
  end

end
