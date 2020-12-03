require 'json'
require 'pry'
require_relative '../config/environment'
require "tty-prompt"
prompt = TTY::Prompt.new

puts "~~~~~~~~~~~~~~~~~~~~~~~~~"
puts "} Welcome to BodyWork! {"
puts "~~~~~~~~~~~~~~~~~~~~~~~~~"
puts 
user_input = prompt.ask("What is your name?")

selected_user = User.find_name(user_input)
#binding.pry

selected_exercise = prompt.select("Which exercises would you like to do?") do | menu |
    menu.choice "See All Exercises"
    menu.choice "See My Exercises"
    menu.choice "Create New Exercise"
end

    
workout = if selected_exercise == "See All Exercises"
    all_exercises = Exercise.all
    exercise_id = prompt.select("Pick an exercise:") do | menu |
        all_exercises.each do | exercise |
            menu.choice exercise.name, exercise.id
        end
    end

    puts "Here is your chosen exercise:"
    exercise = Exercise.find_by(id: exercise_id)
    puts "#{exercise.name}"
    puts "#{exercise.category}"
    puts "#{exercise.instructions}"

    create_new_record = prompt.select("Would you like to log your exercise?") do | menu |
        menu.choice "Yes"
        menu.choice "No"
    end
    
    if create_new_record == "Yes"
        weight = prompt.ask("Input the weight amount you used:", convert: :integer) do |q|
            q.convert :integer
            q.messages[:convert?] = "Please enter a number."
          end
        sets = prompt.ask("How many sets did you do?", convert: :integer) do |q|
            q.convert :integer
            q.messages[:convert?] = "Please enter a number."
          end
        total_reps = prompt.ask("Input your total reps:", convert: :integer) do |q|
            q.convert :integer
            q.messages[:convert?] = "Please enter a number."
          end
        Record.create(user_id: selected_user.id, exercise_id: exercise_id, weight: weight, sets: sets, total_reps: total_reps)
        puts "Your record was saved!"
    end

    view_record = prompt.select("Would you like to view your last record?") do | menu |
        menu.choice "Yes"
        menu.choice "No"
    end

    if view_record == "Yes"
        last_record = selected_user.records.last
        exercise = Exercise.find_by(id: last_record.id)
        puts "#{last_record.exercise.name}"
        puts "#{last_record.weight}"
        puts "#{last_record.sets}"
        puts "#{last_record.total_reps}"
    end

elsif selected_exercise == "See My Exercises"
    user_exercises = selected_user.exercises.uniq
    exercise_id = prompt.select("Pick an exercise:") do | menu |
        # binding.pry 
        user_exercises.each do | exercise |
            menu.choice exercise.name, exercise.id
        end
    end

    puts "Here is your chosen exercise:"
    exercise = Exercise.find_by(id: exercise_id)
    puts "#{exercise.name}"
    puts "#{exercise.category}"
    puts "#{exercise.instructions}"

    create_new_record = prompt.select("Would you like to log your exercise?") do | menu |
        menu.choice "Yes"
        menu.choice "No"
    end
    
    if create_new_record == "Yes"
        weight = prompt.ask("Input the weight amount you used:", convert: :integer) do |q|
            q.convert :integer
            q.messages[:convert?] = "Please enter a number."
          end
        sets = prompt.ask("How many sets did you do?", convert: :integer) do |q|
            q.convert :integer
            q.messages[:convert?] = "Please enter a number."
          end
        total_reps = prompt.ask("Input your total reps:", convert: :integer) do |q|
            q.convert :integer
            q.messages[:convert?] = "Please enter a number."
          end
        Record.create(user_id: selected_user.id, exercise_id: exercise_id, weight: weight, sets: sets, total_reps: total_reps)
        puts "Your record was saved!"
    end

    view_record = prompt.select("Would you like to view your last record?") do | menu |
        menu.choice "Yes"
        menu.choice "No"
    end

    if view_record == "Yes"
        last_record = selected_user.records.last
        exercise = Exercise.find_by(id: last_record.id)
        puts "#{last_record.exercise.name}"
        puts "#{last_record.weight}"
        puts "#{last_record.sets}"
        puts "#{last_record.total_reps}"
    end

#     if 
#         #if user picks "squats"
#         #we want to return the objects of exercise class
end
    
# exercise_info = Exercise.find_by(id: workout) 
#     # puts exercise_info.name 
#     #  binding.pry 
#     #[#<Exercise id: 9, name: "Crunches", category: "Bodyweight", instructions: "https://www.google.com/url?client=internal-element...">]
    
# p exercise_info

if selected_exercise == "Create New Exercise"
    exercise_name = prompt.ask("What is the name of the exercise?")
    category = prompt.select("What is the exercise category?") do | menu |
        menu.choice "Bodyweight"
        menu.choice "Abs"
        menu.choice "Upperbody"
        menu.choice "Lowerbody"
        menu.choice "Kettlebells"
    end
    instructions = prompt.ask("Please include some instructions?")
    new_exercise = Exercise.create(name: exercise_name, category: category, instructions: instructions)
    create_new_record = prompt.select("Would you like to log your exercise?") do | menu |
        menu.choice "Yes"
        menu.choice "No"
    end

    puts "Here is your new exercise!"
    puts "#{new_exercise.name}"
    puts "#{new_exercise.category}"
    puts "#{new_exercise.instructions}"
    
    if create_new_record == "Yes"
        weight = prompt.ask("Input the weight amount you used:", convert: :integer) do |q|
            q.convert :integer
            q.messages[:convert?] = "Please enter a number."
          end
        sets = prompt.ask("How many sets did you do?", convert: :integer) do |q|
            q.convert :integer
            q.messages[:convert?] = "Please enter a number."
          end
        total_reps = prompt.ask("Input your total reps:", convert: :integer) do |q|
            q.convert :integer
            q.messages[:convert?] = "Please enter a number."
          end
        Record.create(user_id: selected_user.id, exercise_id: new_exercise.id, weight: weight, sets: sets, total_reps: total_reps)
        puts "Your record was saved!"
    end

    view_record = prompt.select("Would you like to view your last record?") do | menu |
        menu.choice "Yes"
        menu.choice "No"
    end

    if view_record == "Yes"
        last_record = selected_user.records.last
        exercise = Exercise.find_by(id: last_record.id)
        puts "#{last_record.exercise.name}"
        puts "#{last_record.weight}"
        puts "#{last_record.sets}"
        puts "#{last_record.total_reps}"
    end
end


    # puts exercise_info.name 
    # binding.pry 
    # puts exercise_info.category
    # puts exercise_info.instructions 

    # we want the user to be able to cheks it records
# user_records = selected_user.records
# p user_records





   




# else
#     selected_user.exercises 
binding.pry 
0