os.execute( "chcp 65001 > nul" )
dofile('decode_Ansi_Utf8.lua'); --функция (внешняя) трансляции строк в utf8
--Таблица с данными полученная
dofile('APS.lua') 
for i=1,#APS_Struct do
  if AnsiToUtf8(APS_Struct[i].UH) ~= '' then 
    print(AnsiToUtf8(APS_Struct[i].ustName)..'_v : REAL; //'..AnsiToUtf8(APS_Struct[i].Comment))
  end
  if AnsiToUtf8(APS_Struct[i].UL) ~= '' then 
    print(AnsiToUtf8(APS_Struct[i].ustName)..'_n : REAL; //'..AnsiToUtf8(APS_Struct[i].Comment))
  end
end