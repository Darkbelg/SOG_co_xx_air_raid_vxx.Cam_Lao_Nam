// F3 - Briefing - Credits: Please see the F3 online manual http://www.ferstaberinde.com/f3/en/
// <marker name='XXX'>XXX</marker>
// Green #80FF00
// Orange #FF7F00
// Blue #00FFFF

if (isNil "f_param_CasualtiesCap") then { f_param_CasualtiesCap = 100 }; // Set CasCap if author did not.

// The code below creates the administration sub-section of notes.
_adm = player createDiaryRecord ["Diary", ["Administration",[] call f_fnc_fillAdministration]];

// Edit the if statement for different faction briefs.

if (side group player != CIVILIAN) then {
	// The code below creates the execution sub-section of notes.
	_exe = player createDiaryRecord ["Diary", ["Mission",format["
	<br/><font size='18' color='#80FF00'>OBJECTIVES</font>
	<br/>Commander defend the city of Hanoi from incoming phantoms. 
	<br/>You have 10 minutes to deploy your forces.
	<br/>Mission should take about one hour.
	<br/>
	<br/>There are service center around hanoi to rearm,repair and refuel.
	<br/>Destroyed vehicles spawned back at their beginning position every 10 minutes.
	<br/>There are bicycles available to drive back to their spawn point. 
	<br/>
	<br/>There is no failure only success.
	<br/>
	<br/><font size='18' color='#80FF00'>FRIENDLY FORCES</font>
	<br/>A,B and C platoon  4* AA truck, D  AA Boat, E Medics and CO radar truck.
	<br/>All truck gunners should have a radio.
	<br/>
	<br/>In order to use the radar truck you have to be in the driver seat.
	<br/><font size='18' color='#80FF00'>ENEMY FORCES</font>
	<br/>Phantoms will be attacking from every direction.
	<br/>They will be carrying 12*500lb bombs.
	<br/>
	<br/>Target of bombing will be a mix off points in hanoi or enemy combatents.
	<br/>
	<br/><font size='18' color='#80FF00'>CREDITS</font>
	<br/>Created by <font color='#FF0080'>Darkbelg</font color>
	<br/>
	<br/>A custom-made mission for ArmA 3 and Zeus Community
	<br/>http://zeus-community.net
	<br/>",
	if (f_param_CasualtiesCap > 0 && f_param_CasualtiesCap < 100) then { format["Ensure casualties are kept below %1 and %1&#37; of your force is not incapacitated.<br/>", f_param_CasualtiesCap] } else { "" },
	(((vehicles select { side _x getFriend side group player < 0.6 && !(_x isKindOf "staticWeapon" || _x isKindOf "static") && count crew _x > 0}) apply {  getText (configFile >> "CfgVehicles" >> typeOf _x >> "displayName") }) call BIS_fnc_consolidateArray) apply { format["%2x <font color='#00FFFF'>%1</font><br/>", _x#0, _x#1] } joinString "",
	format["%1x <font color='#00FFFF'>Infantry Groups</font><br/>", { side _x getFriend side group player < 0.6 && count units _x >= 3 && vehicle leader _x == leader _x} count allGroups]
	]]];
};

/*
// Sector Heatmap (PEL Markers)
// <br/>Toggle PEL IDs <font color='#80FF00'><execute expression=""allMapMarkers apply { if (['pel_text_',_x] call BIS_fnc_inString) then { _x setMarkerAlphaLocal 0.3 }; };"">On</execute></font> | <font color='#CF142B'><execute expression=""allMapMarkers apply { if (['pel_text_',_x] call BIS_fnc_inString) then { _x setMarkerAlphaLocal 0 }; };"">Off</execute></font>
{
	_x params ["_pos", "_count"];
	
	private _mkr = createMarkerLocal [format["pel_area_%1",_forEachIndex], _pos];
	_mkr setMarkerShapeLocal "RECTANGLE";
	_mkr setMarkerBrushLocal "SolidBorder";
	_mkr setMarkerAlphaLocal 0.3;
	_mkr setMarkerColorLocal "ColorEast";
	_mkr setMarkerSizeLocal [50,50];
	
	private _mkr = createMarkerLocal [format["pel_text_%1",_forEachIndex], [(_pos#0)-50,(_pos#1)-40]];
	_mkr setMarkerTypeLocal "MIL_DOT";
	_mkr setMarkerTextLocal format["PEL %1", _forEachIndex + 1];
	_mkr setMarkerAlphaLocal 0;
	_mkr setMarkerColorLocal "ColorEast";
	_mkr setMarkerSizeLocal [0.1,0.1];
} forEach ((allGroups select { side _x getFriend side group player < 0.6 && count units _x >= 2 } apply { getPos leader _x select [0,2] apply { _x - _x % 100 + 50 } }) call BIS_fnc_consolidateArray);
*/