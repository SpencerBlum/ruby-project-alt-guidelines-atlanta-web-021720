class JournalEntry < ActiveRecord::Base
    belongs_to :user
    belongs_to :location

    def self.all_user_journal(user_ID)
        #find all user journals for a particular user
        JournalEntry.where(user_id: user_ID)
    end

    def self.get_all_user_journals(user_ID)

        user_entries =  JournalEntry.all_user_journal(user_ID)

        user_entries.map {|entry| entry.title}

    end
end