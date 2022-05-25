os.execute( "chcp 65001 > nul" )
dofile('decode_Ansi_Utf8.lua'); --функция (внешняя) трансляции строк в utf8
--Таблица с данными полученная
dofile('APS.lua') 
for i=1,#APS_Struct do
  UH=string.gsub(AnsiToUtf8(APS_Struct[i].UH), ',', '.')
  UL=string.gsub(AnsiToUtf8(APS_Struct[i].UL), ',', '.')
  Time=string.gsub(AnsiToUtf8(APS_Struct[i].Time), ',', '.')
  if Time == '' then Time = '0' end
  if UH ~= '' then 
    print('    algGVL.GPA_ANB_Settings.'..AnsiToUtf8(APS_Struct[i].ustName)..'_v := VGALG.fnANB_init(TRUE, 0, '..Time..'); //'..AnsiToUtf8(APS_Struct[i].Comment))
    end
  if UL ~= '' then 
    print('    algGVL.GPA_ANB_Settings.'..AnsiToUtf8(APS_Struct[i].ustName)..'_n := VGALG.fnANB_init(FALSE, 0, '..Time..'); //'..AnsiToUtf8(APS_Struct[i].Comment))
  end
end