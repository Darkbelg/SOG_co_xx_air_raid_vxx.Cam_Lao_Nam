params ["_grpLeader"];

if(!isServer) exitWith {};

deleteVehicle (vehicle _grpLeader);

{
	deleteVehicle _x;
} forEach (units (group _grpLeader));

deleteGroup (group _grpLeader);