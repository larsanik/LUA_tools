os.execute( "chcp 65001 > nul" )
dofile('decode_Ansi_Utf8.lua'); --функция (внешняя) трансляции строк в utf8
--Таблица с данными полученная
dofile('AM.lua') 
for i=1,#AM_Struct do
print(AnsiToUtf8(AM_Struct[i].Name)..' : INT := '..(i-1)..'; //'..AnsiToUtf8(AM_Struct[i].Comment))
end