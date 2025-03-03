params ["_newUnit", "_oldUnit", "_respawn", "_respawnDelay"];
player removeAllEventHandlers "HIT";
//[_newUnit, "scripts\zeus\curator.sqf"] remoteExec ["execVM", 2];
[] execVM "scripts\zeus\curator.sqf";