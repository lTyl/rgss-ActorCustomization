#===============================================================================
# Actor Customization V.6.00    ----      RMXP Version
#===============================================================================
#-------------------------------------------------------------------------------
# Written by Synthesize
# January 21, 2006
# Script Version 6.0.1
#===============================================================================
#    * This script will not work with RMVX. A VX version is in the works. *
#===============================================================================
module ActorCustomization
  #-----------------------------------------------------------------------------
  # System Settings
  # System settings are settings you should review before trying the script.
  # Each option has its own comments, and should be straightforward
  #-----------------------------------------------------------------------------
  Points_gained_at_levelup = 5   # Points gained at level-up (0 = Disable)
  Draw_map_as_background = false   # Draw the Background as the map? False = Draw Picture::Name)
  Picture_name = 'sky'   # The picture to draw as a background ('' for Black)
  Error_sound = '057-Wrong01'   # The sound to play if there is an error
  Use_class_id = false   # Advance characters based on the class ID
  Call_after_battle = false   # Automatically call Scene_AC at level-up
  Draw_face = false   # Draw the actors face?
  Use_help_window = true   # Use the help window?
  #-----------------------------------------------------------------------------
  # Maximum Values
  # Set these values if you are using a Maximum Statistics script (Go over the
  # stat limits). If not, leave these values as is.
  #-----------------------------------------------------------------------------
  Max_hp = 9999
  Max_sp = 9999
  Max_str = 999
  Max_dex = 999
  Max_agi = 999
  Max_int = 999
  #-----------------------------------------------------------------------------
  # Point Options
  # These are all new settings. They directly control point options and allow
  # you the option of turning ON/OFF features and customizing how many points
  # are needed to upgrade one stat.
  #-----------------------------------------------------------------------------
  Draw_point_in_menu = true   # Draw the amount of points on MenuStatus?
  Draw_levelup_notice_in_menu = true   # Draw levelup notice on MenuStatus?
  Point_name = "Upgrade points:"   # Point name
  Levelup_text = "(LVLUP)"    # Level Up text
  Raise_hp_with_strength = false   # HP raises as Strength raises
  Amount_to_raise = 0.15     # As a decimal
  Raise_sp_with_intelligence = false   # SP raises as Intelligence raises
  Amount_to_raise2 = 0.15    # As a decimal
  Remove_points = true   # Allow the player to remove used points
  Points_needed = [1, 1, 1, 1, 1, 1]   # The amount of points needed to upgrade
  # Health, SP, STR, DEX, AGI, INT respectively. 
  #-----------------------------------------------------------------------------
  # Statistical Growth Rate
  # This section allows you to customize how many numerical stats an attribute
  # rises based on the Actor.id or the Class_id.
  #-----------------------------------------------------------------------------
  # Format = {Actor.id (or class_id) => Amount to raise}
  Actor_HP = {1 => 5, 2 => 5}
  # The default value. If a value is not specified, use the below.
  Actor_HP.default = 1
  # Format = {Actor.id (or class_id) => amount to raise)
  Actor_SP = {1 => 10, 2 => 3}
  Actor_SP.default = 1
  # Format = {Actor.id (or class_id) => amount to raise)
  Actor_STR = {1 => 7, 2 => 6}
  Actor_STR.default = 1
  # Format = {Actor.id (or class_id) => amount to raise)  
  Actor_DEX = {1 =>6, 2 => 2}
  Actor_DEX.default = 1
  # Format = {Actor.id (or class_id) => amount to raise)  
  Actor_AGI = {1 =>4, 2 => 1}
  Actor_AGI.default = 1  
  # Format = {Actor.id (or class_id) => amount to raise)
  Actor_INT = {1 => 3, 2 => 1}
  Actor_INT.default = 1
  #-----------------------------------------------------------------------------
  # Equipment Boost Settings
  # Another new feature. Equipment boosts 'boost' statistics while an accessory
  # is equipped that possess one of the system attributes defined in the
  # equipment_id array. The equipment_amount array tells the script how much
  # an individual (or many) stats are boosted.
  #-----------------------------------------------------------------------------
  # Use Equipment boosts?
  Use_equipment_boosts = true
  # Format = {System_attribute => Amount to boost}
  Equipment_amount = {17 => 5, 18 => 3, 19 => 6, 20 => 7, 21 => 8, 22 => 9}
  # The default Value. Should be 0 for best effect.
  Equipment_amount.default = 0
  # The system attributes.
  Equipment_id = [17, 18, 19, 20, 21, 22]
  # Equipment_id = [HP Boost, SP Boost, STR Boost, DEX Boost, AGI Boost,
  # INT Boost]
  #-----------------------------------------------------------------------------
  # Skin Settings
  # Another new section. This area allows you to adjust the placement of the 
  # windows without having to go and dig around in the script. It should be 
  # useful for beginners who want to make their own layout with the script, but
  # don't want to go and try to find the values to do it.
  #-----------------------------------------------------------------------------
  Actor_window_horizontal = 0   # Adjust the Actor window ( -# =left, +# =right)
  Actor_window_vertical = 0   # Adjust the Actor Window ( -# =up, +# =down)
  Actor_window_opacity = 250   # The opacity of the window
  Actor_window_width = 275    # The width of the Actor window
  Actor_window_height = 85   # The height of the actor window
  #-----------------------------------------------------------------------------
  Main_command_horizontal = 0   # Adjust the Command window ( -# =left, +# =right)
  Main_command_vertical = 0   # Adjust the Command Window ( -# =up, +# =down)
  Main_command_opacity = 250   # Adjsut the opacity
  Main_command_width = 275   # The width of the main command window
  #-----------------------------------------------------------------------------
  Main_status_horizontal = 0   # Adjust the Actor Status window
  Main_status_vertical = 0    # Adjust the main-status window
  Main_status_opacity = 250   # Adjust the Main_Status opacity
  Main_status_width = 329    # The width of the Main Status
  Main_status_height = 305   # The height of the Main Status
  #-----------------------------------------------------------------------------
  Main_confirm_horizontal = 0   # Adjust the confirm window
  Main_confirm_vertical = 0    # Adjust the confirm window
  Main_confirm_opacity = 250   # Adjust the opacity
  #-----------------------------------------------------------------------------
  Main_help_horizontal = 0   # Adjust the help window
  Main_help_vertical = 0   # Adjust the help window
  Main_help_opacity = 250   # Adjust the opacity
  Main_help_width = 500   # The Confirm window width
  Main_help_height = 200   # The confirm window height
