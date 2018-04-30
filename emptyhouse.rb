def empty_house(char_obj)
  did_hit_head = char_obj.did_hit_head

  puts "\nYou find yourself in an empty house.  What do you do?"

  while true
    input = prompt
    did_use_global = global_commands(input, char_obj)
    # if a global command was used, skip the other checks
    if did_use_global == true
      # do nothing
    elsif input == 'explore'
      if did_hit_head == false
        puts "\nThere is absolute nothing in this house.  At all.  Weird."
      else
        puts "\nYou find a Trap Door in the corner."
      end
    elsif (['trap door', 'Trap Door', 'Trap door'].include?(input) == true ) && (did_hit_head == true )
      puts "\nThe trap door creaks as you open it and descend..."
      trap_door(char_obj)

    elsif ['outside', 'exit', 'leave'].include?(input) == true
      outside(char_obj)
    else
      puts "\nWhat you say?"
    end

    puts "\nYou are currently in the empty house."
  end
end
def trap_door(char_obj)
  # initialize and fight dragon
  dragon_thing = Item.new('dragon thing', 'misc', 0, 'It\'s some kind of a thing from a dragon.', 0 )
  dragon = Character.new('Dragon', 100, 20, 8, 1000, [dragon_thing])
  puts "\nFlames light up the basement, there's a #{dragon.char_name} here!"
  puts "DRAGON: \"GRAWWW, fool!  Get ye butt from out my chambeeeerrraahhhrg!!"
  fight(char_obj, dragon)

  puts "The vanquished dragon has some kind of death rattle, it's very dramatic."
  puts "You beat the boss, and by extension the whole game!!  But you can keep playing if you want."
end
