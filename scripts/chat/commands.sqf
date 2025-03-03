pvpfw_chatIntercept_allCommands = [
	[
		"help",
		{
			_commands = "";
			{
				_commands = _commands + (pvpfw_chatIntercept_commandMarker + (_x select 0)) + ", ";
			}forEach pvpfw_chatIntercept_allCommands;
			systemChat format["Available Commands: %1",_commands];
		}
	],
	[
		"roll",
		{
			_rNumber = ceil random 100;
			_rShans = format["Удача благосклонна к %3 на %1%2",_rNumber, "%", name player];
			[_rShans] remoteExec ["systemChat"];
		}
	],
	[
        "rp",
        {
			_act = (_this select 0);
			_rpchat = format ["RP  %1: %2", name player, _act];
			[_rpchat] remoteExec ["systemChat"];
        }
    ]
];