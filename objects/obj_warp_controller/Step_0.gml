if (room != newRoom)
{
    fadeLevel += 0.025;    
    if (fadeLevel >= 1)
    {
        room_goto(newRoom);
        obj_player.x = newX;
        obj_player.y = newY;    
    }    
}    
else 
{
    fadeLevel -= 0.025;    
}

if (fadeLevel <= 0)
{
    instance_destroy();    
}    