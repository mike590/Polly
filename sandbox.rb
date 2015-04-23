require 'pry'
require 'json'

f = File.read('firstparsecorrected.json')
doc = JSON.parse(f)
@list = doc["list"]
@vowels = "əēīȯᵊiaüāeäōuœ"
@consonants = "bdfghk+~lmnŋⁿrʳpstvqyz" # missing superscript y
@con_combos = ["ch", "hw", "sh", "th", "zh"] 
@hybrids = ["ər", "är", "au", "er", "ir", "ȯi", "ȯr", "ur"]

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

boom = {}
@list.each do |obj|
  obj["pron"].each do |pron|
    @consonants.chars.each do |con|
      boom[con] ||= []
      boom[con].push("#{obj['word']}: #{pron}") if pron.include?("ə#{con}")
      # syls = pron.split("-")
      # syls.each do |syl|
      # end
    end
  end
end  



binding.pry