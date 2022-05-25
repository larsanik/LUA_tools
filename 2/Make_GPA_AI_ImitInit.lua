os.execute( "chcp 65001 > nul" )
dofile('decode_Ansi_Utf8.lua'); --функция (внешняя) трансляции строк в utf8
--Таблица с данными полученная
dofile('IO_AI.lua') -- подключаемые внешние данные
name_list={}
local f_out = io.open('GPA_AI_ImitInit_Reset.txt','w+'); -- открытие фа
for i=1,#AI_Struct do
  AlgName=AnsiToUtf8(AI_Struct[i].Name)
  TypeADC=AnsiToUtf8(AI_Struct[i].TypeADC)
  if TypeADC=='4_20mA' then
    table.insert(name_list, AlgName)
  end
end

f_out:write('    //************ AI imit Init (начало) *************'..'\n')
for i=1, #name_list do
  f_out:write('    alggvl.GPA_AI_DRV.'..name_list[i]..' := 4.0;'..'\n')
end
f_out:write('    //************ AI imit Init (конец) *************'..'\n')
f_out:write('\n')
  
f_out:write('    //************ AI imit Reset (начало) *************'..'\n')
for i=1, #name_list do
  f_out:write('    alggvl.GPA_AI_DRV.'..name_list[i]..' := 0.0;'..'\n')
end
f_out:write('    //************ AI imit Reset (конец) *************'..'\n')
f_out:write('\n')

f_out:write('    //************ AI reset fault Init (начало) *************'..'\n')
for i=1,#AI_Struct do
  AlgName=AnsiToUtf8(AI_Struct[i].Name)
  f_out:write('    alggvl.GPA_AI_ToHMI.'..AlgName..'.manual := TRUE;'..'\n')
end
f_out:write('    //******************************************************'..'\n')
for i=1,#AI_Struct do
  AlgName=AnsiToUtf8(AI_Struct[i].Name)
  f_out:write('    alggvl.GPA_AI_ToHMI.'..AlgName..'.manual := FALSE;'..'\n')
end
f_out:write('    //************ AI reset fault Init (конец) *************')



f_out:flush() 
f_out:close()	