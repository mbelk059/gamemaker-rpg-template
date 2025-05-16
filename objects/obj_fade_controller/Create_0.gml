fade_alpha = 0;         // Current fade level (0 = fully visible, 1 = fully black)
fade_speed = 0.05;      // How fast the fade happens
fade_target = 0;        // Target fade level (0 or 1)
fade_state = "none";    // Current fade state: "none", "fade_in", "fade_out", "hold"
hold_time = 0;          // Time to hold at full fade
callback = -1;          // Optional callback function to call after fade complete
fade_in_speed = 0.05;   // Speed for fading in

// Public functions
/// @function fade_out([speed], [hold_time], [callback])
function fade_out(_speed = 0.05, _hold_time = 0, _callback = -1) {
    fade_speed = _speed;
    fade_target = 1;
    fade_state = "fade_out";
    hold_time = _hold_time;
    callback = _callback;
}

/// @function fade_in([speed], [callback])
function fade_in(_speed = 0.05, _callback = -1) {
    fade_speed = _speed;
    fade_target = 0;
    fade_state = "fade_in";
    callback = _callback;
}

/// @function fade_cycle([fade_out_speed], [hold_time], [fade_in_speed], [callback])
function fade_cycle(_fade_out_speed = 0.05, _hold_time = 30, _fade_in_speed = 0.05, _callback = -1) {
    fade_speed = _fade_out_speed;
    fade_target = 0;
    fade_state = "fade_out";
    hold_time = _hold_time;
    // Store the fade in speed so we can use it later
    fade_in_speed = _fade_in_speed;
    callback = _callback;
}

/// @function is_fading()
function is_fading() {
    return fade_state != "none";
}