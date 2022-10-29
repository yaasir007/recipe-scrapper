class View
  def display(recipes)
    recipes.each_with_index do |recipe, index|
      status = recipe.done? ? "[X]" : "[ ]"
      puts "#{index + 1}. #{status}: #{recipe.name} and #{recipe.description} | #{recipe.rating} | #{recipe.prep_time}"
    end
  end

  def ask_for_recipe_name
    puts "What is the name of your recipe"
    print "> "
    gets.chomp
  end

  def ask_user_for_prep_time
    puts "Prep time Please?"
    print "> "
    gets.chomp
  end

  def ask_for_recipe_description
    puts "Please add a description"
    print "> "
    gets.chomp
  end

  def ask_user_for_index
    puts "Which index ?"
    print "> "
    gets.chomp.to_i - 1
  end

  def ask_user_for_rating
    puts "Rating Please [1-5]"
    print "> "
    gets.chomp.to_i
  end

  def ask_for_keyword
    puts "What is the desired keyword?"
    print "> "
    gets.chomp
  end

  def ask_user_to_wait
    puts "Please wait, we are getting you the results..."
    puts "....."
    puts "....."
    puts "....."
  end
end
