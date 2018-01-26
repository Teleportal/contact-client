require "unirest"

system "clear"
screen_size = 200

url = "http://localhost:3000"

puts
puts ("=" * screen_size)
puts

puts "Choose an option:"
puts "    [1] Show one contact"
puts "    [2] Show all contact"

input_option = gets.chomp

if input_option == 1
  url += "/first_contact"
elsif input_option == 2
  url += "/all_contact"
end

response = Unirest.get(url)
contact = response.body
puts JSON.pretty_generate(contact)
puts
puts ("=" * screen_size)