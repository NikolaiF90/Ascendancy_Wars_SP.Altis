/*
Makes specified _container saveable.
*/

params ["_container"];

[format ["Trying to add container %1 to save.", _container]] call skhpersist_fnc_LogToRPT;

if (PSave_CustomContainersToSave find _container == -1) then 
{
	[format ["Adding container %1 to save.", _container]] call skhpersist_fnc_LogToRPT;
	PSave_CustomContainersToSave pushBack _container;
}
else
{
	[format ["Container %1 is already added for saving.", _container]] call skhpersist_fnc_LogToRPT;
};