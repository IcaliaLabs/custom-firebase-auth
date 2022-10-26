class AuthGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../../../', __dir__)

  def create_views
    if class_name == 'Install'
      #  ---------- Gems --------------

        gem 'faraday', '~> 1.10'
        gem 'jwt', '~> 2.5'
        gem 'warden', '~> 1.2', '>= 1.2.9'

        rake 'bundle'
      #  ---------- Controllers --------------
        
        template 'lib/generators/auth/templates/controllers/home_controller.rb',
        File.join('app/controllers', class_path, 'home_controller.rb')

        template 'lib/generators/auth/templates/controllers/session_controller.rb',
        File.join('app/controllers', class_path, 'session_controller.rb')

        template 'lib/generators/auth/templates/controllers/unauthorized_controller.rb',
        File.join('app/controllers', class_path, 'unauthorized_controller.rb')

        inject_into_file 'app/controllers/application_controller.rb', after: "class ApplicationController < ActionController::Base\n" do 
          <<-'RUBY'
  helper_method :current_user, :user_signed_in?

  def warden
    request.env['warden']
  end

  def user_signed_in?(...)
    warden.authenticated?(...)
  end

  def authenticate_user!(...)
    session[:after_sign_in_path] = request.path unless user_signed_in?(...)
    warden.authenticate!(...)
  end

  def after_sign_in_path
    session.delete(:after_sign_in_path) || root_path
  end

  def current_user(...)
    warden.user(...)
  end
          RUBY
        end

      #  ---------- Javascript --------------

        template 'lib/generators/auth/templates/javascript/controllers/sign_in_controller.js',
        File.join('app/javascript/controllers', class_path, 'sign_in_controller.js')

      #  ---------- Models --------------

        template 'lib/generators/auth/templates/models/identity_plataform/cert_store.rb',
        File.join('app/models/identity_platform', class_path, 'cert_store.rb')

        template 'lib/generators/auth/templates/models/identity_plataform/error.rb',
        File.join('app/models/identity_platform', class_path, 'error.rb')

        template 'lib/generators/auth/templates/models/identity_plataform/token.rb',
        File.join('app/models/identity_platform', class_path, 'token.rb')

        template 'lib/generators/auth/templates/models/identity_plataform/warden_strategy.rb',
        File.join('app/models/identity_platform', class_path, 'warden_strategy.rb')        

        template 'lib/generators/auth/templates/models/user_migration.rb',
        File.join('db/migrate', class_path, "#{Time.now.strftime('%Y%m%d%H%M%S')}_create_users.rb")

        template 'lib/generators/auth/templates/models/user.rb',
        File.join('app/models', class_path, 'user.rb')
        

      #  ---------- Views --------------

        create_file 'app/views/session/new.html.erb',

        <<-FILE
<section id='auth-container' data-controller='sign-in' class='w-full content-center'>
  <%= form_with url: session_path, scope: :session, data: { sign_in_target: 'sessionForm' } do |f| %>
    <%= f.hidden_field :token, data: { sign_in_target: 'token' } %>
  <% end %>
</section>
        FILE

        create_file 'app/views/home/show.html.erb',

        <<-FILE
<div>
  <h1 class="font-bold text-4xl">Hello<%= ' ' + current_user.email if user_signed_in? %>!</h1>
  <p class=" text-blue-600">
    <% unless user_signed_in? %><%= link_to 'Sign in?', new_session_path %>
    <% else %><%= link_to 'Sign out?', session_path, data: { 'turbo-method': :delete } %>
    <% end %>
  </p>
</div>
        FILE

      # ---------- Routes --------------

        route "root 'home#show'"
        route "get 'sign-in', to: 'session#new', as: :new_session"
        route "resource :session, only: %i[create destroy], controller: :session"

      # ---------- Importmap --------------

        inject_into_file 'config/importmap.rb', after: "pin_all_from \"app/javascript/controllers\", under: \"controllers\"\n" do 
          <<-'RUBY'
pin 'firebaseui', to: 'https://ga.jspm.io/npm:firebaseui@6.0.1/dist/esm.js'
pin '@firebase/app', to: 'https://ga.jspm.io/npm:@firebase/app@0.7.24/dist/esm/index.esm2017.js'
pin '@firebase/app-compat', to: 'https://ga.jspm.io/npm:@firebase/app-compat@0.1.25/dist/esm/index.esm2017.js'
pin '@firebase/auth-compat', to: 'https://ga.jspm.io/npm:@firebase/auth-compat@0.2.14/dist/index.esm2017.js'
pin '@firebase/auth/internal', to: 'https://ga.jspm.io/npm:@firebase/auth@0.20.1/dist/esm2017/internal.js'
pin '@firebase/component', to: 'https://ga.jspm.io/npm:@firebase/component@0.5.14/dist/esm/index.esm2017.js'
pin '@firebase/logger', to: 'https://ga.jspm.io/npm:@firebase/logger@0.3.2/dist/esm/index.esm2017.js'
pin '@firebase/util', to: 'https://ga.jspm.io/npm:@firebase/util@1.6.0/dist/index.esm2017.js'
pin 'dialog-polyfill', to: 'https://ga.jspm.io/npm:dialog-polyfill@0.4.10/dialog-polyfill.js'
pin 'firebase/compat/app', to: 'https://ga.jspm.io/npm:firebase@9.8.1/compat/app/dist/index.esm.js'
pin 'firebase/compat/auth', to: 'https://ga.jspm.io/npm:firebase@9.8.1/compat/auth/dist/index.esm.js'
pin 'idb', to: 'https://ga.jspm.io/npm:idb@7.0.1/build/index.js'
pin 'material-design-lite/src/button/button', to: 'https://ga.jspm.io/npm:material-design-lite@1.3.0/src/button/button.js'
pin 'material-design-lite/src/mdlComponentHandler', to: 'https://ga.jspm.io/npm:material-design-lite@1.3.0/src/mdlComponentHandler.js'
pin 'material-design-lite/src/progress/progress', to: 'https://ga.jspm.io/npm:material-design-lite@1.3.0/src/progress/progress.js'
pin 'material-design-lite/src/spinner/spinner', to: 'https://ga.jspm.io/npm:material-design-lite@1.3.0/src/spinner/spinner.js'
pin 'material-design-lite/src/textfield/textfield', to: 'https://ga.jspm.io/npm:material-design-lite@1.3.0/src/textfield/textfield.js'
pin 'tslib', to: 'https://ga.jspm.io/npm:tslib@2.4.0/tslib.es6.js'
          RUBY
        end

      #  ---------- Rake --------------

      rake 'db:migrate'

      # ---------- Initializers --------------
      initializer "warden.rb" do
        %{
# frozen_string_literal: true

Rails.application.reloader.to_prepare do
    Warden::Strategies.add :identity_token, IdentityPlatform::WardenStrategy
end
  
Rails.application.config.middleware.use Warden::Manager do |manager|
    manager.default_strategies :identity_token
    manager.failure_app = UnauthorizedController
  
    manager.serialize_into_session(&:id)
    manager.serialize_from_session { |id| User.find_by id: }
end 
        }
      end
      # ---------- END --------------
    end
  end
end