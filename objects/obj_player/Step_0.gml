if (variable_global_exists("cutscene_active") && global.cutscene_active) {
    if (instance_exists(obj_cutscene_controller) && 
        obj_cutscene_controller.current_step < array_length(obj_cutscene_controller.sequence) &&
        obj_cutscene_controller.sequence[obj_cutscene_controller.current_step].type != "move_player") {
        
        // Idle animation handling
        if (sprite_index == spr_player_right || sprite_index == spr_player_right_idle) 
            sprite_index = spr_player_right_idle;
        else if (sprite_index == spr_player_left || sprite_index == spr_player_left_idle) 
            sprite_index = spr_player_left_idle;
        else if (sprite_index == spr_player_up || sprite_index == spr_player_up_idle)
            sprite_index = spr_player_up_idle;
        else if (sprite_index == spr_player_down || sprite_index == spr_player_down_idle)
            sprite_index = spr_player_down_idle;
    }
    exit; // Skip ALL player input
}
if (instance_exists(obj_dialog)) {
    exit;
}
// === MOVEMENT ===
var hor = keyboard_check(vk_right) - keyboard_check(vk_left);
var ver = keyboard_check(vk_down) - keyboard_check(vk_up);
var moving = hor != 0 || ver != 0;
if (moving) {
    var move_x = hor * move_speed;
    var move_y = ver * move_speed;
    
    // Handle X movement first (allows sliding along walls)
    if (!place_meeting(x + move_x, y, obj_wall)) {
        x += move_x;
    } else {
        // Try to slide along the wall by moving pixel by pixel
        var sign_x = sign(move_x);
        while (!place_meeting(x + sign_x, y, obj_wall)) {
            x += sign_x;
        }
    }
    
    // Then handle Y movement separately (allows sliding along walls)
    if (!place_meeting(x, y + move_y, obj_wall)) {
        y += move_y;
    } else {
        // Try to slide along the wall by moving pixel by pixel
        var sign_y = sign(move_y);
        while (!place_meeting(x, y + sign_y, obj_wall)) {
            y += sign_y;
        }
    }
    
    // === Sprite handling ===
    if (ver > 0) sprite_index = spr_player_down;
    else if (ver < 0) sprite_index = spr_player_up;
    else if (hor > 0) sprite_index = spr_player_right;
    else if (hor < 0) sprite_index = spr_player_left;
    facing = point_direction(0, 0, hor, ver);
} else {
    // Idle sprites
    if (sprite_index == spr_player_right) sprite_index = spr_player_right_idle;
    else if (sprite_index == spr_player_left) sprite_index = spr_player_left_idle;
    else if (sprite_index == spr_player_up) sprite_index = spr_player_up_idle;
    else if (sprite_index == spr_player_down) sprite_index = spr_player_down_idle;
}
// === Attack ===
if (keyboard_check_pressed(vk_space)) {
    if (!global.cutscene_active) {
        var inst = instance_create_depth(x, y, depth, obj_attack);
        inst.image_angle = facing;
        inst.damage *= damage;
    }
}

depth = -bbox_bottom;