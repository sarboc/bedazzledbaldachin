module TwiliosHelper

  def parse_message(phone, message)
    # phone = params[:From]
    # message = params[:Body]

    # see if a player exists
    player = Player.where("end_time is null").find_by_phone(phone)



    if player
      # if player joined via passphrase, the next text gets stored as their name
      if player.name == "passphrase_joiner"
        player.update_attributes(name: message)

        if player.event.event_status == true
          player.send_text("Welcome #{player.name}! Please stay tuned for your first prompt. Text 'q' at any time to quit the game.")
          "#{player.get_new_prompt} Respond with 'd' when done or 'p' to pass."
        else
          "Welcome #{player.name}! Please stay tuned for your first prompt. Text 'q' at any time to quit the game."
        end
      else
        # person belongs to a game and has a name, so send them a message
        case message.downcase
          when "y", /yes/, /accept/, "ok"
            accept(player)
          when "'d'", "d", /done/, /complete/
            new_prompt(player, :completed)
          when "'p'", "p", /pass/
            new_prompt(player, :passed)
          when "'q'", "q", /leave/, /quit/
            leave(player)
          when "'h'", "h", /help/
            help_message
          else
            random_message(player)
        end
      end
    else
      # player doesn't belong to a game; see if they are trying to join an event
      event = Event.where("event_status is not false").find_by_wordnik(message.downcase)

      # if an event exists with that passphrase, add the person as a player
      if event
        join_by_passphrase(event, phone)

      # else, send them a message about our app
      else
        "Your party as ended or you're not part of a party. Sorry. Visit www.lederfeier.com to learn more."
      end
    end

  end

  def new_prompt(player, column)
    # if prompt, mark prompt as either passed or completed and send new prompt
    if player.event_prompts.last
      # use symbol passed to function as the column name for the update
      player.event_prompts.last.update_attributes(column => true)

      # send back a new prompt for the player
      "#{player.get_new_prompt} Respond with 'd' when done or 'p' to pass."

    # if no prompt, then the game hasn't started yet
    else
      "You don't have any prompts yet! Please wait until the party starts"
    end
  end

  def help_message
    "Respond with 'y' to accept an invitation, 'd' to mark a prompt as done, 'p' to pass a prompt, 'q' to quit the game."
  end

  def leave(player)
    player.leave
    "Awww sorry to see you go! Thanks for playing Lederfeier - see you next time!"
  end

  def accept(player)
    # change player accepted to true
    unless player.accepted
      player.accept_invite

      if player.event.event_status == true
        player.send_text("Welcome #{player.name}! Please stay tuned for your first prompt. Text 'q' at any time to quit the game.")
        "#{player.get_new_prompt} Respond with 'd' when done or 'p' to pass."
      else
        "Welcome #{player.name}! Please stay tuned for your first prompt. Text 'q' at any time to quit the game."
      end

    else
      "You've already joined the game. If you want to leave, respond with 'd'."
    end
  end

  def join_by_passphrase(event, phone)
    player = Player.create_by_passphrase(event, phone)
    player.accept_invite
    "Thanks for joining! What's your name?"
  end

  def random_message(player)
    # if user has not accepted, send message with ways to join

    # if user has accepted, send message with ways to leave
    "I don't know how to do that. Please respond with 'h' for help."
  end

end