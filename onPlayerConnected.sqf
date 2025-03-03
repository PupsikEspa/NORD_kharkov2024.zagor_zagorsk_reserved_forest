// Вступление.

cutText ["","BLACK FADED",2];
titleText ["<t color='#7FFFD4' size='2'>Добро пожаловать на NORD!</t><br/><t color='#ff0000' size='1.3'></t>", "PLAIN", 0.4, true, true];
sleep 3;
cutText ["","BLACK IN",5];



_nameplayer = name player;
if ((_nameplayer find "ССЛД" !=-1) || (_nameplayer find "ЕФР" !=-1) || (_nameplayer find "CPL" !=-1)) then 
{
	player setRank "CORPORAL"
} 
else 
{
	if ((_nameplayer find "МСЖ" !=-1) || (_nameplayer find "ССЖ" !=-1) || (_nameplayer find "СЖ" !=-1) || (_nameplayer find "СТ" !=-1) || (_nameplayer find "ШТБ" !=-1) || (_nameplayer find "МСТ" !=-1) || (_nameplayer find "СМСЖ" !=-1) || (_nameplayer find "ГМС" !=-1) || (_nameplayer find "МЛ.С-Т" !=-1) || (_nameplayer find "С-Т" !=-1) || (_nameplayer find "СТ.С-Т" !=-1) || (_nameplayer find "СТ-НА" !=-1)) then 
	{
		player setRank "SERGEANT"
	} 
	else 
	{
		if ((_nameplayer find "МЛТ" !=-1) || (_nameplayer find "ЛТ" !=-1) || (_nameplayer find "СЛТ" !=-1) || (_nameplayer find "SPLT" !=-1) || (_nameplayer find "МЛ.Л-Т" !=-1) || (_nameplayer find "Л-Т" !=-1) || (_nameplayer find "СТ.Л-Т" !=-1)) then 
		{
			player setRank "LIEUTENANT"
		} 
		else 
		{
			if ((_nameplayer find "КПТ" !=-1) || (_nameplayer find "К-Н" !=-1)) then 
			{
				player setRank "CAPTAIN"
			} 
			else 
			{
				if ((_nameplayer find "МР" !=-1) || (_nameplayer find "П-ПО" !=-1) || (_nameplayer find "ПЛК" !=-1) || (_nameplayer find "М-Р" !=-1) || (_nameplayer find "П.ПК" !=-1) || (_nameplayer find "П-К" !=-1)) then 
                {
                    player setRank "MAJOR"
                }
                else 
				{
					if ((_nameplayer find "БР-НГ" !=-1) || (_nameplayer find "ГМ-Р" !=-1) || (_nameplayer find "ГН-ЛТ" !=-1) || (_nameplayer find "ГН" !=-1) || (_nameplayer find "ГЕН.М-Р" !=-1) || (_nameplayer find "ГЕН.Л-Т" !=-1) || (_nameplayer find "ГЕН.П-К" !=-1) || (_nameplayer find "ГЕН.А" !=-1)) then 
					{
						player setRank "COLONEL"
					}
				}
			}
		}
	}
};