require_relative '../config/environment'
require "pry"



####Create a new user
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
        user_firstpage
    end

####Method Deletes a user
    def delete_user
        prompt = TTY::Prompt.new
        choices = User.get_all_user_names
        selected_promt = prompt.select("What user do you want to delete", "[Back]", choices)
        if selected_promt == "[Back]"
            user_firstpage
        elsif
            selected = prompt.select("What user do you want to delete", "Yes", "No")
            if selected == "No"
            delete_user
            else
            found_user = User.find_by(username: selected_promt)
            found_user.destroy
            puts "User has been deleted"
            puts "-------------------------------"
            puts "-------------------------------"
            puts "-------------------------------"
            user_firstpage
            end          
        end
    end





    def user_firstpage
        prompt = TTY::Prompt.new
        selected_promt = prompt.select("Welcome to your journal", %w(exit Select-user Create-user  Delete-user))
        if selected_promt == "exit" 
        
        elsif selected_promt == "Select-user"
            puts  "User Selected"
        elsif selected_promt == "Create-user"
                create_user
        elsif selected_promt == "Delete-user"
            delete_user
        end
    end


    #delete_user
    user_firstpage




