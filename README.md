# Perfect Makeover Fashion ASMR — Godot 2D UI/UX Foundation

## Project status
This ZIP contains the first-stage 2D UI/UX prototype and project structure.
**Level 1 gameplay is not implemented yet**, by design. The next stage is to build
Hair Wash & Style as the first playable level and test it.

## Requirements
- Godot 4.x (recommended: current stable Godot 4 release)
- Android export template only when you are ready to build an APK

## Open the project
1. Extract this ZIP.
2. Open Godot Project Manager.
3. Choose **Import** and select `project.godot` from this folder.
4. Open the project and press F6/F5 (or the Play button).

## Screens included
- Splash / loading
- Main menu
- World 1 map
- Level selection
- Level 1 mission brief
- Shop preview
- Daily rewards preview
- Settings toggles
- Level-complete visual preview

## Controls
All navigation uses large touch-friendly buttons. The prototype is designed around a
720 × 1280 portrait viewport and Godot's `canvas_items` stretch mode.

## Important limits
- No playable makeover tools or character interaction yet.
- No ads, analytics, online services, purchases, cloud saves, or real reward economy.
- The shop and daily reward are UI previews only.
- The character/illustration artwork is represented with emoji placeholders in this
  first code prototype. Replace these with original 2D art assets before release.
- Android APK export and real-device testing have not been performed.

## Next development stage
Implement only Level 1:
1. Character portrait and messy-hair state.
2. Tool selection: remove debris, shampoo, rinse, hair mask, dryer, comb.
3. Touch/mouse drag interactions and progress validation.
4. Before/after transformation and star result.
5. Test the level in Godot and on an Android device.