end
#===============================================================================
# What else is new?
#===============================================================================
=begin
  New in ACV6 is an internal class called Data_Points that makes the management
  of points significantly easier with Call Script commands. Currently, you can
  use the following syntaxes in a call script command. More will be added at a 
  later time.
  
  $data_points.
    add(amount, member)        Add the 'amount' of upgrade points to 'member'
    remove(amount, member)   Remove the 'amount' of upgrade points from 'member'
    view(member)           Return 'member' upgrade_points
    checksum(amount, member)  Check if 'member' points are within 'amount' range
    add_maxhp(amount, member)  Add max_hp 'amount' to 'member'
    add_hp(amount, member)   Add hp 'amount' to 'member'
    add_sp(amount, member)   Add sp 'amount' to 'member'
    add_maxsp(amount, member)  Add maxsp 'amount' to 'member'
    add_str(amount, member)    Add str 'amount' to 'member'
    add_dex(amount, member)    Add dex 'amount' to 'member'
    add_agi(amount, member)    Add agi 'amount' to 'member'
    add_int(amount, member)    Add int 'amount' to 'member'
    restore(member)          Fully heal 'member'
    
#===============================================================================
# My goal when I decided to make this script:
#===============================================================================
  My goal for this script was to make a powerful custom level up procedure
  but make everything user friendly and allow those without technical/rgss
  history to customize the script to their liking while utilizing the full 
  capabilities of this script.

