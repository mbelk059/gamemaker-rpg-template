if (current_message < 0) exit;
    
var _str = messages[current_message].msg;

// Track whether we just completed the message this frame
var just_completed = false;

// Text Unrolling Logic
if (current_char < string_length(_str))
{
    // If space is pressed, show the full message
    if (keyboard_check_pressed(input_key) && current_char > 0)
    {
        current_char = string_length(_str);
        draw_message = _str; // Set the full message immediately
        just_completed = true; // Mark that we just completed the message
    }
    else
    {
        // Normal text scrolling
        current_char += char_speed;
        draw_message = string_copy(_str, 1, floor(current_char));
    }
}    

// Only allow proceeding if the full message is displayed AND we didn't just complete it
var can_proceed = (current_char >= string_length(_str)) && !just_completed;

// Check if dialog_choices is a valid array before using it
if (is_array(dialog_choices) && array_length(dialog_choices) > 0 && can_proceed)
{
    if (keyboard_check_pressed(vk_up))
        selected_choice = max(0, selected_choice - 1);
    if (keyboard_check_pressed(vk_down))
        selected_choice = min(array_length(dialog_choices) - 1, selected_choice + 1);
    
    if (keyboard_check_pressed(input_key))
    {
        var chosen_action = dialog_choices[selected_choice].next;
        
        // Find and load the corresponding dialog path
        if (variable_global_exists(chosen_action)) {
            messages = variable_global_get(chosen_action);
            current_message = 0;
            current_char = 0;
            draw_message = ""; // Reset the draw message
        }
        
        dialog_choices = []; // Clear choices after selection
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