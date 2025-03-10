[] execVM "onPlayerRespawn.sqf";

_EndSplashScreen = {
    for "_x" from 1 to 4 do {
        endLoadingScreen;
        sleep 3;
    };
};

//ТАБЛИЧКИ
[] execVM "scripts\plates_rus.sqf"; //ВС РФ
[] execVM "scripts\plates_ukr.sqf"; //ВСУ


[] spawn _EndSplashScreen;
//////////////////////////////////////////////////////

// Add EH
waitUntil{!(isNull player)};
waitUntil{local player};

if(!hasInterface) exitWith {}; // If headless then exit

[] execVM "intro\introtext.sqf";
[] execVM "sherpa_scripts\ini_zeus.sqf";
[] execVM "onPlayerConnected.sqf";
[] execVM "sherpa_scripts\ini_safeZone.sqf";
[] execVM "scripts\countLocalFPS.sqf";
[] execVM "scripts\addDonate.sqf";
[] execVM "scripts\commander.sqf";
//[] execVM "scripts\zeus\curator.sqf";
0 spawn {[] execVM "sherpa_scripts\ini_arsenalRestrict.sqf"};

_getPKPinfo = ["Инфо о ПКП", "Инфо о ПКП", "", {
	_side = if (str (side player) == "EAST") then {"РФ"} else {if (str (side player) == "WEST") then {"ВСУ"} else {""} };
	if (_side != "") then 
	{
		_active = missionNamespace getVariable [(str (side player) + "_pkpOpen"), true];
		_canOpen = missionNamespace getVariable [(str (side player) + "_canOpenPKP"), true];
		_lastOpen = missionNamespace getVariable [(str (side player) + "_lastOpenPKP"), 0];
		_left = missionNamespace getVariable [(str (side player) + "_pkpUsesLeft"), 100];
		_delta = missionNamespace getVariable ["PKP_DELTA", 0];
		_duration = missionNamespace getVariable ["PKP_DURATION", 0];
	
		// [
		// 	if (_active) then {format ["ПКП %1 ОТКРЫТ", _side]} else {format ["ПКП %1 ЗАКРЫТ", _side]},
		// 	if (_active) then {format ["ДО ЗАКРЫТИЯ %1 С", (_duration - (serverTime - _lastOpen))]} else {format ["ОСТАЛОСЬ %1 С", (_delta - (serverTime - _lastOpen))]},
		// 	format ["ДЕЛЬТА: %1", _delta], 
		// 	format ["ДЛИТЕЛЬНОСТЬ: %1", _duration]
		// ] spawn BIS_fnc_infoText;
		[
			[(if (_active) then {format ["ПКП %1 ОТКРЫТ", _side]} else {format ["ПКП %1 ЗАКРЫТ", _side]}), 0.5, 0.5],
			[(if (_active) then {format ["ДО ЗАКРЫТИЯ %1 С", (_duration - (serverTime - _lastOpen))]} else {format ["ДО ОТКРЫТИЯ %1 С", (_delta - (serverTime - _lastOpen))]}), 0.5, 0.5],
			[(format ["ОСТАЛОСЬ: %1", _left]), 0.5, 0.5],
			[(format ["ДЕЛЬТА: %1", _delta]), 0.5, 0.5],
			[(format ["ДЛИТЕЛЬНОСТЬ: %1", _duration]), 0.5, 0.5, 8]
		] spawn BIS_fnc_EXP_camp_SITREP;
	} else {
		rf_active = missionNamespace getVariable ["EAST_pkpOpen", true];
		rf_canOpen = missionNamespace getVariable ["EAST_canOpenPKP", true];
		rf_lastOpen = missionNamespace getVariable ["EAST_lastOpenPKP", 0];
		rf_left = missionNamespace getVariable ["EAST_pkpUsesLeft", 100];
		ua_active = missionNamespace getVariable ["WEST_pkpOpen", true];
		ua_canOpen = missionNamespace getVariable ["WEST_canOpenPKP", true];
		ua_lastOpen = missionNamespace getVariable ["WEST_lastOpenPKP", 0];
		ua_left = missionNamespace getVariable ["WEST_pkpUsesLeft", 100];
		_delta = missionNamespace getVariable ["PKP_DELTA", 0];
		_duration = missionNamespace getVariable ["PKP_DURATION", 0];
		[
			[(if (rf_active) then {"ПКП РФ ОТКРЫТ"} else {"ПКП РФ ЗАКРЫТ"}), 0.5, 0.5],
			[(if (rf_active) then {format ["ДО ЗАКРЫТИЯ %1 С", (_duration - (serverTime - rf_lastOpen))]} else {format ["ДО ОТКРЫТИЯ %1 С", (_delta - (serverTime - rf_lastOpen))]}), 0.5, 0.5],
			[(format ["ОСТАЛОСЬ: %1", rf_left]), 0.5, 0.5],
			["", 0, 0],
			[(if (ua_active) then {"ПКП ВСУ ОТКРЫТ"} else {"ПКП ВСУ ЗАКРЫТ"}), 0.5, 0.5],
			[(if (ua_active) then {format ["ДО ЗАКРЫТИЯ %1 С", (_duration - (serverTime - ua_lastOpen))]} else {format ["ДО ОТКРЫТИЯ %1 С", (_delta - (serverTime - ua_lastOpen))]}), 0.5, 0.5],
			[(format ["ОСТАЛОСЬ: %1", ua_left]), 0.5, 0.5],
			[(format ["ДЕЛЬТА: %1", _delta]), 0.5, 0.5],
			[(format ["ДЛИТЕЛЬНОСТЬ: %1", _duration]), 0.5, 0.5, 8]
		] spawn BIS_fnc_EXP_camp_SITREP;
	};
}, {true}] call ace_interact_menu_fnc_createAction;