#===============================================================================
# This script is compatible with the following battle systems:
#===============================================================================
- UCoders NeoABS
- Blizzard ABS
- XRXS Zoom Battle System
- MrMo ABS and SDK 2.2
- Caldaron's ABS
- Prexus' ABS
- The RTAB
- May work with others. The above is what I tested with.
=end
#-------------------------------------------------------------------------------
#                             ActorCustomization:: Main
# This handles all window calls, math and everything else related to the script
# in general. Editing is not advised.
#-------------------------------------------------------------------------------
class Scene_AC
  #-----------------------------------------------------------------------------
  # Initialize variables
  #-----------------------------------------------------------------------------
  def start(actor_index)
    @actor_index = actor_index
    @actor = $game_party.actors[@actor_index]
    if ActorCustomization::Use_class_id == false
      @hp = ActorCustomization::Actor_HP[@actor.id]
      @sp = ActorCustomization::Actor_SP[@actor.id]
      @str = ActorCustomization::Actor_STR[@actor.id]
      @dex = ActorCustomization::Actor_DEX[@actor.id]
      @agi = ActorCustomization::Actor_AGI[@actor.id]
      @int = ActorCustomization::Actor_INT[@actor.id]
    else
      @hp = ActorCustomization::Actor_HP[@actor.class_id]
      @sp = ActorCustomization::Actor_SP[@actor.class_id]
      @str = ActorCustomization::Actor_STR[@actor.class_id]
      @dex = ActorCustomization::Actor_DEX[@actor.class_id]
      @agi = ActorCustomization::Actor_AGI[@actor.class_id]
      @int = ActorCustomization::Actor_INT[@actor.class_id]
      return
    end
    unless $data_armors[@actor.armor4_id]== nil and ActorCustomization::Use_equipment_boosts == true
      @hp += ActorCustomization::Equipment_amount[ActorCustomization::Equipment_id[0]]
      @sp += ActorCustomization::Equipment_amount[ActorCustomization::Equipment_id[1]]
      @str += ActorCustomization::Equipment_amount[ActorCustomization::Equipment_id[2]]
      @dex += ActorCustomization::Equipment_amount[ActorCustomization::Equipment_id[3]]
      @agi += ActorCustomization::Equipment_amount[ActorCustomization::Equipment_id[4]]
      @int += ActorCustomization::Equipment_amount[ActorCustomization::Equipment_id[5]]
    end
    @hp_spent = 0
    @sp_spent = 0
    @str_spent = 0
    @dex_spent = 0
    @agi_spent = 0
    @int_spent = 0
  end
  #-----------------------------------------------------------------------------
  # Main:: Calls all of the windows
  #-----------------------------------------------------------------------------
  def main
    start(0)
    main_spriteset
    main_actor
    main_command
    main_status
    main_confirm
    main_help
    @main_command.active = false
    Graphics.transition
    loop do
      Graphics.update
      Input.update
      update
      if $scene != self
        break
      end
    end
    dispose_windows
  end
  #-----------------------------------------------------------------------------
  # Main_Spriteset:: Calls the background
  #-----------------------------------------------------------------------------
  def main_spriteset
    if ActorCustomization::Draw_map_as_background == true
      @background = Spriteset_Map.new
    else
      @background = Sprite.new
      @background.bitmap = RPG::Cache.picture(ActorCustomization::Picture_name)
    end
  end
  #-----------------------------------------------------------------------------
  # Main_Confirm:: Confirm Changes?
  #-----------------------------------------------------------------------------
  def main_confirm
    c1 = "Yes"
    c2 = "No"
    @main_confirm_window = Window_Command.new(100, [c1, c2])
    @main_confirm_window.x = 320 + ActorCustomization::Main_confirm_horizontal
    @main_confirm_window.y = 150 + ActorCustomization::Main_confirm_vertical
    @main_confirm_window.opacity = ActorCustomization::Main_confirm_opacity
    @main_confirm_window.active = false
    @main_confirm_window.visible = false
    @main_confirm_window.z = 9999
  end
  #-----------------------------------------------------------------------------
  # Main_Status:: Creates the main status window
  #-----------------------------------------------------------------------------
  def main_status
    @status_window = Window_AC_Status.new(@actor)
    @status_window.x = 18 + ActorCustomization::Main_status_horizontal
    @status_window.y = 56 + ActorCustomization::Main_status_vertical
    @status_window.opacity = ActorCustomization::Main_status_opacity
  end
  #-----------------------------------------------------------------------------
  # Main_Actor
  #-----------------------------------------------------------------------------
  def main_actor
    @main_actor_window = Window_AC_Actor.new
    @main_actor_window.x = 344 + ActorCustomization::Actor_window_horizontal
    @main_actor_window.y = 277 + ActorCustomization::Actor_window_vertical
    @main_actor_window.opacity = ActorCustomization::Actor_window_opacity
    @main_actor_window.active = true
    @main_actor_window.z = 9998
  end
  #-----------------------------------------------------------------------------
  # Main_Help:: The Help Window
  #-----------------------------------------------------------------------------
  def main_help
    @main_help = Window_AC_Help.new
    @main_help.x = 75 + ActorCustomization::Main_help_horizontal
    @main_help.y = 150 + ActorCustomization::Main_help_vertical
    @main_help.opacity = ActorCustomization::Main_help_opacity
    @main_help.visible = false
    @main_help.active = false
    @main_help.z = 10000
  end
  #-----------------------------------------------------------------------------
  # Main_Command:: This handles all progression
  #-----------------------------------------------------------------------------
  def main_command
    s1 = "<<  Modify #{$data_system.words.hp} by #{@hp}  >>"
    s2 = "<<  Modify #{$data_system.words.sp} by #{@sp}  >>"
    s3 = "<<  Modify #{$data_system.words.str} by #{@str} >>"
    s4 = "<<  Modify #{$data_system.words.dex} by #{@dex} >>"
    s5 = "<<  Modify #{$data_system.words.agi} by #{@agi} >>"
    s6 = "<<  Modify #{$data_system.words.int} by #{@int} >>"
    @main_command = Window_Command.new(ActorCustomization::Main_command_width, [s1, s2, s3, s4, s5, s6])
    @main_command.x = 343 + ActorCustomization::Main_command_horizontal
    @main_command.y = 56 + ActorCustomization::Main_command_vertical
    @main_command.opacity = ActorCustomization::Main_command_opacity
  end
  #-----------------------------------------------------------------------------
  # Dispose_Windows:: Clears all of the sprites that AC uses
  #-----------------------------------------------------------------------------
  def dispose_windows
    @background.dispose
    @main_actor_window.dispose
    @status_window.clear_face if ActorCustomization::Draw_face == true
    @status_window.dispose
    @main_command.dispose
    @main_confirm_window.dispose
    @main_help.dispose
  end
  #-----------------------------------------------------------------------------
  # Call_refresh:: Refreshes the Screen
  #-----------------------------------------------------------------------------
  def call_refresh(value)
    @status_window.refresh(@actor)
    if value == 1
      @main_command.dispose
      main_command
    end
  end
  #-----------------------------------------------------------------------------
  # Update:: Updates Actor Customization
  #-----------------------------------------------------------------------------
  def update
    @main_actor_window.update
    if @main_actor_window.active
      update_actor
      return
    end
    if @main_command.active
      update_commands
      return
    end
    if @main_confirm_window.active
      update_confirm
      return
    end
    if @main_help.active
      update_help
      return
    end
  end
  #-----------------------------------------------------------------------------
  # Update_Actor:: Updates the actor screen
  #-----------------------------------------------------------------------------
  def update_actor
    total_point_spent = (@hp_spent + @sp_spent + @str_spent + @dex_spent + @agi_spent + @int_spent)
    if Input.trigger?(Input::B)
      if total_point_spent == 0
        $game_system.se_play($data_system.cancel_se)
        $scene = Scene_Map.new
      else
        @main_confirm_window.active = true
        @main_confirm_window.visible = true
        @main_actor_window.active = false
      end
      return
    end
    if Input.trigger?(Input::C)
      if total_point_spent == 0
        $game_system.se_play($data_system.decision_se)
        @actor_index = @main_actor_window.index
        @actor = $game_party.actors[@actor_index]
        @main_command.active = true
        @main_actor_window.active = false
        start(@actor_index)
        call_refresh(1)
      else
        @main_confirm_window.active = true
        @main_confirm_window.visible = true
        @main_actor_window.active = false
      return
      end
    end
  end
  #-----------------------------------------------------------------------------
  # Update_Commands:: Updates the Commands
  #-----------------------------------------------------------------------------
  def update_commands
    @main_command.update
    if Input.trigger?(Input::B)
      $game_system.se_play($data_system.cancel_se)
      @main_command.active = false
      @main_actor_window.active = true
      return
    end
    if Input.trigger?(Input::C) && ActorCustomization::Use_help_window == true
      @main_command.active = false
      @main_help.active = true
      @main_help.visible = true
      return
    end
    if Input.trigger?(Input::LEFT)
      decrease_points if ActorCustomization::Remove_points == true
      return
    end
    if Input.trigger?(Input::RIGHT)
      increase_points
      return
    end
  end
  #-----------------------------------------------------------------------------
  # Update_Confirm:: This asks for confirmation.
  #-----------------------------------------------------------------------------
  def update_confirm
    @main_confirm_window.update
    if Input.trigger?(Input::C)
      case @main_confirm_window.index
      when 0 # Yes
        @hp_spent = 0
        @sp_spent = 0
        @str_spent = 0
        @dex_spent = 0
        @agi_spent = 0
        @int_spent = 0
        $game_system.se_play($data_system.decision_se)
        @actor_index = @main_actor_window.index
        @actor = $game_party.actors[@actor_index]
        @main_command.active = true
        @main_actor_window.active = false
        start(@actor_index)
        call_refresh(1)
        @main_confirm_window.active = false
        @main_confirm_window.visible = false
      when 1 # No
        $game_system.se_play($data_system.cancel_se)
        @main_confirm_window.active = false
        @main_confirm_window.visible = false
        @main_command.active = true
      end
    end
  end
  #-----------------------------------------------------------------------------
  # Update Help:: This is the help window
  #-----------------------------------------------------------------------------
  def update_help
    if Input.trigger?(Input::C)
      @main_help.active = false
      @main_help.visible = false
      @main_command.active = true
    end
  end
  #-----------------------------------------------------------------------------
  # Increase Points:: This adds/removes points
  #-----------------------------------------------------------------------------
  def increase_points
    case @main_command.index
    when 0
      if @actor.upgrade_points >= ActorCustomization::Points_needed[0] && @actor.maxhp <= ActorCustomization::Max_hp
        $game_system.se_play($data_system.decision_se)
        @actor.upgrade_points -= ActorCustomization::Points_needed[0]
        @actor.hp += @hp
        @actor.maxhp += @hp
        @hp_spent += 1
        @actor.used_hp_points += 1
        call_refresh(0)
      else
        call_sound
      end
    when 1
      if @actor.upgrade_points >= ActorCustomization::Points_needed[1] && @actor.maxsp <= ActorCustomization::Max_sp
        $game_system.se_play($data_system.decision_se)
        @actor.upgrade_points -= ActorCustomization::Points_needed[1]
        @actor.sp += @sp
        @actor.maxsp += @sp
        @sp_spent += 1
        @actor.used_sp_points += 1
        call_refresh(0)
      else
        call_sound
      end
    when 2
      if @actor.upgrade_points >= ActorCustomization::Points_needed[2] && @actor.str <= ActorCustomization::Max_str
        $game_system.se_play($data_system.decision_se)
        @actor.upgrade_points -= ActorCustomization::Points_needed[2]
        @actor.str += @str
        @actor.hp += (@actor.str * ActorCustomization::Amount_to_raise) if ActorCustomization::Raise_hp_with_strength == true
        @str_spent += 1
        @actor.used_str_points += 1
        call_refresh(0)
      else
        call_sound
      end
    when 3
      if @actor.upgrade_points >= ActorCustomization::Points_needed[3] && @actor.dex <= ActorCustomization::Max_dex
        $game_system.se_play($data_system.decision_se)
        @actor.upgrade_points -= ActorCustomization::Points_needed[3]
        @actor.dex += @dex
        @dex_spent += 1
        @actor.used_dex_points += 1
        call_refresh(0)
      else
        call_sound
      end
    when 4
      if @actor.upgrade_points >= ActorCustomization::Points_needed[4] && @actor.agi <= ActorCustomization::Max_agi
        $game_system.se_play($data_system.decision_se)
        @actor.upgrade_points -= ActorCustomization::Points_needed[4]
        @actor.agi += @agi
        @agi_spent += 1
        @actor.used_agi_points += 1
        call_refresh(0)
      else
        call_sound
      end
    when 5
      if @actor.upgrade_points >= ActorCustomization::Points_needed[5] && @actor.int <= ActorCustomization::Max_int
        $game_system.se_play($data_system.decision_se)
        @actor.upgrade_points -= ActorCustomization::Points_needed[5] 
        @actor.int += @int
        @actor.maxsp += (@actor.int * ActorCustomization::Amount_to_raise2) if ActorCustomization::Raise_sp_with_intelligence == true
        @actor.sp += (@actor.int * ActorCustomization::Amount_to_raise2) if ActorCustomization::Raise_sp_with_intelligence == true
        @int_spent += 1
        @actor.used_int_points += 1
        call_refresh(0)
      else
        call_sound
      end
    end
  end
  #-----------------------------------------------------------------------------
  # Decrease Points:: This is where points are removed
  #-----------------------------------------------------------------------------
  def decrease_points
    case @main_command.index
    when 0
      if @actor.used_hp_points != 0
        $game_system.se_play($data_system.decision_se)
        @actor.upgrade_points += ActorCustomization::Points_needed[0]
        @actor.hp -= @hp
        @actor.maxhp -= @hp
        @hp_spent -= 1
        @actor.used_hp_points -= 1
        call_refresh(0)
      else
        call_sound
      end
    when 1
      if @actor.used_sp_points != 0
        $game_system.se_play($data_system.decision_se)
        @actor.upgrade_points += ActorCustomization::Points_needed[1]
        @actor.sp -= @sp
        @actor.maxsp -= @sp
        @sp_spent -= 1
        @actor.used_sp_points -= 1
        call_refresh(0)
      else
        call_sound
      end
    when 2
      if @actor.used_str_points != 0
        $game_system.se_play($data_system.decision_se)
        @actor.upgrade_points += ActorCustomization::Points_needed[2]
        @actor.hp -= (@actor.str * ActorCustomization::Amount_to_raise) if ActorCustomization::Raise_hp_with_strength == true
        @actor.str -= @str
        @str_spent -= 1
        @actor.used_str_points -= 1
        call_refresh(0)
      else
        call_sound
      end
    when 3
      if @actor.used_dex_points != 0
        $game_system.se_play($data_system.decision_se)
        @actor.upgrade_points += ActorCustomization::Points_needed[3]
        @actor.dex -= @dex
        @dex_spent -= 1
        @actor.used_dex_points -= 1
        call_refresh(0)
      else
        call_sound
      end
    when 4
      if @actor.used_agi_points != 0
        $game_system.se_play($data_system.decision_se)
        @actor.upgrade_points += ActorCustomization::Points_needed[4]
        @actor.agi -= @agi
        @agi_spent -= 1
        @actor.used_agi_points -= 1
        call_refresh(0)
      else
        call_sound
      end
    when 5
      if @actor.used_int_points != 0
        $game_system.se_play($data_system.decision_se)
        @actor.upgrade_points += ActorCustomization::Points_needed[5]
        @actor.sp -= (@actor.int * ActorCustomization::Amount_to_raise2) if ActorCustomization::Raise_sp_with_intelligence == true
        @actor.maxsp -= (@actor.int * ActorCustomization::Amount_to_raise2) if ActorCustomization::Raise_sp_with_intelligence == true
        @actor.int -= @int
        @int_spent -= 1
        @actor.used_int_points -= 1
        call_refresh(0)
      else
        call_sound
      end
    end
  end
  #-----------------------------------------------------------------------------
  # Call Sound:: Play the error sound
  #-----------------------------------------------------------------------------
  def call_sound
    $game_system.se_play(RPG::AudioFile.new(ActorCustomization::Error_sound))
  end
