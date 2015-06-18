require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'omniauth-github'
require 'sinatra/json'

require_relative 'config/application'

Dir['app/**/*.rb'].each { |file| require_relative file }

helpers do
  def current_user
    user_id = session[:user_id]
    @current_user ||= User.find(user_id) if user_id.present?
  end

  def signed_in?
    current_user.present?
  end
end

def set_current_user(user)
  session[:user_id] = user.id
end

def authenticate!
  unless signed_in?
    flash[:notice] = 'You need to sign in if you want to do that!'
    redirect '/'
  end
end

get '/' do
  @meetups = Meetup.order(:name).all
  erb :index
end

get '/new' do
  erb :new
end

post '/new' do
  authenticate!
  @new_meetup = Meetup.create!(params)
  @attendee = Attendee.create!(user_id: current_user.id, meetup_id: @new_meetup.id, organizer: true, active: true)
  flash[:notice] = 'You have created a new Meetup!'
  redirect "/meetups/#{@new_meetup.id}"
end

post '/meetups/:id/join' do
  meetup = Meetup.find(params[:id])

  authenticate!
  unless Attendee.where(user_id: current_user.id, meetup_id: params[:id], active: true).empty?
     flash[:notice] = "You have already joined this meetup."
     redirect "/meetups/#{params[:id]}"
  end

  Attendee.create!(user_id: current_user.id, meetup_id: params[:id], organizer: false, active: true)
  flash[:notice] = "Congratulations, you just joined #{meetup.name}, we\'ll see you at #{meetup.location}!"

  redirect "/meetups/#{params[:id]}"
end

post '/meetups/:id/leave' do
  defector = Attendee.where(user_id: current_user.id, meetup_id: params[:id], active: true)
  defector.first.update!(active: false)
  redirect "/meetups/#{params[:id]}"
end

get '/meetups/:id/authenticate' do
  if Attendee.where(user_id: current_user.id, meetup_id: params[:id], active: true).empty?
     result = "Join"
  else
    result = "Leave"
  end
  json({
    button: result
    })
end

post '/meetups/:id/comment' do
  Comment.create!(body: params[:comment_body], user_id: current_user.id, meetup_id: params[:id] )
  redirect "/meetups/#{params[:id]}"
end

get '/meetups/:id' do
  @current_meetup = Meetup.find(params[:id])
  @active_attendees = @current_meetup.attendees.where(active: true)
  @all_the_comments = @current_meetup.comments

  erb :show
end

get '/auth/github/callback' do
  auth = env['omniauth.auth']

  user = User.find_or_create_from_omniauth(auth)
  set_current_user(user)
  flash[:notice] = "You're now signed in as #{user.username}!"

  redirect '/'
end

get '/sign_out' do
  session[:user_id] = nil
  flash[:notice] = "You have been signed out."

  redirect '/'
end

get '/example_protected_page' do
  authenticate!
end
