require_relative '../config/environment'
require "pry"
def loginnow
puts "enter username"
name = gets.chomp
end

####Create A new user

    def create_user
        prompt = TTY::Prompt.new
        puts "It is time to create your journal:)"
        puts "-------------------------------"
        puts "-------------------------------"
        puts "-------------------------------"
        new_name = prompt.ask("Enter a name")
        # new_password = prompt.mask("What is your secret?")
        new_password = prompt.ask("What is your password?")
        #binding.pry
        new_user = User.new(username: new_name, password: new_password )
        new_user.save
        new_user
    end

    def user_firstpage
        prompt = TTY::Prompt.new
        selected_promt = prompt.select("Welcome to your journal", %w(Selectuser Createuser exit))
        if selected_promt == "exit" 
        
        elsif selected_promt == "Selectuser"
            puts  "User Selected"
        elsif selected_promt == "Createuser"
                create_user
        end
    end

    user_firstpage