end  
#-------------------------------------------------------------------------------
# End Main ActorCustomization Section.
# Below you will find the method used to add points at level-up
# as well as all of the windows that are needed.
#-------------------------------------------------------------------------------
# Game_Actor:: Alias methods
#    Create points for actors and add points at level_up
#-------------------------------------------------------------------------------
class Game_Actor < Game_Battler
  attr_accessor :upgrade_points
  attr_accessor :used_hp_points
  attr_accessor :used_sp_points
  attr_accessor :used_str_points
  attr_accessor :used_dex_points
  attr_accessor :used_agi_points
  attr_accessor :used_int_points
  # Aliases
  alias synthesize_ac_setup setup
  alias synthesize_ac_battle exp=
  #-----------------------------------------------------------------------------
  # Setup
  #-----------------------------------------------------------------------------
  def setup(actor_id)
    synthesize_ac_setup(actor_id)
    @upgrade_points = 0
    @used_hp_points = 0
    @used_sp_points = 0
    @used_str_points = 0
    @used_dex_points = 0
    @used_agi_points = 0
    @used_int_points = 0
  end
  #-----------------------------------------------------------------------------
  # Add Points 
  #-----------------------------------------------------------------------------
  def exp=(exp)
    @exp = [[exp, 9999999].min, 0].max
    # Level up
    while @exp >= @exp_list[@level+1] and @exp_list[@level+1] > 0
      @level += 1
      @upgrade_points += ActorCustomization::Points_gained_at_levelup
      # Learn skill
      for j in $data_classes[@class_id].learnings
      if j.level == @level
          learn_skill(j.skill_id)
        end
      end
    end
    synthesize_ac_battle(exp)
    $scene = Scene_AC.new if ActorCustomization::Call_after_battle == true
  end
