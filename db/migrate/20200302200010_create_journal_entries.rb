class CreateJournalEntries < ActiveRecord::Migration[5.2]
  def change
    create_table :journal_entries do |t|
      t.integer :user_id
      t.integer :location_id
      t.string :title, default: nil
      t.string :notes, default: nil
      t.datetime :date
    end
  end
end
