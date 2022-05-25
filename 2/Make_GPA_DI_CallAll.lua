os.execute( "chcp 65001 > nul" )
print('Какой узел будем собирать:')
print('1 - все')
print('2 - БУ')
print('3 - ЭС')
print('4 - ЦБК')
print('5 - АМГБ')
local answer = io.read()
if answer=='1' then selectedNode='все'
elseif answer=='2' then selectedNode='БУ'
elseif answer=='3' then selectedNode='ЭС'
elseif answer=='4' then selectedNode='ЦБК'
elseif answer=='5' then selectedNode='АМГБ'
else 
print('Введено некоректное значение!')
  print('Жми Enter!')
  io.read()
  return
  end
print('Собираю узел: ' .. selectedNode)
dofile('decode_Ansi_Utf8.lua'); --функция (внешняя) трансляции строк в utf8
--Таблица с данными полученная
dofile('IO_DI.lua') -- подключаемые внешние данные
local f_out = io.open('GPA_DI_CallAll.txt','w+'); -- открытие фа
f_out:write('//***************************************'..'\n')
f_out:write('//*  Сгенерировано: '..os.date('%d/%m/%Y %X')..'\n')
f_out:write('//*  Узел: '..selectedNode..'\n')
f_out:write('//***************************************'..'\n')
f_out:write('\n')
f_out:write('repTime := 3600;'..'\n')
f_out:write('IF NOT algGVL.init THEN'..'\n')
f_out:write(' //------------------------------- аргументы функции инициализации --------------------------------'..'\n')
f_out:write(' //                              максимальное время в ремонте, сек. Не может быть меньше или равно «0»'..'\n')
f_out:write(' //                               |       задержка от дребезга'..'\n')
f_out:write(' //                               |       |    признак инверсии'..'\n')
f_out:write(' //                               |       |    |   номер по порядку'..'\n')
f_out:write(' //DI_init(GPA_DI_Settings.BK_OF,repTime,0.0,false,0);'..'\n')
f_out:write(' //-------------------------------------------------------------------------------------------'..'\n')
f_out:write(' //Начало сгенерированного кода DI_init'..'\n')
for i=1,#DI_Struct do
    if AnsiToUtf8(DI_Struct[i].Node)==selectedNode or selectedNode=='все' then
      f_out:write('//['..AnsiToUtf8(DI_Struct[i].Node)..'] ['..AnsiToUtf8(DI_Struct[i].Address)..'] ['..AnsiToUtf8(DI_Struct[i].AdrCh)..'] '..AnsiToUtf8(DI_Struct[i].Comment)..'\n')
      AlgName=AnsiToUtf8(DI_Struct[i].Name)
      f_out:write(' VGSig.fnDI_init(setStruct => algGVL.GPA_DI_Setting.'..AlgName..', repairTime :=repTime, del := 0.0, inv :=false, id := '..i..');'..'\n')
    end
end
f_out:write(' //Конец сгенерированного кода'..'\n')
f_out:write('END_IF;'..'\n')
f_out:write('\n')
f_out:write('//Начало сгенерированного кода DI_Processing'..'\n')
for i=1,#DI_Struct do
  if AnsiToUtf8(DI_Struct[i].Node)==selectedNode or selectedNode=='все' then  
    f_out:write('//['..AnsiToUtf8(DI_Struct[i].Node)..'] ['..AnsiToUtf8(DI_Struct[i].Address)..'] ['..AnsiToUtf8(DI_Struct[i].AdrCh)..'] '..AnsiToUtf8(DI_Struct[i].Comment)..'\n')
    AlgName=AnsiToUtf8(DI_Struct[i].Name)
    f_out:write('VGSig.fnDI_Processing(IN := algGVL.GPA_DI_DRV.'..AlgName..', externalFault := false, set := algGVL.GPA_DI_Setting.'..AlgName..', FromHMI := algGVL.GPA_DI_FromHMI.'..AlgName..', ToHMI := algGVL.GPA_DI_ToHMI.'..AlgName..', my := algGVL.GPA_DI_Internal.'..AlgName..', out :=  algGVL.GPA_DI.'..AlgName..');'..'\n')
  end
end
f_out:write('//Конец сгенерированного кода'..'\n')
f_out:flush() 
f_out:close()	
print('Готого!')
print('Жми Enter!')
io.read()
