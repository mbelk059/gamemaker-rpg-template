var _dx = 10;
var _dy = gui_h * 0.7;
var _boxw = gui_w - 20;
var _boxh = gui_h - _dy - 10;

draw_sprite_stretched(spr_box, 0, _dx, _dy, _boxw, _boxh);

_dx += 16;
_dy += 16;

// Check if the current message has a name field
var _current_msg = messages[current_message];
if (variable_struct_exists(_current_msg, "name")) {
    // If there's a name, display it with its color
    var _name = _current_msg.name;
    draw_set_font(Font1);
    draw_set_color(global.char_colors[$ _name]);
    draw_text(_dx, _dy, _name);
    draw_set_color(c_white);
    _dy += 40; // Add the spacing for the name
}
else {
    // No name field, just add minimal spacing
    _dy += 10; // You can adjust this value as needed
}

// Draw the message text
draw_text_ext(_dx, _dy, draw_message, -1, _boxw - _dx - _dx * 2);
// Draw choices if available
if (is_array(dialog_choices) && array_length(dialog_choices) > 0)
{
    var choice_y = _dy + 50;
    for (var i = 0; i < array_length(dialog_choices); i++)
    {
        if (i == selected_choice)
            draw_set_color(c_yellow);
        else
            draw_set_color(c_white);

        draw_text(_dx, choice_y, dialog_choices[i].text);
        choice_y += 30;
    }
}