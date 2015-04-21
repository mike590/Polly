require 'nokogiri'
require 'httparty'
require 'pry'
require 'json'

# http://www.merriam-webster.com/help/MWOL%20Pronunciation%20Guide.pdf

f = File.read("testwords.json")
# Create array of 5000 most commonly used words
word_arr = JSON.parse(f)
# Create array to push word objects into
list = []
start = Time.new

# Iterate through the word_arr, calling the dictionary api for each word to load it and its pronunciation into the list variablr
10.times do |count|

  api_response = Nokogiri::XML(HTTParty.get("http://www.dictionaryapi.com/api/v1/references/collegiate/xml/?key=0f3925c0-a95a-47af-b669-07e949857ca6"))

  # Iterate through the multiple entries for each word
  api_response.css("entry").each do |node|

    # Only look at entries that include a pronunciation tag (<pr>)
    if !node.css("pr").empty?

      # Remove it tags, which are extra text in the middle of pr tags
      node.css("it").remove

      # Put the primary pr tag in the list, getting the word name by <ew> tag
      # The pr tag is split into an array, as there are mulitple ways to form the pronunciation using various symbols
      temp = {}
      temp[:word] = node.css("ew")[0].text
      # Use .strip on each element in the array, then use .gsub(/\A\p{Space}*/, '') to detect @nbsp in the last element
      temp_arr = node.css("pr")[0].text.split(", ")
      # CHECK FOR ONE ELEMENT ARRAYS THAT BEGIN OR END IN DASHES OR ONLY HAVE CONSONANTS
      temp_arr.each do |pron|

      end
      temp[:pron] = []

      temp[:pron] = node.css("pr")[0].text.split(", ")
      list.push(temp)
      puts "Added #{}"

      # If there are secondary entries, they will be within <in> tags
      if !node.css("in").empty?

        # Iterate through the it tags
        node.css("in").each do |xtra|

          # If the it tag contains a pr tag, grab the pr, as well as the word by using the <if> tag
          if !xtra.css("pr").empty?
            temp = {}
            temp[:word] = xtra.css("if")[0].text
            # Use .strip on each element in the array, then use .gsub(/\A\p{Space}*/, '') to detect @nbsp in the last element
            temp[:pron] = xtra.css("pr")[0].text.split(", ")
            list.push(temp)
          end
        end
      end

    end
  
  end

end

puts Time.new - start
binding.pry

# Exlclusion Criteria:

#   prons with only consonants should be excluded, and the word 
#     should be excluded if its only pron is made of only consonants

#  prons including a division sign should be excluded

#  temporarily: delete anything beginning or ending with a -



#   if pron begins with -, it is the last syllable(s) of its word
#   if pron ends with -, it is the first syllable(s) of its word
#   if pron begins and ends with -, or even has - within it, it could be
#     pronouncing specific syllables. I do not yet see a way in which it is
#     indicating the placement of the selected syllables.
#       For now, delete all entries beginning or ending with -.
 
#   dashes delimit syllables, though possibly not within parentheses?

#   ˌ indicate low stress, ˈ indicate high stress, both preceding the syllable

#   parentheses indicate the enclosed sybmols are present in one pronunciation, but 
#     not another. Therefore, when a pron includes (), it must be logged twice, once with
#     the enclosed symbols, once without, neither with parentheses
#       CHECK: Is it possible for there to be two sets of ()? If so, need more combinations 
#         of copies

#   Unsavable Symbols: These need to be checked for and given manual maps to go between sublime
#     and the api
#       u with a single dot above it: it gets written as "u̇"
#       console can't do underlined h, but can do underlined t, so underlined th can be id'd as "t͟h"
#         **both the above mentioned (dotted u and undelrined th) translate correctly back into console, **
#         **so maybe dont need an alternate symbol to map them too?**
#       

#   Cant find underlined k to copy and check, same with connected ue

# Parse words from 5000 most commonly used words and save to json, 
# in order to iterate through them using the dictionary API to get words 
# and pronunciationsymbols

# f = File.open("wordlist.html", "r")

# doc = Nokogiri::HTML(f)

# f.close

# arr = []

# doc.css("tr > td").each do |node|
#   arr.push(node.text)
# end

# 14.times do
#   arr.delete_at(0)
# end

# words = []

# arr.each_with_index do |node, i|
#   if i % 5 == 0
#     words.push(node.gsub(/\A\p{Space}*/, ''))
#   end
# end

# f = File.open("testwords.json", "w") do |k|
#   k.write(words.to_json)
# end




