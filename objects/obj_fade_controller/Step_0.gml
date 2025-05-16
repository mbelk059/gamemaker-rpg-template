if (fade_state == "fade_in") {
    // Fading in (from black to visible)
    fade_alpha -= fade_speed;
    if (fade_alpha <= 0) {
        fade_alpha = 0;
        fade_state = "none";
        
        // Execute callback if one exists
        if (callback != -1) {
            callback();
            callback = -1;
        }
    }
} else if (fade_state == "fade_out") {
    // Fading out (from visible to black)
    fade_alpha += fade_speed;
    if (fade_alpha >= 1) {
        fade_alpha = 1;
        if (hold_time > 0) {
            fade_state = "hold";
        } else {
            // Execute callback if one exists
            if (callback != -1) {
                callback();
                callback = -1;
            }
        }
    }
} else if (fade_state == "hold") {
    // Hold at full black
    hold_time--;
    if (hold_time <= 0) {
        // After holding, what happens next depends on fade_target
        if (fade_target == 0) {
            fade_state = "fade_in";
            fade_speed = fade_in_speed; // Use the stored fade_in_speed
        } else {
            fade_state = "none";
            
            // Execute callback if one exists
            if (callback != -1) {
                callback();
                callback = -1;
            }
        }
    }
}
