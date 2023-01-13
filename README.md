![Group 2 (13)](https://user-images.githubusercontent.com/76072277/212427113-123c0e95-9982-41de-a4fd-32ac33340bd2.png)

[![Love](http://ForTheBadge.com/images/badges/built-with-love.svg)](https://github.com/Azerothwav) [![name](https://img.shields.io/badge/Discord-7289DA?style=for-the-badge&logo=discord&logoColor=white)](https://forum.cfx.re/t/realistic-vehicle-failure-repair-fix/4887760/2) [![name](https://img.shields.io/badge/YouTube-FF0000?style=for-the-badge&logo=youtube&logoColor=white)](https://www.youtube.com/channel/UCH7coJ4d1gqh8BMMHacGQ5A) [![LUA](https://img.shields.io/badge/Lua-2C2D72?style=for-the-badge&logo=lua&logoColor=white)](https://www.lua.org) [![Ko-Fi](https://img.shields.io/badge/Ko--fi-F16061?style=for-the-badge&logo=ko-fi&logoColor=white)](https://ko-fi.com/azeroth)

# Installation
    curl https://github.com/Azerothwav/Az_wheeldamage

# Informations
This script allows you to add a new element of realism to your server by adding the possibility of losing wheels. 

![alt text](https://media.discordapp.net/attachments/912680553503948821/996428698565754890/unknown.png?width=1405&height=701)

## Requirements to trigger the loss of wheels:
- Make a jump that lasts more than 1 second (configurable in the config.lua)
- Make a collision with a certain speed (configurable in the config.lua)


The wheels are removable to be put back on the original vehicle. 

![alt text](https://media.discordapp.net/attachments/912680553503948821/996428806766198804/unknown.png)

## Integration for other script
A trigger is available to allow your mechanic script to repair the damaged vehicle.
    
    TriggerEvent("az_wheel:fixvehicle")

## Limitation
The limitations of GTA make that the motorcycle wheels are not detachable, so they are immune. I also limited the wheels for boats, planes and helicopters. The off-road wheels allow to override the fact of losing a wheel via height but not via collisions.

## Known bugs:
- Vehicles can sometimes bug and go under the map (rare but it can happen)

## Framework 
**QBCore / ESX / Standalone / Custom**

# Preview
https://www.youtube.com/watch?v=TYFLSRikyyA&t=1s
