# require 'faker'

# puts "Deleting users and karma_points..."
# User.delete_all
# KarmaPoint.delete_all

# ActiveRecord::Base.logger = nil

# puts "Creating users..."

# now = Time.now

# TOTAL_KARMA = 1_500_000
# TOTAL_USERS = 100_000
# SLICE_SIZE  = 20_000

# fields = [:first_name, :last_name, :email, :username, :created_at, :updated_at, :karma_sum]
# TOTAL_USERS.times.each_slice(SLICE_SIZE).each_with_index do |ids, index|
#   data = ids.map do |i|
#     [Faker::Name.first_name, Faker::Name.last_name, "email_#{i}@example.com", "user_#{i}", now, now]
#   end

#   puts "Inserted #{(index + 1)*SLICE_SIZE} of #{TOTAL_USERS} users..."
#   User.import(fields, data, :validate => false, :timestamps => false)
# end

# user_ids = User.pluck(:id)
# fields = [:user_id, :value, :label, :created_at, :updated_at]


# TOTAL_KARMA.times.each_slice(SLICE_SIZE).each_with_index do |ids, index|
#   data = ids.map do
#     user_id = user_ids.sample
#     [user_id, rand(1..user_id), Faker::Lorem.word, now, now]
#   end

#   puts "Inserted #{(index + 1)*SLICE_SIZE} of #{TOTAL_KARMA} karma points..."
#   KarmaPoint.import(fields, data, :validate => false, :timestamps => false)
# end

# Find sum of karma per user with SQL
@users = User.all

count = 0
@users.each do |user|
  user_result = ActiveRecord::Base.connection.execute("SELECT SUM(value) FROM karma_points WHERE user_id=#{user.id}")
  karma_point = user_result[0]["sum"].to_i
  ActiveRecord::Base.connection.execute("UPDATE users SET karma_sum='#{karma_point}' WHERE id=#{user.id}")
  count += 1
  p count if count%500 == 0
end