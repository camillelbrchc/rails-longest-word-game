require 'open-uri'
require 'json'

class GamesControllerController < ApplicationController
  def new
    @letters = []
    10.times do |letter|
      @letters << ('A'..'Z').to_a[rand(27)-1]
    end
  end

  def score
    @word = params[:word]
    grid = params[:grid]

    @array_answer = @word.upcase.split('')
    array_grid = grid.upcase.split('')

    if JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{@word}").read)['found'] == true
      @array_answer.each do |letter|
        if array_grid.include?(letter)
          array_grid.slice!(array_grid.index(letter))
          @result_message = "good"
        else
          @result_message = "wrong"
        end
      end
    else
      @result_message = "#{@word} is not an english word"
    end
  end
end
