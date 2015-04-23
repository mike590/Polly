require 'json'
require 'pry'

f = File.read("firstparsecorrected.json")
first_list = JSON.parse(f)["list"]

f = File.read("secondparse.json")
second_list = JSON.parse(f)["list"]

comb_list = []
dup_list = []

first_list.each do |k|
  word = k["word"]
  temp = k
  second_list.each_with_index do |j, i|
    if j["word"] == word
      dup_list.push([j, k])
      j["pron"].each do |pron|
        if !temp["pron"].include?(pron)
          temp["pron"].push(pron)
        end
      end
      second_list.delete_at(i)
    end
  end
  comb_list.push(temp)
end
second_list.each do |k|
  comb_list.push(k)
end

def get(str, arr)
  word = ""
  arr.each do |obj|
    word = obj if str == obj["word"]
  end
  return word
end

u = File.read("firstparsecorrected.json")
words_left = JSON.parse(u)["list"]

current_state = {list: comb_list, words_left: words_left}

foo = File.open("secondparsecombined.json", "w") do |k|
  k.write(current_state.to_json)
end

