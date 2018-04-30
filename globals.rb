module Global
  #-----------------
  # global variables
  #-----------------

  # booleans
  HAS_BANK_CARD = false
  HAS_COUPON = false
  HAS_CROWBAR = false
  USED_COUPON = false
  HIT_HEAD = false

  # integers
  MONEY = 50

  # arrays
  INVENTORY = ['picture', 'popsicle']

  # ----------------
  # global functions
  # ----------------

  def Global.prompt
    print "> "
    return $stdin.gets.chomp
  end

  def Global.has_bank_card
    HAS_BANK_CARD = true
  end

  def Global.commands(user_input)
    bool = false
    #puts "Value of bool before if statement: #{bool}"

    if user_input == "quit"
      puts "Bye, bye!"
      exit(0)

    elsif ['S', 's', 'status', 'Status', 'STATUS'].include?(user_input)
      Global.status
      bool = true

    elsif ['I', 'i', 'inventory', 'Inventory', 'INVENTORY'].include?(user_input)
      Global.inventory
      bool = true

    elsif ['H', 'h', 'help', 'Help', 'HELP'].include?(user_input)
      Global.help
      bool = true

    end

    #puts "Value of bool after if statement: #{bool}"
    return bool

  end

  # displays the user's inventory
  def Global.inventory
    puts "You have #{MONEY} dollars.  Inside your pockets you find:"
    INVENTORY.each {|entry| print entry, ' '}
    print "\n"
  end

   # work these out
  def Global.status
    puts "STATUS has not been written yet."
  end
  def Global.help
    puts "HELP has not been written yet."
  end

end
