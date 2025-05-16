// Check if animation should continue or has completed
// We don't want to destroy immediately anymore since the fade will handle cleanup
if (image_index >= image_number - 1) {
    // Mark as done rather than destroying
    animation_done = true;
    image_speed = 0;  // Pause at last frame
    image_index = image_number - 1;
}