end
#-------------------------------------------------------------------------------
# Begin AC windows
#      Here you will find all of the contents that make up AC.
#-------------------------------------------------------------------------------
# Actor Window
#-------------------------------------------------------------------------------
class Window_AC_Actor < Window_Selectable
  #-----------------------------------------------------------------------------
  # Initialize
  #-----------------------------------------------------------------------------
  def initialize
    super(0, 0, ActorCustomization::Actor_window_width, ActorCustomization::Actor_window_height)
    self.contents = Bitmap.new(width - 32, height - 32)
    self.active = false
    self.index = -1
    @item_max = $game_party.actors.size
    @column_max = 2
    draw_actor
    self.active = false
    self.index = 0
  end
  #-----------------------------------------------------------------------------
  # Draw_Actor
  #-----------------------------------------------------------------------------
  def draw_actor
    for i in 0...$game_party.actors.size
      actor = $game_party.actors[i]
      self.contents.draw_text(65, 50, 100, 100, $game_party.item_number(1).to_s)
      x = i * 65
      y = 50
      draw_actor_graphic(actor, x + 20, y)
    end
  end
  #--------------------------------------------------------------------------
  # * Cursor Rectangle Update
  #--------------------------------------------------------------------------
  def update_cursor_rect
    self.cursor_rect.set(0 + index * 65, 0, 40, 54)
  end
