require 'pry'
require 'json'

f = File.read('parses/secondparsecombined.json')
doc = JSON.parse(f)
@list = doc["list"]
@vowels = "əēīȯᵊiaüāeäōuœ" # then deal with syllables that have multiple vowels
@consonants = "bdfghk+~lmnŋⁿrʳpstvqyz" # missing superscript y
@con_combos = ["ch", "hw", "sh", "th", "zh"] 
@hybrids = ["ər", "är", "au", "er", "ir", "ȯi", "ȯr", "ur", 'ȯi']

def find(str)
  matches = []
  @list.each do |obj|
    obj["pron"].each do |pron|
      if pron.include?(str)
        matches.push("#{obj["word"]}: #{pron}") 
      end
    end
  end
  return matches
end

def get(str)
  word = ""
  @list.each do |obj|
    word = obj if str == obj["word"]
  end
  return word
end

test = {}
@list.each do |obj|
  obj["pron"].each do |pron|
    @consonants.chars.each do |con|
      test[con] ||= {"high" => [], "low" => [], "none" => []}
      syls = pron.split("-")
      use_pron = false
      accent = "none"
      front = true
      syls.each do |syl|
        if syl.include?("e#{con}")
          use_pron = true 
          accent = "high" if syl[0] == "ˈ"
          accent = "low" if syl[0] == "ˌ"
          front = false if syl[-1] != con
        end
      end
      if use_pron
        front ? test[con][accent].unshift("#{obj['word']}: #{pron}") : test[con][accent].push("#{obj['word']}: #{pron}") 
      end
    end
  end
end 

endings = {"high" => [], "low" => [], "none" => []}
@list.each do |obj|
  obj["pron"].each do |pron|
    syls = pron.split("-")
    use_pron = false
    accent = "none"
    syls.each do |syl|
      if syl[-1] == "e"
        use_pron = true 
        accent = "high" if syl[0] == "ˈ"
        accent = "low" if syl[0] == "ˌ"
      end
    end
    endings[accent].push("#{obj['word']}: #{pron}") if use_pron
  end
end  

# Check for multiple vowels on one syllable 


binding.pry