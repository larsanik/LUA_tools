os.execute( "chcp 65001 > nul" )
dofile('decode_Ansi_Utf8.lua'); --функция (внешняя) трансляции строк в utf8
--Таблица с данными полученная
dofile('IO_AI.lua') 
local f_out = io.open('alarm_msg_FltAn.csv','w+'); -- open file
-- hat
f_out:write('#Version: 1.0.0.0'..'\n')
f_out:write('ID;ObservationType;Details1;Details2;Details3;Details4;Details5;Details6;Deactivation;Class;Message;MinPendingTime;Latch1;Latch2;HigherPrioAlarm'..'\n')
local ii=0
for i=1,#AI_Struct do
  Name=AnsiToUtf8(AI_Struct[i].Name)
  Comment=AnsiToUtf8(AI_Struct[i].Comment)  
    f_out:write(tostring(ii)..';Digital;algGVL.GPA_AI_ToHMI.'..Name..'.fault_common;=;TRUE;;;;;Warning;'..Comment..';t#0s;;;'..'\n')
    ii=ii+1
    --if ii > 15 then return end
end
