while {true} do {
    waitUntil {!isnull (finddisplay 312)};
    _name = format ["%1 (%2)", name player, getPlayerUID player];
    _current_curators = missionNamespace getVariable ["current_curators", []];

    if (!(_name in _current_curators)) then {
        _current_curators pushBack _name;
        missionNamespace setVariable["current_curators", _current_curators, true];
    };
    _str = "<t color='#00FF00'>Активные зевсы:</t>";
    { _str = format["%1 <br/> %2", _str, _x]; } forEach _current_curators;
    hintSilent parseText _str;
    (finddisplay 312) displayAddEventHandler ["Unload", {
        _current_curators deleteAt (_current_curators find _name);
        missionNamespace setVariable["current_curators", _current_curators, true];
        hintSilent "";
    }];
    sleep 1;
}