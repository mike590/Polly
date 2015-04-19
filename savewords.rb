require 'nokogiri'
require 'httparty'
require 'pry'
require 'json'

f = File.read("testwords.json")
# Create array of 5000 most commonly used words
word_arr = JSON.parse(f)
# Create array to push word objects into
list = []
start = Time.new

# Iterate through the word_arr, calling the dictionary api for each word to load it and its pronunciation into the list variablr
100.times do |count|

  api_response = Nokogiri::XML(HTTParty.get("http://www.dictionaryapi.com/api/v1/references/collegiate/xml/" + word_arr[count] + "?key=0f3925c0-a95a-47af-b669-07e949857ca6"))

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
      temp[:pron] = node.css("pr")[0].text.split(", ")
      list.push(temp)

      # If there are secondary entries, they will be within <in> tags
      if !node.css("in").empty?

        # Iterate through the it tags
        node.css("in").each do |xtra|

          # If the it tag contains a pr tag, grab the pr, as well as the word by using the <if> tag
          if !xtra.css("pr").empty?
            temp = {}
            temp[:word] = xtra.css("if")[0].text
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




