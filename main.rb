#puts "Start of file."

require_relative 'character.rb'
require_relative 'item.rb'
require_relative 'fight.rb'

# ----------------
# global functions
# ----------------
# generic prompt
def prompt
  print "\n> "
  return $stdin.gets.chomp
end
# commands usable in every room
def global_commands(user_input, char_obj)
  bool = false
  #puts "Value of bool before if statement: #{bool}"
  if ['Q', 'q', 'QUIT', 'Quit', 'quit'].include?(user_input)
    puts "Are you sure you want to quit?"
    input = prompt
    if ['y', 'Y', 'YES', 'Yes' 'yes'].include?(input)
      puts "\nOk bye bye!\n"
      exit(0)
    else
      # do nothing
    end
    bool = true
  elsif ['S', 's', 'status', 'Status', 'STATUS'].include?(user_input)
    puts ""
    char_obj.display_status
    bool = true
  elsif ['I', 'i', 'inventory', 'Inventory', 'INVENTORY'].include?(user_input)
    puts "\n#{char_obj.char_name} has $#{char_obj.char_money}"
    char_obj.display_inv
    bool = true
  elsif ['H', 'h', 'help', 'Help', 'HELP'].include?(user_input)
    display_help
    bool = true
  # if player has the item in their inventory, "use" it
  elsif char_obj.has_item(user_input) == true
    item = char_obj.get_item_from_inv(user_input)
    item.use_inv(char_obj)
    bool = true
  end
  #puts "Value of bool after if statement: #{bool}"
  return bool
end
# help screen
def display_help
  puts "\nWelcome to the world of whatever, a text based adventure that's not too bad."
  puts "You control the game by entering commands, preferably lower case."
  puts "The game doesn't know a lot of words, so if your command doesn't work try a similar word."
  puts "Here are some useful commands:"
  puts "\nexplore   inventory (or i)   status (or s)   quit"
  puts "You can exit buildings with  exit  leave  outside"
  puts "\nYou can also try using items in your inventory."
end

# ----------
# room files
# ----------
require_relative 'outside.rb'
require_relative 'bank.rb'
require_relative 'restaurant.rb'
require_relative 'emptyhouse.rb'

def start (char_obj)
  # assign character's name
  puts "\nWhat is your character's name?"
  input = prompt
  char_obj.char_name = input

  puts "\nTIP: try typing   help"

  # start a scenario
  #
  #fight_room(char_obj)
  outside(char_obj)
  #bank(char_obj)
  #restaurant(char_obj)
  #empty_house(char_obj)
end

# initialize Items
picture = Item.new('picture', 'misc', 0, 'It\'s a picture of a family.  Maybe your family.', 1)
#weird_thing = Item.new('weird thing', 'misc', 0, 'This thing is pretty weird.  I wonder what it\'s for...', 0)
sandwich = Item.new('sandwich', 'heal', 10, 'This ??? sandwich restores 10 hp.', 0 )
#pork_chop = Item.new('pork chop', 'heal', 30, 'Big ol\' slab of meat restores 30 hp.', 0)
#caviar = Item.new('caviar', 'heal', 0, 'Caviar, eh?  Pretty faaaancyyyy...', 0)
# crowbar = Item.new('crowbar', 'weapon', 15, 'A well-used crowbar.  Attack +15.', 0)

# store items in array to be passed to functions
#item_array = [picture, bank_card, coupon, weird_thing, sandwich, pork_chop, caviar, crowbar]
# initialize player Character
player = Character.new('Player', 50, 15, 4, 100, [picture, sandwich] )

# player.take_damage(10)
# player.add_to_inventory(sandwich)


start(player)






#######################
# checking things out #
#######################

# puts "#{player.char_inv}"
# name_array = player.char_inv.map {|a| a.item_name}
# puts "#{name_array}"


#
# if player.char_weap != nil
#   puts "You are equipped with #{player.char_weap.item_name}"
# else
#   puts "You are not equipped."
# end
# player.add_to_inventory(crowbar)
# player.display_inv()
# player.equip(crowbar)
# puts player.char_weap.item_name



# input = prompt
# item = player.get_item_from_inv(input)
# puts "#{item.item_desc}"

# player.display_inv
# player.add_to_inventory(sandwich)
# player.display_inv
# player.add_to_inventory(sandwich)
# player.display_inv
# sandwich.use_inv(player)
# player.display_inv
# sandwich.use_inv(player)
# player.display_inv
# sandwich.use_inv(player)
# player.display_inv

# player.take_damage(15)
# player.display_hp
# sandwich.use_inv(player)
# player.display_hp
# dead = player.take_damage(100)
# player.display_hp
# if dead == true
#   puts "you ded"
# end
# tests
#item_array.each {|item| puts item.item_desc}

# player.display_hp()
# player.display_money()
# player.display_inv()
# player.display_inv_fight()
# player.display_status()

# puts "#{player.char_hp}"
# puts "after player and potion are defined"
# puts "Line 1: #{potion.item_name}, #{potion.item_type}, #{potion.item_amount}"
# puts "Line 2: #{potion.item_desc}"
# puts "after printing"
#start(player)



# player.display_hp()
# puts "You take 40 damage..."
# player.add_to_hp(-40)
# player.display_hp()
# puts "You are healed by 60..."
# player.add_to_hp(60)
# player.display_hp()
# puts "You take 500 damage..."
# player.add_to_hp(-500)
# player.display_hp()
#
# print "\n"
#
# player.display_money()
# puts "Trying to add 50 bucks..."
# player.add_to_money(50)
# player.display_money()
# puts "Trying to remove 200 bucks..."
# player.add_to_money(-200)
# player.display_money()
# puts "Trying to remove 75 bucks..."
# player.add_to_money(-75)
# player.display_money()
#
# print "\n"
#
# player.display_inv()
# puts "Adding 'butts' to inventory..."
# player.add_to_inventory('butts')
# player.display_inv()
# puts "Taking 'picture' from inventory..."
# player.take_from_inventory('picture')
# player.display_inv()
# puts "Taking 'oh gee' from inventory..."
# player.take_from_inventory('oh gee')
# player.display_inv()

# while true
#   puts "Check for cars?"
#   input = prompt
#   if (input == 'quit')
#     exit(0)
#   elsif (input == 's')
#     player.display_status()
#   else
#     car_check(player)
#   end
# end