end 
#-------------------------------------------------------------------------------
# Window_AC_Status
#-------------------------------------------------------------------------------
class Window_AC_Status < Window_Base
  #-----------------------------------------------------------------------------
  # Initialize
  #-----------------------------------------------------------------------------
  def initialize(actor)
    super(32, 32, ActorCustomization::Main_status_width, ActorCustomization::Main_status_height)
    self.contents = Bitmap.new(width - 32, height- 32)
    refresh(actor)
  end
  #-----------------------------------------------------------------------------
  # Refresh
  #-----------------------------------------------------------------------------
  def refresh(actor)
    self.contents.clear
    draw_actor_graphic(actor, 35, 50) if ActorCustomization::Draw_face == false
    draw_actor_face(actor, 35, 50) if ActorCustomization::Draw_face == true
    draw_actor_class(actor, 85, 20)
    draw_actor_name(actor, 80, 0)
    draw_actor_level(actor, 176, 0)
    draw_actor_hp(actor, 4, 68, 172)
    self.contents.font.color = system_color
    self.contents.draw_text(165, 12, 100, 100, "Points used:")
    self.contents.draw_text(165, 60, 100, 50, "#{$data_system.words.hp}:   #{actor.used_hp_points}", 2)
    self.contents.draw_text(165, 84, 100, 50, "#{$data_system.words.sp}:    #{actor.used_sp_points}", 2)
    self.contents.draw_text(165, 120, 100, 50, "#{$data_system.words.str}:    #{actor.used_str_points}", 2)
    self.contents.draw_text(165, 144, 100, 50, "#{$data_system.words.dex}:    #{actor.used_dex_points}", 2)
    self.contents.draw_text(165, 168, 100, 50, "#{$data_system.words.agi}:    #{actor.used_agi_points}", 2)
    self.contents.draw_text(165, 192, 100, 50, "#{$data_system.words.int}:    #{actor.used_int_points}", 2)
    draw_actor_sp(actor,4, 90, 172)
    draw_actor_parameter(actor, 4, 132, 3)
    draw_actor_parameter(actor, 4, 156, 4)
    draw_actor_parameter(actor, 4, 180, 5)
    draw_actor_parameter(actor, 4, 204, 6)
    self.contents.font.color = system_color
    self.contents.draw_text(175, 205, 100, 100, "Points:")
    self.contents.font.color = normal_color
    self.contents.draw_text(165, 205, 100, 100, actor.upgrade_points.to_s, 2)
  end
  #-----------------------------------------------------------------------------
  # Draw_Face
  #-----------------------------------------------------------------------------
  def draw_actor_face(actor, x, y)
    @face = Sprite.new
    @face.bitmap = RPG::Cache.picture(actor.character_name + "_face")
    @face.x = x
    @face.y = y
    @face.z = 9999
  end
  #-----------------------------------------------------------------------------
  # Clear Face
  #-----------------------------------------------------------------------------
  def clear_face
    @face.dispose
  end
