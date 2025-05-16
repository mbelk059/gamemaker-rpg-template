if (instance_exists(obj_dialog)) exit;
    
if (instance_exists(obj_player) && distance_to_object(obj_player) < 16 && !cutscene_played)  // Check if cutscene hasn't played
{
    can_talk = true;
    if (keyboard_check_pressed(input_key))
    {
        create_dialog(dialog);
    }    
}    
else 
{
    can_talk = false;    
}