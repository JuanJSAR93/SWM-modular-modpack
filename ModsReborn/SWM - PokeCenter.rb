class Swm_PokeCenter_PC
  def shouldShow?
    # Aquí decides si siempre aparece o si depende de switches
    return true
  end

  def name
    return _INTL('Pokémon Center')
  end

  def access
    Kernel.pbMessage(_INTL('Connecting to PokeCenter'))
    loop do
      choice = swm_PokeCenter_show_menu(
        _INTL('What do you wish to do?'),
        [
          [:HealParty, 'Heal Pokémon'],
          [:CANCEL, 'Disconnect']
        ]
      )
      break if choice.nil? || choice == :CANCEL
      swm_PokeCenter_heal_party if choice == :HealParty
    end
  end

  def swm_PokeCenter_heal_party
    for i in $Trainer.party
      i.heal
    end
    pbSEPlay("Healing") # sonido de curación, opcional
    Kernel.pbMessage(_INTL("Your Pokémon were healed."))
  end

  def swm_PokeCenter_show_menu(title, items) # items es un array de [retval, text]
    options, choices = swm_PokeCenter_menu_options(*items)
    choice = Kernel.pbMessage(
      title,
      choices,
      -1
    )
    return nil if choice < 0
    return options[choice]
  end

  def swm_PokeCenter_menu_options(*items)
    options = []
    choices = []
    items.each do |itm|
      choices.push(options.push(itm[0]) && itm[1])
    end
    return options, choices
  end
end

PokemonPCList.registerPC(Swm_PokeCenter_PC.new)