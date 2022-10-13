class IcalialabsFirebaseGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("../../../", __dir__)

  def create_views
    if class_name == 'Views'
      directory 'app/views/firebase/', 'app/views/firebase/'
    elsif class_name == "User"
      time = Time.now.strftime("%Y%m%d%H%M%S")

      template 'lib/generators/icalialabs_firebase/templates/user.rb', File.join('app/models', class_path, "user.rb")
      template "lib/generators/icalialabs_firebase/templates/migration.rb", File.join('db/migrate/', class_path, "#{time}_create_users.rb")
    end
  end
end
