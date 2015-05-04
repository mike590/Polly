require 'pry'
require 'json'
# Load master rhymemap, contained in @test variable
require './rhymemap/stressfreemaster.rb'

f = File.read('parses/sixthparsecombined.json')
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

def rhyme(str, i = 0)
  match_word = get(str)
  pattern = match_word['code'][i]
  rhymes = []
  # For spaces within words
  @list.each do |word|
    word['code'].each_with_index do |code, ind|
      if code.include?(pattern)
        rhymes.push({word: word['word'], rhyme: word['pron'][ind]})
      end
    end
  end
  # How to match patterns with missing syls
  # use regex scan to see if it includes rhyme
  # replace missing syls with \d+, e.g. 12-\d+-\d+-86 would match [12-35-80-86]
  # pass in '12-\d+-\d+-86' (single quotes important) to Regexp.new('12-\d+-\d+-86')
  # then pass that to scan, it generates the for you
  return rhymes
end

# Used to find all letters from vowel to end of syllable, unless multiple vowels present,
# as well as stress
def define_rhyme(pattern)
  syls = pattern.split('-').reject{|s| s.empty? }
  defined_rhymes = []
  syls.each do |syl|
    use = true
    temp = ""
    temp += "ˌ" if syl[0] == "ˌ"
    temp += "ˈ" if syl[0] == "ˈ"
    if syl.include?("oi")
      ind = syl.index("oi")
    elsif syl.include?("au")
      ind = syl.index("au")
    else
      if !syl.scan(/[əēīȯᵊiaüāeäōuœ]/).empty?
        ind = syl.index(syl.scan(/[əēīȯᵊiaüāeäōuœ]/)[0])
      else
        use = false
      end
    end
    if use
      temp += syl[ind..(syl.length - 1)]
    else
      temp = "skip"
    end
    defined_rhymes.push(temp)
  end
  return defined_rhymes.join("-")
end

def rhyme_exact(str, i=0)
  match_word = get(str)
  pattern = define_rhyme(match_word['pron'][i])
  p_length = pattern.length
  syl_count = pattern.split("-").length
  rhymes = []
  @list.each do |word|
    catch :rhyme_found do
      word['exacts'].each do |pron|
        if pron != 'skip' && pron.split("-").length >= syl_count
          rhymes.push(word['word']) if pron.index(pattern) == pron.length - p_length
          throw :rhyme_found
        end
      end
    end
  end
  return rhymes
end

# codify the list for rhyme(str)
@list.each do |word|
  word["code"] = []
  word["pron"].each do |pron|
    syls = pron.split("-")
    code_arr = []
    syls.each do |syl|
      catch :code_found do
        @map.each do |k, v|
          v[:prim].each do |rhyme|
            if syl.include?(rhyme)
              code_arr.push(k)
              throw :code_found
            end
          end
        end
      end
    end
    word["code"].push(code_arr.join("-"))
  end
end

# Replace al syllables with defined_rhymes (from above) for exact_rhyme(str)
@list.each do |word|
  temp = []
  word["pron"].each do |pron|
    temp.push(define_rhyme(pron))
  end
  word["exacts"] = temp
end
binding.pry

# Create hash with consonant keys, each key containg a list of prons that 
# have the selected vowel followed by consonant in the key
# select_vowel = 'ü'
# test = {}
# @list.each do |obj|
#   obj["pron"].each do |pron|
#     @consonants.chars.each do |con|
#       test[con] ||= {"high" => [], "low" => [], "none" => []}
#       syls = pron.split("-")
#       use_pron = false
#       accent = "none"
#       front = true
#       syls.each do |syl|
#         if syl.include?("#{select_vowel}#{con}")
#           use_pron = true 
#           accent = "high" if syl[0] == "ˈ"
#           accent = "low" if syl[0] == "ˌ"
#           front = false if syl[-1] != con
#         end
#       end
#       if use_pron
#         front ? test[con][accent].unshift("#{obj['word']}: #{pron}") : test[con][accent].push("#{obj['word']}: #{pron}") 
#       end
#     end
#   end
# end

# Check for syllables with multiple vowels
# test = {"high" => [], "low" => [], "none" => []}
# @list.each do |obj|
#   obj["pron"].each do |pron|
#     syls = pron.split("-")
#     use_pron = false
#     accent = "none"
#     syls.each do |syl|
#       counter = 0
#       syl.chars do |let|
#         counter += 1 if @vowels.include?(let)
#       end
#       if counter > 1
#         use_pron = true 
#         accent = "high" if syl[0] == "ˈ"
#         accent = "low" if syl[0] == "ˌ"
#       end
#     end
#     test[accent].push("#{obj['word']}: #{pron}") if use_pron
#   end
# end 

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
