# ----------------
# outside scenario
# ----------------
def outside(char_obj)
  has_crowbar = char_obj.has_item('crowbar')
  did_enter_house = char_obj.did_enter_house

  puts "\nYou find yourself on the street outside three buildings.  What do you do?"

  while true
    input = prompt
    # first checks the global commands, and notes if one is used
    did_use_global = global_commands(input, char_obj)                         # if no global command used, checks room-specific stuff
    if did_use_global == true
      # do nothing
    # environment interaction
    elsif input == "explore"
      puts "\nYou see a Bank, a Restaurant, and a boarded-up Empty House."
      puts "On the street are a smattering of people, who might give you some coin if you Beg them."
    elsif input == "beg"
      puts "\nYou try asking strangers for some money."
      car_check(char_obj)
      money = beg
      char_obj.char_money += money
      puts "You got #{money} dollars."
    # (try to) change locations
  elsif ['bank', 'Bank', 'BANK'].include?(input) == true
      car_check(char_obj)
      bank(char_obj)
    elsif ['restaurant', 'Restaurant', 'RESTAURANT'].include?(input) == true
      car_check(char_obj)
      restaurant(char_obj)
    elsif ['empty house', 'Empty House', 'EMPTY HOUSE', 'Empty house'].include?(input) == true
      if did_enter_house == true
        car_check(char_obj)
        empty_house(char_obj)
      elsif char_obj.has_item('crowbar') == true
        puts "\nYou use the crowbar to pry off the boards, and enter the house."
        car_check(char_obj)
        char_obj.did_enter_house = true
        did_enter_house = char_obj.did_enter_house
        empty_house(char_obj)
      else
        puts "\nThe house is boarded up, you can't get in."
      end
    # otherwise
    else
      puts "\nWhat you say?"
    end

    puts "\n(You are currently outside.)"
  end

end
# ----------------
# helper functions
# ----------------
# check for cars
def car_check(char_obj)
  prng = Random.new
  rand_num = prng.rand(0.0..1.0)
  if (rand_num < 0.1)
    puts "\nYou get hit by a car!  Holy cow!"
    char_obj.take_damage(10)
    puts "You take 10 damage."
  else
    # do nothing
  end
end
# beg for money
def beg
  prng = Random.new
  amount = prng.rand(3..20)
  rand_num = prng.rand(1..10)
  if rand_num < 8
    success = 1
  else
    success = 0
  end
  money = success * amount
  return money
end
