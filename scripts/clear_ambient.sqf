true spawn {
	waitUntil 
	{
		{
			if (agent _x isKindOf "Rabbit_F" || agent _x isKindOf "Snake_random_F" || agent _x isKindOf "egl_rabbit" || agent _x isKindOf "snake_lgs") then 
			{
				deleteVehicle agent _x;
			};
		} forEach agents;
		false;
	};
};