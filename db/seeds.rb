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
  { description: "Almonds. Discuss.", rating_id: 1},
  { description: "Think about your first kiss. What face did you just make, and why?", rating_id: 2},
  { description: "What was your childhood nickname?", rating_id: 2},
  { description: "Begin a friendly debate over the pronunciation of the following word: gif", rating_id: 1},
  { description: "How often do you google and/or facebook your elementary-school crush?", rating_id: 2},
  { description: "Peanut butter: smooth or crunchy?", rating_id: 1},
  { description: "Put your hand in the front pocket of the person on your right. Announce what you find.", rating_id: 3 },
  { description: "Would you rather lose your dominant hand or your dominant foot?", rating_id: 1 },
  { description: "Switch tops with another party member of your choosing.", rating_id: 3 },
  { description: "If you are currently wearing underpants, describe them to the group. If not, explain why.", rating_id: 3 }
]

prompt1 = Prompt.find(1)
prompt2 = Prompt.find(2)
prompt3 = Prompt.find(3)
prompt4 = Prompt.find(4)
prompt5 = Prompt.find(5)
prompt6 = Prompt.find(6)
prompt7 = Prompt.find(7)
prompt8 = Prompt.find(8)
prompt9 = Prompt.find(9)
prompt10 = Prompt.find(10)

date = PartyType.find(1)
date_prompts = [prompt1, prompt2, prompt3, prompt5, prompt10]
date_prompts.each do |prompt|
  date.prompts << prompt
end

dinner = PartyType.find(2)
dinner_prompts = [prompt1, prompt2, prompt3, prompt4, prompt5, prompt6, prompt8]
dinner_prompts.each do |prompt|
  dinner.prompts << prompt
end

party = PartyType.find(3)
party_prompts = [prompt2, prompt3, prompt5, prompt7, prompt8, prompt9, prompt10]
party_prompts.each do |prompt|
  party.prompts << prompt
end

team = PartyType.find(4)
team_prompts = [prompt1, prompt3, prompt4, prompt6, prompt8]
team_prompts.each do |prompt|
  team.prompts << prompt
end








