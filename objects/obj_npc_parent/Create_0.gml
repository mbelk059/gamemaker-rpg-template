input_key = vk_space;
can_talk = false;

if (global.museum_after_hours) {
    // Don't create this NPC if it's after hours
    instance_destroy();
}