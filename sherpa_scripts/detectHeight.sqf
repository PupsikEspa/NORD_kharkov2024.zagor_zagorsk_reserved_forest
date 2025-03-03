loopCheckHeight = [] spawn {
    while {true} do {
        {
            _altitude = (getPosATL _x) select 2;
            if (_x isKindOf "Air" && _altitude > 3000 && (typeOf _x != "rhs_pchela1t_vvsc")) then {
                _x setDamage 1;
            };
        } forEach vehicles;
        sleep 20;
    };
};