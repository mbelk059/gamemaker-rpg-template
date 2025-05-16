depth = -9999;
global.font = Font2;
//item constructor
function create_item(_name, _desc, _spr, _effect) constructor 
{
    name = _name;
    description = _desc;
    sprite = _spr;
    effect = _effect;
}
//create items
global.item_list =
{
    burger : new create_item(
        "Burger",
        "A BURGER TO EAT! Get HP.",
        spr_burger,
        function()
        {
            obj_player.hp += 10;
            return true; // Return true to indicate item should be consumed
        }
    ),
    
    redkey : new create_item(
        "Key",
        "Opens doors.",
        spr_redkey,
        function()
        {
            var door_opened = false;
            if (instance_exists(obj_red_door))
            {
                with(obj_red_door)
                {
                    if (distance_to_object(obj_player) < 20) {
                        instance_destroy();
                        door_opened = true;
                    }
                }
            }
            return door_opened; // Only consume key if a door was opened
        }
    ),
}
//create inventory
inv = array_create(0);

inv_max = 5;

selected_item = -1;