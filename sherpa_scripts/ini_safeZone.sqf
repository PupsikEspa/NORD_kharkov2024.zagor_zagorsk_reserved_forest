handleShootSafeZone = player addEventHandler ["Fired", {
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
    if ((_unit inArea nfz_1) or (_unit inArea nfz_2)) then {
        deleteVehicle _projectile;
        if (_unit == _unit) then {
            endMission "shoot";
        };
    };
}];
["ace_firedPlayer", {
    if ((_unit inArea nfz_1) or (_unit inArea nfz_2)) then {
        deleteVehicle _projectile;
        if (_unit == _unit) then {
            endMission "shoot";
        };
    };
}] call CBA_fnc_addEventHandler;

["ace_explosives_place", {
    if ((_unit inArea nfz_1) or (_unit inArea nfz_2)) then {
        deleteVehicle _projectile;
        if (_unit == _unit) then {
            endMission "shoot";
        };
    };
}] call CBA_fnc_addEventHandler;

["ace_explosives_setup", {
    if ((_unit inArea nfz_1) or (_unit inArea nfz_2)) then {
        deleteVehicle _projectile;
        if (_unit == _unit) then {
            endMission "shoot";
        };
    };
}] call CBA_fnc_addEventHandler;

["ace_firedPlayerVehicle", {
    if ((_unit inArea nfz_1) or (_unit inArea nfz_2)) then {
        deleteVehicle _projectile;
        if (_unit == _unit) then {
            endMission "shoot";
        };
    };
}] call CBA_fnc_addEventHandler;

["ace_rearm_sourceInitalized", {
    [ammo_truck, 10000] call ace_rearm_fnc_setSupplyCount;
}] call CBA_fnc_addEventHandler;