os.execute( "chcp 65001 > nul" )
dofile('decode_Ansi_Utf8.lua'); --функция (внешняя) трансляции строк в utf8
--Таблица с данными полученная
dofile('APS.lua') 

--перечни внутренних сигналов и линков
FR={}
LG={}
SR={}
print('//--------------------------------------------------------------------------------')
for i=1,#APS_Struct do
  ending = ''
  protect_up = ''
  protect_down = ''
  protect = ''
  UH=string.gsub(AnsiToUtf8(APS_Struct[i].UH), ',', '.')
  UL=string.gsub(AnsiToUtf8(APS_Struct[i].UL), ',', '.')
  Time=string.gsub(AnsiToUtf8(APS_Struct[i].Time), ',', '.')
  TypeSig=AnsiToUtf8(APS_Struct[i].TypeSig)
  if Time == '' then Time = '0' end
  ustName=AnsiToUtf8(APS_Struct[i].ustName)
  Name=AnsiToUtf8(APS_Struct[i].Name)
  Comment=AnsiToUtf8(APS_Struct[i].Comment)  
  --ON/OF protect
  Protect_ON=AnsiToUtf8(APS_Struct[i].Protect_ON)  
  Protect_OF=AnsiToUtf8(APS_Struct[i].Protect_OF)  
  ProtectCODE=AnsiToUtf8(APS_Struct[i].ProtectCODE)  
  if Protect_ON == 'вкл. питание' then protect_up = '' else protect_up = Protect_ON end
  if Protect_OF == 'откл. питание' then protect_down = '' else protect_down = Protect_OF end
  if protect_up ~= '' and protect_down ~= '' then protect = ' AND ('..protect_up..') AND NOT ('..protect_down..')' end
  if protect_up ~= '' and protect_down == '' then protect = ' AND ('..protect_up..')' end
  if protect_up == '' and protect_down ~= '' then protect = ' AND NOT ('..protect_down..')' end
  if ProtectCODE~='' then protect=' AND '..ProtectCODE end
  
  Condition=AnsiToUtf8(APS_Struct[i].Condition)  
  
  if TypeSig == 'AI' or  TypeSig == 'Calc_AI' then --only for AI&Calc_AI
    if UL ~= '' then ending = '_n'    end
    if UH ~= '' then ending = '_v'    end
    print('//Поз. '..i..', '..Comment)
    print('VGALG.fnAPS_Processing( algGVL.GPA_ANB.'..ustName..ending..protect..', '..Time..', unlock, algGVL.GPA_APS_Internal.'..ustName..', GPA_FirstOutIndex, i, algGVL.GPA_APS.'..ustName..', new_wrn, new_crs, algGVL.GPA_Alarms, AlarmTarget);')    
    print('//--------------------------------------------------------------------------------')
  elseif TypeSig == 'DI' then --only for DI
    print('//Поз. '..i..', '..Comment)
    print('VGALG.fnAPS_Processing( algGVL.GPA_DI.'..Name..protect..', '..Time..', unlock, algGVL.GPA_APS_Internal.'..ustName..', GPA_FirstOutIndex, i, algGVL.GPA_APS.'..ustName..', new_wrn, new_crs, algGVL.GPA_Alarms, AlarmTarget);')    
    print('//--------------------------------------------------------------------------------')
  elseif TypeSig == 'NOT DI' then --only for NOT DI
    print('//Поз. '..i..', '..Comment)
    print('VGALG.fnAPS_Processing( NOT algGVL.GPA_DI.'..Name..protect..', '..Time..', unlock, algGVL.GPA_APS_Internal.'..ustName..', GPA_FirstOutIndex, i, algGVL.GPA_APS.'..ustName..', new_wrn, new_crs, algGVL.GPA_Alarms, AlarmTarget);')   
    print('//--------------------------------------------------------------------------------')
  elseif TypeSig == 'FR' then --only for FR
    print('//Поз. '..i..', '..Comment)
    print('VGALG.fnAPS_Processing( algGVL.GPA_FR.'..ustName..', 0.0, unlock, algGVL.GPA_APS_Internal.'..ustName..', GPA_FirstOutIndex, i, algGVL.GPA_APS.'..ustName..', new_wrn, new_crs, algGVL.GPA_Alarms, AlarmTarget);')
    print('//--------------------------------------------------------------------------------')
    table.insert(FR, ustName..':BOOL; //'..Comment)
  elseif TypeSig == 'LG' then --only for LG
    print('//Поз. '..i..', '..Comment)
    print('VGALG.fnAPS_Processing( algGVL.GPA_LG.'..ustName..protect..', '..Time..', unlock, algGVL.GPA_APS_Internal.'..ustName..', GPA_FirstOutIndex, i, algGVL.GPA_APS.'..ustName..', new_wrn, new_crs, algGVL.GPA_Alarms, AlarmTarget);')   
    print('//--------------------------------------------------------------------------------')
    table.insert(LG, ustName..':BOOL; //'..Comment)
   elseif TypeSig == 'SR' then --only for SR
    print('//Поз. '..i..', '..Comment)
    print('VGALG.fnAPS_Processing( algGVL.GPA_SR.'..ustName..protect..', '..Time..', unlock, algGVL.GPA_APS_Internal.'..ustName..', GPA_FirstOutIndex, i, algGVL.GPA_APS.'..ustName..', new_wrn, new_crs, algGVL.GPA_Alarms, AlarmTarget); //'..Comment)    
    print('//--------------------------------------------------------------------------------')
    table.insert(SR, ustName..':BOOL; //'..Comment)
  else  
  print('No rules * '..TypeSig..' * '..ustName..' * '..Comment)
  print('//--------------------------------------------------------------------------------')
  end
end
print('//--------------------------------------------------------------------------------')
--struct strFR
local f_out_1 = io.open('strFR.txt','w+'); -- open file
f_out_1:write('TYPE strFR :'..'\n')
f_out_1:write('STRUCT'..'\n')
for i=1,#FR do
  f_out_1:write('    '..FR[i]..'\n')
end
f_out_1:write('END_STRUCT'..'\n')
f_out_1:write('END_TYPE'..'\n')
f_out_1:flush() 
f_out_1:close()	

--struct strLG
local f_out_2 = io.open('strLG.txt','w+'); -- open file
f_out_2:write('TYPE strLG :'..'\n')
f_out_2:write('STRUCT'..'\n')
for i=1,#LG do
  f_out_2:write('    '..LG[i]..'\n')
end
f_out_2:write('END_STRUCT'..'\n')
f_out_2:write('END_TYPE'..'\n')
f_out_2:flush() 
f_out_2:close()	

--struct strSR
local f_out_3 = io.open('strSR.txt','w+'); -- open file
f_out_3:write('TYPE strSR :'..'\n')
f_out_3:write('STRUCT'..'\n')
for i=1,#SR do
  f_out_3:write('    '..SR[i]..'\n')
end
f_out_3:write('END_STRUCT'..'\n')
f_out_3:write('END_TYPE'..'\n')
f_out_3:flush() 
f_out_3:close()	