module ContactsController

  def contacts_index
    response = Unirest.get(@url)
    contacts_hashes = response.body
    contacts = []

    contacts_hashes.each do |contact|
      contacts << Contact.new(contact)
    end
    
    puts JSON.pretty_generate(contact)
  end

  def contacts_show
    print Paint["What is the id of the contact: ", :yellow]
    input_id = gets.chomp

    response = Unirest.get(@url + "/#{input_id}")
    contact = response.body

    puts JSON.pretty_generate(contact)
  end

  def contacts_create
    client_params = {}
    puts Paint["Gonna need a few details:", :yellow]
    print "First Name: "
    client_params[:first_name] = gets.chomp
    print "Middle Name: "
    client_params[:middle_name] = gets.chomp
    print "Last Name: "
    client_params[:last_name] = gets.chomp
    print "Email: "
    client_params[:email] = gets.chomp
    print "Phone Number: "
    client_params[:phone_number] = gets.chomp
    print "Birthday: "
    client_params[:birthday] = gets.chomp
    print "Bio: "
    client_params[:bio] = gets.chomp

    response = Unirest.post(@url,
                            parameters: client_params
                            )
    if response.code == 200
      new_contact = response.body

      puts JSON.pretty_generate(new_contact)
    else
      errors = response.body["errors"]
      errors.each do |error|
        puts error
      end
    end
  end

  def contacts_update
    print Paint["What is the id of the contact: ", :yellow]
    input_id = gets.chomp

    response = Unirest.get(@url + "/#{input_id}")
    old_contact = response.body

    client_params = {}
    print "First Name (#{old_contact["first_name"]}): "
    client_params[:first_name] = gets.chomp
    print "Middle Name (#{old_contact["middle_name"]}): "
    client_params[:middle_name] = gets.chomp
    print "Last Name (#{old_contact["last_name"]}): "
    client_params[:last_name] = gets.chomp
    print "Email (#{old_contact["email"]}): "
    client_params[:email] = gets.chomp
    print "Phone Number (#{old_contact["phone_number"]}): "
    client_params[:phone_number] = gets.chomp
    print "Birthday (#{old_contact["birthday"]}): "
    client_params[:birthday] = gets.chomp
    print "Bio (#{old_contact["bio"]}): "
    client_params[:bio] = gets.chomp

    client_params.delete_if { |key, value| value.empty? }

    response = Unirest.patch(@url + "/#{input_id}",
                            parameters: client_params
                            )

    if response.code == 200
      updated_contact = response.body

      puts JSON.pretty_generate(updated_contact)
    else
      errors = response.body["errors"]
      errors.each do |error|
        puts error
      end
    end
  end

  def contacts_destroy
    print Paint["What is the id of the contact: ", :yellow]
    input_id = gets.chomp

    response = Unirest.delete(@url + "/#{input_id}")
    data = response.body

    puts data["message"]
  end

end