require './pdf.rb'
include Pdf

@reader = PDF::Reader.new('../data/Contrato2017900083.pdf')
@pdfpath = '../data/Contrato2017900083.pdf'

nomeEmitente = 'Clinica4567'
secao = 'Emitente'
sec1 = '3. AVALISTAS'
sec2 = '4. TERCEIRO(S) GARANTIDOR(ES)'  
@sec = secao
@emitente = Pdf.break_section(@reader,sec1,sec2)
txt = Array.new
txt = Pdf.pdf_to_text('../data/Contrato2017900083.pdf')
newTxt = Pdf.get_txt_from_marker(@pdfpath,'EMISSÃO')
newTxt = newTxt.to_s.split("\n")
arr = newTxt.reject { |e| e.to_s.empty? }
puts arr
puts Pdf.getTagValue(@emitente,"Cônjuge")
puts nomeEmitente

if nomeEmitente.eql?(Pdf.getTagValue(@emitente,"Nome\/Razão Social")) then
  puts 'VERY GOOD!'
else
  puts 'DAMN!'
end
