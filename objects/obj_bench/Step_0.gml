if (instance_exists(obj_dialog)) exit;
    
if (instance_exists(obj_player) && distance_to_object(obj_player) < 16)
{
    can_talk = true;
    if (keyboard_check_pressed(input_key))
    {
        // Choose different dialogue based on whether cutscene has played
        if (global.bench_cutscene_played) {
            create_dialog(global.bench_normal);  // Show normal bench dialogue
        } else {
            create_dialog(global.bench);  // Show initial dialogue with choices
        }
    }    
}    
else 
{
    can_talk = false;    
}