global.char_colors = {
    "Congrats": c_yellow,
    "Max": c_yellow,
    "Bunny": c_aqua,
    "Bob": c_orange,
    "burger": c_black,
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

global.burger_state1 = [{msg: "It's a burger." }];
global.burger_state2 = [{msg: "It's still a burger." }];
global.burger_state3 = [{msg: "You keep checking the burger... It's starting to get cold." }];




function create_dialog(_messages){
    if (instance_exists(obj_dialog)) return;
        
    var _inst = instance_create_depth(0, 0, 0, obj_dialog);
    _inst.messages = _messages;
    _inst.current_message = 0;
}

function execute_choice_action(path_name) {
    if (variable_global_exists(path_name)) {
        return variable_global_get(path_name);
    }
    return [];
}
