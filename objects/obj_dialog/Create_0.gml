messages = [];
current_message = 0;
current_char = 0;
draw_message = "";

char_speed = 0.5;
input_key = vk_space;

gui_w = display_get_gui_width();
gui_h = display_get_gui_height();

dialog_choices = [];
selected_choice = 0;

waiting_for_input = false;