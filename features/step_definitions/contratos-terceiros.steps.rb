require 'rspec'
require './scripts/terceiros.rb'
require 'json'
##################################
### TERCEIRO(s) GARANTIDORE(s) ###
##################################
Quando(/^existir dados de Terceiro\(s\) Garantidore\(s\) para o contrato em questão$/) do  
  expect(@terceiros.tercs.nil?).to be false
  expect(@terceiros.tercs.empty?).to be false
  expect(@terceiros.terceiros.nil?).to be false
  expect(@terceiros.terceiros.empty?).to be false
  
  expect(@terceiros.terceiros.keys.size).to be >= 1
end

Então(/^no contrato deve constar os respectivos nomes na seção Terceiro\(s\) Garantidore\(s\)$/) do
  count2 = 0
  keys = @terceiros.terceiros.keys
  #puts "KEYS: "+keys.to_s
  #puts "JSON: " + base_json[keys[count2]]
  while count2 < @terceiros.terceiros.keys.size do
    puts "Avalista #{count2}: " + @terceiros.terceiros[keys[count2]]["Nome/Razão Social"]
    tercContrato = @terceiros.terceiros[keys[count2]]["Nome/Razão Social"].match(/(\w+.\w+)$/).to_s
    tercJson = @terceiros_json[keys[count2]]["Nome/Razão Social"].match(/(\w+.\w+)$/).to_s
    #puts "TEST: '#{tercContrato}'"
  
    expect(tercContrato).to be_eql(tercJson)
    count2 += 1
  end
end

Quando(/^o Estado Civil do Terceiro estiver populado$/) do
  count2 = 0
  keys = @terceiros.terceiros.keys
  #puts base_json[count2.to_s]
  while count2 < @terceiros.terceiros.keys.size do
    puts "Avalista #{count2}: " + @terceiros.terceiros[keys[count2]]["Estado Civil"]
    expect(@terceiros.terceiros[keys[count2]]["Estado Civil"]).to be_eql(@terceiros_json[keys[count2]]["Estado Civil"])
    count2 += 1
  end
end

Então(/^o nome do cônjuge deve estar populado de acordo para cada Terceiro$/) do
  count2 = 0
  keys = @terceiros.terceiros.keys
  #puts base_json[count2.to_s]
  while count2 < @terceiros.terceiros.keys.size do
    #puts "Avalista #{count2}: " + @terceiros.terceiros[keys[count2]]["Cônjuge Anuente"]
    expect(@terceiros.terceiros[keys[count2]]["Cônjuge Anuente"]).to be_eql(@terceiros_json[keys[count2]]["Cônjuge Anuente"])
    
    if (@terceiros.terceiros[keys[count2]]["Estado Civil"].upcase.eql?("CASADO")) then
      puts "Avalista #{count2}: " + @terceiros.terceiros[keys[count2]]["Cônjuge Anuente"]
      expect(@terceiros.terceiros[keys[count2]]["Cônjuge Anuente"]).to_not be_eql("")
    else
      puts "Avalista #{count2}: " + @terceiros.terceiros[keys[count2]]["Cônjuge Anuente"]
      expect(@terceiros.terceiros[keys[count2]]["Cônjuge Anuente"]).to be_empty
    end
    count2 += 1
  end
end

Então(/^o nome do Cônjuge populado deve estar relacionado ao respectivo Terceiro\.$/) do
  count2 = 0
  keys = @terceiros.terceiros.keys
  
  while count2 < @terceiros.terceiros.keys.size do
    #puts "Avalista #{count2}: " + @avalistas.avalistas[keys[count2]]["Cônjuge Anuente"]
    expect(@terceiros.terceiros[keys[count2]]["Cônjuge Anuente"]).to be_eql(@terceiros_json[keys[count2]]["Cônjuge Anuente"])
    estadoCivil = @terceiros.terceiros[keys[count2]]["Estado Civil"].upcase
    puts estadoCivil
    case estadoCivil
    when ("CASADO" || "UNIÃO ESTÁVEL")
      expect(@terceiros.terceiros[keys[count2]]["Cônjuge Anuente"]).to_not be_eql("")
      expect(@terceiros.terceiros[keys[count2]]["Cônjuge Anuente"]).to be_eql(@terceiros_json[keys[count2]]["Cônjuge Anuente"])
    else
      expect(@terceiros.terceiros[keys[count2]]["Cônjuge Anuente"]).to be_empty
    end
    count2 += 1
  end
end
