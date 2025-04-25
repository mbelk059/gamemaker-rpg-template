if (!triggered && !instance_exists(obj_cutscene_controller) && !instance_exists(obj_dialog)) {
    triggered = true;  // Prevent multiple triggers
    start_cutscene();
}

// Function to start a cutscene
function start_cutscene() {
    var controller = instance_create_depth(0, 0, 0, obj_cutscene_controller);
    controller.player_ref = other;  // 'other' refers to the player in the collision event
    controller.trigger_obj = id;
    controller.is_active = true;
    
    switch (cutscene_type) {
        case "basic":
            // Simple cutscene: player walks up, dialog appears, then walks right
            controller.sequence = [
                {type: "move_player", x: x, y: y - 32, speed: 1},
                {type: "wait", time: 30},
                {type: "dialog", messages: [
                    {name: "Max", msg: "Testing the cutscene system!"}
                ]},
                {type: "dialog", messages: [
                    {name: "Bunny", msg: "testing a second boxxxxxxxxxxxx...."}
                ]},
                {type: "wait", time: 60},
                {type: "move_player", x: x + 32, y: y - 32, speed: 1},
                {type: "end_cutscene"}
            ];
            break;
            
        // You can add more cutscene types here
        case "another_cutscene":
            controller.sequence = [
                // Different sequence of actions
            ];
            break;
    }
}