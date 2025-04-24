if (!dialog_loaded && dialog_id != "") {
    dialog_loaded = true;
    
    // Dynamically create the variable names
    var state1 = dialog_id + "_state1";
    var state2 = dialog_id + "_state2";
    var state3 = dialog_id + "_state3";
    
    // Check if these globals exist
    if (variable_global_exists(state1)) {
        dialog_states[0] = variable_global_get(state1);
    }
    if (variable_global_exists(state2)) {
        dialog_states[1] = variable_global_get(state2);
    }
    if (variable_global_exists(state3)) {
        dialog_states[2] = variable_global_get(state3);
    }
}

if (instance_exists(obj_dialog)) exit;
if (instance_exists(obj_player) && distance_to_object(obj_player) < 8)
{
    can_interact = true;
    if (keyboard_check_pressed(input_key) && array_length(dialog_states) > 0)
    {
        var dialog_to_use;
        if (interaction_count < array_length(dialog_states)) {
            dialog_to_use = dialog_states[interaction_count];
            interaction_count++;
        } else {
            dialog_to_use = dialog_states[array_length(dialog_states) - 1]; // Use the last one
        }
        create_dialog(dialog_to_use);
    } 
}    
else 
{
    can_interact = false;    
}