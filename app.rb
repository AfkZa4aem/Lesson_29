#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database,  "sqlite3:barbershop.db"

class Client < ActiveRecord::Base
end

class Barber < ActiveRecord::Base
end

class Contact < ActiveRecord::Base
end

before do
	@barbers = Barber.order "created_at DESC"
end

get '/' do
	
	erb :index
end

get '/visit' do

	erb :visit
end

post '/visit' do

	@username = params[:username]
	@phone = params[:phone]
	@datetime = params[:datetime]
	@barber = params[:barber]
	@color = params[:color]

	Client.create( 
				name: @username,
				phone: @phone,
				datestamp: @datetime,
				barber: @barber,
				color: @color)

	erb "<h2>Спасибо, вы записались!</h2>"

end

get '/contacts' do
	erb :contacts
end

post '/contacts' do
	@email = params[:email]
	@message = params[:message]
	
	Contact.create( email: @email, message: @message)

	erb "Thank you we will contact you"
end
