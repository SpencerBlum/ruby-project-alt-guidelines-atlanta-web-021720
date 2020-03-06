require_all 'app'
puts "Destroying Data"

User.destroy_all
Location.destroy_all
JournalEntry.destroy_all

puts "Data Destroyed!!!!!!"
puts "*********************************************************"
puts "Data Destroyed!!!!!!"
puts "*********************************************************"
puts "Data Destroyed!!!!!!"
puts "*********************************************************"


puts "Create Users"
user1 = User.create(username: "stu", password: "hangover")
user2 = User.create(username: "pooh", password: "honey")
user3 = User.create(username: "harrypotter", password: "grifendor")
user4 = User.create(username: "russel", password: "up")
user5 = User.create(username: "Donkey", password: "shrek")
user6 = User.create(username: "michaelscott", password: "The office")
user7 = User.create(username: "Susan", password: "susan")

puts "create locations"

l1 = Location.create(country: "usa" , place: "vegas")
l2 = Location.create(country: "thailand" , place: "bangkok")
l3 = Location.create(country: "uk" , place: "hogwarts")
l4 = Location.create(country: "uk" , place: "Little Whinging")
l5 = Location.create(country: "uk" , place: "Hundred Acre Wood")
l6 = Location.create(country: "venezuela" , place: "paradise falls")
l7 = Location.create(country: "China" , place: "Wuhan")
l8 = Location.create(country: "usa" , place: "Scranton")
l9 = Location.create(country: "usa" , place: "Shreks Swamp")


puts "Locations Created!!!!!!!"
puts "*********************************************************"
puts "Locations Created!!!!!!!"
puts "*********************************************************"
puts "Locations Created!!!!!!!"
puts "*********************************************************"

puts "Create Journal Entries"

j1 = JournalEntry.create(user_id: user1.id, location_id: l1.id, title: "Long night", notes: "Today we lost dug and woke up with a tiger in the bedroom. Vegas is wild!!!!! Also I think I got married", date: Time.now)
j2 = JournalEntry.create(user_id: user1.id, location_id: l2.id, title: "Thailand Log", notes: "What the hell happend last night. Woke up in Thailand", date: Time.now)

j3 = JournalEntry.create(user_id: user2.id, location_id: l5.id, title: "Great day", notes: "I Found honey and played with all my friends", date: Time.now)
j4 = JournalEntry.create(user_id: user2.id, location_id: l5.id, title: "Sad day", notes: "Had to cheer up ior because he was realy sad", date: Time.now)
j5 = JournalEntry.create(user_id: user2.id, location_id: l5.id, title: "The search is on", notes: "Christopher robbin and I went on search for the hephalump and we are going to find it", date: Time.now)

j6 = JournalEntry.create(user_id: user3.id, location_id: l3.id, title: "I can do better", notes: "Dear diary, I saw Ginny in the halls but I was too shy to speak to her. I'll try again tomorrow", date: Time.now)
j7 = JournalEntry.create(user_id: user3.id, location_id: l3.id, title: "Rough day", notes: "Dear diary, I was able to cast my first spell today but almost burned down the school", date: Time.now)

j8 = JournalEntry.create(user_id: user7.id, location_id: l7.id, title: "Feeling Excited", notes: "Just arrived in Wuhan this afternoon, seems like people don't go outside much as I have been here for a bit and have not seen anyone.", date: Time.now)
j9 = JournalEntry.create(user_id: user7.id, location_id: l7.id, title: "Local market visit", notes: "Wuhan is known for the local meat market so I had to check it out. It was wierd though did see anyone selling meat and police were yelling at me.", date: Time.now)
j10 = JournalEntry.create(user_id: user7.id, location_id: l7.id, title: "Rough Day in Wuhan", notes: "Feeling pretty out it today I have a high fever and am having trouble breathing", date: Time.now)
j11 = JournalEntry.create(user_id: user7.id, location_id: l7.id, title: "COVID19 is not tight", notes: "In the hospital and feel horibble should have never come to wuhan.", date: Time.now)

j12 = JournalEntry.create(user_id: user6.id, location_id: l8.id, title: "Cuts are here", notes: "Management called and I need to let go of someone on the team. Need a scape goat.", date: Time.now)
j13 = JournalEntry.create(user_id: user6.id, location_id: l8.id, title: "Dwight is my scape goat", notes: "I will have dwight fire someone this way I wont be blamed.", date: Time.now)
j14 = JournalEntry.create(user_id: user6.id, location_id: l8.id, title: "Dwight has become a dictator", notes: "Everyone is panicking and even I don't know who will be let go. Could be me.", date: Time.now)
j15 = JournalEntry.create(user_id: user6.id, location_id: l8.id, title: "Kevin spilled the beans", notes: "Litterally kevin spilled chilli all over the office today", date: Time.now)

j16 = JournalEntry.create(user_id: user4.id, location_id: l6.id, title: "Elderly assistance badge", notes: "Leaving today to find and elderly man to assist", date: Time.now)
j17 = JournalEntry.create(user_id: user4.id, location_id: l6.id, title: "Crazy day", notes: "I got to this mans house to assist him and his house went up into the sky with me in it.", date: Time.now)
j18 = JournalEntry.create(user_id: user4.id, location_id: l6.id, title: "Landed in Paradise falls", notes: "Talk about elderly assistance I helped carry his home all the way to paradise falls. definitly getting this badge", date: Time.now)

j19 = JournalEntry.create(user_id: user5.id, location_id: l9.id, title: "I can fly", notes: "Met a beautiful dragon today and saved a princess what I great day", date: Time.now)
j20 = JournalEntry.create(user_id: user5.id, location_id: l9.id, title: "Got no time for drama", notes: "Shrek was in a mood today left him alone to deal with it himself. Got no time for basic oger syndrome.", date: Time.now)


puts "seed data"

puts '|||||||||||||||||||||||||||||||||||||||||||||'
puts '|||||||||||||||||||||||||||||||||||||||||||||'
puts "Yo data is seeded"
puts '|||||||||||||||||||||||||||||||||||||||||||||'
puts '|||||||||||||||||||||||||||||||||||||||||||||'













