require 'pry'
require 'json'

parses = []

f = File.read('parses/firstparsecorrected.json')
doc = JSON.parse(f)
parses.push({num: "first", list: doc['list'], words_left: doc['words_left']})

f = File.read('parses/secondparsecombined.json')
doc = JSON.parse(f)
parses.push({num: "second", list: doc['list'], words_left: doc['words_left']})

f = File.read('parses/thirdparsecombined.json')
doc = JSON.parse(f)
parses.push({num: "third", list: doc['list'], words_left: doc['words_left']})

f = File.read('parses/fourthparsecombined.json')
doc = JSON.parse(f)
parses.push({num: "fourth", list: doc['list'], words_left: doc['words_left']})

f = File.read('parses/fifthparsecombined.json')
doc = JSON.parse(f)
parses.push({num: "fifth", list: doc['list'], words_left: doc['words_left']})

f = File.read('parses/sixthparsecombined.json')
doc = JSON.parse(f)
parses.push({num: "sixth", list: doc['list'], words_left: doc['words_left']})

f = File.read('parses/seventhparsecombined.json')
doc = JSON.parse(f)
parses.push({num: "seventh", list: doc['list'], words_left: doc['words_left']})

f = File.read('parses/seventhparseraw.json')
doc = JSON.parse(f)
parses.push({num: "seventh raw", list: doc['list'], words_left: doc['words_left']})

parses.each do |p|
  puts p[:num]
  puts "list: #{p[:list].length}"
  puts "words_left: #{p[:words_left].length}"
end

binding.pry