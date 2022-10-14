require 'net/http'
require 'uri'
require 'json'

class FirebaseController < ApplicationController
  def login; end

  def signup; end

  def create_user
    user_email
    uri = URI("https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=HERE_GOES_MY_API_KEY")

    response = Net::HTTP.post_form(uri, "email": @email, "password": @password)
    data = JSON.parse(response.body)
    session[:user_id] = data["localId"]
    session[:data] = data

    redirect_to root_path, notice: "Sign Up successfully." if response.is_a?(Net::HTTPSuccess)
  end

  def create_session
    user_email
    uri = URI("https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=HERE_GOES_MY_API_KEY")

    response = Net::HTTP.post_form(uri, "email": @email, "password": @password)
    data = JSON.parse(response.body)


    if response.is_a?(Net::HTTPSuccess)
      session[:user_id] = data["localId"]
      session[:data] = data
      redirect_to root_path, notice: "Log in successfully."
    end
  end

  def logout
    session.clear
    redirect_to root_path, notice: "Log Out"
  end

  private

  def user_email
    @email = params[:email]
    @password = params[:password]
  end
end
