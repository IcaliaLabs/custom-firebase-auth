# Icalialabs::Firebase Gem.
The **icalialabs_firebase** gem was developed to help us auttenticate users in our Apps. It doesn't generate models to migrate in your database and it creates the session controller, views and routes.
## Usage
You have to sign up in [Firebase](https://firebase.google.com/), create a new project, enable the authentication service and get an API Key in the Project Settings section.

## Installation
```ruby
gem "icalialabs-firebase"
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install icalialabs-firebase
```
In order to generate the sessions controller and routes, run the following command:
```
rails g icalialabs_firebase install
```
In order to generate the views folder, run the following command:
```
rails g icalialabs_firebase views
```
You have to add your API Key in controllers/firebase_controller.rb
```
uri = URI("https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=HERE_GOES_MY_API_KEY")
```
## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
