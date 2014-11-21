require 'pry'
# letters = ('a'..'z').to_a
# array = []
board_size  = 4


# board_size .times do
#   inner_array = []
#   board_size .times {inner_array.push(letters.sample)}
#   array.push(inner_array)
# end


# array = ["t","h","a","n","e","f","d","g","h","l","l","f","m","o","n","u"]


letters = ('a'..'z').to_a
array = []
x = 16

x.times {array.push(letters.sample)}

matched_words = []

def is_word(word)
  words = ["the", "and", "hello", "fun"]
  words.include? word
end

(3..x).flat_map{|size| array.combination(size).to_a }.each do |x|
  matched_words.push(x.join()) if is_word(x.join())
end





binding.pry


# # You are given a 4x4 grid of characters
# # Given that you have a method ‘is_word’ that returns a boolean, return a list of all possible words that can be created, by chaining adjacent letters using the following rules:
# # The letters in the word must be adjacent to each other
# # “Adjacent” can be defined as a letter that lies within one position, horizontally, vertically or diagonally of the current position.
# # Once a letter is used in a word, it cannot be reused in the same word. The letter can be reused however, in different words
# # A word consists of 3 or more letters in order to be valid

# def make_words(array, x, y, size)
#   matched_words = []
#   word = ""
#   counter = 0
#   while x < size && y < size
#     word += array[x][y]
#     array[x][y] = nil
#     if is_word(word)
#       matched_words.push(word)
#     end
#     counter.even? ? x += 1 : y += 1
#     counter +=  1
#   end
#   binding.pry
# end






# make_words(array,0,0, board_size)
