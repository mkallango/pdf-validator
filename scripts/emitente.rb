
class Emitente
  attr_reader :emitente, :nome, :cpf_cpnj, :conjuge,
              :estado_civil, :regimes, :regimesHash, :regime_bens


  def initialize(emitente, pdf)
    @regimesHash = {
      :C => "Comunhão de Bens".gsub(/[[:space:]]/,'').strip,
      :P => "Comunhão Parcial de Bens ".gsub(/[[:space:]]/,'').strip,
      :S => "Separação de Bens".gsub(/[[:space:]]/,'').strip,
      :A => "Part. Final Aqüestos".gsub(/[[:space:]]/,'').strip,
      :N => "Nenhum".gsub(/[[:space:]]/,'').strip
    }
    
    @regimes = [
      @regimesHash[:C],
      @regimesHash[:P],
      @regimesHash[:S],
      @regimesHash[:A],
      @regimesHash[:N]
    ]
    
    @emitente = Array.new
    @emitente = emitente
    @cpf_cnpj = pdf.getTagValue(@emitente,"CPF/CNPJ").to_s.gsub(/\p{Space}/,'')
    @nome = pdf.getTagValue(@emitente,"Nome\/Razão Social").to_s
    @regime_bens = pdf.getTagValue(@emitente,"Regime de bens").to_s #.gsub(/\p{Space}/, '').strip
    @estado_civil = pdf.getTagValue(@emitente,"Estado Civil").to_s.match(/[^\W]*/).to_s
    @conjuge = { 
      :nome => pdf.getTagValue(@emitente,"Cônjuge") , 
      :cpf => pdf.getTagValue(@emitente,"CPF").gsub(/[[:space:]]/,'').strip
    }
  end

  def estado_civil
    return @estado_civil
  end

  def nome= (str)
    @nome = str
  end
  
  def cpf_size
    return @cpf_cnpj.size
  end

  def destroy
    @emitente.each(&:destroy)
  end

end
