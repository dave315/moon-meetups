class CreateAttendees < ActiveRecord::Migration
  def change
    create_table :attendees do |t|
      t.integer :user_id
      t.integer :meetup_id
      t.boolean :organizer
    end
  end
end
