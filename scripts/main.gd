extends Control

# UI/UX foundation only. Level 1 gameplay is intentionally not implemented yet.
const BG := Color("#fff0f8")
const PINK := Color("#ed4caa")
const DEEP_PINK := Color("#a82c83")
const PURPLE := Color("#8050c9")
const LIGHT_PURPLE := Color("#eadcff")
const GOLD := Color("#ffc83d")
const INK := Color("#44244b")
const WHITE := Color("#ffffff")
const GREEN := Color("#43c86b")

var current_screen := ""
var sound_on := true
var music_on := true
var vibration_on := true
var coins := 1200
var gems := 50

func _ready() -> void:
    show_splash()

func _clear_screen() -> void:
    for child in get_children():
        child.queue_free()

func _style(fill: Color, border: Color = Color("#ffffff"), radius: int = 22) -> StyleBoxFlat:
    var box := StyleBoxFlat.new()
    box.bg_color = fill
    box.border_color = border
    box.set_border_width_all(3)
    box.set_corner_radius_all(radius)
    box.content_margin_left = 16
    box.content_margin_right = 16
    box.content_margin_top = 10
    box.content_margin_bottom = 10
    return box

func _label(parent: Control, text: String, size: int = 24, color: Color = INK, centered: bool = true) -> Label:
    var label := Label.new()
    label.text = text
    label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER if centered else HORIZONTAL_ALIGNMENT_LEFT
    label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
    label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
    label.add_theme_font_size_override("font_size", size)
    label.add_theme_color_override("font_color", color)
    label.custom_minimum_size = Vector2(0, max(36, size + 18))
    parent.add_child(label)
    return label

func _button(parent: Control, text: String, action: Callable, primary: bool = true) -> Button:
    var button := Button.new()
    button.text = text
    button.custom_minimum_size = Vector2(0, 58)
    button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    button.add_theme_font_size_override("font_size", 22)
    button.add_theme_color_override("font_color", WHITE if primary else DEEP_PINK)
    button.add_theme_color_override("font_hover_color", WHITE if primary else DEEP_PINK)
    button.add_theme_stylebox_override("normal", _style(PINK if primary else WHITE, GOLD if primary else LIGHT_PURPLE, 24))
    button.add_theme_stylebox_override("hover", _style(DEEP_PINK if primary else LIGHT_PURPLE, GOLD, 24))
    button.add_theme_stylebox_override("pressed", _style(PURPLE, GOLD, 24))
    button.add_theme_stylebox_override("focus", _style(PINK, GOLD, 24))
    button.pressed.connect(action)
    parent.add_child(button)
    return button

func _new_screen(title: String, subtitle: String = "") -> VBoxContainer:
    _clear_screen()
    var bg := ColorRect.new()
    bg.color = BG
    bg.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
    add_child(bg)

    var top := ColorRect.new()
    top.color = Color("#f9d7ed")
    top.position = Vector2(0, 0)
    top.size = Vector2(720, 180)
    top.set_anchors_and_offsets_preset(Control.PRESET_TOP_WIDE)
    top.offset_bottom = 180
    bg.add_child(top)

    var margin := MarginContainer.new()
    margin.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
    margin.add_theme_constant_override("margin_left", 26)
    margin.add_theme_constant_override("margin_right", 26)
    margin.add_theme_constant_override("margin_top", 30)
    margin.add_theme_constant_override("margin_bottom", 28)
    add_child(margin)

    var page := VBoxContainer.new()
    page.add_theme_constant_override("separation", 14)
    page.size_flags_vertical = Control.SIZE_EXPAND_FILL
    margin.add_child(page)

    _label(page, title, 34, DEEP_PINK)
    if subtitle != "":
        _label(page, subtitle, 18, INK)
    return page

func _spacer(parent: Control, amount: int = 1) -> void:
    var gap := Control.new()
    gap.custom_minimum_size.y = amount * 12
    gap.size_flags_vertical = Control.SIZE_EXPAND_FILL
    parent.add_child(gap)

