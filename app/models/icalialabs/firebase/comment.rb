module Icalialabs::Firebase
  class Comment < ApplicationRecord
    belongs_to :article
  end
end