end
#-------------------------------------------------------------------------------
# Window_Main_Help::  This draws the help contents
#-------------------------------------------------------------------------------
class Window_AC_Help < Window_Base
  def initialize
    super(0, 0, ActorCustomization::Main_help_width, ActorCustomization::Main_help_height)
    self.contents = Bitmap.new(width - 32, height - 32)
    refresh
  end
  def refresh
    self.contents.draw_text(0, 0, 350, 30, "1.) Select the character to edit", 1)
    self.contents.draw_text(0, 24, 350, 30, "2.) Use the arrow keys to add/remove points", 1)
    self.contents.draw_text(0, 48, 400, 30, "3.) The characters stats will increase depending on the stat chosen.", 1)
    self.contents.draw_text(0, 72, 450, 30, "4.) You can see how many points are in each stat with the display window.", 1)
    self.contents.draw_text(0, 96, 450, 30, "5.) Always use up all of your stat points.", 1)
    self.contents.draw_text(0, 120, 450, 30, "6.) Once complete, press the cancel key to return to your adventure.", 1)
    self.contents.draw_text(0, 144, 450, 30, "Press the ENTER key to close this window.", 2)
  end
end
#-------------------------------------------------------------------------------
# MenuStatus:: Draw points/level-up display in the menu
#    Note: This feature may/may not work with a CMS
#-------------------------------------------------------------------------------
class Window_MenuStatus < Window_Selectable
  alias synthesize_menu_refresh refresh
  def refresh
    synthesize_menu_refresh
    for i in 0...$game_party.actors.size
      x = 64
      y = i * 116
      actor = $game_party.actors[i]
      if actor.upgrade_points != 0 && ActorCustomization::Draw_levelup_notice_in_menu == true
        self.contents.font.color = system_color
        w = contents.text_size(actor.name).width
        self.contents.draw_text(x + w, y, 100, 30, "#{ActorCustomization::Levelup_text}")
      end
      self.contents.font.color = system_color
      self.contents.draw_text(x + 225, y, 100, 30, "#{ActorCustomization::Point_name}") if ActorCustomization::Draw_point_in_menu == true
      self.contents.font.color = normal_color
      self.contents.draw_text(x + 346, y, 50, 30, "#{actor.upgrade_points}") if ActorCustomization::Draw_point_in_menu == true
    end
  end
