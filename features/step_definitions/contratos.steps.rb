require './scripts/pdf.rb'
require './scripts/emitente'
require './scripts/assinaturas'
require 'rspec'

#include Pdf
Dado(/^um contrato '(.*)' em PDF$/) do |arg1|
  @pdf = Pdf.new arg1
end

Dado(/^as informações de '(.*)' para cruzamento de dados com contrato$/) do |tipo|
  #pending # Obter informações a partir do banco de dados
  case tipo
  when 'Avalistas'
    @avalistas_json = JSON.parse(File.read('./data/avalistas.json'))
  when 'Terceiros'
    @terceiros_json = JSON.parse(File.read('./data/terceiros.json'))
  when 'Garantias'
    @garantias_json = JSON.parse(File.read('./data/garantias.json'))
  when 'Emitente'
    next
  when 'Assinaturas'
    next
  else
    raise 'Tipo de informação não encontrada.'
  end   
end


Dado(/^a seção '(.*)' do contrato extraída em texto$/) do |secao|
  case secao
  when 'Emitente'
    sec1 = '2. EMITENTE'
    sec2 = '3. AVALISTAS'  
    @sec = secao
    @emitente = Emitente.new @pdf.break_section(sec1,sec2),@pdf
    #@emitente.emitente.each { |s| puts s }
  when 'Avalistas'
    sec1 = '3. AVALISTAS'
    sec2 = '4. TERCEIRO(S) GARANTIDOR(ES)'
    @sec = secao
    @avalistas = Avalistas.new @pdf.break_section(sec1,sec2),@pdf
    #@avalistas.avalistas.each { |s| puts s }
  when 'Terceiros'
    sec1 = '4. TERCEIRO(S) GARANTIDOR(ES)'
    sec2 = 'II - CARACTERÍSTICAS DESTA CÉDULA DE CRÉDITO BANCÁRIO'
    @sec = secao
    @terceiros = Terceiros.new @pdf.break_section(sec1,sec2),@pdf
  when 'Garantias'
    sec1 = '15. Garantias:'
    sec2 = 'III - OUTROS DADOS DESTA CÉDULA DE CRÉDITO BANCÁRIO'
    @sec = secao
    @garantias = Garantias.new @pdf.break_section(sec1,sec2),@pdf    
  when 'Assinaturas'
    sem1 = '2. EMITENTE'
    sem2 = '3. AVALISTAS'  
    @emitente = Emitente.new @pdf.break_section(sem1,sem2),@pdf

    sea1 = '3. AVALISTAS'
    sea2 = '4. TERCEIRO(S) GARANTIDOR(ES)'
    @avalistas = Avalistas.new @pdf.break_section(sea1,sea2),@pdf

    set1 = '4. TERCEIRO(S) GARANTIDOR(ES)'
    set2 = 'II - CARACTERÍSTICAS DESTA CÉDULA DE CRÉDITO BANCÁRIO'
    @terceiros = Terceiros.new @pdf.break_section(set1,set2),@pdf

    sec1 = 'EMISSÃO:'
    @sec = secao
    @assinaturas = Assinaturas.new @pdf.get_secao_assinaturas(sec1)
    
    puts "---------------------------------------"
    puts "----------CONTRATOS.STEPS--------------"
    puts "---------------------------------------"
    puts @assinaturas.assinaturas
    puts  
  else
    "Seção não reconhecida."
  end  
  
end

