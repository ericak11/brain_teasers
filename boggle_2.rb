# What is the reasoning behind your approach?
# Although this approach takes a long time to execute I liked the simplicity of the code
# If I had more time to complete this challenge. I would adjust the code so that instead of permutating all of the possibilities it would
# instead only caluclulate values of possible routes

# What strategy did you choose and why?
# I chose to find all possible combinations of letters and then from that see if the words match the dicitonary.
# If the word matches the dictionary it is then evaluated to see if it is possible on a boggle board based on the relationship
# in placement between each letter
#
# Would this solution scale with larger boards?
# This would scale to larger (or smaller boards). but would take exponentially more time to run.


require 'pry'
board_size  = 4
letters = ('a'..'z').to_a
array = []
x = board_size ** 2

x.times do
  letter = letters.sample
  array.push(letter)
  letters.delete(letter)
end

board_hash = {}

array.each_with_index { |letter, index|  board_hash[index + 1] = letter  }

matched_words = []

def is_word(word, dictionary)
  dictionary[word[0,3]].include? word
end

def get_dictionary
  dict = Hash.new{|hash, key| hash[key] = []}
  File.open('dictionary.txt').each do |row|
    word = row.strip.downcase
    if word.length >= 3
      first_letters =  word[0,3]
      dict[first_letters] << word
    end
  end
  dict
end


def is_right(index, size)
  index % size == 0
end

def is_left(index, size)
  index % size == 1
end

def get_coordinates(index, board_size, array)
  coordinates_array = []
  if index <= board_size
    if is_right(index, board_size)
      coordinates_array = [index - 1, index + (board_size), index + (board_size - 1)]
    elsif is_left(index, board_size)
      coordinates_array = [index + 1, index + (board_size), index + (board_size + 1)]
    else
      coordinates_array = [index + 1, index - 1, index + (board_size), index + (board_size + 1), index + (board_size - 1)]
    end
  elsif index >= array.length - board_size
    if is_right(index, board_size)
      coordinates_array = [index - 1, index - (board_size), index - (board_size - 1)]
    elsif is_left(index, board_size)
      coordinates_array = [index + 1, index - (board_size), index - (board_size + 1)]
    else
      coordinates_array = [index + 1, index - 1, index - (board_size), index - (board_size + 1), index - (board_size - 1)]
    end
  else
    if is_right(index, board_size)
      coordinates_array = [index - 1, index - (board_size), index - (board_size - 1), index + (board_size), index + (board_size - 1)]
    elsif is_left(index, board_size)
      coordinates_array = [index + 1, index - (board_size), index - (board_size + 1), index + (board_size), index + (board_size - 1)]
    else
      coordinates_array = [index + 1, index - 1, index + (board_size), index + (board_size + 1), index + (board_size - 1), index - (board_size), index - (board_size + 1), index - (board_size - 1)]
    end
  end
  coordinates_array
end

dictionary = get_dictionary
puts "dict loaded"
(3..6).flat_map{|size| array.permutation(size).to_a }.map do |x|
  matched_words.push(x.join()) if is_word(x.join(), dictionary)
end
puts "3 - 7 RUN"

word_list = []
matched_words.each do |word|
  word_nums = []
  word.chars.each do |letter|
    word_nums.push(board_hash.invert[letter])
  end
  if word_nums.uniq.length == word_nums.length
    word_nums.each_with_index do |num, index|
      if index < word_nums.length - 1
        coordinates = get_coordinates(num, board_size, array)
        break if !coordinates.include? word_nums[index + 1]
      else
        word_list.push(word)
      end
    end
  end
end


puts word_list

