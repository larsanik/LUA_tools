require 'winapi'
local s=""
for i=151,255 do
print("APS_SHUD_MK150.EMG_Str["..i.."] :=  'EMG"..i.."';")
s=s.."APS_SHUD_MK150.EMG_Str["..i.."] :=  'EMG"..i.."';\r\n"
end
winapi.set_clipboard(s)