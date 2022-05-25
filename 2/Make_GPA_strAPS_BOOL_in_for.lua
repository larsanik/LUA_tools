os.execute( "chcp 65001 > nul" )
dofile('decode_Ansi_Utf8.lua'); --функция (внешняя) трансляции строк в utf8
--Таблица с данными полученная
dofile('APS.lua') 
List={}

for i=1,#APS_Struct do
  ustName=AnsiToUtf8(APS_Struct[i].ustName)
  Comment=AnsiToUtf8(APS_Struct[i].Comment)
  --List[i] = '    '..ustName..':BOOL; //'..Comment
  List[i] = '    '..ustName..':VGALG.strAlarm_Internal; //'..Comment
end
table.sort(List)
for i=1,#List do
print(List[i])
end
