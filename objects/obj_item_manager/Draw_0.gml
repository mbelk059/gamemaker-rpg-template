draw_set_font(global.font);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);

// Calculate base position once - outside the loop
var _xx = camera_get_view_x(view_camera[0]) + 8;
var _yy = camera_get_view_y(view_camera[0]) + 32;
var _sep = 12; // Fixed separation value

for (var i = 0; i < array_length(inv); i++)
{
    // Calculate position for this item
    var _item_y = _yy + (_sep * i);
    
    // Draw sprite
    draw_sprite(inv[i].sprite, 0, _xx, _item_y);
    
    // Set color based on selection
    if (selected_item == i) {
        draw_set_color(c_yellow);
    } else {
        draw_set_color(c_white);
    }
        
    // Draw text (same scale as before)
    draw_text_transformed(_xx + 16, _item_y, inv[i].name, 0.4, 0.4, 0);
    
    if selected_item == i
    {
        draw_text_ext(_xx, _yy + _sep*array_length(inv), inv[i].description, 12, 80);
    }
}

// Reset color at the end
draw_set_color(c_white);