params ["_pilot","_spread"];

if(!isServer) exitWith {};

systemChat "looking to drop some bombs";

_plane = vehicle _pilot;
_plane limitSpeed 1000;

// _weapon = (weapons _plane)#0;
//_plane setVelocityModelSpace [0,300,0];

// systemChat format ["Weapon:%1, Magazine:%2",_weapon, magazinesAmmo _plane];
// _weapons = weapons _plane;


// {
// 	[_plane, _x] call BIS_fnc_fire;
// 	_speed = speed _plane / 3.6;
// 	_delay = _spread / _speed;

// 	sleep _delay;
//"vn_bomb_mk82_he_launcher"
//vn_bomb_f4_out_500_mk82_he_mag_x6
// } forEach _weapons;


{
	for "_i" from 0 to ((_x#1)+1) do {
		// [_plane, "vn_bomb_blu1b_500_fb_launcher"] call BIS_fnc_fire;
		[_plane, "vn_bomb_mk82_he_launcher"] call BIS_fnc_fire;
		_speed = speed _plane / 3.6;
		_delay = _spread / _speed;

		sleep _delay;
	}
} forEach magazinesAmmo _plane;
