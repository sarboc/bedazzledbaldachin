module TwiliosHelper

  def parse_message(phone, message)
    # phone = params[:From]
    # message = params[:Body]

    # see if a player exists
    player = Player.find_by_phone(phone)

    if player
      # person belongs to a game, so send them a message
      case message.downcase
        when "y", "yes", "accept", "ok"
          accept(player)
        when /done/
          new_prompt(player, :completed)
        when /pass/
          new_prompt(player, :passed)
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

    def new_prompt(player, column)
    # if prompt, mark prompt as either passed or completed and send new prompt
    if player.event_prompts.last
      # use symbol passed to function as the column name for the update
      player.event_prompts.last.update_attributes(column => true)

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
    "promts will start soon yay"
    #   unless player.accepted
    #   player.update_attributes(accepted: true)
    #   start_time = Time.now
    #   end_time = start_time + 60 * 60 * 3
    #   player.update_attributes(start_time: start_time, end_time: end_time)
    #   "Welcome #{player.name}! Please stay tuned for your first prompt."
    # else
    #   "You've already joined the game."
    # end
  end

  def random_message(player)
    # if user has not accepted, send message with ways to join
    # if user has accepted, send message with ways to leave
    "I don't know how to do that. Please respond with 'yes' to accept an invitation"
  end

end
