module Icalialabs::Firebase
  class Article < ApplicationRecord
    has_many :comments
  end
end