[player, 1, ["ACE_SelfActions"], _getPKPinfo] call ace_interact_menu_fnc_addActionToObject;

// Copyright 2022 Sysroot

// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at

    // http://www.apache.org/licenses/LICENSE-2.0

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// Remove existing ace medical damage event handler
//player removeEventHandler ["HandleDamage", player getVariable ["ACE_medical_HandleDamageEHID", -1]];

/*
_id = ["ace_arsenal_onLoadoutLoad", {
	[player, [missionnamespace, "VirtualInventory"]] call BIS_fnc_saveInventory;
}] call CBA_fnc_addEventHandler;

player addEventHandler ["Respawn", {
	if ([missionnamespace, "VirtualInventory"] call BIS_fnc_inventoryExists) then
		{
			[player, [missionNamespace, "VirtualInventory"]] call BIS_fnc_loadInventory;
		}
}];
*/

// // Replace with custom damage event handler
// player setVariable [
// 	"ACE_medical_HandleDamageEHID", 
// 	player addEventHandler ["HandleDamage", {

// 		params ["_unit", "_selection", "_damage", "_source", "_projectile", "_hitIndex", "_instigator", "_hitPoint"];
			
// 			private ["_prevDamage", "_armorCoef", "_hitpointArmor"];
// 			// Hitpoint damage before this calculation
// 			if (_hitPoint == "") then {
// 				_prevDamage = damage _unit;
// 			} else {
// 				_prevDamage = player getHitIndex _hitIndex;
// 			};
		
// 			_hitpointArmor = 1.45273;
// 			// Hitpoint damage to be added by this calculation
// 			private _addedDamage = _damage - _prevDamage;

// 				// Check if there's already an armor coefficient set for this unit, use that if there is
// 				// Otherwise, get armor coefficient manually
// 				private _unitCoef = 1;
// 				_armorCoef = _unitCoef;
// 				// Apply optional hitpoint multiplier
// 				// Try to find unit-specific hitpoint multiplier
// 				private _hitPointMult = 1;
// 				_armorCoef = _armorCoef * _hitPointMult;
// 				// Detect explosive damage and apply AAA_VAR_EXPLOSIVE_MULT if it is greater than 0 
// 				if (true && {_projectile != "" && {getNumber (configFile >> "CfgAmmo" >> _projectile >> "indirectHit") > 0}}) then {
// 					_armorCoef = _armorCoef * 1;// 1- aaa expl mult
// 				};
// 				// Multiply addedDamage by hitpoint's armor value divided by armor coefficient to correct ACE's armor
// 				private _damageMultiplier = _hitpointArmor / _armorCoef;
// 				_addedDamage = _addedDamage * _damageMultiplier;
			
// 				// private _ogDamage = _damage - _prevDamage;
// 				// diag_log text "AAA TOLIK DEBUG: NEW HIT PROCESSED! DETAILS BELOW:";
// 				// diag_log text format ["HIT UNIT: %1", _unit];
// 				// diag_log text format ["SHOOTER: %1", _source];
// 				// diag_log text format ["HITPOINT: %1", _hitPoint];
// 				// diag_log text format ["HITPOINT ARMOR: %1", _hitpointArmor];
// 				// diag_log text format ["ORIGINAL DAMAGE RECEIVED: %1", _ogDamage];
// 				// diag_log text format ["NEW DAMAGE RECEIVED: %1", _addedDamage];
// 				// if (_ogDamage != 0) then {
// 				// 	diag_log text format ["%1 DAMAGE CHANGE: %2%3", "%", ((_addedDamage - _ogDamage) * 100 / _ogDamage) toFixed 2, "%"];
// 				// } else {
// 				// 	diag_log text "% DAMAGE CHANGE: N/A";
// 				// };
// 				// diag_log text format ["TOTAL HITPOINT DAMAGE: %1", _prevDamage + _addedDamage];
// 				// diag_log text "";
			
// 			// Replace original damage value with new damage value
// 			_this set [2, _prevDamage + _addedDamage];
// 		// Call ace medical's damage handler with updated value
// 		_this call ACE_medical_engine_fnc_handleDamage;
// 	}]
// ];