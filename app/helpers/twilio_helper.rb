module TwilioHelper

  def parse_message(phone, message)
    # phone = params[:From]
    # message = params[:Body]

    # see if a player exists
    player = Player.find_by_phone(phone)

    if player
      # person belongs to a game, so send them a message
      case message
        when "done"
          # mark prompt as done and send new prompt
          "done"
        when "pass"
          # mark prompts as passed and send new prompt
          "pass"
        when "leave"
          # mark end time for user
          "leave"
        else
          # see if player has a name. If not, set it
          # if user has a name, send back a helpfeul error message
          "I don't know that"
      end
    else
      # player doesn't belong to a game
      "We don't know who you are. Sorry. Visit www.lederfeier.com to learn more."
    end

  end
end
