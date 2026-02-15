##### REJUV 13.5.7 ENHANCED #####

$swm_typeBitmaps = nil

class PokemonDataBox < SpriteWrapper

  # ===============================
  # DIBUJAR ICONOS
  # ===============================
  def swm_setTypeBattleIcons
    swm_ensureTypeBitmaps
    type1, type2 = swm_getBattlerTyping
    return if type1.nil?

    baseX, baseY = swm_getBaseTypeCoords

    if $swm_typeBitmaps[type1]
      self.bitmap.blt(baseX, baseY,
        $swm_typeBitmaps[type1],
        $swm_typeBitmaps[type1].rect)
    end

    if type2 && type1 != type2 && $swm_typeBitmaps[type2]
      dist = $swm_typeBitmaps[type1].rect.width
      self.bitmap.blt(baseX + dist, baseY,
        $swm_typeBitmaps[type2],
        $swm_typeBitmaps[type2].rect)
    end
  end

  # ===============================
  # POSICIÓN
  # ===============================
  def swm_getBaseTypeCoords
    baseX = @spritebaseX + 8
    baseY = @spritebaseY - 1
    return baseX, baseY
  end

  # ===============================
  # CARGAR BITMAPS
  # ===============================
  def swm_ensureTypeBitmaps
    return if !swm_shouldLoadTypeBitmaps

    rawBmp = AnimatedBitmap.new(_INTL("Data/Mods/SWM - TypeBattleIcons"))
    
    retval = {}
    spriteWidth = 32
    spriteHeight = 12

    map = [
      :NORMAL,
      :FIGHTING,
      :FLYING,
      :POISON,
      :GROUND,
      :ROCK,
      :BUG,
      :GHOST,
      :STEEL,
      :QMARKS,
      :FIRE,
      :WATER,
      :GRASS,
      :ELECTRIC,
      :PSYCHIC,
      :ICE,
      :DRAGON,
      :DARK,
      :FAIRY,
      :SHADOW
    ]

    map.each_with_index do |type_sym, i|
      rect = Rect.new(0, i * spriteHeight, spriteWidth, spriteHeight)
      bitmap = Bitmap.new(rect.width, rect.height)
      bitmap.blt(0, 0, rawBmp.bitmap, rect)
      retval[type_sym] = bitmap
    end

    $swm_typeBitmaps = retval
  end

  def swm_shouldLoadTypeBitmaps
    return true if !$swm_typeBitmaps
    $swm_typeBitmaps.each_value do |bmp|
      return true if bmp.disposed?
    end
    return false
  end

  # ===============================
  # OBTENER TIPOS (ADAPTADO REJUV)
  # ===============================
  def swm_getBattlerTyping
    return nil if !@battler

    # Illusion (Zoroark/Zorua)
    if @battler.effects[:Illusion]
      ill = @battler.effects[:Illusion]
      type1 = ill.type1
      type2 = ill.type2
    else
      type1 = @battler.type1
      type2 = @battler.type2
    end

    # Convertir a símbolo si viene como ID
    type1 = convertType(type1)
    type2 = convertType(type2)

    return type1, type2
  end

  def convertType(type)
    return nil if type.nil?
    return type if type.is_a?(Symbol)

    begin
      return GameData::Type.get(type).id
    rescue
      return nil
    end
  end

  # ===============================
  # HOOK EN REFRESH
  # ===============================
  unless method_defined?(:swm_typeBattleIcons_oldRefresh)
    alias swm_typeBattleIcons_oldRefresh refresh
  end

  def refresh(*args)
    result = swm_typeBattleIcons_oldRefresh(*args)
    swm_setTypeBattleIcons
    return result
  end

end