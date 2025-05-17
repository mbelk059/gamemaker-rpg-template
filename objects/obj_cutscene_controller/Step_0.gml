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

// Check if we're waiting for a fade effect to complete
if (waiting_for_fade) {
    if (instance_exists(fade_controller) && !fade_controller.is_fading()) {
        waiting_for_fade = false;
    } else {
        exit; // Still waiting for fade to complete
    }
}

// If there are no more actions, end the cutscene
if (current_step >= array_length(sequence)) {
    global.cutscene_active = false;
    is_active = false;
    
    // This cleanup is now handled by the fade callback
    // instead of happening instantly
    instance_destroy();
    exit;
}

// Execute the current action
var action = sequence[current_step];
var action_complete = false;

switch (action.type) {
    case "move_player":
        // Your move logic
        action_complete = cutscene_move_player(action.x, action.y, action.speed);
        break;
        
    case "spawn_bunny_animation":
        // Spawn the bunny animation
        if (!instance_exists(obj_bunny_on_bench)) {
            var inst = instance_create_layer(276, 278, "Cutscene", obj_bunny_on_bench);
            action.bunny_id = inst.id; // Save for reference
        }
        action_complete = true;
        break;
        
    case "wait_for_bunny_anim":
        // Wait for bunny animation to reach a specific frame before fading
        if (instance_exists(obj_bunny_on_bench)) {
            var bunny = obj_bunny_on_bench;
            
            // When animation is near completion (e.g., 5 frames from end)
            // Assuming image_speed = 1
            var frames_before_end = 5;
            if (bunny.image_index >= bunny.image_number - frames_before_end) {
                action_complete = true;
            }
        } else {
            // If bunny doesn't exist for some reason, continue
            action_complete = true;
        }
        break;
    
    case "remove_npcs":
        // Get all NPCs and remove them
        with (obj_npc_parent) {
            instance_destroy();
        }
        // Add any other NPC object types you have
        // For example:
        // with (obj_npc2) { instance_destroy(); }
        // with (obj_npc3) { instance_destroy(); }
        
        // You can also add some ambient effects here if desired
        // For example, dimming the room lights
        
        action_complete = true;
        break;
        
    case "fade_out":
        // Create fade controller if it doesn't exist
        if (!instance_exists(obj_fade_controller)) {
            fade_controller = instance_create_depth(0, 0, -9999, obj_fade_controller);
        } else {
            fade_controller = instance_find(obj_fade_controller, 0);
        }
        
        // Start fade out effect
        with (fade_controller) {
            fade_out(action.speed, action.hold_time);
        }
        
        // Mark that we're waiting for fade to complete
        waiting_for_fade = true;
        action_complete = true;
        break;
        
    case "restore_player":
        // Restore player visibility
        if (instance_exists(player_ref)) {
            player_ref.visible = player_visible_before;
            
            // Re-enable player movement
            if (variable_instance_exists(player_ref, "can_move")) {
                player_ref.can_move = true;
            }
        }
        
        // Clean up bunny if it still exists
        with (obj_bunny_on_bench) {
            instance_destroy();
        }
        
        action_complete = true;
        break;
        
    case "fade_in":
        // Create fade controller if it doesn't exist
        if (!instance_exists(obj_fade_controller)) {
            fade_controller = instance_create_depth(0, 0, -9999, obj_fade_controller);
        } else {
            fade_controller = instance_find(obj_fade_controller, 0);
        }
        
        // Start fade in effect
        with (fade_controller) {
            fade_in(action.speed);
        }
        
        // Mark that we're waiting for fade to complete
        waiting_for_fade = true;
        action_complete = true;
        break;
        
    case "wait":
        wait_time = action.time;
        action_complete = true;
        break;
        
    case "end_cutscene":
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