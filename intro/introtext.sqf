/*
	File: introtext.sqf
	Description: Добавляет текст после загрузки игрока на сервер
*/

_onScreenTime = 5;

sleep 11; //Время до начала титров

_role1 = "Добро пожаловать на NORD";
_role1names = [profileName];
_role2 = "Игровой проект NORD";
_role2names = ["Revived by Enthusiasts"];
_role3 = "Прекрасный";
_role3names = ["Lucas, Doctor, Giga, Fraer, ESP, Shilov"];
_role4 = "Посетите нашу группу VK";
_role4names = ["-"];
_role5 = "Присоединяйтесь к Discord";
_role5names = ["-"];
_role6 = "Удачной игры!";
_role6names = [profileName];
{
sleep 2; // #1f75fe
_memberFunction = _x select 0;
_memberNames = _x select 1;
_finalText = format ["<t size='0.55' color='#ffd700' align='right'>%1<br /></t>", _memberFunction];
_finalText = _finalText + "<t size='0.70' color='#ffffff' align='right'>";
{_finalText = _finalText + format ["%1<br />", _x]} forEach _memberNames;
_finalText = _finalText + "</t>";
_onScreenTime + (((count _memberNames) - 1) * 0.9);
[
_finalText,
[safezoneX + safezoneW - 0.8,0.50], //Стандарт: 0.5,0.35
[safezoneY + safezoneH - 0.8,0.7], //Стандарт: 0.8,0.7
_onScreenTime,
0.5
] spawn BIS_fnc_dynamicText;
sleep (_onScreenTime);
} forEach [
//В списке ниже должно быть точно такое же количество ролей, как и в списке выше
[_role1, _role1names],
[_role2, _role2names],
[_role3, _role3names],
[_role4, _role4names],
[_role5, _role5names],
[_role6, _role6names]
];