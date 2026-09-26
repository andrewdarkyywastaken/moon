if shared.moonlight_loaded then
	return false;
end;
local sdk = loadstring(game:HttpGet("https://sdkapi-public.luarmor.net/library.lua"))();
sdk.script_id = "219cc6b2c3578ead9cf25bac3c007dbb";
local status = sdk.check_key(script_key);
if status.code ~= "KEY_VALID" then
	if messagebox then
		messagebox(status.message, "Moonlight", 0x00000030 + 0x00010000);
	else
		error(status.message);
	end;
	return false;
end;
shared.moonlight_loaded = true;
if not game:IsLoaded() then
	game.Loaded:Wait();
end;
if queue_on_teleport then
	local connection;
	connection = game:GetService("Players").LocalPlayer.OnTeleport:Connect(function(teleportState, placeId)
		if teleportState == Enum.TeleportState.InProgress and placeId == game.PlaceId then
			connection:Disconnect();
			queue_on_teleport(string.format("script_key='%s'loadstring(game:HttpGet('https://raw.githubusercontent.com/andrewdarkyywastaken/moonlight/main/loader.lua'))()", script_key));
		end;
	end);
end;
task.spawn(sdk.load_script);
return true;
