require 'rspec'

################
### EMITENTE ###
################
Então(/^o Nome do Emitente no contrato deve ser igual a '(.*)'$/) do |nomeEmitente|
  @ptrn = /\p{Space}/
  nomePdf = @emitente.nome.gsub(@ptrn,'').to_s
  expect(nomePdf.eql?(nomeEmitente.gsub(@ptrn,'').to_s)).to be true
end

Quando(/^o campo Estado Civil do emitente estiver populado no contrato$/) do
  expect(@emitente.estado_civil).not_to be_nil,"A variável Estado Civil NÃO deve conter valor Nil"
  #puts @emitente.cpf_size
  if @emitente.cpf_size > 14 then
    expect(@emitente.estado_civil).to be_empty,"A variável Estado Civil deve conter valor vazio."
  else
    expect(@emitente.estado_civil).not_to be_empty,"A variável Estado Civil NÃO deve conter valor vazio."
  end

end

Então(/^o campo Regime de Bens do emitente deve estar populado de acordo$/) do
  erroRegimeVazio = "Regime de bens não deveria retornar vazio."
  regime_bens = @emitente.regime_bens.gsub(/\p{Space}/,'')
  @emitente.estado_civil    
  case @emitente.estado_civil
  when ("DIVORCIADO" || "SOLTEIRO")
    expect(@emitente.regime_bens.gsub(/\p{Space}/,'')).to be_empty,"Emitente com estado civil '"+@emitente.estado_civil+"' não deve conter dados de 'Regime de bens'"
  when ("CASADO" || "UNIÃO ESTÁVEL")
    if !@emitente.regime_bens.nil?
      # p regime_bens
      # p @emitente.regimes
      expect(@emitente.regimes.include?(regime_bens)).to be true
    else
      expect(@emitente.regime_bens).should be_nil,erroRegimeVazio  
    end
  when 'OUTROS'    
    if !@emitente.regime_bens.gsub(/\W/,'').empty?
      expect(@emitente.regimes.include?(regime_bens)).to be true
    else
      expect(@emitente.regime_bens.gsub(/\W/,'')).to be_empty  
    end    
  else
    expect(@emitente.regime_bens.gsub(/\p{Space}/,'')).to be_empty,'"Estado civil não reconhecido.'
  end
end

Então(/^os campos Cônjuge e CPF do conjuge do emitente devem estar populados de acordo$/) do  
  puts "Cônjuge: " + @emitente.conjuge[:nome].to_s +  " / Cpf: " + @emitente.conjuge[:cpf].to_s
  puts "Estado Civil: '" + @emitente.estado_civil.to_s + "'"
  case @emitente.estado_civil
  # Caso estado civil seja Divorciado, Solteiro, então não deve conter dados de Cônjuge
  when ('DIVORCIADO' || 'SOLTEIRO')
    expect(@emitente.conjuge[:nome].gsub(/\p{Space}/,'')).to be_empty,"Emitente com estado civil '"+@emitente.estado_civil+"' não deve conter dados de 'Cônjuge'"
    expect(@emitente.conjuge[:cpf].gsub(/\p{Space}/,'')).to be_empty,"Emitente com estado civil '"+@emitente.estado_civil+"' não deve conter dados de 'CPF do Cônjuge'"
  # Caso estado civil seja Casado, União Estável, então deve conter dados de Cônjuge
  when ('CASADO' || 'UNIÃO ESTÁVEL')
    expect(@emitente.conjuge[:nome]).not_to be_empty,"Emitente com estado civil '"+@emitente.estado_civil+"' deve conter dados de 'Cônjuge'"
    expect(@emitente.conjuge[:cpf]).not_to be_empty,"Emitente com estado civil '"+@emitente.estado_civil+"' deve conter dados de 'CPF do Cônjuge'"   
  # Caso estado civil seja Outros, 
  # - Caso haja algum dado de cônjuge preenchido então ambos os dados do Cônjuge devem ser retornados
  # - Caso algum dado esteja vazio, ambos os dados de Cônjuge devem ser retornados vazio 
  when ('OUTROS')
    if @emitente.conjuge[:nome].empty? then
      expect(@emitente.conjuge[:cpf]).to be_empty,"Emitente: Nome Cônjuge está vazio, não deveria conter valor de CPF."
    elsif @emitente.conjuge[:cpf].empty? then
      expect(@emitente.conjuge[:nome]).to be_empty,"Emitente: CPF do cônjuge está vazio, não deveria conter valor de Nome de Cõnjuge."
    else
      expect(@emitente.conjuge[:nome]).not_to be_empty,"Emitente com estado civil '"+@emitente.estado_civil+"' se possui CPF do Cônjuge deve conter também o Nome do Cônjuge'"
      expect(@emitente.conjuge[:cpf]).not_to be_empty,"Emitente com estado civil '"+@emitente.estado_civil+"' se possui Nome do Cônjuge deve conter também o CPF do Cônjuge'"
    end    
  else
    expect(@emitente.conjuge[:nome].gsub(/\p{Space}/,'')).to be_empty,"Emitente sem estado civil '"+@emitente.estado_civil+"' não deve conter dados de 'Cônjuge'"
    expect(@emitente.conjuge[:cpf].gsub(/\p{Space}/,'')).to be_empty,"Emitente sem estado civil '"+@emitente.estado_civil+"' não deve conter dados de 'CPF do Cônjuge'"
  end
end

Então(/^finaliza o teste da seção emitente$/) do
  @emitente = nil
end