class ValidateAttendees < ActiveRecord::Migration
  def up
    Attendee.all.each do |attendee|
      if attendee.organizer.nil?
        attendee.organizer = false

        if attendee.active.nil?
          attendee.active = true
        end
      end
    end

    change_column :attendees, :user_id, :integer, null: false
    change_column :attendees, :meetup_id, :integer, null: false
    change_column :attendees, :organizer, :boolean, null: false
    change_column :attendees, :active, :boolean, null: false
  end

  def down
    change_column :attendees, :user_id, :integer
    change_column :attendees, :meetup_id, :integer
    change_column :attendees, :organizer, :boolean
    change_column :attendees, :active, :boolean
  end
end
