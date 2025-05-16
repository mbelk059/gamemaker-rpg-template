if (current_message < 0 || current_message >= array_length(messages)) exit;
    
var _str = messages[current_message].msg;
// Track whether we just completed the message this frame
var just_completed = false;

// Text Unrolling Logic
if (current_char < string_length(_str))
{
    waiting_for_input = false;  // Still displaying text
    
    // If space is pressed, show the full message
    if (keyboard_check_pressed(input_key) && current_char > 0)
    {
        current_char = string_length(_str);
        draw_message = _str; // Set the full message immediately
        just_completed = true; // Mark that we just completed the message
        waiting_for_input = true;  // Now waiting for input to proceed
    }
    else
    {
        // Normal text scrolling
        current_char += char_speed;
        draw_message = string_copy(_str, 1, floor(current_char));
        
        // If we just finished displaying the text naturally
        if (current_char >= string_length(_str))
        {
            waiting_for_input = true;  // Now waiting for input to proceed
            just_completed = true; // Mark that we just completed the message
        }
    }
}
else
{
    waiting_for_input = true;  // Full message is displayed, waiting for input
}

// Only allow proceeding if the full message is displayed AND we didn't just complete it this frame
var can_proceed = waiting_for_input && !just_completed;

// Check if dialog_choices is a valid array before using it
if (is_array(dialog_choices) && array_length(dialog_choices) > 0 && waiting_for_input)
{
    if (keyboard_check_pressed(vk_up))
        selected_choice = max(0, selected_choice - 1);
    if (keyboard_check_pressed(vk_down))
        selected_choice = min(array_length(dialog_choices) - 1, selected_choice + 1);
    
    if (keyboard_check_pressed(input_key)) {
        var chosen_action = dialog_choices[selected_choice];
    
        // Special: Trigger cutscene if next is a known cutscene key
        if (is_struct(chosen_action) && variable_struct_exists(chosen_action, "next")) {
            var path = chosen_action.next;
        
            // START CUTSCENE INSTEAD
            if (path == "start_bench_cutscene") {
                // Create the cutscene controller and assign the cutscene
                var controller = instance_create_depth(0, 0, 0, obj_cutscene_controller);
                controller.player_ref = obj_player; // or retrieve however you refer to the player
                
                // IMPORTANT: Store original player visibility before changing it
                controller.player_visible_before = obj_player.visible;
                
                // Hide the player during cutscene
                obj_player.visible = false;
                
                // Disable player movement
                obj_player.can_move = false;
                
                // Set cutscene as active
                controller.is_active = true;
                
                // Set the bench as having played its cutscene
                with (obj_bench) {
                    cutscene_played = true;
                }
                
                // Updated sequence with fade effects
                controller.sequence = [
                    {type: "move_player", x: obj_player.x, y: obj_player.y - 16, speed: 1},
                    {type: "spawn_bunny_animation"},
                    {type: "wait_for_bunny_anim"},
                    {type: "fade_out", speed: 0.05, hold_time: 30},  // Fade to black
                    {type: "restore_player"},  // Restore player while screen is black
                    {type: "fade_in", speed: 0.05},  // Fade back in
                    {type: "end_cutscene"},
                    {type: "move_player", x: obj_player.x + 2, y: obj_player.y + 10, speed: 1}
                ];
                
                // Kill the dialog box now
                instance_destroy();
            }
            
            // DEFAULT DIALOG PATH LOADING
            else if (variable_global_exists(path)) {
                messages = variable_global_get(path);
                current_message = 0;
                current_char = 0;
                draw_message = "";
                waiting_for_input = false;
            } else {
                // Invalid path or nothing to do
                instance_destroy();
            }
        } else {
            // No next path provided, just close dialog
            instance_destroy();
        }
    
        dialog_choices = []; // Clear choices
    }
}    

// Move to Next Message (if no choices and can proceed)
else if (keyboard_check_pressed(input_key) && can_proceed)
{
    // Only proceed if we haven't reached the end of all messages
    if (current_message < array_length(messages) - 1)
    {
        current_message++;
        current_char = 0;
        draw_message = ""; // Reset the draw message
        waiting_for_input = false;  // Reset waiting status
        
        // Check if the new message has choices
        if (current_message < array_length(messages)) {
            var msg = messages[current_message];
            
            // Safe check for choices property
            if (is_struct(msg) && 
                variable_struct_exists(msg, "choices") && 
                is_array(msg.choices) && 
                array_length(msg.choices) > 0)
            {
                // Enable choice selection
                dialog_choices = msg.choices;
                selected_choice = 0; // Default choice
            }
        }
    }
    else
    {
        // We've reached the end of all messages
        instance_destroy();
    }
}