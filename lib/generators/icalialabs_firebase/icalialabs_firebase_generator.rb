class IcalialabsFirebaseGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("../../../", __dir__)

  def create_views
    # ---------- Install argument. -------------
    if class_name == 'Install'
      template 'lib/generators/icalialabs_firebase/templates/firebase_controller.rb',
          File.join('app/controllers', class_path, "firebase_controller.rb")
      route "get '/login', to: 'firebase#login'"
      route "get '/signup', to: 'firebase#signup'"
      route "post '/create_user', to: 'firebase#create_user'"
      route "post '/create_session', to: 'firebase#create_session'"
      route "delete '/logout', to: 'firebase#logout', as: 'logout'"
      inject_into_file 'app/controllers/application_controller.rb',
              after: "class ApplicationController < ActionController::Base\n" do <<-'RUBY'
  helper_method :current_user

  def current_user
    @current_user ||= session[:user_id]
  end
              RUBY
      end

    # ---------- Views argument. -------------
    elsif class_name == 'Views'
      directory 'app/views/firebase/', 'app/views/firebase/'
      inject_into_file 'app/views/layouts/application.html.erb',
              after: "<body>\n" do <<-"RUBY"
    <%= notice if notice %>
    <% if current_user.present? %>
      <%= button_to "Log Out", logout_path, to: "pages#logout", method: :delete %>
    <% else %>
      <%= button_to 'Log in', login_path, method: :get %>
      <%= button_to 'Sign up', signup_path, method: :get %>
    <% end %>
  RUBY
  end
    end
  end
end



