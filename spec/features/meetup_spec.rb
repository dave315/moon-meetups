require 'spec_helper'

# Acceptance Criteria:

#
# [X] I should see the name of the meetup.
# [X] I should see a description of the meetup.
# [X] I should see where the meetup is located.

feature "User views meetup page" do
  scenario "user sees the name of the meetup" do
    moon = Meetup.create!(name: "Moon Frisbee League (MFL)",
    description: "A meetup for moon-dwellers to play Moon-Frisbee(TM).",
    location: "MFL HQ, 1 Moon St.")

    visit "/meetups/#{moon.id}"

    expect(page).to have_content moon.name
    expect(page).to have_content moon.description
    expect(page).to have_content moon.location
  end
end

# Acceptance Criteria:
#
#  Meetups should be listed alphabetically.
# [X] Each meetup listed should link me to the show page for that meetup.

feature "User views the index page" do
  scenario "user sees the correct titles listed alphabetically" do
    jupiter = Meetup.create!(name: "Train Concert",
    description: "Make your way through the constellations and rage with Train on Jupiter ",
    location: "The Red Spot")

    moon = Meetup.create!(name: "Moon Frisbee League (MFL)",
    description: "A meetup for moon-dwellers to play Moon-Frisbee(TM).",
    location: "MFL HQ, 1 Moon St.")

    visit '/'

    expect(page).to have_content("All Meetups")
    expect(page.body.index(moon.name)).to be < page.body.index(jupiter.name)
  end

    scenario "user can visit a meetup page from index" do
      moon = Meetup.create!(name: "Moon Frisbee League (MFL)",
      description: "A meetup for moon-dwellers to play Moon-Frisbee(TM).",
      location: "MFL HQ, 1 Moon St.")

      visit '/'

      expect(page).to have_content "All Meetups"
      expect(page).to have_content moon.name


      click_link "Moon Frisbee League (MFL)"
      expect(page).to have_content moon.name
      expect(page).to have_content moon.description
      expect(page).to have_content moon.location

  end
end

# ACCEPTANCE CRITERIA!

# I must be signed in.
# I must supply a name.
# I must supply a location.
# I must supply a description.
# I should be brought to the details page for the meetup after I create it.
# I should see a message that lets me know that I have created a meetup successfully.
#

feature "User can create new meetup" do
  scenario "user can add a meetup for the hulahoop club on Saturn" do

end
