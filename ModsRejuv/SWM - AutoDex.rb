##### AUTO EVO DEX - REJUV 13.5.7 ENHANCED #####

AUTOEVO_SHOW_MESSAGE = true

Events.onEndBattle += proc {|sender,e|
  autoevo_rescan_full_dex
}

def autoevo_rescan_full_dex
  return unless $Trainer
  return unless $Trainer.pokedex

  dex = $Trainer.pokedex.dexList
  unlocked = []
  owned_species = []

  # Equipo
  $Trainer.party.each do |pkmn|
    next unless pkmn
    owned_species << [pkmn.species, pkmn.form]
  end

  # PC
  if $PokemonStorage
    for box in 0...$PokemonStorage.maxBoxes
      for slot in 0...$PokemonStorage.maxPokemon(box)
        pkmn = $PokemonStorage[box, slot]
        next unless pkmn
        owned_species << [pkmn.species, pkmn.form]
      end
    end
  end

  owned_species.uniq!

  full_unlock = []

  owned_species.each do |species, form|
    full_unlock.concat(autoevo_get_full_line(species))
  end

  full_unlock.uniq!

  full_unlock.each do |sp|
    next unless dex[sp]
    next if dex[sp][:owned?]

    dex[sp][:seen?] = true
    dex[sp][:owned?] = true
    
    # Añadir soporte shadow y shiny
    dex[sp][:shadowCaught?] = true if dex[sp].key?(:shadowCaught?)
    dex[sp][:shinySeen?] = true if dex[sp].key?(:shinySeen?)

    # Marcar TODAS las formas como vistas
    if dex[sp].key?(:forms)
      dex[sp][:forms].each_key do |form_name|
        dex[sp][:forms][form_name] = true
      end
    end

    # Actualizar contadores correctamente
    $Trainer.pokedex.instance_variable_set(:@seenCount,
      $Trainer.pokedex.instance_variable_get(:@seenCount) + 1)

    $Trainer.pokedex.instance_variable_set(:@ownedCount,
      $Trainer.pokedex.instance_variable_get(:@ownedCount) + 1)

    #unlocked << getMonName(sp)
    base_name = getMonName(sp)
    form_names = []
    
    if dex[sp].key?(:forms)
      dex[sp][:forms].each_key do |form_name|
        next if form_name == "Normal Form"
        form_names << form_name
      end
    end
    unlocked << base_name
    form_names.each do |form_name|
      unlocked << "#{base_name} (#{form_name})"
    end
  end

  return if unlocked.empty?
  return unless AUTOEVO_SHOW_MESSAGE

  if unlocked.length > 15
    Kernel.pbMessage(
      _INTL('Pokedex update! {1} new entries added.',
      unlocked.length)
    )
  else
    Kernel.pbMessage(
      _INTL("New entries added: {1}",
      unlocked.join(", "))
    )
  end
end

def autoevo_get_full_line(species)
  baby = pbGetBabySpecies(species)[0]
  return [] unless baby

  line = []

  $cache.pkmn.each_key do |sp|
    begin
      b = pbGetBabySpecies(sp)[0]
      line << sp if b == baby
    rescue
      next
    end
  end

  return line
end

##### /AUTO EVO DEX #####