func show_splash() -> void:
    current_screen = "splash"
    var page := _new_screen("✨ PERFECT MAKEOVER ✨", "FASHION ASMR")
    _spacer(page, 2)
    _label(page, "👑", 100, PINK)
    _label(page, "Beauty • Fashion • Relax", 23, PURPLE)
    _spacer(page, 2)
    var bar := ProgressBar.new()
    bar.min_value = 0
    bar.max_value = 100
    bar.value = 100
    bar.custom_minimum_size = Vector2(0, 24)
    page.add_child(bar)
    _label(page, "Loading your beauty studio…", 17, INK)
    _spacer(page, 2)
    await get_tree().create_timer(1.1).timeout
    if current_screen == "splash":
        show_home()

func _top_currency(parent: Control) -> void:
    var row := HBoxContainer.new()
    row.add_theme_constant_override("separation", 10)
    parent.add_child(row)
    var coins_label := _label(row, "🪙 %d" % coins, 18, INK)
    coins_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    var gems_label := _label(row, "💎 %d" % gems, 18, INK)
    gems_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
    _button(row, "⚙", show_settings, false)

func show_home() -> void:
    current_screen = "home"
    var page := _new_screen("PERFECT MAKEOVER", "Fashion ASMR • Beauty Studio")
    _top_currency(page)
    _spacer(page, 1)
    _label(page, "👸", 112, PINK)
    _label(page, "Your transformation journey starts here!", 21, INK)
    _spacer(page, 1)
    _button(page, "▶   PLAY", show_world_map, true)
    _button(page, "🎁   DAILY REWARDS", show_daily_rewards, false)
    _button(page, "🛍   BEAUTY SHOP", show_shop, false)
    _button(page, "⚙   SETTINGS", show_settings, false)
    _spacer(page)
    _label(page, "Made for relaxing makeover moments ♡", 15, PURPLE)

func show_world_map() -> void:
    current_screen = "world_map"
    var page := _new_screen("WORLD 1", "Beauty Studio • Choose your journey")
    _button(page, "←  HOME", show_home, false)
    _label(page, "🏰  BEAUTY STUDIO", 28, DEEP_PINK)
    _label(page, "A lovely salon full of new stories", 18, INK)
    _spacer(page)
    _button(page, "⭐  LEVEL 1  •  HAIR WASH & STYLE", show_level_select, true)
    _button(page, "🔒  LEVEL 2  •  MAKEUP MAKEOVER", _locked_level, false)
    _button(page, "🔒  LEVEL 3  •  WAXING & CARE", _locked_level, false)
    _button(page, "🔒  LEVEL 4  •  OUTFIT STYLING", _locked_level, false)
    _button(page, "🔒  LEVEL 5  •  DRESS CARE", _locked_level, false)
    _spacer(page)
    _label(page, "More worlds will be added in future updates.", 16, PURPLE)

func show_level_select() -> void:
    current_screen = "level_select"
    var page := _new_screen("WORLD 1 LEVELS", "Complete levels to unlock the next challenge")
    _button(page, "←  BACK TO MAP", show_world_map, false)
    _label(page, "⭐  1. HAIR WASH & STYLE", 24, DEEP_PINK)
    _label(page, "Difficulty: Easy     •     Reward: 100 coins", 17, INK)
    _label(page, "🔒  2. Makeup Makeover", 20, PURPLE)
    _label(page, "🔒  3. Waxing & Care", 20, PURPLE)
    _label(page, "🔒  4. Outfit Styling", 20, PURPLE)
    _label(page, "🔒  5. Dress Care (Steam)", 20, PURPLE)
    _spacer(page)
    _button(page, "VIEW LEVEL 1 DETAILS", show_level_info, true)
    _label(page, "Level 1 gameplay will be added in the next development stage.", 16, INK)

