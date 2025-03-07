if (side player == civilian) exitWith {};
_myArs = missionNamespace getVariable ((missionNamespace getVariable "groupNamesByCallsigns" get (groupID (group player))) + "_ars");
{
	if (_x != _myArs) then {[_x, false] call ace_arsenal_fnc_removeBox; _x lockInventory true;};
} forEach [odhbr83_ars,omcbr25_ars,barc29_ars,obrmp155_ars,soborahmat_ars,obrcpn2_ars,polk204ahmat_ars,obrcpn16_ars,gurkraken_ars,legion_pidorasov_ars,gurstugna_ars,gurbratstvo_ars,ohb92_ars,rdk_ars,acpthror_ars,ohbr3_ars,mcp272_ars];