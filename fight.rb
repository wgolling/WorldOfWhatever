#
# fight_room has a bunch of enemies to test out
#
def fight_room (player)
  # ------------
  # enemies list
  # ------------
  # dummy enemy
  dummy_drop = Item.new('dummy drop', 'misc', 0, 'this is a dummy item to test drops', 0 )
  fight_dummy = Character.new('Fight Dummy', 100, 1000, 2, 1000, [dummy_drop])
  # dragon
  dragon_thing = Item.new('dragon thing', 'misc', 0, 'It\'s some kind of a thing from a dragon.', 0 )
  dragon = Character.new('Dragon', 100, 20, 8, 1000, [dragon_thing])
  # ----------
  # items list
  # ----------
  crowbar = Item.new('crowbar', 'weapon', 15, 'A well-used crowbar.  Attack +15.', 0)


  # sets enemy to fight
  enemy = dragon
  # sets items
  player.equip(crowbar)

  # start combat
  puts "\nYou are in the fight simulation room.  Here comes a #{enemy.char_name}."
  fight(player, enemy)
end

# ------------------
# the fight sequence
# ------------------
# player and enemy are Character objects
def fight (player, enemy)
  prng = Random.new

  # load player stuff
  player_name = player.char_name
  player_hp = player.char_hp
  player_maxhp = player.char_maxhp
  player_def_buff = 0
  #player_inv = player.char_inv
  # load enemy stuff
  enemy_name = enemy.char_name
  enemy_hp = enemy.char_hp
  enemy_maxhp = enemy.char_maxhp
  # puts "player hp: #{player_hp}/#{player_maxhp}"
  # puts "enemy hp: #{enemy_hp}/#{enemy_maxhp}"

  turn = 'player'
  is_defending = false

  while (player_hp > 0 ) && (enemy_hp > 0)

    if turn == 'player'
      puts ""
      player.display_hp()
      #enemy.display_hp()

      is_defending = 0                                                        # disable any potential defense
      did_select = false                                                      # reset selection boolean

      #puts "\n#{player_name}'s' turn."
      # player phase

      while did_select == false
        puts "\nWhat will you do?"
        puts "ATTACK   DEFEND   ITEM   RUN"
        input = prompt

        if ['ATTACK', 'attack', 'Attack'].include?(input)
          did_select = true
          # attack code
          puts "\n#{player_name} attacks!"
          dead = attack(player, enemy, 0)
          enemy_hp = enemy.char_hp
          #puts "#{enemy_name} has #{enemy_hp}/#{enemy_maxhp}"

        elsif ['Defend', 'defend', 'DEFEND'].include?(input)
          # defend code
          puts "\n#{player_name} defends..."
          did_select = true
          is_defending = 1

        elsif ['item', 'Item', 'ITEM'].include?(input)
          # item code
          puts "\nYou have:"
          player.display_inv_fight()
          puts "\nWhat item do you want to use?"
          item_input = prompt
          if item_input == 'picture'
            puts "\nYou stare at the picture of a family, and it rouses something in you...."
            puts "You still don't know who they are, but you inspired by their familiar bond!!!"
            puts "The power of family fills you incredibly!!!  Your attack power is OVER 9000!!!!!"
            player.char_str += 9000
            did_select = true
          else
            item = player.get_item_from_inv(item_input)
            if item == nil
              puts "\nYou don't have one of those."
            else
              #puts "\n#{item.item_name}"
              did_select = item.use_battle(player)
              #puts "#{did_select}"
            end
          end

        elsif ['RUN', 'Run', 'run'].include?(input)
          roll = prng.rand(0..1)
          if roll == 0
            puts "You could not run away!"
          else
            puts "You escaped!"
            empty_house(player)
          end
          did_select = true
        end
      end
      turn = 'enemy'

    # enemy phase
    elsif turn == 'enemy'
      puts "\nEnemy turn:"
      roll = prng.rand(1..10)
      if roll <= 8
        #Attack
        puts "#{enemy_name} attacks!"
        dead = attack(enemy, player, 5 * is_defending )
        player_hp = player.char_hp

        if dead == false
          #puts "#{player_name} has #{player_hp}/#{player_maxhp}"
        else
          puts "#{player_name} has fallen..."
          #character is revived and put outside
          player.char_hp = player.char_maxhp
          puts "Try again!"
          puts "\nYou awaken outside.  You still have all your stuff."
          empty_house(player)
        end
      else
        #defend
        puts "Dragon does nothing."
      end
      turn = 'player'

    end
  end

  if (enemy_hp <= 0)
    puts "\nYou defeated #{enemy.char_name}!"
    puts "\nYou got $#{enemy.char_money}!"
    puts "You found a #{enemy.char_inv[0].item_name}!"
    player.add_to_inventory(enemy.char_inv[0])
    player.add_to_money(enemy.char_money)
  elsif (player_hp <= 0)
    puts "\nTry again."
  end
end
# function that calculates damage done, and applies it to the target
def attack (attacker, defender, def_buff)
  #puts "\nAttacker strength: #{attacker.char_str}"
  #puts "\nDefender strength: #{defender.char_def}"

  # check if equipment is nil
  if attacker.char_weap == nil
    weapon_buff = 0
  else
    weapon_buff = attacker.char_weap.item_amount
  end
  if defender.char_arm == nil
    armour_buff = 0
  else
    armour_buff = defender.char_arm.item_amount
  end

  attack_total = attacker.char_str + weapon_buff
  #puts "Attack total: #{attack_total}"
  defend_total = defender.char_def + armour_buff + def_buff
  #puts "Defend total: #{defend_total}"
  damage = [attack_total - defend_total, 0].max
  #puts "Damage: #{damage}"
  #puts "Attack does #{damage} damage."
  dead = defender.take_damage(damage)
  return dead
end