end
#-------------------------------------------------------------------------------
# Data_Points:: This class is designed to make it easier to add/remove points
# with a call script command.
#-------------------------------------------------------------------------------
class Data_Points
  #-----------------------------------------------------------------------------
  # Add points to target member
  #-----------------------------------------------------------------------------
  def add(amount, member)
    $game_party.actors[member].upgrade_points += amount
  end
  #-----------------------------------------------------------------------------
  # Remove target member points
  #-----------------------------------------------------------------------------
  def remove(amount, member)
    add(-amount, member)
  end
  #-----------------------------------------------------------------------------
  # Return target member points
  #-----------------------------------------------------------------------------
  def view(member)
    return $game_party.actors[member].upgrade_points
  end
  #-----------------------------------------------------------------------------
  # Check if member has X points. Return result
  #-----------------------------------------------------------------------------
  def checksum(amount, member)
    if $game_party.actors[member].upgrade_points >= amount
      return true
    else
      return false
    end
  end
  #-----------------------------------------------------------------------------
  # Add max HP to target member
  #-----------------------------------------------------------------------------
  def add_maxhp(amount, member)
    $game_party.actors[member].maxhp += amount
  end
  #-----------------------------------------------------------------------------
  # Add HP to target member
  #-----------------------------------------------------------------------------
  def add_hp(amount, member)
    $game_party.actors[member].hp += amount
  end
  #-----------------------------------------------------------------------------
  # Add MaxSP to target member
  #-----------------------------------------------------------------------------
  def add_maxsp(amount, member)
    $game_party.actors[member].maxsp += amount
  end
  #-----------------------------------------------------------------------------
  # Add SP to target member
  #-----------------------------------------------------------------------------
  def add_sp(amount, member)
    $game_party.actors[member].sp += amount
  end
  #-----------------------------------------------------------------------------
  # Add str to target member
  #-----------------------------------------------------------------------------
  def add_str(amount, member)
    $game_party.actors[member].str += amount
  end
  #-----------------------------------------------------------------------------
  # Add dex to target member
  #-----------------------------------------------------------------------------
  def add_dex(amount, member)
    $game_party.actors[member].dex += amount
  end
  #-----------------------------------------------------------------------------
  # Add Int to target member
  #-----------------------------------------------------------------------------
  def add_int(amount, member)
    $game_party.actors[member].int += amount
  end
  #-----------------------------------------------------------------------------
  # Restore Target members HP and SP
  #-----------------------------------------------------------------------------
  def restore(member)
    $game_party.actors[member].hp = $game_party.actors[member].maxhp
    $game_party.actors[member].sp = $game_party.actors[member].maxsp
  end
end
#-------------------------------------------------------------------------------
# Command_New_Game:: Store Data_Points into a variable
#-------------------------------------------------------------------------------
class Scene_Title
  alias synthesize_commandnewgame_ac command_new_game
  def command_new_game
    synthesize_commandnewgame_ac
    $data_points = Data_Points.new
  end
end
#===============================================================================
#   * This script will not work with RMVX. A VX version is in the works. *
#===============================================================================
# Written by Synthesize
# Version 6.0.1
# January 21, 2008
#===============================================================================
# Actor Customization!   ----  RMXP Version
#===============================================================================