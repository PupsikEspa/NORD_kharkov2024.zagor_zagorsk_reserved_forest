params ["_newUnit", "_oldUnit", "_respawn", "_respawnDelay"];
player removeAllEventHandlers "HIT";
[] execVM "scripts\zeus\curator.sqf";
[] execVM "scripts\addDonate.sqf";