global.char_colors = {
    "Congrats": c_yellow,
    "Max": c_yellow,
    "Bunny": c_aqua,
    "Bob": c_orange,
    "burger": c_black,
    "Fox": c_orange,
}




global.bench = [
{
    msg: "Sit on the bench?", 
    choices: [ 
        { text: "Yes", next: "start_bench_cutscene" },
        { text: "No"}
    ]
}
]


global.bench_normal = [
    {
        msg: "It's a nicely crafted bench."
    }
]

// Variable to track if the bench cutscene has been played
// This will persist between room changes
if (!variable_global_exists("bench_cutscene_played")) {
    global.bench_cutscene_played = false;
}



global.welcome_dialog = [
{
    name: "Max",
    msg: "Welcome to the pit."
},
{
    name: "Bunny",
    msg: "Thanks!"
},
{
    name: "Max",
    msg: "Do you want to fight or flee?", 
    choices: [ 
        { text: "Fight!", next: "fight_path" }, 
        { text: "Flee...", next: "flee_path" }
    ]
}
]

global.fight_path = [ 
{ 
    name: "Max", 
    msg: "Brave choice! Let's see what you've got." 
}
];

global.flee_path = [ 
{ 
    name: "Max", 
    msg: "Coward. But smart, maybe." 
},
{
    name: "Bunny",
    msg: "dwuqbhduwibhcuwie test"
}
];





global.dialog2 = [
{
name: "Bob",
msg: "BTW this is a test!"  
},
{
name: "Bunny",
msg: "testestetstetetststt tetsttetsttetstt ettts test te tte sttets ... ... .......tstetetststt tetsttetsttetstt ettts test te tte stt tstetetststt tetsttetsttetstt ettts test te tte stt tstetetststt tetsttetsttetstt ettts test te tte stt."  
},
{
name: "Bob",
msg: "o"  
},
]


global.foxlobby = [
{
    name: "Fox",
    msg: "I'm not doing anything suspicious..."
},
{
    name: "Fox",
    msg: "Hey what are you looking at??!!"
},
]


global.burger_state1 = [{msg: "It's a burger." }];
global.burger_state2 = [{msg: "It's still a burger." }];
global.burger_state3 = [{msg: "You keep checking the burger... It's starting to get cold." }];




function create_dialog(_messages){
    if (instance_exists(obj_dialog)) return;

    var inst = instance_create_depth(0, 0, 0, obj_dialog);
    inst.messages = _messages;
    inst.current_message = 0;
    inst.current_char = 0;
    inst.draw_message = "";
    inst.waiting_for_input = false;

    // Check and initialize dialog choices if the first message has them
    if (array_length(_messages) > 0) {
        var msg = _messages[0];
        if (is_struct(msg) && variable_struct_exists(msg, "choices") && is_array(msg.choices)) {
            inst.dialog_choices = msg.choices;
            inst.selected_choice = 0;
        } else {
            inst.dialog_choices = [];
        }
    }
}

function execute_choice_action(path_name) {
    if (variable_global_exists(path_name)) {
        return variable_global_get(path_name);
    }
    return [];
}
