# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'shoulda-matchers'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  config.filter_run focus: true
  config.run_all_when_everything_filtered = true

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

end

$test_vars = lambda {
  before :each do
    Event.any_instance.stub(:get_random_word).and_return("watermelon", "icepick")
  end

  let(:party) { PartyType.create(description: "Super fun party!") }
  let(:rating) { Rating.create(name: "Super blush", value: 2) }
  let(:event) { Event.create(party_type_id: party.id, rating_id: rating.id) }

  let(:prompt1) {
    Prompt.create( description: "Do something fun!", rating_id: rating.id)
  }

  let(:prompt2) {
    Prompt.create(description: "Do something boring!", rating_id: rating2.id)
  }

  let(:phone){"+15102346789"}
  let(:name){"Miriam"}
  let(:player) { Player.create(name: name, phone: phone, event_id: event.id) }

  let(:player_prompt) { EventPrompt.create(event_id: event.id, player_id: player.id, prompt_id: prompt1.id)}

  let(:invalid_phone){"+14154567891"}

  let(:no_prompts_message){"You don't have any prompts yet! Please wait until the party starts"}
}
