class IcalialabsFirebaseGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("templates", __dir__)

  def create_views
    if class_name == 'Views'
      create_file "app/views/firebase/registrations.html.erb", <<-FILE
<div>
  <h2>Log in</h2>
  <%= form_with(url: '#', method: :post) do |f| %>
    <div>
      <%= f.label :email %>
      <%= f.text_field :email %>
    </div>

    <div>
      <%= f.label :password %>
      <%= f.password_field :password %>
    </div>

    <div>
      <%= f.submit 'Log in' %>
    </div>
  <% end %>
</div>
      FILE

      create_file "app/views/firebase/sessions.html.erb", <<-FILE
<div>
  <h2>Sign in</h2>
  <%= form_with(url: '#', method: :post) do |f| %>
    <div>
      <%= f.label :email %>
      <%= f.text_field :email %>
    </div>

    <div>
      <%= f.label :password %>
      <%= f.password_field :password %>
    </div>

    <div>
      <%= f.submit 'Sign in' %>
    </div>
  <% end %>
</div>
      FILE
    elsif class_name == "User"
      template 'user.rb', File.join('app/models', class_path, "user.rb")
      time = Time.now.strftime("%Y%m%d%H%M%S")
      template "migration.rb", File.join('db/migrate/', class_path, "#{time}_create_users.rb")
    end
  end
end
