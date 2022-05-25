os.execute( "chcp 65001 > nul" )
dofile('decode_Ansi_Utf8.lua'); --функция (внешняя) трансляции строк в utf8
--Таблица с данными полученная
dofile('APS.lua') 
local f_out = io.open('alarm_msg_ppu_hr.csv','w+'); -- open file
-- hat
f_out:write('#Version: 1.0.0.0'..'\n')
f_out:write('ID;ObservationType;Details1;Details2;Details3;Details4;Details5;Details6;Deactivation;Class;Message;MinPendingTime;Latch1;Latch2;HigherPrioAlarm'..'\n')
local ii=0
for i=1,#APS_Struct do
  Type=AnsiToUtf8(APS_Struct[i].Type)
  ustName=AnsiToUtf8(APS_Struct[i].ustName)
  Comment=AnsiToUtf8(APS_Struct[i].Comment)  
  if Type == 'ХР' then 
    f_out:write(tostring(ii)..';Digital;algGVL.GPA_PPU_HR.'..ustName..';=;TRUE;;;;;Info;'..Comment..';t#0s;;;'..'\n')
    ii=ii+1
  end
end