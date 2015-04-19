require 'nokogiri'
require 'httparty'
require 'pry'
require 'json'

f = File.read("testwords.json")
word_arr = JSON.parse(f)
list = []
start = Time.new

100.times do |count|

  api_response = Nokogiri::XML(HTTParty.get("http://www.dictionaryapi.com/api/v1/references/collegiate/xml/" + word_arr[count] + "?key=0f3925c0-a95a-47af-b669-07e949857ca6"))


  api_response.css("entry").each do |node|

    if !node.css("pr").empty?
      node.css("it").remove
      temp = {}
      temp[:word] = node.css("ew")[0].text
      temp[:pron] = node.css("pr")[0].text.split(", ")
      list.push(temp)

      if !node.css("in").empty?
        node.css("in").each do |xtra|
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




