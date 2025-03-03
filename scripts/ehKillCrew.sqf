handleDestroyedVehicle = addMissionEventHandler ["EntityKilled", {
	params ["_unit", "_killer", "_instigator", "_useEffects"];
    if ((_unit isKindOf "Tank") or (_unit isKindOf "Car") or (_unit isKindOf "TrackedAPC") or (_unit isKindOf "WheeledAPC") or (_unit isKindOf "Plane") or (_unit isKindOf "Helicopter")) then {
        {
            _x setDamage 1;
        } forEach crew _unit;
    };
}];