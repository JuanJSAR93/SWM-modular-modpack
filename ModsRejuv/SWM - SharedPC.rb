##### REJUV 13.5.7 ENHANCED #####

#####MODDED
$swm_loadedSharedBox = false

def swm_getSharedSaveFile
  folder = RTP.getSaveFolder().gsub(/[\/\\]$/,'')+'/../Pokemon Shared PC'
  Dir.mkdir(folder) unless (File.exist?(folder))
  return "#{folder}/SharedBox.rxdata"
end

def swm_loadSharedBox
  $swm_loadedSharedBox = true
  return nil if !$PokemonStorage
  return nil if !swm_ensureSharedSavedFile
  File.open(swm_getSharedSaveFile){|f|
    contents = Marshal.load(f)
    $PokemonStorage.swm_setSharedBoxContents(contents)
  }
end

def swm_ensureSharedSavedFile
  sharedSavefile = swm_getSharedSaveFile
  return true if safeExists?(sharedSavefile)
  $swm_loadedSharedBox = true
  return swm_saveSharedBox
end

def swm_saveSharedBox
  return false if !$swm_loadedSharedBox
  return false if !defined?($PokemonStorage)
  sharedSavefile = swm_getSharedSaveFile
  sharedSavefileTmp = "#{sharedSavefile}.tmp"
  sharedSavefileBackup = "#{sharedSavefile}.bak"
  boxNum = $PokemonStorage.swm_getSharedBoxId(true)
  return false if !boxNum
  File.open(sharedSavefileTmp, 'wb'){|f|
    # Guardar directamente el array interno de Pokémon
    Marshal.dump($PokemonStorage[boxNum].pokemon, f)
  }
  File.delete(sharedSavefileBackup) if safeExists?(sharedSavefileBackup)
  File.rename(sharedSavefile, sharedSavefileBackup) if safeExists?(sharedSavefile)
  File.rename(sharedSavefileTmp, sharedSavefile)
  return true
end
#####/MODDED

class PokemonStorage
  attr_accessor :swm_sharedBoxNum

  def swm_getSharedBoxId(allowUndefined)
    if !@swm_sharedBoxNum
      return nil if !allowUndefined
      return swm_setSharedBoxId
    end
    return @swm_sharedBoxNum
  end

  def swm_setSharedBoxId
    # Forzar que sea la última caja (ej. 50)
    boxNum = self.maxBoxes - 1
    if !@boxes[boxNum] || @boxes[boxNum].name != "Shared Box"
      @boxes[boxNum] = PokemonBox.new("Shared Box")
    end
    @swm_sharedBoxNum = boxNum
    return boxNum
  end

  def swm_setSharedBoxContents(value)
    boxNum = swm_getSharedBoxId(true)
    return false if !boxNum
    @boxes[boxNum] = PokemonBox.new("Shared Box")
    for i in 0...value.length
      @boxes[boxNum].pokemon[i] = value[i]   # Usar el array interno
    end
    return true
  end
end

class PokemonLoad
  if !defined?(swm_sharedPC_oldPbStartLoadScreen)
    alias :swm_sharedPC_oldPbStartLoadScreen :pbStartLoadScreen
  end

  def pbStartLoadScreen(*args, **kwargs)
    result = swm_sharedPC_oldPbStartLoadScreen(*args, **kwargs)
    swm_loadSharedBox
    return result
  end
end

if !defined?(swm_sharedPC_oldPbSave)
  alias :swm_sharedPC_oldPbSave :pbSave
end

def pbSave(*args, **kwargs)
  result = swm_sharedPC_oldPbSave(*args, **kwargs)
  swm_saveSharedBox
  return result
end