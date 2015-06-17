class AddActiveToAttendees < ActiveRecord::Migration
  def change
    add_column :attendees, :active, :boolean
  end
end
