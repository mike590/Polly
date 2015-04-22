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
  matches = {}
  @list.each do |obj|
    obj["pron"].each do |pron|
      if pron.include?(str)
        matches[obj["word"]] ||= []
        matches[obj["word"]].push(pron) 
      end
    end
  end
  return matches
end

binding.pry