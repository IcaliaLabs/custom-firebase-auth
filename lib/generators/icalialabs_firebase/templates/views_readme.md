
=======================================================

Insert this code below your body tag in 'app/views/layouts/application.html.erb':

--------
  <%= notice if notice %>

  <% if current_user.present? %>
    <%= button_to 'Log Out', logout_path, to: 'pages#logout', method: :delete, id: 'logout_button' %>
  <% else %>
    <%= button_to 'Log in', login_path, method: :get, id: 'login_button' %>
    <%= button_to 'Sign up', signup_path, method: :get, id: 'signup_button' %>
  <% end %>
---------

  - Notice for showing messages.
  - Buttons for Log in, Sign up and Log out.

=======================================================
