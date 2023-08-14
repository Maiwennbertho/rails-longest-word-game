require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ("A".."Z").to_a.sample }
    return @letters
  end

  def english_word(word)
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    word_dictionary = open(url).read
    word_info = JSON.parse(word_dictionary)
    return word_info['found']
  end

  def letter_in_grid(answer, grid)
    @answer.chars.sort.all? { |letter| @grid.include?(letter) }
  end

  class GamesController < ApplicationController
    # ...

    def score
      @grid = params[:grid]
      @word = params[:word]

      if !word_in_grid?(@word, @grid)
        @result = "Désolé, mais #{@word.upcase} ne peut pas être construit à partir de #{@grid}."
      else
        valid_word = valid_english_word?(@word)

        if valid_word
          @score = calculate_score(@word)
          @result = "Félicitations ! #{@word.upcase} est un mot valide et votre score est #{@score}."
        else
          @result = "Désolé, mais #{@word.upcase} ne semble pas être un mot anglais valide."
        end
      end

      @new_game_link = link_to('Nouvelle partie', new_game_path)

      render 'score'
    end
  end
end
