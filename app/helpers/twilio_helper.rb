module TwilioHelper

  def parse_message(phone, message)
    # phone = params[:From]
    # message = params[:Body]

    # see if a player exists
    player = Player.find_by_phone(phone)

    if player
      # person belongs to a game, so send them a message
      case message.downcase
        when "y" || "yes" || "accept" || "ok"
          # "Cool! we are going to send u some badasss prompts soon!"
          accept(player)
        when "done"
          mark_completed(player)
        when "pass"
          mark_passed(player)
        when "leave"
          leave(player)
        else
          random_message(player)
      end
    else
      # player doesn't belong to a game
      "We don't know who you are. Sorry. Visit www.lederfeier.com to learn more."
    end

  end

  def mark_completed(player)
    # mark prompt as done and send new prompt
    if player.event_prompts.last
      player.event_prompts.last.update_attributes(completed: true)
      "done"
    else
      "You don't have any prompts yet! Please wait until the party starts"
    end
  end

  def mark_passed(player)
    # mark prompts as passed and send new prompt
    "pass"
  end

  def leave(player)
    # mark end time for user
    "leave"
  end

  def accept(player)
    # change player accepted to true
  end

  def random_message(player)
    # if user has not accepted, send message with ways to join
    # if user has accepted, send message with ways to leave
    "I don't know how to do that. Please respond with 'yes' to accept an invitation"
  end

end
