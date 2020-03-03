class Location < ActiveRecord::Base
    has_many :journal_entries
    has_many :users, through: :journal_entries
end