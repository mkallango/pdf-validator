require './scripts/terceiro'

#include Pdf

class Terceiros
  
  attr_accessor :terceiros
  attr_reader :tercs
  @@terceiros = Hash.new
  @tercs = Array.new
  
  def initialize(terceiros=@@terceiros, pdf)
    @tercs = Array.new
    tercTemp = Array.new
    count = 1
    terceiros.each do |tc|
      tc = tc.strip 
      
      if terceiros.size == count
        tercTemp.push(tc)
        @tercs.push(tercTemp)
      elsif tc.include?("CPF:") then
        tercTemp.push(tc)
        @tercs.push(tercTemp)
        tercTemp = Array.new
      elsif tc =~ /^\s$/ then
        @tercs.push(tercTemp)
        tercTemp = Array.new
      elsif !(tc =~ /^\s$/) then
        tercTemp.push(tc)
      end
      count+=1
    end
    c = 0
    @tercs.each do |t|
      #t.each { |s| p s.match(/\p{Space}\p/) }
      if t.size < 2 then
        @tercs.delete(t)                
      elsif !t.empty? then
        insert_terceiro t, pdf
      end
      c += 1      
    end
    #puts @tercs
    #puts @@avalistas.to_json
  end

  def insert_terceiro(terc, pdf)
    terceiro = Terceiro.new terc, pdf    
    @@terceiros[terceiro.cpf_cnpj.to_s] = {
        "Nome/Razão Social" => terceiro.nome.to_s,
        "CPF/CNPJ" => terceiro.cpf_cnpj.to_s,
        "Estado Civil" => terceiro.estado_civil.to_s,
        "Regime de bens" => terceiro.regime_bens.to_s,
        "Cônjuge Anuente" => terceiro.conjuge[:nome].to_s,
        "CPF" => terceiro.conjuge[:cpf].to_s
      }
  end

  
  def terceiros
    return @@terceiros
  end
end

  