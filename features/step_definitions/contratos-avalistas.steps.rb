require 'rspec'
require './scripts/avalistas.rb'
require 'json'
#################
### AVALISTAS ###
#################
Quando(/^existir dados de AVALISTAS para o contrato em questão$/) do  
  expect(@avalistas.avals.empty?).to be false
  expect(@avalistas.avalistas.nil?).to be false
  expect(@avalistas.avalistas.empty?).to be false
  
  expect(@avalistas.avalistas.keys.size).to be >= 1
  
end

Então(/^no contrato deve constar os respectivos nomes na seção AVALISTAS$/) do
  count2 = 0
  p  =  /\p{space}/
  keys = @avalistas.avalistas.keys
  #puts base_json[count2.to_s]
  while count2 < @avalistas.avalistas.keys.size do
    puts "Avalista #{count2}: " + @avalistas.avalistas[keys[count2]]["Nome/Razão Social"].to_s
    expect(@avalistas.avalistas[keys[count2]]["Nome/Razão Social"].gsub(p,'').to_s).to be_eql(@avalistas_json[keys[count2]]["Nome/Razão Social"].gsub(p,'').to_s)
    count2 += 1
  end
end

Quando(/^o Estado Civil do Avalista estiver populado$/) do
  count2 = 0
  keys = @avalistas.avalistas.keys
  #puts base_json[count2.to_s]
  while count2 < @avalistas.avalistas.keys.size do
    puts "Avalista #{count2}: " + @avalistas.avalistas[keys[count2]]["Estado Civil"]
    expect(@avalistas.avalistas[keys[count2]]["Estado Civil"]).to be_eql(@avalistas_json[keys[count2]]["Estado Civil"])
    count2 += 1
  end
end

Então(/^o nome do cônjuge deve estar populado de acordo para cada Avalista$/) do
  count2 = 0
  p  =  /\p{space}/
  keys = @avalistas.avalistas.keys
  #puts base_json[count2.to_s]
  while count2 < @avalistas.avalistas.keys.size do
    #puts "Avalista #{count2}: " + @avalistas.avalistas[keys[count2]]["Cônjuge Anuente"]
    expect(@avalistas.avalistas[keys[count2]]["Cônjuge Anuente"].gsub(p,'')).to be_eql(@avalistas_json[keys[count2]]["Cônjuge Anuente"].gsub(p,''))
    
    if (@avalistas.avalistas[keys[count2]]["Estado Civil"].upcase.eql?("CASADO")) then
      puts "Avalista #{count2}: " + @avalistas.avalistas[keys[count2]]["Cônjuge Anuente"]
      expect(@avalistas.avalistas[keys[count2]]["Cônjuge Anuente"]).to_not be_eql("")
    else
      puts "Avalista #{count2}: " + @avalistas.avalistas[keys[count2]]["Cônjuge Anuente"]
      expect(@avalistas.avalistas[keys[count2]]["Cônjuge Anuente"].gsub(p,'')).to be_empty
    end
    count2 += 1
  end
end

Então(/^o nome do Cônjuge populado deve estar relacionado ao respectivo Avalista\.$/) do
  count2 = 0
  keys = @avalistas.avalistas.keys
  p  =  /\p{space}/
  while count2 < @avalistas.avalistas.keys.size do
    #puts "Avalista #{count2}: " + @avalistas.avalistas[keys[count2]]["Cônjuge Anuente"]
    expect(@avalistas.avalistas[keys[count2]]["Cônjuge Anuente"].gsub(p,'').to_s).to be_eql(@avalistas_json[keys[count2]]["Cônjuge Anuente"].gsub(p,'').to_s)
    estadoCivil = @avalistas.avalistas[keys[count2]]["Estado Civil"].upcase
    
    case estadoCivil
    when ("CASADO" || "UNIÃO ESTÁVEL")
      expect(@avalistas.avalistas[keys[count2]]["Cônjuge Anuente"]).to_not be_eql("")
      expect(@avalistas.avalistas[keys[count2]]["Cônjuge Anuente"].gsub(p,'').to_s).to be_eql(@avalistas_json[keys[count2]]["Cônjuge Anuente"].gsub(p,'').to_s)
    else
      expect(@avalistas.avalistas[keys[count2]]["Cônjuge Anuente"].gsub(p,'').to_s).to be_empty
    end
    count2 += 1
  end
end
