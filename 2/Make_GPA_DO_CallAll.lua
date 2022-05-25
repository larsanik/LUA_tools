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
dofile('IO_DO.lua') -- подключаемые внешние данные
local f_out = io.open('GPA_DO_CallAll.txt','w+'); -- открытие фа
f_out:write('//***************************************'..'\n')
f_out:write('//*  Сгенерировано: '..os.date('%d/%m/%Y %X')..'\n')
f_out:write('//*  Узел: '..selectedNode..'\n')
f_out:write('//***************************************'..'\n')
f_out:write('\n')
f_out:write('//----------- Обработка дискретных выходов ---------------')
f_out:write('//Начало сгенерированного кода DO_Processing'..'\n')
for i=1,#DO_Struct do
  if AnsiToUtf8(DO_Struct[i].Node)==selectedNode or selectedNode=='все' then  
    f_out:write('//['..AnsiToUtf8(DO_Struct[i].Node)..'] ['..AnsiToUtf8(DO_Struct[i].Address)..'] ['..AnsiToUtf8(DO_Struct[i].AdrCh)..'] '..AnsiToUtf8(DO_Struct[i].Comment)..'\n')
    AlgName=AnsiToUtf8(DO_Struct[i].Name)
    f_out:write('VGSig.fnDO_Processing(algOut := algGVL.GPA_DO.'..AlgName..', fromHMI := algGVL.GPA_DO_FromHMI.'..AlgName..', toHMI := algGVL.GPA_DO_ToHMI.'..AlgName..', drv =>  algGVL.GPA_DO_DRV.'..AlgName..');'..'\n')
  end
end
f_out:write('//Конец сгенерированного кода'..'\n')
f_out:flush() 
f_out:close()	
print('Готого!')
print('Жми Enter!')
io.read()
