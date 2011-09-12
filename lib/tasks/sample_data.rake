namespace :db do  
  desc "Fill database with sample data"    
  task :populate => :environment do
    Rake::Task['db:reset'].invoke    
    make_users
    make_microposts
    make_relationships
  end    
end

# Populate the database with fake users.
def make_users
  admin = User.create!(:name => "Example User", 
                       :email => "example@railstutorial.org",
                       :password => "foobar", 
                       :password_confirmation => "foobar")
  admin.toggle!(:admin)
  99.times do |n|
    name = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password = "password"
    User.create!(:name => name, 
                 :email => email, 
                 :password => password, 
                 :password_confirmation => password)
  end
end

# Populate the database with fake microposts.
def make_microposts
  User.all(:limit => 6).each do |user|
    50.times do
      user.microposts.create!(:content => Faker::Lorem.sentence(5))
    end
  end  
end

# Populate the database with fake relationships.
def make_relationships
  all_users = User.all
  user = all_users.first
  following = all_users[1..50]
  followers = all_users[3..40]
  following.each { |followed| user.follow!(followed) }
  followers.each { |follower| follower.follow!(user) }
end