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
          new_prompt(player, "completed")
        when "pass"
          new_prompt(player, "passed")
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

  def new_prompt(player, status)
    # if prompt, mark prompt as either passed or completed and send new prompt
    if player.event_prompts.last
      if status == "completed"
        # set the current prompt to completed
        player.event_prompts.last.update_attributes(completed: true)

      elsif status == "passed"
        #set the current prompt to passed
        player.event_prompts.last.update_attributes(passed: true)
      end

      # send back a new prompt for the player
      player.get_new_prompt

    # if no prompt, then the game hasn't started yet
    else
      "You don't have any prompts yet! Please wait until the party starts"
    end
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
