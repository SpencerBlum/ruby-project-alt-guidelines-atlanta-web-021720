class User < ActiveRecord::Base
    has_many :journal_entries
    has_many :locations, through: :journal_entries
end