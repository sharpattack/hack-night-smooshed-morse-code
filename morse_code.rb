require 'json'

class MorseCode
  MORSE_TO_ALPHA_MAPPING = {
    ".-"=>"a",
    "-..."=>"b",
    "-.-."=>"c",
    "-.."=>"d",
    "."=>"e",
    "..-."=>"f",
    "--."=>"g",
    "...."=>"h",                                                                               
    ".."=>"i",
    ".---"=>"j",
    "-.-"=>"k",
    ".-.."=>"l",
    "--"=>"m",
    "-."=>"n",
    "---"=>"o",
    ".--."=>"p",
    "--.-" =>"q",
    ".-."=>"r",
    "..."=>"s",
    "-"=>"t",
    "..-"=>"u",
    "...-"=>"v",
    ".--"=>"w",
    "-..-"=>"x",
    "-.--"=>"y",
    "--.."=>"z"
  } 

  ALPHA_TO_MORSE_MAPPING = MORSE_TO_ALPHA_MAPPING.dup.invert


  def initialize(message, type="encoded")
    @message = message
    @type = type
    load_mapping
    morse_possibilities
  end

  def self.encode_string(message)
    encoder = self.new(message)
    encoder.run
  end

  def self.decode_string(message)
    decoder = self.new(message, "decoded")
    decoder.run
  end

  def run
    if @type == "encoded"
      return @message.gsub(" ", "").split("").map { |x| ALPHA_TO_MORSE_MAPPING[x] }.join
    elsif @type == "decoded"
      return @@possibilities[@message]
    end
  end

  def give_me_thirteen
    @@possibilities.max_by{ |k,v| v.length }
  end


  def load_mapping
    @@library ||= JSON.parse(File.read('./mapped.json'))
  end


  def morse_possibilities
    @@possibilities ||= @@library.inject({}) do |memo, (key, value)|
      if memo[value].nil?
        memo[value] = [key]
      else
        memo[value] << key
      end
      memo
    end
  end
end

puts MorseCode.encode_string("programmer") == ".--..-.-----..-..-----..-."
puts MorseCode.decode_string(".--..-.-----..-..-----..-.")
puts MorseCode.decode_string("-.....-...")
max_value = MorseCode.new("").give_me_thirteen
puts max_value 
