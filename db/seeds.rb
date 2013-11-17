# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

party_types = PartyType.create [
  { description: "Fun Date" }, #1
  { description: "Dinner with friends"}, #2
  { description: "Raucous party" }, #3
  { description: "Team building" } #4
]

ratings = Rating.create [
  {
    name: "Not embarrassing",
    value: 1
  },{
    name: "Somewhat embarrasing",
    value: 2
  },{
    name: "Prepare for some blushing",
    value: 3
  }

]

prompts = Prompt.create [
  #1
  { description: "Almonds. Discuss.", rating_id: 1},
  #2
  { description: "Think about your first kiss. What face did you just make, and why?", rating_id: 2},
  #3
  { description: "What was your childhood nickname?", rating_id: 2},
  #4
  { description: "Begin a friendly debate over the pronunciation of the following word: gif", rating_id: 1},
  #5
  { description: "How often do you google and/or facebook your elementary-school crush?", rating_id: 2},
  #6
  { description: "Peanut butter: smooth or crunchy?", rating_id: 1},
  #7
  { description: "Put your hand in the front pocket of the person on your right. Announce what you find.", rating_id: 3 },
  #8
  { description: "Would you rather lose your dominant hand or your dominant foot?", rating_id: 1 },
  #9
  { description: "Switch tops with another party member of your choosing.", rating_id: 3 },
  #10
  { description: "If you are currently wearing underpants, describe them to the group. If not, explain why.", rating_id: 3 },
  #11
  { description: "Describe the best meal you've ever had", rating_id: 1 },
  #12
  { description: "You just won the lottery and never have to work again. What do you do?", rating_id: 1 },
  #13
  { description: "Describe a daring act you've performed with a romantic partner", rating_id: 3 },
  #14
  { description: "The person on your right is now known as 'Fancy Pants'. Don't call him/her anything else for the rest of the night", rating_id: 2 },
  #15
  { description: "Close your eyes. Turn around. Guess the identity of another player by touch alone.", rating_id: 3 },
  #16
  { description: "Describe your ideal weekend.", rating_id: 1 },
  #17
  { description: "If you could make something that's not socially acceptable, acceptable. What would it be?", rating_id: 1 },
  #18
  { description: "What's the most embarrasing thing that's happened to you during sex?", rating_id: 3 },
  #19
  { description: "Which fictional character would you most like to meet?", rating_id: 1 },
  #20
  { description: "What is your favorite curse word?", rating_id: 2 },
  #21
  { description: "If you could only ever drink one thing, what would it be?", rating_id: 1},
  #22
  { description: "What's the last tv show you binge watched?", rating_id: 1 },
  #23
  { description: "Would you rather have fur or scales?", rating_id: 1 }
  #24
  # { description: "", rating_id: },
  # #25
  # { description: "", rating_id: },
  # #26
  # { description: "", rating_id: },
  # #27
  # { description: "", rating_id: },
  # #28
  # { description: "", rating_id: },
  # #29
  # { description: "", rating_id: },
  # #30
  # { description: "", rating_id: }
]


date = PartyType.find(1)
date_prompts = [1, 2, 3, 5, 10, 11, 12, 13, 16, 17, 19, 20, 21, 22, 23]
date_prompts.each do |prompt_id|
  date.prompts << Prompt.find(prompt_id)
end

dinner = PartyType.find(2)
dinner_prompts = [1, 2, 3, 4, 5, 6, 8, 11, 12, 16, 17, 19, 21, 22, 23]
dinner_prompts.each do |prompt_id|
  dinner.prompts << Prompt.find(prompt_id)
end

party = PartyType.find(3)
party_prompts = [2, 3, 5, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 22, 23]
party_prompts.each do |prompt_id|
  party.prompts << Prompt.find(prompt_id)
end

team = PartyType.find(4)
team_prompts = [1, 3, 4, 6, 8, 11, 12, 14, 16, 17, 19, 21, 22, 23]
team_prompts.each do |prompt_id|
  team.prompts << Prompt.find(prompt_id)
end








