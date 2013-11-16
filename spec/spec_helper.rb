# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'sms_spec'

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
  config.include Devise::TestHelpers, type: :controller
  config.include ControllerHelpers, type: :controller
  config.include SmsSpec::Helpers
  config.include SmsSpec::Matchers
  SmsSpec.driver = :"twilio-ruby"
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

  let(:phone){"+15559876543"}
  let(:name){"Miriam"}
  let(:player) { Player.create(name: name, phone: phone, event_id: event.id) }

  let(:player_prompt) { EventPrompt.create(event_id: event.id, player_id: player.id, prompt_id: prompt1.id)}

  let(:invalid_phone){"+15551234567"}

  let(:accepted_message){"Welcome #{player.name}! Please stay tuned for your first prompt. Text 'q' at any time to quit the game."}
  let(:already_accepted_message){"You've already joined the game. If you want to leave, respond with 'd'."}
  let(:no_prompts_message){"You don't have any prompts yet! Please wait until the party starts"}
  let(:instructions){" Respond with 'd' when done or 'p' to pass."}
  let(:leave_text) {"Awww sorry to see you go! Thanks for playing Lederfeier - see you next time!"}
  let(:unknown_player_text) {"Your party as ended or you're not part of a party. Sorry. Visit www.lederfeier.com to learn more."}
  let(:unknown_text) {"I don't know how to do that. Please respond with 'h' for help."}
  let(:help_message) {"Respond with 'y' to accept an invitation, 'd' to mark a prompt as done, 'p' to pass a prompt, 'q' to quit the game."}
}
