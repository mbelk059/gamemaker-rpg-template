selected_item = -1;
for (var i = 0; i < array_length(inv); i++)
{
    // Calculate base position once
    var _xx = camera_get_view_x(view_camera[0]) + 8;
    var _yy = camera_get_view_y(view_camera[0]) + 32;
    var _sep = 12; // Fixed separation value
    
    // Calculate position for this item
    var _item_y = _yy + (_sep * i);
    
    // Create a proper hitbox area for text - make it larger
    var _text_width = string_width(inv[i].name) * 0.4; // Account for the 0.4 scale
    var _text_height = string_height(inv[i].name) * 0.4; // Account for the 0.4 scale
    
    // Check if mouse is over the item or its text
    if (point_in_rectangle(mouse_x, mouse_y, 
                        _xx, _item_y, 
                        _xx + 16 + _text_width, _item_y + _text_height))
    {
        selected_item = i;
    }
}

if (selected_item != -1)
{
    // use an item
    if (mouse_check_button_pressed(mb_left))
    {
        // Execute the effect and check if we should remove the item
        var should_consume = inv[selected_item].effect();
        
        // Only delete the item if the effect returns true
        if (should_consume)
        {
            array_delete(inv, selected_item, 1);
            selected_item = -1; // Reset selection after item is used
        }
    }
}