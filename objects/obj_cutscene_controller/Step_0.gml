if (is_active) {
    global.cutscene_active = true;
} else {
    global.cutscene_active = false;
    exit;
}

// If waiting, decrement wait timer
if (wait_time > 0) {
    wait_time--;
    exit;
}

// If there are no more actions, end the cutscene
if (current_step >= array_length(sequence)) {
    global.cutscene_active = false;
    is_active = false;
    instance_destroy();
    exit;
}

// Execute the current action
var action = sequence[current_step];
var action_complete = false;

switch (action.type) {
    case "move_player": 
        action_complete = cutscene_move_player(action.x, action.y, action.speed);
        break;
    case "dialog":
        if (!instance_exists(obj_dialog)) {
            if (!variable_instance_exists(id, "dialog_was_shown") || !dialog_was_shown) {
                // Create dialog if it doesn't exist and wasn't shown before
                var dialog = instance_create_depth(0, 0, -1000, obj_dialog);
                dialog.messages = action.messages;
                dialog.current_message = 0;  // Start with first message
                dialog.current_char = 0;
                dialog.draw_message = "";
                dialog.waiting_for_input = false;
                dialog_was_shown = true;  // Mark that we've shown this dialog
            } else {
                // Dialog was previously shown and now it's gone (player finished it)
                action_complete = true;
                dialog_was_shown = false;  // Reset for next dialog action
            }
        }
        break;
    case "wait":
        wait_time = action.time;
        action_complete = true;
        break;
    case "end_cutscene":
        global.cutscene_active = false;
        is_active = false;
        action_complete = true;
        break;
}

// Move to next step if current one is complete
if (action_complete) {
    current_step++;
}

// Functions for handling cutscene actions
function cutscene_move_player(target_x, target_y, move_speed) {
    if (!instance_exists(player_ref)) return true;
    
    var dx = target_x - player_ref.x;
    var dy = target_y - player_ref.y;
    
    // If player is close enough to target, consider it arrived
    if (abs(dx) < move_speed && abs(dy) < move_speed) {
        player_ref.x = target_x;
        player_ref.y = target_y;
        return true;
    }
    
    // Calculate direction to move
    var dir = point_direction(player_ref.x, player_ref.y, target_x, target_y);
    var move_x = lengthdir_x(move_speed, dir);
    var move_y = lengthdir_y(move_speed, dir);
    
    // Update player animation based on movement direction
    if (abs(move_x) > abs(move_y)) {
        if (move_x > 0) player_ref.sprite_index = spr_player_right;
        else player_ref.sprite_index = spr_player_left;
    } else {
        if (move_y > 0) player_ref.sprite_index = spr_player_down;
        else player_ref.sprite_index = spr_player_up;
    }
    
    // Move player without using move_and_collide to avoid errors
    // Simple movement with collision check
    var tilemap = player_ref.tilemap;
    
    // Check horizontal movement
    var new_x = player_ref.x + move_x;
    if (!tilemap_get_at_pixel(tilemap, new_x, player_ref.y)) {
        player_ref.x = new_x;
    }
    
    // Check vertical movement
    var new_y = player_ref.y + move_y;
    if (!tilemap_get_at_pixel(tilemap, player_ref.x, new_y)) {
        player_ref.y = new_y;
    }
    
    return false;
}
