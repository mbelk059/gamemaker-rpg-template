/// In obj_player Draw GUI Event
var _dx = 16;
var _dy = 16;

// properties
draw_set_color(c_white);
draw_set_font(Font1);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Health display using carrot sprites
var _carrot_count = 5; // Number of carrots to display
var _carrot_scale = 2.1; // Make carrots bigger (adjust as needed)
var _carrot_width = sprite_get_width(spr_carrot) * _carrot_scale;
var _carrot_height = sprite_get_height(spr_carrot) * _carrot_scale;
var _carrot_spacing = 10; // Space between carrots
var _health_per_carrot = hp_total / _carrot_count; // How much health each carrot represents

// Draw the carrots
for (var i = 0; i < _carrot_count; i++) {
    var _carrot_x = _dx + i * (_carrot_width + _carrot_spacing);
    var _carrot_y = _dy;
    
    // Calculate how full this carrot should be (0 to 1)
    var _current_carrot_health = min(max(0, hp - (i * _health_per_carrot)), _health_per_carrot);
    var _fill_amount = _current_carrot_health / _health_per_carrot;
    
    if (_fill_amount > 0) {
        // Draw partially filled carrot using part_ext
        var _fill_height = sprite_get_height(spr_carrot) * _fill_amount;
        draw_sprite_part_ext(
            spr_carrot, 0,
            0, sprite_get_height(spr_carrot) - _fill_height, // Source x, y
            sprite_get_width(spr_carrot), _fill_height,      // Source width, height
            _carrot_x, _carrot_y + (_carrot_height - (_fill_height * _carrot_scale)), // Dest x, y
            _carrot_scale, _carrot_scale,                      // Scale
            c_white, 1                                        // Color, alpha
        );
        
        // Draw empty carrot outline (optional)
        draw_sprite_ext(spr_carrot, 1, _carrot_x, _carrot_y, _carrot_scale, _carrot_scale, 0, c_white, 0.5);
    } else {
        // Draw empty carrot
        draw_sprite_ext(spr_carrot, 1, _carrot_x, _carrot_y, _carrot_scale, _carrot_scale, 0, c_white, 0.5);
    }
}

// XP bar
var _barw = 256; // We still need this for the XP bar
var _barh = 32;  // We still need this for the XP bar
var _xp_barw = _barw * (xp / xp_require);
_dy += _carrot_height + 16; // Use carrot height instead of bar height
//draw_sprite_stretched(spr_box, 0, _dx, _dy, _barw, _barh);
//draw_sprite_stretched_ext(spr_box, 1, _dx, _dy, _xp_barw, _barh, c_blue, 0.6);
//draw_text(_dx + _barw/2, _dy + _barh/2, $"LEVEL {level}");

// Reset properties
draw_set_halign(fa_left);
draw_set_valign(fa_top);