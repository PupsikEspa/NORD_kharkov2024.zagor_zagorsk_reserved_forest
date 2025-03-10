params ["_playerUnit", "_playerVarName"];

//systemChat "infunc2";
missionNamespace setVariable [_playerVarName, _playerUnit, true];
	
private _curVarName = _playerVarName+"Cur";
//systemChat format["_playerVarName: %1", _playerVarName];
//systemChat format["_curVarName: %1", _curVarName];

//["infunc"] remoteExec ["systemChat", -2];

if (!isNil _curVarName) then {
	//["!isnil"] remoteExec ["systemChat", -2];
	deleteVehicle (missionNamespace getVariable [_curVarName, objNull]);
	missionNamespace setVariable [_curVarName, nil, true];
};

if (isNil _curVarName) then {
	//["+isnil"] remoteExec ["systemChat", -2];
	[-1, compile format["if (player == %1) then {%1 sideChat 'creating Curator';}", _playerVarName]] call CBA_fnc_globalExecute;
	if (isNil "DedmenCur_group") then {DedmenCur_group = creategroup sideLogic;};
	private _myCurObject = DedmenCur_group createunit["ModuleCurator_F", [0, 90, 90], [], 0.5, "NONE"];	//Logic Server
	_myCurObject setVariable ["showNotification",false];

	missionNamespace setVariable [_curVarName, _myCurObject, true];
	publicVariable "DedmenCur_group";
	unassignCurator _myCurObject;
	_cfg = (configFile >> "CfgPatches");
	_newAddons = [];
	for "_i" from 0 to((count _cfg) - 1) do {
		_name = configName(_cfg select _i);
		_newAddons pushBack _name;
	};
	if (count _newAddons > 0) then {_myCurObject addCuratorAddons _newAddons};
	_myCurObject setcuratorcoef["place", 0];
	_myCurObject setcuratorcoef["delete", 0];
	private _enableSyncVar = _playerVarName+"_enableSync";
	private _val = random 500;
	missionNamespace setVariable [_enableSyncVar, random 500];
	[_enableSyncVar,_val] spawn {
		while  {(missionNamespace getVariable [_this select 0, 0]) == (_this select 1)} do {
		// {
		_myCurObject addCuratorEditableObjects[(allMissionObjects "All"), true];
		// } forEach allCurators;
		sleep 2;
	};};

};
private _myCurObject = missionNamespace getVariable [_curVarName, objNull];
private _myPlayer = missionNamespace getVariable [_playerVarName, objNull];
_myCurObject addEventHandler ["CuratorObjectPlaced", {
	params ["_curator", "_entity"];
	class = missionNamespace getVariable ([(getDescription _entity) select 0, 0]);
	missionNamespace setVariable [(getDescription _entity) select 0, class + 1];
	publicVariable ((getDescription _entity) select 0);
}];
_myCurObject addEventHandler ["CuratorObjectDeleted", {
	params ["_curator", "_entity"];
	class = missionNamespace getVariable ([(getDescription _entity) select 0, 0]);
	if (class > 0) then {
		missionNamespace setVariable [(getDescription _entity) select 0, class - 1];
		publicVariable ((getDescription _entity) select 0);
	};
}];

unassignCurator _myCurObject;
sleep 0.4;
_myPlayer assignCurator _myCurObject;