# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require "random_data"

1.times do
  Post.create!(
    title:    Random_Data.random_sentence,
    content:  Random_Data.random_paragraph
  )
end
posts = Post.all

2.times do
  Comment.create!(
    post: posts.sample,
    comment: Random_Data.random_sentence
  )
end

puts "Seeding complete"
puts "#{Post.count} post created!"
puts "#{Comment.count} comments created!"
