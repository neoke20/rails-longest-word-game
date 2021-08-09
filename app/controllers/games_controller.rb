require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = (0...10).map { ('a'..'z').to_a[rand(26)] }
  end

  def word_check(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt.join('')}"
    attempt_word = URI.open(url).read
    word = JSON.parse(attempt_word)
    word['found']
  end

  def score
    @word = params[:word].downcase.split('')
    @letters = params[:letters].split(' ')
    @win = "Congratulations! #{@word.join('').upcase} is a valid English word"
    @lose = "Sorry! #{@word.join('').upcase} is not a valid English word"
    @lose_wrong_letter = "Sorry, but #{@word.join('').upcase} cannot be built with #{@letters.join(', ').upcase}"
    if (@word - @letters).length > 0
     @answer = @lose_wrong_letter
    elsif word_check(@word)
      @answer = @win
    else
      @answer = @lose
    end
  end
end
