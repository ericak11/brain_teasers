require 'pry'
letters = ('a'..'z').to_a.map { |letter| letter == "q" ? letter = "qu" : letter }
array = []
board_size  = 3

(board_size ** 2).times {array.push(letters.sample)}
board_hash = {}

array.each_with_index { |letter, index|  board_hash[index + 1] = letter  }


def is_word(word)
  dictionary = get_dictionary
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

def get_coordinates(index, board_size)
  coordinates_array = []
  if index <= board_size
    if is_right(index, board_size)
      coordinates_array = [index - 1, index + (board_size), index + (board_size - 1)]
    elsif is_left(index, board_size)
      coordinates_array = [index + 1, index + (board_size), index + (board_size + 1)]
    else
      coordinates_array = [index + 1, index - 1, index + (board_size), index + (board_size + 1), index + (board_size - 1)]
    end
  elsif spot >= array.length - board_size
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

def make_words(index, hash, size)
  matched_words = []
  words = []
  valid = true

  if  words.length > 0
    words.each_with_index do |word|
      if word.length >= 3
        matched_words.push(word) if is_word(word)
      end
      last_place = hash.key(word[-1])
      coor_array = get_coordinates(last_place, size)
      coor_array.each do |spot|
        words.push(hash[last_place] + hash[spot])
      end
    end
  else
    coor_array = get_coordinates(index, size)
    coor_array.each do |spot|
      binding.pry
      words.push(hash[index] + hash[spot])
    end
  end

end


make_words(1, board_hash, board_size)
