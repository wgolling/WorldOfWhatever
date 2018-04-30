# -------------------
# restaurant scenario
# -------------------
def restaurant(char_obj)
  puts "\nYou find yourself in a restaurant.  What do you do?"
  has_coupon = char_obj.has_item('coupon')
  has_crowbar = char_obj.has_item('crowbar')
  did_get_crowbar = char_obj.did_get_crowbar
  did_enter_house = char_obj.did_enter_house

  is_lady_here = true
  warnings = 0

  # puts "Has coupon? #{has_coupon}"
  # puts "Has crowbar? #{has_crowbar}"
  # puts "Got crowbar? #{did_get_crowbar}"
  # puts "Did enter house? #{did_enter_house}"

  while true
    input = prompt
    # checks global commands, and notes if one is used
    did_use_global = global_commands(input, char_obj)
    # if a global command was used, skip the other checks
    if did_use_global == true
      # do nothing

    # explore
    elsif input == "explore"
      if is_lady_here == true
        puts "\nYou see a Diner Lady behind a Counter, and a Menu on the wall."
        puts "There are two tables where you can Sit for dinner.  One of them has a broken chair."
      else
        puts "\nThere is a Menu on the wall beside the Counter, and two tables to Sit at."
        puts "The Diner Lady has stepped out."
      end

    # diner lady INTERACTION
    elsif (input == "Diner Lady") || (input == "diner lady") || (input == "Diner lady")
      if is_lady_here == true
        puts "\nDINER LADY: \"Siddown and I'll bring ya a menu.\""
        if (did_get_crowbar == false)
          puts "DINER LADY: \"But don't come behind the counter or I'll mess you up, for real.\""
        else
          puts "DINER LADY: \"Don't come back here or I'll mess you up,"
          puts "by, like, I dunno, seating you in a broken chair or something!\""
          if (has_crowbar == true) && (did_enter_house == true)
            puts "\nDINER LADY: \"Hey, nice crowbar!  Can I have it?  I lost mine...\""
            input_crowbar = prompt
            if (input_crowbar == 'yes')
              puts "\nDINER LADY: \"Wow thanks!  I'll keep it on me all the time.\""
              item = char_obj.get_item_from_inv('crowbar')
              char_obj.take_from_inventory(item)
            else
              puts "\nDINER LADY: \"Rats.\""
            end
          else
            # do nothing
          end
        end
      else
        puts "\nDiner Lady is not here."
      end

    # tables interaction
    elsif (input == 'sit' ) || (input == 'Sit' )
      puts "\nWhich table? (broken/normal)"
      input_table = prompt
      if (input_table == 'broken' ) && (did_enter_house == false )
        puts "\nYou slide off the chair and hit your butt, lol."
        puts "You lose 5 hp."
        char_obj.take_damage(5)
      elsif (input_table == 'broken' ) && (did_enter_house == true )
        puts "\nYou slide off the chair and hit your head."
        puts "You feel a lot more perceptive than you used to for some reason."
        char_obj.did_hit_head = true
      elsif input_table == 'normal'
        if is_lady_here == true
          if has_coupon == true
            puts "\nDINER LADY: \"Oh, you have a coupon!  Do you want the special for $50?\" (y/n)"
            input_special = prompt
            if (input_special == 'y' ) && (char_obj.char_money >= 50 )
              puts "\nDINER LADY: \"Great!  I'll bring it out for you.\""
              puts "DINER LADY: \"I might be a while, don't go behind the counter while I'm gone.\""
              puts "The Diner Lady shuffles into the kitchen.  You hear chainsaws."
              puts "..."
              puts "I don't think she's coming back soon."
              char_obj.add_to_money(-50)
              is_lady_here = false
            elsif (input_special == 'y' ) && (char_obj.char_money < 50 )
              puts "\nDINER LADY: \"What do you think this is, a charity?\""
            else
              puts "\nDINER LADY:  Hey, your loss.  Here's the regular menu:\""
              menu(char_obj)
            end
          else
            puts "\nDINER LADY: \"Oh, you don't have a coupon!  There's a special, but you need a coupon.\""
            puts "DINER LADY: \"Here's the regular menu, I guess...\""
            menu(char_obj)
          end
        else
          puts "\bYou sit at the table.  I don't think anyone is coming to take your order."
        end
      end

    # counter interaction
    elsif input == 'counter'
      if (is_lady_here == true) && (warnings == 0)
        puts "\nDINER LADY: \"Seriously, don't come back here.  Mess you up so bad.\""
        warnings += 1
      elsif (is_lady_here == true) && (warnings == 1)
        puts "\nDINER LADY: \"I'm warning you: if you keep trying to come back here you're gonna get messed.\""
        warnings += 1
      elsif (is_lady_here == true) && (warnings == 2)
        puts "\nDINER LADY: \"THAT's it, I warned you!!\""
        puts "Diner lady pulls out a crowbar from behind the counter and messes you up really bad."
        dead = char_obj.take_damage(40)
        puts "You have died.  You'll have to start over."
        puts " "
        exit(0)
      elsif (is_lady_here == false ) && (did_get_crowbar == false )
        puts "\nYou look behind the counter, and find a crowbar.  You put it in your pocket."
        crowbar = Item.new('crowbar', 'weapon', 15, 'A well-used crowbar.  Attack +15.', 0)
        char_obj.add_to_inventory(crowbar)
        char_obj.did_get_crowbar = true
        did_get_crowbar = char_obj.did_get_crowbar
      elsif (is_lady_here == false ) && (did_get_crowbar == true )
        puts "\nSomebody carved \"El Buttso was here\"..."
      end

    # menu
    elsif input == 'menu'
      if is_lady_here == true
        puts "DINER LADY: \"Fancy anything?\""
        menu(char_obj)
      else
        puts "\bYou see a menu, but there's no one to take your order."
      end

    # go back outside
    elsif (input == 'outside' ) || (input == 'exit') || (input == 'leave')
      outside(char_obj)
    else
      puts "\nWhat you say?"
    end
    puts "\n(You are standing in the restaurant.)"
  end
