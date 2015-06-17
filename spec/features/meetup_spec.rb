require 'spec_helper'
require_relative '../../app/models/user.rb'

# Acceptance Criteria:
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

# [X] I must be signed in.
# [X] I must supply a name.
# [X] I must supply a location.
# [X] I must supply a description.
# [x] I should be brought to the details page for the meetup after I create it.
# [X] I should see a message that lets me know that I have created a meetup successfully.

# Still need to:
# - look into what the schema still needs (foreign key between users & meetups?)
# - add form validation for empty fields (html require)
# - add errors for form validation
# - final set of tests to join meetups

feature "User can create new meetup" do
  scenario "user can add a meetup for the hulahoop club on Saturn" do

    user = User.create!(provider: 'github',
    uid: 1,
    email: 'user@example.com',
    username: 'user1',
    avatar_url: 'http:user.img')

    visit "/"

    sign_in_as(user)
    expect(page).to have_content("Signed in as #{user.username}")

    visit "/new"

    fill_in('Meetup Name', with: 'Hulahoop Club' )
    fill_in('Location', with: 'Saturn, Outer-Ring')
    fill_in('Description', with: 'Beginners welcome, just bring a passion and your own hoop! See ya there! :D' )
    click_button('submit')

    expect(page).to have_content 'Hulahoop Club'
    expect(page).to have_content 'You have created a new Meetup!'
  end

end


# Acceptance Criteria:
#
# [X] I must be signed in.
# [X] From a meetups detail page, I should click a button to join the meetup.
# [] I should see a message that tells let's me know when I have successfully joined a meetup.

feature "user can join a meetup" do
  scenario "from the meetups detail page, user clicks on join to join the meetup" do

    jupiter = Meetup.create!(name: "Train Concert",
    description: "Make your way through the constellations and rage with Train on Jupiter ",
    location: "The Red Spot")

    user = User.create!(provider: 'github',
    uid: 1,
    email: 'mlg@alrightokay.com',
    username: 'mlg',
    avatar_url: 'http:user.img')

    visit "/"

    sign_in_as(user)
    expect(page).to have_content("Signed in as #{user.username}")

    visit "/meetups/#{jupiter.id}"

    click_button("Join")
    expect(page).to have_content("Congratulations, you just joined #{jupiter.name}, we'll see you at #{jupiter.location}!")



  end
end
