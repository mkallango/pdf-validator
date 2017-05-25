class Assinaturas
  attr_reader :assinaturas
  attr_reader :emitente, :avalistas, :emitente_conjuge

  def initialize (assinaturas)
    @assinaturas = assinaturas
    @emitente = { :nome => @assinaturas[1], :cpf_cnpj => @assinaturas[2] }   
    
    conjIndex = @assinaturas.index(@emitente[:nome])+2
    @emitente_conjuge = { :nome => @assinaturas[conjIndex], :cpf => @assinaturas[conjIndex+1]}    
    @avalistas = avalistas
  end

  def avalistas
    avalistas = Array.new
    count = 0
    while count < @assinaturas.size do 
      if @assinaturas[count].match(/AVALISTA:/) then
        avalistas.push({ :nome => @assinaturas[count].strip, :cpf => @assinaturas[count+1].strip })
        count += 2
      end
      count += 1
    end
    return avalistas
  end
end