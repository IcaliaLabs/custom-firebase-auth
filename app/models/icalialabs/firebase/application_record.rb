module Icalialabs
  module Firebase
    class ApplicationRecord < ActiveRecord::Base
      self.abstract_class = true
    end
  end
end