func show_level_info() -> void:
    current_screen = "level_info"
    var page := _new_screen("LEVEL 1", "Hair Wash & Style")
    _button(page, "←  BACK TO LEVELS", show_level_select, false)
    _label(page, "👩🏻‍🦱  ➜  💇🏻‍♀️", 66, PINK)
    _label(page, "YOUR MISSION", 24, DEEP_PINK)
    _label(page, "1. Remove leaves and tangles\\n2. Wash hair with shampoo\\n3. Apply a nourishing hair mask\\n4. Rinse, dry and style the hair\\n5. Reveal the final makeover!", 19, INK)
    _spacer(page)
    _button(page, "LEVEL 1 GAMEPLAY — NEXT STAGE", _gameplay_not_ready, true)
    _label(page, "This button is a planned entry point, not playable yet.", 15, PURPLE)

func _gameplay_not_ready() -> void:
    _notice("Level 1 gameplay is not included in this UI/UX build. It will be implemented and tested next.")

func _locked_level() -> void:
    _notice("This level is locked for now. Complete the earlier level in a future gameplay build.")

func show_shop() -> void:
    current_screen = "shop"
    var page := _new_screen("BEAUTY SHOP", "Use your coins to prepare for future makeovers")
    _button(page, "←  HOME", show_home, false)
    _label(page, "🪙  %d coins     💎  %d gems" % [coins, gems], 21, DEEP_PINK)
    _label(page, "🧴  Shampoo Pack       150 coins", 20)
    _label(page, "✨  Hair Care Kit       250 coins", 20)
    _label(page, "💖  Style Bundle        400 coins", 20)
    _spacer(page)
    _label(page, "Shop layout is ready. Purchases will be connected later.", 16, PURPLE)

func show_daily_rewards() -> void:
    current_screen = "daily_rewards"
    var page := _new_screen("DAILY REWARDS", "Come back every day for a little surprise")
    _button(page, "←  HOME", show_home, false)
    _label(page, "🎁", 82, PINK)
    _label(page, "DAY 1  •  100 COINS", 24, DEEP_PINK)
    _label(page, "A sparkling start to your makeover journey!", 18)
    _button(page, "COLLECT (PREVIEW)", _collect_reward, true)
    _label(page, "Daily streak and save system will be connected in a later stage.", 15, PURPLE)

func _collect_reward() -> void:
    coins += 100
    _notice("Preview reward collected! Your coin balance is now %d." % coins)

func show_settings() -> void:
    current_screen = "settings"
    var page := _new_screen("SETTINGS", "Make your studio feel comfortable")
    _button(page, "←  HOME", show_home, false)
    _button(page, "♪  MUSIC: %s" % ("ON" if music_on else "OFF"), _toggle_music, false)
    _button(page, "♫  SOUND: %s" % ("ON" if sound_on else "OFF"), _toggle_sound, false)
    _button(page, "📳  VIBRATION: %s" % ("ON" if vibration_on else "OFF"), _toggle_vibration, false)
    _spacer(page)
    _label(page, "Version 0.1 • UI/UX Prototype", 16, PURPLE)

func _toggle_music() -> void:
    music_on = not music_on
    show_settings()

func _toggle_sound() -> void:
    sound_on = not sound_on
    show_settings()

func _toggle_vibration() -> void:
    vibration_on = not vibration_on
    show_settings()

func show_level_complete_preview() -> void:
    current_screen = "level_complete_preview"
    var page := _new_screen("LEVEL COMPLETE!", "Transformation finished beautifully")
    _label(page, "👸  ✨  ⭐⭐⭐", 58, GOLD)
    _label(page, "+100 COINS", 28, DEEP_PINK)
    _button(page, "REPLAY", show_level_info, true)
    _button(page, "HOME", show_home, false)

func _notice(message: String) -> void:
    var dialog := AcceptDialog.new()
    dialog.dialog_text = message
    dialog.title = "Perfect Makeover"
    add_child(dialog)
    dialog.popup_centered(Vector2i(520, 220))
