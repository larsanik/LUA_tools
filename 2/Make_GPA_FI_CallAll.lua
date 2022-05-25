os.execute( "chcp 65001 > nul" )
print('Какой узел будем собирать:')
print('1 - все')
print('2 - БУ')
--print('3 - ЭС')
--print('4 - ЦБК')
--print('5 - АМГБ')
local answer = io.read()
if answer=='1' then selectedNode='все'
elseif answer=='2' then selectedNode='БУ'
--elseif answer=='3' then selectedNode='ЭС'
--elseif answer=='4' then selectedNode='ЦБК'
--elseif answer=='5' then selectedNode='АМГБ'
else 
print('Введено некоректное значение!')
  print('Жми Enter!')
  io.read()
  return
  end
print('Собираю узел: ' .. selectedNode)
dofile('decode_Ansi_Utf8.lua'); --функция (внешняя) трансляции строк в utf8
--Таблица с данными полученная
dofile('IO_FI.lua') -- подключаемые внешние данные
local f_out = io.open('GPA_FI_CallAll.txt','w+'); -- открытие фа
f_out:write('//***************************************'..'\n')
f_out:write('//*  Сгенерировано: '..os.date('%d/%m/%Y %X')..'\n')
f_out:write('//*  Узел: '..selectedNode..'\n')
f_out:write('//***************************************'..'\n')
f_out:write('\n')
f_out:write('repTime := 3600;'..'\n')
f_out:write('IF NOT algGVL.init THEN'..'\n')
f_out:write(' //------------------------------- аргументы функции инициализации --------------------------------'..'\n')
f_out:write(' // 1                                минимум шкалы канала, ед.изм. Не может быть >= max'..'\n')
f_out:write(' // 2                                |   максимум шкалы канала, ед.изм. Не может быть <= min'..'\n')
f_out:write(' // 3                                |   |   значение АЦП, соответствующее минимуму шкалы канала, б.р.'..'\n')
f_out:write(' // 4                                |   |   |   значение АЦП, соотв. макс. шкалы, б.р. Не может быть равно minADC'..'\n')
f_out:write(' // 5                                |   |   |   |     уровень зашкала вниз, ед.изм. Не может быть >= hiLim и < min'..'\n')
f_out:write(' // 6                                |   |   |   |     |    уровень зашкала вверх, ед.изм. Не может быть <= loLim и > max'..'\n')
f_out:write(' // 7                                |   |   |   |     |    |   уровень обрыва вниз, ед.изм. Не может быть >= loLim'..'\n')
f_out:write(' // 8                                |   |   |   |     |    |    |   уровень обрыва вверх, ед.изм. Не может быть <= hiLim'..'\n')
f_out:write(' // 9                                |   |   |   |     |    |    |   |  макс. допустимая скорость роста, ед.изм./сек. Если «0» - скорость роста не анализируется'..'\n')
f_out:write(' //10                                |   |   |   |     |    |    |   |   |   время восстановления после неисправности, сек. Не может быть меньше "0"'..'\n')
f_out:write(' //11                                |   |   |   |     |    |    |   |   |   |   максимальное время в ремонте, сек. Не может быть меньше или равно «0»'..'\n')
f_out:write(' //12                                |   |   |   |     |    |    |   |   |   |   |    тау фильтра, сек. Если «0» - фильтрация отсутствует'..'\n')
f_out:write(' //13                                |   |   |   |     |    |    |   |   |   |   |    |  номер по порядку	'..'\n')
f_out:write(' //AI_init(UPG_AI_Settings.Pg_in_UPG,0.0,6.0,2.0,10.0,-0.5,6.5,-1.0,7.0,0.0,1.0,3600,1.0,0);'..'\n')
f_out:write(' //-------------------------------------------------------------------------------------------'..'\n')
f_out:write(' //Начало сгенерированного кода AI_init'..'\n')
for i=1,#AI_Struct do
    if AnsiToUtf8(AI_Struct[i].Node)==selectedNode or selectedNode=='все' then
      f_out:write('//['..AnsiToUtf8(AI_Struct[i].Node)..'] ['..AnsiToUtf8(AI_Struct[i].Address)..'] ['..AnsiToUtf8(AI_Struct[i].AdrCh)..'] '..AnsiToUtf8(AI_Struct[i].Comment)..'\n')
      AlgName=AnsiToUtf8(AI_Struct[i].Name)
      min_PV=AnsiToUtf8(AI_Struct[i].LL)
      max_PV=AnsiToUtf8(AI_Struct[i].HL)
      --TypeADC=AnsiToUtf8(AI_Struct[i].TypeADC)
      --print(min_PV)
      --print(max_PV)
      --min_PV=string.gsub(min_PV, ',', '.')
      --max_PV=string.gsub(max_PV, ',', '.')
      --if TypeADC=='thermocouple' then
       -- minADC=min_PV
       -- maxADC=max_PV
      --elseif TypeADC=='4_20mA' then
       -- minADC=4
       -- maxADC=20
      --elseif TypeADC=='0_20mA' then
       -- minADC=0
        --maxADC=20
      --elseif TypeADC=='2_10V' then
        --minADC=2
        --maxADC=10
      --elseif TypeADC=='0_10V' then
       -- minADC=0
        --maxADC=10
      --else
        minADC=AnsiToUtf8(AI_Struct[i].HzL)
        maxADC=AnsiToUtf8(AI_Struct[i].HzH)
      --end
    span=math.abs(max_PV - min_PV)
    loLim=min_PV-span*0.03
    hiLim=max_PV+span*0.03
    loBrk=min_PV-span*0.06
    hiBrk=max_PV+span*0.06
    f_out:write(' VGSig.fnAI_init(setStruct => algGVL.GPA_FI_Setting.'..AlgName..', min_PV := '..min_PV..', max_PV :=  '..max_PV..', minADC := '..minADC..', maxADC := '..maxADC..', loLim := '..loLim..', hiLim := '..hiLim..', loBrk := '..loBrk..', hiBrk := '..hiBrk..', maxROC:= 0.0, recoveryTime:= 5.0, repairTime :=repTime, tau:= 1.0, id := '..i..', corrADC := 0.0);'..'\n')
    end
end
f_out:write(' //Конец сгенерированного кода'..'\n')
f_out:write('END_IF;'..'\n')
f_out:write('\n')
f_out:write('//Начало сгенерированного кода AI_Processing'..'\n')
for i=1,#AI_Struct do
  if AnsiToUtf8(AI_Struct[i].Node)==selectedNode or selectedNode=='все' then  
    f_out:write('//['..AnsiToUtf8(AI_Struct[i].Node)..'] ['..AnsiToUtf8(AI_Struct[i].Address)..'] ['..AnsiToUtf8(AI_Struct[i].AdrCh)..'] '..AnsiToUtf8(AI_Struct[i].Comment)..'\n')
    AlgName=AnsiToUtf8(AI_Struct[i].Name)
    f_out:write('VGSig.fnAI_Processing(IN := algGVL.GPA_FI_DRV.'..AlgName..', set := algGVL.GPA_FI_Setting.'..AlgName..', btn := algGVL.GPA_FI_FromHMI.'..AlgName..', out := algGVL.GPA_FI_ToHMI.'..AlgName..', my := algGVL.GPA_FI_Internal.'..AlgName..', nOk :=  algGVL.alg.AI_FLT);'..'\n')
  end
end
f_out:write('//Конец сгенерированного кода'..'\n')
f_out:flush() 
f_out:close()	
print('Готого!')
print('Жми Enter!')
io.read()
