class AddDescriptionToMeetup < ActiveRecord::Migration
  def change
    add_column :meetups, :description, :text, null: false
    add_column :meetups, :location, :string, null: false
  end
end
