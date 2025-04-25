sequence = [];          // Array to store cutscene actions
current_step = 0;       // Current step in the sequence
is_active = false;      // Is the cutscene active?
wait_time = 0;          // Timer for wait actions
player_ref = noone;     // Reference to player object
trigger_obj = noone;    // Reference to the triggering object

global.cutscene_active = false;

dialog_created = false;
dialog_was_shown = false;