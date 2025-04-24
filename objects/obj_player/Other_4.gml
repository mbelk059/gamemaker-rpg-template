with (obj_carry_data)
{   
    other.level = level;
    other.xp = xp;
    other.xp_require = xp_require;
    other.damage = damage;
    other.hp_total = hp_total
    
    if (variable_instance_exists(id, "hp"))
    {
        other.hp = hp;
    }    
    
    instance_destroy();
}    