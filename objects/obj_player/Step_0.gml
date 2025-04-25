if (variable_global_exists("cutscene_active") && global.cutscene_active) {
    // Check if cutscene controller exists AND is currently on a move_player action
    if (instance_exists(obj_cutscene_controller) && 
        obj_cutscene_controller.current_step < array_length(obj_cutscene_controller.sequence) &&
        obj_cutscene_controller.sequence[obj_cutscene_controller.current_step].type != "move_player") {
        
        // Set idle sprite based on current direction
        if (sprite_index == spr_player_right || sprite_index == spr_player_right_idle) 
            sprite_index = spr_player_right_idle;
        else if (sprite_index == spr_player_left || sprite_index == spr_player_left_idle) 
            sprite_index = spr_player_left_idle;
        else if (sprite_index == spr_player_up || sprite_index == spr_player_up_idle)
            sprite_index = spr_player_up_idle;
        else if (sprite_index == spr_player_down || sprite_index == spr_player_down_idle)
            sprite_index = spr_player_down_idle;
    }
    
    exit; // Skip ALL player input processing
}

// Check if obj_dialog exists
if (instance_exists(obj_dialog)) {
    exit; // Exit if obj_dialog exists
}

var _hor = keyboard_check(vk_right) - keyboard_check(vk_left);
var _ver = keyboard_check(vk_down) - keyboard_check(vk_up);

var _len = _hor!=0 || _ver!=0;
var _dir = point_direction(0, 0, _hor, _ver);
_hor = lengthdir_x(_len, _dir);
_ver = lengthdir_y(_len, _dir);

move_and_collide(_hor * move_speed, _ver * move_speed, tilemap, undefined, undefined, undefined, move_speed, move_speed);

if (_hor != 0 or _ver != 0 )
{
    if (_ver > 0) sprite_index = spr_player_down;
    else if (_ver < 0) sprite_index = spr_player_up;
    else if (_hor > 0) sprite_index = spr_player_right;
    else if (_hor < 0) sprite_index = spr_player_left;   
        
    facing =  point_direction(0, 0, _hor, _ver);
}
else 
{
    if (sprite_index == spr_player_right) sprite_index = spr_player_right_idle;
    else if (sprite_index == spr_player_left) sprite_index = spr_player_left_idle;
    else if (sprite_index == spr_player_up) sprite_index = spr_player_up_idle;
    else if (sprite_index == spr_player_down) sprite_index = spr_player_down_idle;    
}

if (keyboard_check_pressed(vk_space))
{
    // Only allow attacks when not in a cutscene
    if (!variable_global_exists("cutscene_active") || !global.cutscene_active) {
        var inst = instance_create_depth(x, y, depth, obj_attack);
        inst.image_angle = facing;
        inst.damage *= damage;
    }
}