if(isServer) then
{
	waitUntil {kyk_ew_initComplete};
	
	call kyk_ew_fnc_removeAllJammers;
	
	["O_TAG_r142n", 1, [0,2000,2000,2000,2000,2000,2000,1,0]] call kyk_ew_fnc_jammerAdd;
    ["MY_TAG_r142n", 1, [0,2000,2000,2000,2000,2000,2000,1,0]] call kyk_ew_fnc_jammerAdd;
    ["V_TAG_r142n", 1, [0,2000,2000,2000,2000,2000,2000,1,0]] call kyk_ew_fnc_jammerAdd;
    ["Z_TAG_r142n", 1, [0,2000,2000,2000,2000,2000,2000,1,0]] call kyk_ew_fnc_jammerAdd;
    ["b_afougf_yt_gaz66_r142", 1, [0,2000,2000,2000,2000,2000,2000,1,0]] call kyk_ew_fnc_jammerAdd;
    ["b_ngu_gaz66_r142", 1, [0,2000,2000,2000,2000,2000,2000,1,0]] call kyk_ew_fnc_jammerAdd;
};