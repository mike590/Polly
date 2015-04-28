require 'pry'
require 'json'

f = File.read('parses/fourthparsecombined.json')
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

test = {"high" => [], "low" => [], "none" => []}
@list.each do |obj|
  obj["pron"].each do |pron|
    syls = pron.split("-")
    use_pron = false
    accent = "none"
    syls.each do |syl|
      counter = 0
      syl.chars do |let|
        counter += 1 if @vowels.include?(let)
      end
      if counter > 1
        use_pron = true 
        accent = "high" if syl[0] == "ˈ"
        accent = "low" if syl[0] == "ˌ"
      end
    end
    test[accent].push("#{obj['word']}: #{pron}") if use_pron
end
end 

# endings = {"high" => [], "low" => [], "none" => []}
# @list.each do |obj|
#   obj["pron"].each do |pron|
#     syls = pron.split("-")
#     use_pron = false
#     accent = "none"
#     syls.each do |syl|
#       if syl[-1] == "œ"
#         use_pron = true 
#         accent = "high" if syl[0] == "ˈ"
#         accent = "low" if syl[0] == "ˌ"
#       end
#     end
#     endings[accent].push("#{obj['word']}: #{pron}") if use_pron
#   end
# end  

# Check for multiple vowels on one syllable 
binding.pry

# Use to replace underlined th with ~ and u̇ with u
# new_list = []
# @list.each do |obj|
#   temp = {}
#   temp["word"] = obj["word"]
#   temp['pron'] = []
#   obj['pron'].each do |pron|
#     temp["pron"].push(pron.gsub("t͟h", "~").gsub("u̇", "u"))
#   end
#   new_list.push(temp)
# end

# current_state = {"list" => new_list, "words_left" => doc["words_left"]}

# l = File.open("parses/thirdparsecorrect.json", "w") do |k|
#   k.write(current_state.to_json)
# end
