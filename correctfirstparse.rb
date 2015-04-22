require 'pry'
require 'json'

f = File.read('firstparse.json')
doc = JSON.parse(f)
list = doc["list"]
new_arr = []
matches = []





# Removed pron's that began or end with a dash, but were missed because they
# actually began or ended with ˈ or ˌ
# list.each do |obj|
#   temp = {}
#   temp["word"] = obj["word"]
#   temp["pron"] = []
#   obj["pron"].each do |pron|
#     exclude_pron = false
#     if pron[0] == "ˈ" 
#       exclude_pron = true if pron[1] == "-"
#     end
#     if pron[-1] == "ˈ" 
#       exclude_pron = true if pron[-2] == "-"
#     end
#     if pron[0] == "ˌ" 
#       exclude_pron = true if pron[1] == "-"
#     end
#     if pron[-1] == "ˌ" 
#       exclude_pron = true if pron[-2] == "-"
#     end
#     temp["pron"].push(pron) unless exclude_pron
#   end
#   new_arr.push(temp)
# end
# new_stash = {"words_left" => doc["words_left"], "list" => new_arr}
# f = File.open("firstparsecorrected.json", "w") do |k|
#   k.write(new_stash.to_json)
# end

# Converted underlined th's and k's

# match_k = []
# match_th = []
# list.each do |obj|
#   obj["pron"].each do |pron|
#     match_th.push(pron) if pron.include?("t͟h")
#     match_k.push(pron) if pron.include?("k͟")
#     matches.push(pron) if pron.include?("͟")
#   end
# end
# list.each do |obj|
#   temp = {}
#   temp["word"] = obj["word"]
#   temp["pron"] = []
#   obj["pron"].each do |pron|
#     temp["pron"].push(pron.gsub("u̇", "u").gsub("t͟h", "~").gsub("k͟", "+"))
#   end
#   new_arr.push(temp)
# end
# match_k_2 = []
# match_th_2 = []
# new_arr.each do |obj|
#   obj["pron"].each do |pron|
#     match_th.push(pron) if pron.include?("t͟h")
#     match_k.push(pron) if pron.include?("k͟")
#   end
# end


