end
# menu
def menu (char_obj)
  money = char_obj.char_money
  puts "\nWhat'll ya have?"
  puts "MENU: sandwich - $20   pork chop - $30   caviar - $100   weird thing - $1000   nothing - free"
  input = prompt
  if (input == 'sandwich') && (money >= 20)
    puts "\nDINER LADY: \"Sandwich?  Nicceeee\""
    char_obj.char_money -= 20
    sandwich = Item.new('sandwich', 'heal', 10, 'This ??? sandwich restores 10 hp.', 0 )
    char_obj.add_to_inventory(sandwich)
  elsif (input == 'pork chop') && (money >= 30)
    puts "\nDINER LADY: \"Pork chop?  Oo baby.\""
    char_obj.char_money -= 30
    pork_chop = Item.new('pork chop', 'heal', 30, 'Big ol\' slab of meat restores 30 hp.', 0)
    char_obj.add_to_inventory(pork_chop)
  elsif (input == 'caviar') && (money >= 100)
    puts "\nDINER LADY: \"CAVIAR!??  What'r ya doin in THIS dump, money bags?\""
    puts "DINER LADY: \"Surely there's better stuff to spend money on that THIS.\""
    char_obj.char_money -= 100
    caviar = Item.new('caviar', 'heal', 0, 'Caviar, eh?  Pretty faaaancyyyy...', 0)
    char_obj.add_to_inventory(caviar)
  elsif (input == 'weird thing' && (money >= 1000))
    puts "\nDINER LADY: \"Ha, if you want it you can have it.\""
    char_obj.char_money -= 1000
    weird_thing = Item.new('weird thing', 'misc', 0, 'I don\'t even.', 0 )
    char_obj.add_to_inventory(weird_thing)
  else
    puts "\nChanged your mind and/or can't afford it?  That's ok."
  end
end
