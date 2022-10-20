class IcalialabsFirebaseGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../../../', __dir__)

  def create_views
    case class_name
      when 'Install'
        copy_templates_with_install
        firebase_routes
        inject_code_with_install
      when 'Views'
        directory 'app/views/firebase/', 'app/views/firebase/'
        inject_code_with_views
      else
        message_command
    end
  end

  private

  def message_command
    puts 'Sorry, that command is not recognized.'
    puts 'Try one of the commands below:'
    puts '  - rails g icalialabs_firebase install'
    puts '  - rails g icalialabs_firebase views'
  end

  def copy_templates_with_install
    template 'lib/generators/icalialabs_firebase/templates/firebase_controller.rb',
              File.join('app/controllers', class_path, 'firebase_controller.rb')
    template 'lib/generators/icalialabs_firebase/templates/firebase_spec.rb',
              File.join('app/spec/system', class_path, 'firebase_spec.rb')
  end

  def firebase_routes
    route "get '/login', to: 'firebase#login', as: 'login'"
    route "get '/signup', to: 'firebase#signup', as: 'signup'"
    route "post '/create_user', to: 'firebase#create_user'"
    route "post '/create_session', to: 'firebase#create_session'"
    route "delete '/logout', to: 'firebase#logout', as: 'logout'"
  end

  def inject_code_with_install
    inject_into_file 'app/controllers/application_controller.rb',
      after: "class ApplicationController < ActionController::Base\n" do <<-'RUBY'
  helper_method :current_user

  def current_user
    @current_user ||= session[:user_id]
  end
      RUBY
      end
  end

  def inject_code_with_views
    inject_into_file 'app/views/layouts/application.html.erb', after: "<body>\n" do <<-'RUBY'
    <%= notice if notice %>
    <% if current_user.present? %>
      <%= button_to 'Log Out', logout_path, to: 'pages#logout', method: :delete, id: 'logout_button' %>
    <% else %>
      <%= button_to 'Log in', login_path, method: :get, id: 'login_button' %>
      <%= button_to 'Sign up', signup_path, method: :get, id: 'signup_button' %>
    <% end %>
    RUBY
    end
  end
end



