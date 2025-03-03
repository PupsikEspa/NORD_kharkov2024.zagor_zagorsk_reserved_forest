if ( isServer ) then {{if ( !(_x in units player) AND (side _x) == east ) then {deleteVehicle _x;};if ( !(_x in units player) AND (side _x) == west ) then {deleteVehicle _x;};} forEach allUnits;};
