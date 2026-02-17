# ==========================================
# Inicialización forzada en onStepTaken
# ==========================================
Events.onStepTaken += proc {
  SWM_GlobalPopup.init unless $swm_speed_popup
}

# ==========================================
# Global: precargar imágenes desde un solo archivo
# ==========================================
module SWM_GlobalPopup
  def self.init
    return if @speed_fast && @speed_normal && $swm_speed_popup

    # Cargar la imagen que contiene ambos estados
    rawBmp = AnimatedBitmap.new("Data/Mods/SWM - SpeedTogglePopup")

    spriteWidth  = 50   # ajusta al ancho real
    spriteHeight = 50   # ajusta al alto real

    # Recorte SpeedFast
    rect_fast = Rect.new(0, 0, spriteWidth, spriteHeight)
    bmp_fast = Bitmap.new(rect_fast.width, rect_fast.height)
    bmp_fast.blt(0, 0, rawBmp.bitmap, rect_fast)

    # Recorte SpeedNormal
    rect_normal = Rect.new(0, spriteHeight, spriteWidth, spriteHeight)
    bmp_normal = Bitmap.new(rect_normal.width, rect_normal.height)
    bmp_normal.blt(0, 0, rawBmp.bitmap, rect_normal)

    # Guardar directamente los Bitmap recortados
    @speed_fast   = bmp_fast
    @speed_normal = bmp_normal

    $swm_speed_popup ||= Sprite_SWM_SpeedPopup.new
  end

  def self.speed_popup;  $swm_speed_popup; end
  def self.speed_fast;   @speed_fast; end
  def self.speed_normal; @speed_normal; end
end

# ==========================================
# Sprite del popup (ajustado para Bitmap directo)
# ==========================================
class Sprite_SWM_SpeedPopup < Sprite
  def initialize
    super(nil)
    self.z = 999999
    @timer = 0
    @animbitmap = nil
  end

  def show_popup(bitmap, seconds = 1.2)
    dispose_bitmap
    @animbitmap = bitmap
    self.bitmap = @animbitmap

    self.x = Graphics.width - self.bitmap.width - 25
    self.y = Graphics.height - self.bitmap.height - 25

    self.zoom_x = 1.2
    self.zoom_y = 1.2


    self.opacity = 255
    @timer = (Graphics.frame_rate * seconds).to_i
  end

  def update
    return if @timer <= 0
    @timer -= 1
    if @timer < 30
      self.opacity = (@timer / 30.0) * 255
    end
    dispose_bitmap if @timer <= 0
  end

  def dispose_bitmap
    @animbitmap = nil
    self.bitmap = nil
  end
end

# ==========================================
# Controlador
# ==========================================
module SWM_SpeedToggle_Controller
  @last_state = :normal

  def self.update
    SWM_GlobalPopup.init
    current_fps = Graphics.frame_rate
    current_state = current_fps > 40 ? :fast : :normal

    if current_state != @last_state
      popup = SWM_GlobalPopup.speed_popup
      if current_state == :fast
        popup.show_popup(SWM_GlobalPopup.speed_fast)
      else
        popup.show_popup(SWM_GlobalPopup.speed_normal)
      end
      @last_state = current_state
    end

    SWM_GlobalPopup.speed_popup.update
  end
end

# ==========================================
# Integración con Graphics
# ==========================================
module Graphics
  class << self
    alias swm_speedtoggle_update update
    def update
      swm_speedtoggle_update
      SWM_SpeedToggle_Controller.update
    end
  end
end