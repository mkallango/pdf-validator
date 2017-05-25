require './scripts/avalista'


class Avalistas
  
  attr_reader :avals,:avalistas
  @avals = Array.new
  
  def initialize(avalistas, pdf)
    @avalistas = Hash.new
    @avals = Array.new
    avalTemp = Array.new
    count = 1
    avalistas.each do |av|
      av = av.strip 
      if avalistas.size == count
        avalTemp.push(av)
        @avals.push(avalTemp)
      elsif av.eql?(" ") then
        @avals.push(avalTemp)
        avalTemp = Array.new
      elsif !av.eql?(" ") then
        avalTemp.push(av)
      end
      count+=1
    end
    
    listaAvalistas = Array.new
    count = 0
    @avals.each do |a|      
      if !a.empty? then
        count += 1
        listaAvalistas.push(insert_avalista(a, count, pdf))
      end
    end
   
    listaAvalistas.each do |a|       
      @avalistas[a.keys[0]]=a[a.keys[0]]
    end
    
  end

  def insert_avalista(aval,count,pdf)
    av = Hash.new
    @avalista = Avalista.new aval,pdf  
    p = /(\p{space})/  
    av[@avalista.cpf_cnpj.gsub(p,'').to_s] = {
        "Nome/Razão Social" => @avalista.nome.to_s,
        "CPF/CNPJ" => @avalista.cpf_cnpj.gsub(p,'').to_s,
        "Estado Civil" => @avalista.estado_civil.gsub(p,'').to_s,
        "Regime de bens" => @avalista.regime_bens.to_s,
        "Cônjuge Anuente" => @avalista.conjuge[:nome].to_s,
        "CPF" => @avalista.conjuge[:cpf].to_s.gsub(p,'').to_s
      }
    return av
  end

  
  # def avalistas
  #   return @avalistas
  # end

  def destroy
    @avalistas = nil
  end
end

  