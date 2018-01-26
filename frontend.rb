require "unirest"
require "paint"
require_relative "controllers/contacts_controller"
require_relative "views/contacts_views"
require_relative "models/contact"

class FrontEnd
  include ContactsController
  include ContactsViews

  def run

    system "clear"
    @screen_size = 200

    @url = "http://localhost:3000/contacts"

    puts
    puts Paint["=", :red] * @screen_size
    puts Paint["~*~*~*~ Welcome to my Contacts App, for all your contacts needs ~*~*~*~", :blue].center(@screen_size)
    puts Paint["=", :red] * @screen_size


    puts Paint["Choose an option:", :yellow]
    puts Paint["    [1] Show all contacts", :green]
    puts Paint["      [1.1] Search contacts", :green]
    puts Paint["    [2] Create a new contact", :green]
    puts Paint["    [3] Find a specific contact", :green]
    puts Paint["    [4] Update a contact", :green]
    puts Paint["    [5] Delete a contact", :green]

    input_option = gets.chomp

    if input_option == "1"
      contacts_index

    elsif input_option == "1.1"
      print "What would you like to search by (first_name, last_name, phone_number, email, birthday, bio): "
      search_attribute = gets.chomp
      print "What would you like to search for: "
      search_term = gets.chomp

      response = Unirest.get("#{url}?attribute=#{search_attribute}&search=#{search_term}")
      contact = response.body

      puts JSON.pretty_generate(contact)

    elsif input_option == "2"
      contacts_create

    elsif input_option == "3"
      contacts_show

    elsif input_option == "4"
      contacts_update
    elsif input_option == "5"
      contacts_destroy
    end

    puts
    puts Paint["=", :red] * @screen_size
  end
end