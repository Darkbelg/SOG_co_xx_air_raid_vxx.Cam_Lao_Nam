// Either use (_faction in ["blu_f"]) or (side == "west") etc...
// Note - Always lower case!
// ---------------------------------- WEST FORCES -------------------------------------
/*
if (_side == "west") then {
	#include "LOADOUTFILEHERE.sqf"
};
*/
// ---------------------------------- EAST FORCES -------------------------------------

if (_side == "east") then {
	#include "f_loadout_sog_east_nva.sqf";
};

// ---------------------------------- INDP FORCES -------------------------------------
/*
if(_side == "guer") then {
	#include "LOADOUTFILEHERE.sqf"
};
*/