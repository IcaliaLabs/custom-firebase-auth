require "test_helper"
require "generators/views/views_generator"

module Icalialabs::Firebase
  class ViewsGeneratorTest < Rails::Generators::TestCase
    tests ViewsGenerator
    destination Rails.root.join("tmp/generators")
    setup :prepare_destination

    # test "generator runs without errors" do
    #   assert_nothing_raised do
    #     run_generator ["arguments"]
    #   end
    # end
  end
end
