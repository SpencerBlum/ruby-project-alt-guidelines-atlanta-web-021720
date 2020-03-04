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
        user_startapp
    end

####Method Deletes a user
    def delete_user
        prompt = TTY::Prompt.new
        choices = User.get_all_user_names
        selected_promt = prompt.select("What user do you want to delete", "[Back]", choices)
        if selected_promt == "[Back]"
            user_startapp
        elsif
            selected = prompt.select("Are you sure you want to delete this account", "Yes", "No")
            if selected == "No"
            delete_user
            else
            found_user = User.find_by(username: selected_promt)
            found_user.destroy
            puts "User has been deleted"
            puts "-------------------------------"
            puts "-------------------------------"
            puts "-------------------------------"
            user_startapp
            end          
        end
    end

    ####Select a user

    def user_select
        prompt = TTY::Prompt.new
        choices = User.get_all_user_names
        selected_promt = prompt.select("What user do you want to delete", "[Back]", choices)
        if  selected_promt == "[Back]"
            user_startapp
        else 
            @selected_user = User.find_by(username: selected_promt)
            user_journal_page
        end
    end

###Display all user Journals
def display_user_journals
    prompt = TTY::Prompt.new
user_entrys = JournalEntry.all_user_journal(@selected_user.id)
    if user_entrys == []
    puts "Sorry you have no journals yet"
    puts "********************************"
    puts "********************************"
    user_journal_page
    else 
    user_entrys.each do |entry|
        puts "Title: #{entry.title}"
        puts "||||||||||||||||||||||||||||||||"
        puts "||||||||||||||||||||||||||||||||"
        puts "Notes:"
        puts entry.notes
        puts "--------------------------------"
        puts "--------------------------------"
        end
        prompt.keypress("Press space or enter to continue", keys: [:space, :return])
        user_journal_page
    end
end

def create_new_entry
    prompt = TTY::Prompt.new
    puts "hello wellcome to your journal"
    new_country = prompt.ask("What country are you in?")
    new_place = prompt.ask("Where are you at(Ceasars Palace, AT&T park?")
    searched_location = Location.where(country: new_country, place: new_place)
    
    ##if searched location is not in the data base 
    if  searched_location == []
        new_location = Location.new(country: new_country, place: new_place)
        new_location.save
    end
    @new_searched_location = Location.where(country: new_country, place: new_place)
    new_title = prompt.ask("Make a title for your Journal entry")
    new_note = prompt.ask("Add note to journal")
    new_entry = JournalEntry.new(user_id: @selected_user.id, location_id: @new_searched_location[0].id, title: new_title, notes: new_note, date: Time.now)
    new_entry.save
    puts "Journal Created"
    user_journal_page   
end


####View and select journals by title
def select_by_title
    #puts "happy"
    prompt = TTY::Prompt.new
    choices = JournalEntry.get_all_user_journals(@selected_user)
    @selected_title = prompt.select("Select a journal title", "[Back]", choices)
    if @selected_title == "[Back]"
    user_journal_page
    else
    selected_entry = JournalEntry.where(title: @selected_title)
    puts selected_entry[0].title
    puts "---------------------------"
    puts "---------------------------"
    puts selected_entry[0].notes
    new_selected_prompt = prompt.select("Do you want to delete or edit entry", "[Back]", "Edit", "Delete") 
       # binding.pry
        if new_selected_prompt == "[Back]"
        select_by_title   
        elsif new_selected_prompt == "Delete"
        selected_entry[0].destroy
        select_by_title
        elsif new_selected_prompt == "Edit"
        edit_journal
        end
    end
end

####Edit an entry after creation
def edit_journal
    prompt = TTY::Prompt.new
    selected_prompt = prompt.select("Select a journal title", "[Back]", "Edit Title", "Edit Notes")
    if selected_prompt == "[Back]"
        select_by_title
    elsif selected_prompt == "Edit Title"
        new_title = prompt.ask("what is your new Title?")
        old_entry = JournalEntry.where(title: @selected_title, user_id: @selected_user.id)
        old_entry[0].title = new_title
        old_entry[0].save
        select_by_title
    elsif selected_prompt == "Edit Notes"
        new_notes = prompt.ask("Add new notes")
        old_entry = JournalEntry.where(title: @selected_title, user_id: @selected_user.id)
        old_entry[0].notes = new_notes
        old_entry[0].save
        select_by_title
    end 
end

### This is the select screen
    def user_journal_page
        prompt = TTY::Prompt.new
        selected_promt = prompt.select("Main Menu | User: #{@selected_user.username}", "[logout]", "All journals" , "Create new journal", "View By Title", "Exit")
        if selected_promt == "[logout]"
            user_startapp
        elsif selected_promt == "All journals"
            display_user_journals
        elsif selected_promt == "View By Title"
            if JournalEntry.all_user_journal(@selected_user.id) == []
            puts "You have no Journals :("
            user_journal_page
            else 
            select_by_title
            end
        elsif selected_promt == "Create new journal"
            create_new_entry
        end
    end

    def user_startapp
        prompt = TTY::Prompt.new
        selected_promt = prompt.select("Welcome to your journal", %w(exit Admin Log-into-user Create-user  Delete-user ))
        if selected_promt == "exit" 
        puts "Exit APP"
        elsif selected_promt == "Admin"
            user_select
        elsif selected_promt == "Create-user"
            create_user
        elsif selected_promt == "Delete-user"
            delete_user
        elsif selected_promt == "Log-into-user"
            login_into_user
        end
    end


    def login_into_user
        prompt = TTY::Prompt.new
        new_name = prompt.ask("What is your username")
        new_password = prompt.ask("What is your password?")
        if User.where(username: new_name, password: new_password) != []
            #binding.pry
         found_user = User.where(username: new_name, password: new_password)
         @selected_user = found_user[0]
        user_journal_page
        else
            puts "Wrong Username/password"
            puts "*****************************"
            puts "*****************************"
            user_startapp
        end

    end

    #delete_user
    user_startapp




