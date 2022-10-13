require "test_helper"
require "generators/icalialabs_firebase/icalialabs_firebase_generator"

module Icalialabs::Firebase
  class IcalialabsFirebaseGeneratorTest < Rails::Generators::TestCase
    tests IcalialabsFirebaseGenerator
    destination Rails.root.join("tmp/generators")
    setup :prepare_destination

    # test "generator runs without errors" do
    #   assert_nothing_raised do
    #     run_generator ["arguments"]
    #   end
    # end
  end
end
