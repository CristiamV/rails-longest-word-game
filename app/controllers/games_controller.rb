require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('A'..'Z').to_a.sample }
  end

  def score    
    @attemp = params[:word]
    @letters = params[:letters].split(" ")
    @valid_grid_word = valid_grid_word?(@attemp, @letters)
    @valid_english_word = valid_english_word?(@attemp)
  end

  private
  def valid_grid_word?(attemp, letters)
    new_grid = letters.join.downcase.chars
    attemp.chars.all? { |letter| new_grid.include?(letter) }
  end

  def valid_english_word?(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt.downcase}"
    word_serialized = URI.open(url).read
    word = JSON.parse(word_serialized)
    word["found"]
  end
end
