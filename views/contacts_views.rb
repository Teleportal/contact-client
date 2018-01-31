module ContactsViews
  def contact_show_view(contact)
    puts
    puts contact.id
    puts contact.full_name
    puts contact.email
    puts contact.phone_number
    puts contact.birthday
    puts
    puts contact.bio
    puts
  end

  def contacts_index_view(contacts)
    contacts.each do |contact|
      contact_show_view(contact)
    end
  end

end