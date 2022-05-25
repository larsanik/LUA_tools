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
dofile('IO_AO.lua') -- подключаемые внешние данные
local f_out = io.open('GPA_AO_CallAll.txt','w+'); -- открытие фа
f_out:write('//***************************************'..'\n')
f_out:write('//*  Сгенерировано: '..os.date('%d/%m/%Y %X')..'\n')
f_out:write('//*  Узел: '..selectedNode..'\n')
f_out:write('//***************************************'..'\n')
f_out:write('\n')
f_out:write('repTime := 3600;'..'\n')
f_out:write('IF NOT algGVL.init THEN'..'\n')
f_out:write(' //------------------------------- аргументы функции инициализации --------------------------------'..'\n')
f_out:write(' //                                 минимум шкалы канала, ед.изм. Не может быть >= max'..'\n')
f_out:write(' //                                 |   максимум шкалы канала, ед.изм. Не может быть <= min'..'\n')
f_out:write(' //                                 |   |   значение АЦП, соответствующее минимуму шкалы канала, б.р.'..'\n')
f_out:write(' //                                 |   |   |   значение АЦП, соотв. макс. шкалы, б.р. Не может быть равно minADC'..'\n')
f_out:write(' //                                 |   |   |   |    '..'\n')
f_out:write(' //                                 |   |   |   |   номер по порядку	'..'\n')
f_out:write(' //AO_init(UPG_AO_Settings.Pg_in_UPG,0.0,6.0,2.0,10.0,0);'..'\n')
f_out:write(' //-------------------------------------------------------------------------------------------'..'\n')
f_out:write(' //Начало сгенерированного кода AO_init'..'\n')
for i=1,#AO_Struct do
    if AnsiToUtf8(AO_Struct[i].Node)==selectedNode or selectedNode=='все' then
      f_out:write('//['..AnsiToUtf8(AO_Struct[i].Node)..'] ['..AnsiToUtf8(AO_Struct[i].Address)..'] ['..AnsiToUtf8(AO_Struct[i].AdrCh)..'] '..AnsiToUtf8(AO_Struct[i].Comment)..'\n')
      AlgName=AnsiToUtf8(AO_Struct[i].Name)
      min_PV=string.gsub(AnsiToUtf8(AO_Struct[i].LL), ',', '.')
      max_PV=string.gsub(AnsiToUtf8(AO_Struct[i].HL), ',', '.')
      minADC=string.gsub(AnsiToUtf8(AO_Struct[i].MinADC), ',', '.')
      maxADC=string.gsub(AnsiToUtf8(AO_Struct[i].MaxADC), ',', '.')
    f_out:write(' VGSig.fnAO_init(setStruct => algGVL.GPA_AO_Setting.'..AlgName..', min_PV := '..min_PV..', max_PV :=  '..max_PV..', minDAC := '..minADC..', maxDAC := '..maxADC..', id := '..i..');'..'\n')
    end
end
f_out:write(' //Конец сгенерированного кода'..'\n')
f_out:write('END_IF;'..'\n')
f_out:write('\n')
f_out:write('//Начало сгенерированного кода AO_Processing'..'\n')
for i=1,#AO_Struct do
  if AnsiToUtf8(AO_Struct[i].Node)==selectedNode or selectedNode=='все' then  
    f_out:write('//['..AnsiToUtf8(AO_Struct[i].Node)..'] ['..AnsiToUtf8(AO_Struct[i].Address)..'] ['..AnsiToUtf8(AO_Struct[i].AdrCh)..'] '..AnsiToUtf8(AO_Struct[i].Comment)..'\n')
    AlgName=AnsiToUtf8(AO_Struct[i].Name)
    f_out:write('VGSig.fnAO_Processing(IN := algGVL.GPA_AO.'..AlgName..', set := algGVL.GPA_AO_Setting.'..AlgName..', hmi := algGVL.GPA_AO_FromHMI.'..AlgName..', plc := algGVL.GPA_AO_ToHMI.'..AlgName..', out => algGVL.GPA_AO_DRV.'..AlgName..');'..'\n')
  end
end
f_out:write('//Конец сгенерированного кода'..'\n')
f_out:flush() 
f_out:close()	
print('Готого!')
print('Жми Enter!')
io.read()
