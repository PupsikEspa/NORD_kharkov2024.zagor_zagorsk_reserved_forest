if (side player == civilian) exitWith{};

_group = missionNamespace getVariable "groupNamesByCallsigns" get (groupID (group player));

_donateMap = createHashMapFromArray [
	["76561198316727609", ["NMG_weapons_ppsh","71rnd_762mm_psh_nmg","NMG_weapons_pksp","NMG_silence_dtknrmini","rhs_100Rnd_762x54mmR", "ACE_optic_MRCO_2D"]],
	["76561198297574929", ["rhs_weap_SCARH_LB","rhs_mag_20Rnd_SCAR_762x51_m61_ap_bk","rhsusf_acc_rvg_blk","Scot_LEU_MK8_nord","rhsusf_acc_aac_762sd_silencer"]],
	["76561198168372978", ["NMG_weapons_A762"]],
	["76561198055139490", ["lmg_MG3_rail","120Rnd_TE4_LRT4_White_Tracer_762x51_Belt_M","120Rnd_TE4_LRT4_Yellow_Tracer_762x51_Belt_M","120Rnd_TE4_LRT4_Green_Tracer_762x51_Belt_M","120Rnd_TE4_LRT4_Red_Tracer_762x51_Belt_M"]],
	["76561199061768748", ["lmg_MG3_rail","120Rnd_TE4_LRT4_White_Tracer_762x51_Belt_M","120Rnd_TE4_LRT4_Yellow_Tracer_762x51_Belt_M","120Rnd_TE4_LRT4_Green_Tracer_762x51_Belt_M","120Rnd_TE4_LRT4_Red_Tracer_762x51_Belt_M"]],
	["76561199287760678", ["NMG_weapons_AM17pp"]],
	["76561198268337887", ["rhs_weap_SCARH_LB","rhs_mag_20Rnd_SCAR_762x51_m61_ap_bk","rhsusf_acc_rvg_blk","Scot_LEU_MK8_nord","rhsusf_acc_aac_762sd_silencer","tsb_mag_762x51_20rnd_M61_SCARB"]]
];

_myDonate = _donateMap getOrDefault [(getPlayerUID player), []];
if (count _myDonate < 1) exitWith{};
sleep 5;
_logStr = format ["Ars: %1, added items %2; Group %3", _group + "_ars", _myDonate, _group];
diag_log _logStr;
[(missionNamespace getVariable (_group + "_ars")), _myDonate, false] call ace_arsenal_fnc_addVirtualItems;