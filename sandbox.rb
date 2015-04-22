require 'pry'
require 'json'

f = File.read('firstparse.json')
doc = JSON.parse(f)
list = doc["list"]
new_arr = []
match_k = []
match_th = []
matches = []
list.each do |obj|
  obj["pron"].each do |pron|
    match_th.push(pron) if pron.include?("t͟h")
    match_k.push(pron) if pron.include?("k͟")
    matches.push(pron) if pron.include?("͟")
  end
end
list.each do |obj|
  temp = {}
  temp["word"] = obj["word"]
  temp["pron"] = []
  obj["pron"].each do |pron|
    temp["pron"].push(pron.gsub("u̇", "u").gsub("t͟h", "~").gsub("k͟", "+"))
  end
  new_arr.push(temp)
end
match_k_2 = []
match_th_2 = []
new_arr.each do |obj|
  obj["pron"].each do |pron|
    match_th.push(pron) if pron.include?("t͟h")
    match_k.push(pron) if pron.include?("k͟")
  end
end
new_stash = {"words_left" => doc["words_left"], "list" => new_arr}

f = File.open("firstparsecorrected.json", "w") do |k|
  k.write(new_stash.to_json)
end

























