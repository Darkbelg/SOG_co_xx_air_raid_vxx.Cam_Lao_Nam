params ["_randomPosition"];

if(!isServer) exitWith {};

_randomNumber = random(12000);
_randomPointX = _randomPosition#0 + (12000 * cos(_randomNumber * 2 * pi));
_randomPointY = _randomPosition#1 + (12000 * sin(_randomNumber * 2 * pi));
_planeSpeed = 300;

_randomHeigth = random [ 100, f_param_flyHeight, 250];
_spawnPosition = [_randomPointX,_randomPointY,_randomHeigth];
// _marker = createMarker ["beginPosition",_spawnPosition];
// _marker setMarkerType "hd_dot";
// _marker setMarkerText "Spawn Aircraft";

_phantomDir =  [_spawnPosition,_randomPosition] call BIS_fnc_dirTo;
_phantomDistance = [_spawnPosition,_randomPosition] call BIS_fnc_distance2D;

_phantomDeletePosition = [_spawnPosition, (_phantomDistance*2),_phantomDir] call BIS_fnc_relPos;

_phantom = [_spawnPosition,_phantomDir,"vn_b_air_f4c_lrbmb",west] call BIS_fnc_spawnVehicle;
_phantomVehicle = _phantom#0;
private _phantomGroup = _phantom#2;
_phantomGroup setSpeedMode "LIMITED";
_phantomGroup  setBehaviour "CARELESS";
_phantomVehicle flyInHeight _randomHeigth;
_phantomVehicle limitSpeed _planeSpeed;

for "_i" from 1 to 12 do {
	_phantomVehicle setPylonLoadout  [_i, ""];
};

for "_i" from 1 to 5 do {
	_phantomVehicle setPylonLoadout [_i, "vn_bomb_f4_out_500_mk82_he_mag_x6"];
};

//Calculate distance bomb drop position
_metersPersSeconds = velocityModelSpace _phantomVehicle select 1;

dropBombs = { systemChat "dropping bombs"};

_phantomBombDropPosition = [_spawnPosition,
_phantomDistance - 700 - sqrt((2*_randomHeigth)/(9.8))*(_planeSpeed*_randomHeigth/3600)
,_phantomDir] call BIS_fnc_relPos;

_waypointDropBomb = _phantomGroup addWaypoint [_phantomBombDropPosition,0];
_waypointDropBomb setWaypointStatements ["true","[this,50] execVM ""mission\dropBomb.sqf"""];
_waypointDropBomb setWaypointBehaviour "CARELESS";
_waypointDropBomb setWaypointCombatMode "RED";

// _marker = createMarker ["beginPosition1",_phantomBombDropPosition];
// _marker setMarkerType "hd_dot";
// _marker setMarkerText "phantomBombDropPosition";

_phantomGroup addWaypoint [_randomPosition,0];
// _marker = createMarker ["beginPosition2",_randomPosition];
// _marker setMarkerType "hd_dot";
// _marker setMarkerText "randomPosition";

_deelteGroupWaypoint = _phantomGroup addWaypoint [_phantomDeletePosition,0];
_deelteGroupWaypoint setWaypointStatements ["true","[this] execVM ""mission\deletePlane.sqf"""];
// _marker = createMarker ["beginPosition3",_phantomDeletePosition];
// _marker setMarkerType "hd_dot";
// _marker setMarkerText "phantomDeletePosition";