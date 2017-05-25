################
### Emitente ###
################
Dado(/^as informações do emitente no contrato$/) do
  @emitenteNome = @emitente.emitente[0]
  @emitenteCPFCNPJ = @emitente.emitente[1]
end

Então(/^a seção Assinaturas deve conter o Nome$/) do
  emitPat = /:\s(.*)/
  pspace = /\p{Space}/
  emitMatch = @emitenteNome.match(emitPat)[1].strip
  assMatch = @assinaturas.emitente[:nome].match(/:\s(.*)/)
  if !assMatch.nil? then
    puts "Seção Emitente: \t" + emitMatch
    puts "Assinatura: \t" + assMatch[1]
    expect(assMatch[1].strip.gsub(pspace,'')).to eq(emitMatch.gsub(pspace,''))  
  else
    puts "Seção Emitente: \t" + emitMatch
    puts "Assinatura: \t" + @assinaturas.emitente[:nome]    
    expect(@assinaturas.emitente[:nome].strip.gsub(pspace,'')).to eq(emitMatch.gsub(pspace,''))
  end
end

Então(/^o CPF\/CNPJ do Emitente$/) do
  emitPat = /:(.*)/
  emitMatch = @emitenteCPFCNPJ.match(emitPat)[1].strip.gsub(/\p{Space}/,'')
  puts "Seção Emitente: \t"+emitMatch
   
  assPat = /:\s(.*)/
  assMatch = @assinaturas.emitente[:cpf_cnpj].match(assPat)[1].strip.gsub(/\p{Space}/,'')
  puts "Assinatura: \t"+ assMatch

  expect(assMatch).to eq(emitMatch)
end


########################
### Cônjuge Emitente ###
########################
Quando(/^o emitente possuir estado civil Casado$/) do
  @ec = @emitente.estado_civil 
  case @emitente.estado_civil
  when ''
    @ec = 'Não possui Estado Civil' 
  when 'CASADO'||'UNIÃO ESTÁVEL'
    @ec = @emitente.estado_civil
  end
  puts "Emitente Estado Civil: \t" + @ec
end

Quando(/^existir um regime de bens$/) do
  case @emitente.estado_civil
  when ''
    expect(@emitente.regime_bens.gsub(/\p{Space}/,'').to_s).to be_empty,'Emitente sem estado civil não deve possuir Regime de Bens.'
  when 'CASADO'||'UNIÃO ESTÁVEL'
    expect(
      @emitente.regime_bens.gsub(/\p{Space}/,'').to_s.eql?(@emitente.regimesHash[:C])||
      @emitente.regime_bens.gsub(/\p{Space}/,'').to_s.eql?(@emitente.regimesHash[:P])||
      @emitente.regime_bens.gsub(/\p{Space}/,'').to_s.eql?(@emitente.regimesHash[:A])).to be true
    puts "Emitente Regime de Bens: \t" + @emitente.regime_bens
  end
end

Então(/^o Nome e o CPF do Cônjuge devem constar na seção de Assinaturas$/) do
  pspace = /\p{Space}/
  pconjlabel = /CÔNJUGE:\s(.*)/  
  pcpflabel = /CPF:\s(.*)/  
  case @emitente.estado_civil
  when ''
    expect(@emitente.conjuge[:nome].gsub(pspace,'')).to be_empty
    expect(@emitente.conjuge[:cpf].gsub(pspace,'')).to be_empty
  when 'CASADO'||'UNIÃO ESTÁVEL'
    if (@emitente.regime_bens.gsub(/\p{Space}/,'').to_s.eql?(@emitente.regimesHash[:C])||
      @emitente.regime_bens.gsub(/\p{Space}/,'').to_s.eql?(@emitente.regimesHash[:P])||
      @emitente.regime_bens.gsub(/\p{Space}/,'').to_s.eql?(@emitente.regimesHash[:A])) then
        
      assConjMatch = @assinaturas.emitente_conjuge[:nome].match(pconjlabel)[1].strip.gsub(pspace,'')
      assConjCpfMatch = @assinaturas.emitente_conjuge[:cpf].match(pcpflabel)[1].strip.gsub(pspace,'')
      
      puts @assinaturas.emitente_conjuge[:nome]
      puts @assinaturas.emitente_conjuge[:cpf]
      expect(@emitente.conjuge[:nome].gsub(pspace,'')).to eq(assConjMatch)    
      expect(@emitente.conjuge[:cpf].gsub(pspace,'')).to eq(assConjCpfMatch)    
    else
      assConjMatch = @assinaturas.emitente_conjuge[:nome].match(plabel)[1].strip
      puts "Regime de bens: " + @emitente.regime_bens
      puts "Assinatura Conj:" + assConjMatch
    end
  else
    pending #é preciso cobrir outros valores de Estado Civil
  end
end


################
### Avalista ###
################
Dado(/^as informações dos avalistas no contrato$/) do
  expect(@avalistas.avalistas).not_to be_empty
end

Então(/^a seção Assinaturas deve conter os Nomes dos Avalistas$/) do
  @assinaturas.avalistas.each do |av| 
    cpf  =  av[:cpf].match(/:\s(.*)/)[1].strip.gsub(/\p{Space}/,'')
    avalNome = @avalistas.avalistas[cpf]["Nome/Razão Social"]
    assAvalNome = av[:nome].match(/:\s(.*)/)[1].strip
    puts "Aval. Contrato: \t\t"+avalNome
    puts "Aval. Assinatura: \t"+assAvalNome
    puts "---------------------------------------"
    expect(avalNome.gsub(/\p{Space}/,'')).to eq(assAvalNome.gsub(/\p{Space}/,''))
  end
end

Então(/^os CPFs dos Avalistas$/) do
  @assinaturas.avalistas.each do |av| 
    cpf  =  av[:cpf].match(/:\s(.*)/)[1].strip.gsub(/\p{Space}/,'')
    avalCpf = @avalistas.avalistas[cpf]["CPF/CNPJ"]
    assAvalCpf = av[:cpf].match(/:\s(.*)/)[1].strip
    puts "CPF Aval. Contrato: \t"+avalCpf
    puts "CPF Aval. Assinatura: \t"+assAvalCpf
    puts "---------------------------------------"
    expect(avalCpf.gsub(/\p{Space}/,'')).to eq(assAvalCpf.gsub(/\p{Space}/,''))
  end
end


Quando(/^o avalista possuir estado civil Casado$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Então(/^o Nome e o CPF dos? Cônjuges? dos? Avalistas? devem constar na seção de Assinaturas$/) do
  pending # Write code here that turns the phrase above into concrete actions
end