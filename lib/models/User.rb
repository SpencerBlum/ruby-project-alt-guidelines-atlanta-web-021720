class User < ActiveRecord::Base
    has_many :journal_entries
    has_many :locations, through: :journal_entries


    def self.get_all_user_names
        User.all.map {|name| name.username}
    end
end