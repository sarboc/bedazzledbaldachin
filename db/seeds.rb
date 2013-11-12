# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

party_types = PartType.create [
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
  {
    description: "Almonds. Discuss.",
    rating: 1,
  }, {
    description: "Think about your first kiss. What face did you just make, and why?",
    rating: 2
  }, {
    description: "What was your childhood nickname?",
    rating: 2
  }, {
    description: "Begin a friendly debate over the pronunciation of the following word: gif",
    rating: 1
  }, {
    description: "How often do you google and/or facebook your elementary-school crush?",
    rating: 2
  }, {
    description: "Peanut butter: smooth or crunchy?",
    rating:
  }, {
    description: "Put your hand in the front pocket of the person on your right. Announce what you find.",
    rating: 3
  }, {
    description: "Would you rather lose your dominant hand or your dominant foot?",
    rating: 1
  }, {
    description: "Switch tops with another party member of your choosing.",
    rating: 3
  }, {
    description: "If you are currently wearing underpants, describe them to the group. If not, explain why.",
    rating: 3
  }
]

date = PartType.find(1)
date.prompts << Prompt.find(1)
date.prompts << Prompt.find(2)
date.prompts << Prompt.find(3)
date.prompts << Prompt.find(5)
date.prompts << Prompt.find(10)









