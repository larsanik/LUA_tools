os.execute( "chcp 65001 > nul" )
dofile('decode_Ansi_Utf8.lua'); --функция (внешняя) трансляции строк в utf8
--Таблица с данными полученная
dofile('APS.lua') 
for i=1,#APS_Struct do
  UH=string.gsub(AnsiToUtf8(APS_Struct[i].UH), ',', '.')
  UL=string.gsub(AnsiToUtf8(APS_Struct[i].UL), ',', '.')
  if UH ~= '' then 
    print('    algGVL.GPA_Ust.'..AnsiToUtf8(APS_Struct[i].ustName)..'_v := '..UH..'; //'..AnsiToUtf8(APS_Struct[i].Comment))
  end
  if UL ~= '' then 
    print('    algGVL.GPA_Ust.'..AnsiToUtf8(APS_Struct[i].ustName)..'_n := '..UL..'; //'..AnsiToUtf8(APS_Struct[i].Comment))
  end
end