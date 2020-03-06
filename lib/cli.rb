require_relative '../config/environment'
require "pry"

class Cli

####Create a new user
    def create_user
        system "clear"
        prompt = TTY::Prompt.new
        puts "Add a username and password to create an account:)"
        puts "-------------------------------"
        puts "-------------------------------"
        puts "-------------------------------"
        new_name = prompt.ask("Enter a username:")
        if User.find_by(username: new_name) != nil
            puts "Sorry user name already taken try again"
            puts "---------------------------------------"
            user_startapp
        else
        new_password = prompt.mask("Enter a password:")
        new_user = User.new(username: new_name, password: new_password )
        new_user.save
        user_startapp
        end
    end

####Method Deletes a user
    def delete_user
        system "clear"
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
            user_select
            end          
        end
    end

    ####Select a user

    def user_select
        system "clear"
        prompt = TTY::Prompt.new
        choices = User.get_all_user_names
        selected_promt = prompt.select("Select a user profile:", "[Back]", "Delete-user", choices)
        if  selected_promt == "[Back]"
            user_startapp
        elsif selected_promt == "Delete-user"
            delete_user
        else 
            @selected_user = User.find_by(username: selected_promt)
            user_journal_page
        end
    end

###Display all user Journals
def display_user_journals
    system "clear"
    prompt = TTY::Prompt.new
    user_entrys = JournalEntry.all_user_journal(@selected_user.id)
    if user_entrys == []
    puts "Sorry you have no journals yet"
    puts "********************************"
    puts "********************************"
    user_journal_page
    else 
    user_entrys.each do |entry|
        found_location = Location.find_by(id: entry.location_id)
        puts "Title: #{entry.title}"
        puts "Date: #{entry.date} "  + "location: #{found_location.place}"
        puts ""
        puts ""
        puts "Notes:"
        puts entry.notes
        puts "--------------------------------"
        puts "--------------------------------"
        end
        prompt.keypress("Press space or enter to continue", keys: [:space, :return])
        user_journal_page
    end
end

###creates a new journal entry
def create_new_entry
    system "clear"
    prompt = TTY::Prompt.new
    puts "hello wellcome to your journal"
    new_country = prompt.ask("What country are you in?")
    new_place = prompt.ask("Where are you at(Ceasars Palace, AT&T park?")
    searched_location = Location.where(country: new_country, place: new_place)
    
###if searched location is not in the data base 
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
    system "clear"
    prompt = TTY::Prompt.new
    choices = JournalEntry.get_all_user_journals(@selected_user)
    @selected_title = prompt.select("Select a journal title", "[Back]", choices)
    if @selected_title == "[Back]"
    user_journal_page
    else
    selected_entry = JournalEntry.where(title: @selected_title)
    found_location = Location.find_by(id: selected_entry[0].location_id)
    puts "Title: " + selected_entry[0].title
    #binding.pry
    puts "Time: #{selected_entry[0].date} "
    puts "Date: " + selected_entry[0].title + " Location: " + found_location.place
    puts ""
    puts ""
    puts "Notes: " + selected_entry[0].notes
    new_selected_prompt = prompt.select("Do you want to delete or edit entry", "[Back]", "Edit", "Delete") 
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
    system "clear"
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
        #system "clear"
        box = TTY::Box.success("Welcome to Journey")
        print box
        prompt = TTY::Prompt.new
        selected_promt = prompt.select("Home Screen", %w(exit Admin Log-into-user Create-account))
        if selected_promt == "exit" 
        puts "Exit APP"
        elsif selected_promt == "Admin"
            user_select
        elsif selected_promt == "Create-account"
            create_user
        elsif selected_promt == "Log-into-user"
            login_into_user
        end
    end


    def login_into_user
        
        prompt = TTY::Prompt.new
        new_name = prompt.ask("What is your username")
        new_password = prompt.mask("What is your password?")
        if User.where(username: new_name, password: new_password) != []
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
end

def askeeart
   puts" MMMMMMMMMMMMMNmmmmmmdddddddhhhhhhhyyyyyyyyysssssooooooo+++++++++/oydyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyNMMMMMMmyyyhNMM
