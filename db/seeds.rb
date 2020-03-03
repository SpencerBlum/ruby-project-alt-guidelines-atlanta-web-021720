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
user5 = User.create(username: "donkey", password: "shrek")
user6 = User.create(username: "michaelscott", password: "The office")

puts "create locations"

l1 = Location.create(country: "usa" , place: "vegas")
l2 = Location.create(country: "thailand" , place: "bangkok")
l3 = Location.create(country: "uk" , place: "hogwarts")
l4 = Location.create(country: "uk" , place: "Little Whinging")
l5 = Location.create(country: "uk" , place: "Hundred Acre Wood")
l6 = Location.create(country: "venezuela" , place: "paradise falls")

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

puts "seed data"

puts '|||||||||||||||||||||||||||||||||||||||||||||'
puts '|||||||||||||||||||||||||||||||||||||||||||||'
puts "Yo data is seeded"
puts '|||||||||||||||||||||||||||||||||||||||||||||'
puts '|||||||||||||||||||||||||||||||||||||||||||||'













