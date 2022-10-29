class Recipe
  attr_reader :name, :description, :rating
  attr_accessor :prep_time

  def initialize(name, description, rating, prep_time)
    @name = name
    @description = description
    @rating = rating
    @done = false
    @prep_time = prep_time
  end

  def done?
    @done
  end

  def mark_as_done!
    @done = true
  end
end
