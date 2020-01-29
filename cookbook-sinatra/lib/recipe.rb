# MODEL - single piece of data
require 'byebug'

class Recipe
  attr_reader :name, :description, :prep_time, :difficulty, :read
  def initialize(attributes = {})
    @name = attributes[:name]
    @description = attributes[:description]
    @prep_time = attributes[:prep_time]
    @difficulty = attributes[:difficulty]
    @read = attributes[:read]
  end

  def read?
    to_bool(@read)
  end

  def to_bool(read)
    # byebug
    if @read == "true"
      true
    elsif @read == "false"
      false
    end
  end

  def mark_as_read
    @read = "true"
  end
end
