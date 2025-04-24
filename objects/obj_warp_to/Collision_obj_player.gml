 warp = instance_create_depth(x, y, depth - 1000, obj_warp_controller);
 warp.newX = xPosition;
 warp.newY = yPosition;
 warp.newRoom = roomName;
 
 instance_destroy();