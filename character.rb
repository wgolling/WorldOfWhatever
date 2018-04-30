class Character

  attr_accessor :char_name
  attr_accessor :char_hp
  attr_accessor :char_maxhp
  attr_accessor :char_str
  attr_accessor :char_def
  attr_accessor :char_money
  attr_accessor :char_inv
  attr_accessor :char_weap
  attr_accessor :char_arm
  attr_accessor :did_get_crowbar
  attr_accessor :did_equip_crowbar
  attr_accessor :did_hit_head
  attr_accessor :did_enter_house
  # initializer
  def initialize(name, maxhp, strength, defense, money, inventory)
    @char_name = name
    # Character stats
    @char_maxhp = maxhp
    @char_hp = @char_maxhp
    @char_str = strength
    @char_def = defense
    @char_money = money
    @char_inv = inventory
    # Character equipment
    @char_weap = nil
    @char_arm = nil
    # event booleans
    @did_get_crowbar = false
    @did_equip_crowbar = false
    @did_hit_head = false
    @did_enter_house = false
  end
  # -----------------
  # display functions
  # -----------------
  def display_hp()
    puts "#@char_name's hp:  #@char_hp/#@char_maxhp"
  end
  def display_money()
    puts "You have $#@char_money"
  end
  def display_inv()
    puts "Inside your pockets you find:"
    @char_inv.each {|entry| print entry.item_name, '   '}
    print "\n"
  end
  def display_inv_fight()
    @char_inv.each {|entry| print entry.item_name, '   '}
    print "\n"
  end
  def display_status()
    puts "#@char_name"
    puts "#@char_hp/#@char_maxhp hp   #@char_str str   #@char_def def"
    if @char_weap == nil
      weapon_name = 'none'
    else
      weapon_name = @char_weap.item_name
    end
    if @char_arm == nil
      armour_name = 'none'
    else
      armour_name = @char_arm.item_name
    end
    puts "Weapon: #{weapon_name}   Armour: #{armour_name}"
  end
  # ---------------
  # check functions
  # ---------------
  def has_item(item_string)
    name_array = @char_inv.map {|a| a.item_name}
    bool = name_array.include?(item_string)
  end
  # ----------------
  # update functions
  # ----------------
  # function that handles healing
  def heal (num)
    diff = @char_maxhp - @char_hp
    puts "#{@char_name} recovers #{[num, diff].min} hp."
    @char_hp = [@char_maxhp, @char_hp + num].min
  end
  # function which handles damage
  def take_damage (num)
    puts "#{@char_name} takes #{num} points of damage."
    dead = false
    new_hp = @char_hp - num
      if new_hp <= 0
        @char_hp = 0
        dead = true
        #puts "#{@char_name} has fallen."
      else
        @char_hp -= num
      end
      return dead
  end
  # adds integer (could be negative) to char's money
  def add_to_money(num)
    sum = @char_money + num
    if sum < 0
      puts "You don't have that much money."
    else
      @char_money = sum
    end
  end
  # adds an item to char's inventory
  def add_to_inventory(item)
    @char_inv.push(item)
  end
  # removes an item from char's inventory, if it contains one
  def take_from_inventory(item)
    if @char_inv.include?(item)
      @char_inv.slice!(@char_inv.index(item))
    else
      puts "\nYou don't have any of those."
    end
  end
  # changes equipment
  def equip(item)
    # puts "Item type is #{item.item_kind}"
    if item.item_kind == 'weapon'
      @char_weap = item
      puts "\nYou equipped #{item.item_name}.  Attack up #{item.item_amount}."
    elsif item.item_kind == 'armour'
      @char_arm = item
      puts "\nYou equipped #{item.item_name}.  Defense up #{item.item_amount}."
    else
      puts "I don't know what's going on."
    end
  end
  
  # -----------------
  # getting functions
  # -----------------

  # takes a string and looks though Character inventory for an Item object with that name
  # it returns that item if there is one, and returns nil otherwise
  def get_item_from_inv (string)
    #puts "#{string}"
    item = nil
    i = 0
    while i < @char_inv.length
      item_name = @char_inv[i].item_name
      #puts "Item name is #{item_name}"
      if @char_inv[i].item_name == string
        item = @char_inv[i]
        break
      end
      i += 1
    end
    return item
  end

end



# tests

# user.display_hp()
# puts "You take 40 damage..."
# user.add_to_hp(-40)
# user.display_hp()
# puts "You are healed by 60..."
# user.add_to_hp(60)
# user.display_hp()
# puts "You take 500 damage..."
# user.add_to_hp(-500)
# user.display_hp()
#
# user.display_money()
# puts "Trying to add 50 bucks..."
# user.add_to_money(50)
# user.display_money()
# puts "Trying to remove 200 bucks..."
# user.add_to_money(-200)
# user.display_money()
# puts "Trying to remove 75 bucks..."
# user.add_to_money(-75)
# user.display_money()
#
# user.display_inv()
# user.add_to_inventory('butts')
# user.display_inv()
