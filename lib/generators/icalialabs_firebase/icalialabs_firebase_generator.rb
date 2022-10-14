class IcalialabsFirebaseGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("../../../", __dir__)

  def create_views
    if class_name == 'Install'
      template 'lib/generators/icalialabs_firebase/templates/firebase_controller.rb',
          File.join('app/controllers', class_path, "firebase_controller.rb")
      route "get '/login', to: 'firebase#login'"
      route "get '/signup', to: 'firebase#signup'"
      route "post '/create_user', to: 'firebase#create_user'"
      route "post '/create_session', to: 'firebase#create_session'"
      route "delete '/logout', to: 'firebase#logout'"
    elsif class_name == 'Views'
      directory 'app/views/firebase/', 'app/views/firebase/'
    end
  end
end
