# -------------
# bank scenario
# -------------
def bank(char_obj)
  puts "\nYou find yourself in a bank.  What do you do?"

  has_bank_card = char_obj.has_item('bank card')
  #puts "Has bank card? #{has_bank_card}"

  while true
    input = prompt
    # checks global commands, and notes if one is used
    did_use_global = global_commands(input, char_obj)
    # if a global command was used, skip the other checks
    if did_use_global == true
      # do nothing
    elsif input == "explore"
      #puts "Has bank card? #{has_bank_card}"
      puts "\nYou see an ATM and a Teller."
      if has_bank_card
        # do nothing
      else
        puts "It looks like there is a Bank Card in a corner."
      end
    elsif (input == "bank card") && (has_bank_card == false)
      # if player doesn't have a bank card, initialize Item and add to inventory
      bank_card = Item.new('bank card', 'misc', 0, 'The name says \'Seymore Butts\'.  Hopefully that\'s not your name.', 0)
      puts "\nYou pick up a bank card off the floor."
      char_obj.add_to_inventory(bank_card)
      has_bank_card = true
      #puts "bank card status after picking it up: #{$has_bank_card}"
      # elsif (input == "bank card") && (has_bank_card == true)
      #   puts "\nYou have a bank card that you picked up from the floor."
      #   puts "The name on it is Seymore Butts."
    elsif ['ATM', 'atm', 'Atm' ].include?(input) == true
      atm_interaction(has_bank_card, char_obj)
    elsif ['teller', 'Teller', 'TELLER'].include?(input) == true
      teller_interaction
    elsif ['ATM machine', 'atm machine', 'Atm machine' ].include?(input) == true
      puts "\nThat's redundant."
    elsif (input == 'outside' ) || (input == 'exit') || (input == 'leave')
      outside(char_obj)
    else
      puts "\nWhat you say?"
    end

    puts "\n(You are currently in the bank.)"

  end
end
# atm interaction
def atm_interaction(bool, char_obj)
  if bool == false
    puts "\nYou have no way of interacting with the ATM."
  else
    puts "\nInput password:"
    input = prompt

    if input == "butt"
      puts "\nATM: \"Password accepted... Printing coupon...\""
      puts "The ATM prints a coupon for some reason.  You take it."
      coupon = Item.new('coupon', 'misc', 0, 'It\'s a coupon for a secret menu item at the restaurant.', 0)
      char_obj.add_to_inventory(coupon)
    else
      puts "\nATM: \"Password is incorrect.\""
    end
  end
end
# teller interaction
def teller_interaction
  puts "\nTELLER: \"Hello there, how can I help you?"
  input = prompt
  if ['password'].include?(input)
    puts "\nTELLER: \"Passwords are 4 characters long.\""
    puts "\nTELLER: \"It's really bad practice to use part of your name, but people still do it."
  elsif ['bank card'].include?(input)
    puts "\nTELLER: \"You can use your bank card in the ATM, if you know your password...\""
  else
    puts "\nTELLER: \"Sorry, I don't know anything about that.\""
  end
end
