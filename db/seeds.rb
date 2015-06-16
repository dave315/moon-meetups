require_relative '../app/models/meetup.rb'

Meetup.create!(name: "Train Concert",
description: "Make your way through the constellations and rage with Train on Jupiter ",
location: "The Red Spot")

Meetup.create!(name: "Moon Frisbee League (MFL)",
description: "A meetup for moon-dwellers to play Moon-Frisbee(TM).",
location: "MFL HQ, 1 Moon St.")