MMMMMMMMMMdyoo///:::--------.........````````            ||||                                                 ``NMMMMM``.:/sM
MMMMMMMMMhoo:`                                           ||||                                                   NMMMMM`   .+h
MMMMMMMMMoo.                                             ||||                                                   NMMMMM`    :h
MMMMMMMMMo/`                                             ||||                                                   NMMMMM     :h
MMMMNNMMMs/`             -:::`                           ||||                                                   NMMMMN     :h
MMMMMNMMMs/.             dMMM:                           ||||                                                   NMMMMN     :y
MMMNho+oym+.             dMMM:                           ||||                                                   NMMMMN     -y
MMh/:---+Nd-`            dMMM:   `ohmMMNmy/    yddd`  `dddh  .dddoomNy yddd:hNMNd+     /ymNMMmy:  :dddh    +ddd+MMMMMm     :y
MMMs/-`` /Nh`            dMMM:  /MMMNyyhMMMm.  dMMM.  `MMMm  .MMMMMdh+ dMMMMhymMMMs  `dMMd+/+dMMh  sMMMs  .MMMd`MMMMMm     -y
MMMM/.:oyyydd.`          dMMM: .MMMd`   -MMMh  dMMM.  `MMMm  .MMMN.    dMMM:  .MMMm  yMMMs   sMMM/  hMMM: hMMN``MMMMMd     -y
MMMMNds/.` .sh.`    `-   mMMM- .MMMh    `NMMd  dMMM.  `MMMm  .MMMh     dMMM.   MMMm  hMMMyyyyyyyy/  `dMMm+MMM- .MMMMMd     -s
MMMMMM/`    .oh`  /mMMdshMMMm   sMMMd++omMMN:  yMMMd++dMMMm  .MMMh     dMMM.   MMMm  -NMMd/          `mMMMMM+  .MMMMMh     -s
MMMMMMN/`    .sh`` +mMMMMMNy.    :hNMMMMMms.   `yMMMMNsNMMm  .MMMh     dMMM.   MMMm   .smMMMMMMh/     -NMMMy   -MMMMMh     -s
MMMMMMMN/`    .sh`   `-::.          .---`         .-.  ````   `````    ````    ````      `---.        -MMMm`   -MMMMMy     -y
MMMMMMMMN/` ``-+Ny``                                     ||||                                      +ddMMMm.    :MMMMMy     -s
MMMMMMMMMmooo:-/dMs`                                     ||||                                      smmmh+`     :MMMMMs     -s
MMMMMMMMMNmyso:-:o.                                      ||||                                                  /MMMMMs     -s
MMMMMMMMMmmyyso--:.                                      ||||                                                  /MMMMMs     -s
MMMMMMMMMdh+sys+--:.                                     ||||                                                  /MMMMMo     -s
MMMMMMMMMdy:/yyso:-:.    /hhhhy:                +hhhh:   ||||                                        hhhhy+`   +MMMMMo     -s
MMMMMMMMMhs-./hys+:-:.   +M   dN --   -. -.    :Mo     .-`::.    -::`  ...::    .::.  `::-  `-`--   `My  /M/   oMMMMMo     -o
MMMMMMMMMhs-`./yys+--:.  +MdhdNo /M/ /M- h+     +hmho. yMy/+mh -No  N/ dNo/mm .mh  + sm  ym`.M  B    MmhhNh`   oMMMMM+     -o
MMMMMMMMMhs-  ./yys+--:. +M   /M/ oN N+           .Nd yM`  oM.sMssss   dm  oM`+M:-- `Mmss    M+      `M  `Nd   oMMMMM+     -o
MMMMMMMMMhs-   ./yys+--:.+Nhhhds`  yMy  .Ns    :ddydd: yMyyhd/ `ydyyh` hh  oN` sdyhs :dhyho .N/      Nmhhdy- hmsMMMMM+     -o
MMMMMMMMMdy-    ./yys+--:.       `-dd`                 yM||||                                                  sMMMMM/     -o
MMMMMMMMMdy-     ./yys+--:.      .o/`                  :o||||                                                  sMMMMM/     .o
MMMMMMMMMdy-     `.+yys+--:.                             ||||                                                  sMMMMM/     .o
MMMMMMMMMdy-      `.+yyy+-.-.                            ||||                                                  sMMMMM/     .o
MMMMMMMMMmy-        .+yyy+--:.                           ||||                                                  yMMMMM:     .o
MMMMMMMMMmh-        `-+yyy+---.                          ||||                                                  yMMMMM:     .o
MMMMMMMMMmh-         `.+yyy+--:.                         ||||                                                  yMMMMM:     .+
MMMMMMMMMmh-          `-+yyy+--:.                        ||||                                                  yMMMMM:     .+
MMMMMMMMMmh-           `.+yyy+-.:.                       ||||                                                  yMMMMM:     .+
MMMMMMMMMmh:            `-+yys+--:.                      ||||                                                  yMMMMM:     .+
MMMMMMMMMNh:             `-+hys++yd/``                   ||||                                                  hMMMMM:     .+
MMMMMMMMMNd:              `-+hmMMMMm``                   ||||                                                  hMMMMM-     ./
MMMMMMMMMNd:               `-+hNMMMMo``                  ||||                                                  hMMMMM:     .+
MMMMMMMMMNd:                 `-odMMMN.`                  ||||                                                  hMMMMM-     -+
MMMMMMMMMMdh`                 `./yNMMy``                 ||||                                                  hMMMMM:    .+o
MMMMMMMMMMmmm+-`````            `-+hmd`                          `.````````````````.................-----------hMMMMMo::++osN
MMMMMMMMMMMNmmmdmmmmmmmmmmmmmmmmNNNNNNmmmmmmmmmmmmmmmmmmmddddhhyshMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNdmmMM"
end

    #delete_user
    #user_startapp




