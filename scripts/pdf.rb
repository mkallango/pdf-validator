require 'pdf-reader'

class Pdf

  def initialize filename
    @reader = PDF::Reader.new('data/pdfs/'+filename)    
  end

  def break_section(sec1, sec2)
    txt = String.new
    @reader.pages.each do |page|
      txt << page.text.to_s
      txt << "\n"
    end

    seq = Array.new
    txt.string_between_markers(sec1,sec2).each_line {|s| seq.push(s) }
    seq.delete("\n")
    seq.each do |line| 
      if line.gsub(/[[:space:]]/,'').strip.include?('Versão') then 
        seq.delete(line) 
      end
    end
    #puts @seq
    return seq
  end

  def get_secao_assinaturas(sec1)
   txt = String.new
   @reader.pages.each do |page|
      txt << page.text.to_s
      txt << "\n"
    end
    seq = Array.new
    txt.string_left_marker(sec1).each_line {|s| seq.push(s) }
    #puts @seq
    seq.delete("\n")
    seq.each do |line| 
      if line.gsub(/[[:space:]]/,'').strip.include?('Versão') then 
        seq.delete(line) 
      end
    end
    #puts @seq
    return seq    
  end

  # def text
  #   txt = Array.new
  #   @reader.pages.each do |page|
  #     page.text.lines.each do |line|
  #       txt.push(line)
  #     end
  #   end
  #   return txt
  # end

  # def get_txt_from_marker marker
  #   txt = String.new
  #   @reader.pages.each do |page|
  #     page.text.lines.each do |line|
  #       txt << line
  #     end
  #   end
  #   return txt.match(/#{marker}:(.*)/m)
  # end

  def getTagValue(arr,marker)
    arr.each do |line|
      if ((!line.match(/#{marker}:/).nil?) == true) then
        if (line.match(/#{marker}:\s*(.*)./).nil?) then
          if (line.match(/#{marker}:\s*(\d+[,.]\d+)./).nil?) then
            return ''
          else
            str = line.match(/#{marker}:\s*(\d+[,.]\d+)./)[1].to_s
            #puts "RETURN " + str.gsub(/\p{Space}*\p{Space}/, '').strip
            puts "22222"            
            return str.gsub(/\p{Space}*\p{Space}/, '').strip
          end
        else
          str = line.match(/#{marker}:\s*(.*.)$/)[1].to_s
          #puts "33332"+ line.match(/#{marker}:\s(.*.)$/).to_a.to_s
          #p str
          return str
        end
      end      
    end
  end
end

class String
  def string_between_markers marker1, marker2
    self[/#{Regexp.escape(marker1)}(.*?)#{Regexp.escape(marker2)}/m, 1]
  end

  def string_left_marker marker1
    self[/#{Regexp.escape(marker1)}(.*)$/m, 1]
  end
end