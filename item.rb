# the Item class has a name, a type, an amount, and a description
# it has functions for using/equipping items on a Character
class Item
  attr_reader :item_name
  attr_reader :item_kind
  attr_reader :item_amount
  attr_reader :item_desc
  attr_accessor :item_quant
  def initialize (name, type, amount, description, quantity)
    @item_name = name
    #puts @item_name
    @item_kind = type
    #puts @item_kind                                                       # kinds are heal, weapon, armour, misc
    @item_amount = amount
    #puts @item_amount
    @item_desc = description
    #puts @item_desc
    @item_quant = quantity
  end

  # ----------
  # functions
  # ----------

  # use functions
  # use Item from invemtory on a Character object
  def use_inv (char_obj)
    #puts "Item kind: #{@item_kind}"
    if @item_kind == 'heal'
      #puts "current hp: #{char_obj.char_hp}   max hp: #{char_obj.char_maxhp}"
      if char_obj.char_hp < char_obj.char_maxhp
        puts "current hp >= max hp"
        char_obj.heal(@item_amount)
        char_obj.take_from_inventory(self)
      else
        puts "You don't need to use that right now."
      end
    elsif (@item_kind == 'weapon') || (@item_kind == 'armour')
      char_obj.equip(self)
    elsif @item_kind == 'misc'
      puts @item_desc
    end
  end
  # use Item in battle on a Character object
  def use_battle (char_obj)
    did_consume = false
    if char_obj.char_inv.include?(self) == true
      if @item_kind == 'heal'
        puts "\nYou use #{self.item_name}..."
        char_obj.heal(@item_amount)
        char_obj.take_from_inventory(self)
        did_consume = true
      else
        puts "\nYou can't use that in battle."
      end
    else
      puts "\nYou don't have one of those."
    end
    return did_consume
  end
end
