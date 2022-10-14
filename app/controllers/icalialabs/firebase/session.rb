# require 'net/http'
# require 'uri'
# require 'json'

module Icalialabs
  module Firebase

    class SessionController < ApplicationController
    #   before_action :user_email

    #   def signup
    #     uri = URI("https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=HERE_GOES_MY_API_KEY")

    #     response = Net::HTTP.post_form(uri, "email": @email, "password": @password)
    #     session_params

    #     redirect_to root_path, notice: "Sign Up successfully." if response.is_a?(Net::HTTPSuccess)
    #   end

    #   def login
    #     uri = URI("https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=HERE_GOES_MY_API_KEY")
    #     response = Net::HTTP.post_form(uri, "email": @email, "password": @password)

    #     if response.is_a?(Net::HTTPSuccess)
    #       session_params
    #       redirect_to root_path, notice: "Log in successfully."
    #     end
    #   end

    #   def logout
    #     session.clear
    #     redirect_to root_path, notice: "Log Out"
    #   end

    #   private
    #     def user_email
    #       @email = params[:email]
    #       @password = params[:password]
    #     end

    #     def session_params
    #       data = JSON.parse(response.body)
    #       session[:user_id] = data["localId"]
    #       session[:data] = data
    #     end
    # end
  end
end
