os.execute( "chcp 65001 > nul" )
local computername = os.getenv('COMPUTERNAME')
dofile('decode_Ansi_Utf8.lua'); --функция (внешняя) трансляции строк в utf8
--Таблица с данными полученная
dofile('APS.lua') 

--перечни внутренних сигналов
GPA_PPU_GR={}

local f_out = io.open('Check_GR.txt','w+'); -- open file
-- hat
f_out:write('//***************************************'..'\n')
f_out:write('//*  Date: '..os.date('%d/%m/%Y %X')..'\n')
f_out:write('//*  Place: '..computername..'\n')
f_out:write('//***************************************'..'\n')
f_out:write('\n')
f_out:write('//Контроль ГР'..'\n')
f_out:write('algGVL.alg.JumpToGR := algGVL.GPA_BTN.GR OR algGVL.alg.JumpToGR AND NOT (algGVL.GPA_Mode.GR OR algGVL.GPA_BTN.Repair OR algGVL.GPA_BTN.HR);'..'\n')
f_out:write('algGVL.alg.Chk_GR := (algGVL.drm.KPK.complete OR algGVL.drm.PZM.complete OR algGVL.drm.Crank.complete OR algGVL.drm.VOb.complete OR algGVL.drm.NOs.complete OR  algGVL.alg.PZ_end  OR algGVL.drm.NOb.complete OR algGVL.alg.JumpToGR OR algGVL.alg.Chk_GR) AND NOT (algGVL.GPA_BTN.Repair OR algGVL.GPA_BTN.Pusk OR algGVL.GPA_BTN.HR OR algGVL.alg.flashHR or algGVL.alg.flashRemont);'..'\n')
f_out:write('\n')

-- неисправность дискретных дотчиков
dofile('IO_DI.lua') 
f_out:write('//Дискртеные датчики неисправны'..'\n')
f_out:write('algGVL.alg.GR_kcd_fault := NOT (')
oper=''
for i=1,#DI_Struct do
  Name = AnsiToUtf8(DI_Struct[i].Name)
  if string.find(Name, 'KCD') ~= nil then
    f_out:write(oper..'algGVL.GPA_DI.'..Name)
    oper=' AND '
    end
end
f_out:write(');'..'\n')
-- неисправность цепей управления 
f_out:write('//Цепи механизмов неисправны'..'\n')
f_out:write('algGVL.alg.GR_kcu_fault := NOT (')
oper=''
for i=1,#DI_Struct do
  Name = AnsiToUtf8(DI_Struct[i].Name)
  if string.find(Name, 'KCU') ~= nil then
    NameIncrKCU = string.gsub(Name,'_KCU','')
    --print(NameIncrKCU)
    f_out:write(oper..'(algGVL.GPA_DI.'..Name..' OR algGVL.GPA_DO.'..NameIncrKCU..')')
    oper=' AND '
    end
end
f_out:write(');'..'\n')

-- неисправность аналоговых датчиков
dofile('IO_AI.lua') 
dofile('IO_FI.lua') 
f_out:write('//Аналоговые параметры неисправны'..'\n')
f_out:write('algGVL.alg.GR_anPar_fault := ')
oper=''
for i=1,#AI_Struct do
  Name = AnsiToUtf8(AI_Struct[i].Name)
  f_out:write(oper..'algGVL.GPA_AI_ToHMI.'..Name..'.fault_common')
  oper=' OR '
end
for i=1,#FI_Struct do
  Name = AnsiToUtf8(FI_Struct[i].Name)
  f_out:write(oper..'algGVL.GPA_FI_ToHMI.'..Name..'.fault_common')
end

f_out:write(';'..'\n')

-- есть аварийные сигналы
dofile('APS.lua') 
f_out:write('//Есть аварийные сигналы'..'\n')
f_out:write('algGVL.alg.GR_AO_signals := ')
oper=''
for i=1,#APS_Struct do
  ustName = AnsiToUtf8(APS_Struct[i].ustName)
  if (string.find(ustName, 'As_') ~= nil) or (string.find(ustName, 'Ab_') ~= nil) then
    f_out:write(oper..'algGVL.GPA_APS.'..ustName)
    oper=' OR '
  end
end
f_out:write(';'..'\n')

f_out:write('\n')
f_out:write('algGVL.alg.GR_nRdy :=  false;'..'\n')
f_out:write('\n')
f_out:write('//--------------------------------------------------------------------------------'..'\n')

for i=1,#APS_Struct do
  ending = ''
  protect_up = ''
  protect_down = ''
  protect = ''
  UH=string.gsub(AnsiToUtf8(APS_Struct[i].UH), ',', '.')
  UL=string.gsub(AnsiToUtf8(APS_Struct[i].UL), ',', '.')
  Time=string.gsub(AnsiToUtf8(APS_Struct[i].Time), ',', '.')
  TypeSig=AnsiToUtf8(APS_Struct[i].TypeSig)
  Type=AnsiToUtf8(APS_Struct[i].Type)
  if Time == '' then Time = '0' end
  ustName=AnsiToUtf8(APS_Struct[i].ustName)
  Name=AnsiToUtf8(APS_Struct[i].Name)
  Comment=AnsiToUtf8(APS_Struct[i].Comment)  
  --ON/OF protect
  Protect_ON=AnsiToUtf8(APS_Struct[i].Protect_ON)  
  Protect_OF=AnsiToUtf8(APS_Struct[i].Protect_OF)  
  ProtectCODE=AnsiToUtf8(APS_Struct[i].ProtectCODE)  
  --[[
  if Protect_ON == 'вкл. питание' then protect_up = '' else protect_up = Protect_ON end
  if Protect_OF == 'откл. питание' then protect_down = '' else protect_down = Protect_OF end
  if protect_up ~= '' and protect_down ~= '' then protect = ' AND ('..protect_up..') AND NOT ('..protect_down..')' end
  if protect_up ~= '' and protect_down == '' then protect = ' AND ('..protect_up..')' end
  if protect_up == '' and protect_down ~= '' then protect = ' AND NOT ('..protect_down..')' end
  if ProtectCODE~='' then protect=' AND '..ProtectCODE end
  --]]
  Condition=AnsiToUtf8(APS_Struct[i].Condition)  
  
  if Type == 'ГР' then 
  if TypeSig == 'AI' or  TypeSig == 'Calc_AI' then --only for AI&Calc_AI
    if UL ~= '' then ending = '_n'    end
    if UH ~= '' then ending = '_v'    end
    f_out:write('//Поз. '..i..', '..Comment..'\n')
    f_out:write('algGVL.GPA_PPU_GR.'..ustName..' := algGVL.alg.Chk_GR AND algGVL.GPA_ANB.'..ustName..ending..protect..'; algGVL.alg.GR_nRdy := algGVL.alg.GR_nRdy or algGVL.GPA_PPU_GR.'..ustName..';'..'\n')
    table.insert(GPA_PPU_GR, ustName..':BOOL; //'..Comment..'\n')
    f_out:write('//--------------------------------------------------------------------------------'..'\n')
  elseif TypeSig == 'DI' then --only for DI
    f_out:write('//Поз. '..i..', '..Comment..'\n')
    f_out:write('algGVL.GPA_PPU_GR.'..ustName..' := algGVL.alg.Chk_GR AND algGVL.GPA_DI.'..Name..protect..'; algGVL.alg.GR_nRdy := algGVL.alg.GR_nRdy or algGVL.GPA_PPU_GR.'..ustName..';'..'\n')
    table.insert(GPA_PPU_GR, ustName..':BOOL; //'..Comment..'\n')
    f_out:write('//--------------------------------------------------------------------------------'..'\n')
  elseif TypeSig == 'NOT DI' then --only for NOT DI
    f_out:write('//Поз. '..i..', '..Comment..'\n')
    f_out:write('algGVL.GPA_PPU_GR.'..ustName..' := algGVL.alg.Chk_GR AND NOT algGVL.GPA_DI.'..Name..protect..'; algGVL.alg.GR_nRdy := algGVL.alg.GR_nRdy or algGVL.GPA_PPU_GR.'..ustName..';'..'\n')
    table.insert(GPA_PPU_GR, ustName..':BOOL; //'..Comment..'\n')    
    f_out:write('//--------------------------------------------------------------------------------'..'\n')
  elseif TypeSig == 'FR' then --only for FR
    f_out:write('//Поз. '..i..', '..Comment..'\n')
    f_out:write('algGVL.GPA_PPU_GR.'..ustName..' := algGVL.alg.Chk_GR AND NOT algGVL.GPA_FR.'..ustName..protect..'; algGVL.alg.GR_nRdy := algGVL.alg.GR_nRdy or algGVL.GPA_PPU_GR.'..ustName..';'..'\n')
    table.insert(GPA_PPU_GR, ustName..':BOOL; //'..Comment..'\n')        
    f_out:write('//--------------------------------------------------------------------------------'..'\n')
    elseif TypeSig == 'LG' then --only for LG
    f_out:write('//Поз. '..i..', '..Comment..'\n')
    f_out:write('algGVL.GPA_PPU_GR.'..ustName..' := algGVL.alg.Chk_GR AND NOT algGVL.alg.'..ustName..protect..'; algGVL.alg.GR_nRdy := algGVL.alg.GR_nRdy or algGVL.GPA_PPU_GR.'..ustName..';'..'\n')
    table.insert(GPA_PPU_GR, ustName..':BOOL; //'..Comment..'\n')    
    f_out:write('//--------------------------------------------------------------------------------'..'\n')
    elseif TypeSig == 'SR' then --only for SR
    f_out:write('//Поз. '..i..', '..Comment..'\n')
    f_out:write('algGVL.GPA_PPU_GR.'..ustName..' := algGVL.alg.Chk_GR AND NOT algGVL.GPA_SR.'..ustName..protect..'; algGVL.alg.GR_nRdy := algGVL.alg.GR_nRdy or algGVL.GPA_PPU_GR.'..ustName..';'..'\n')
    table.insert(GPA_PPU_GR, ustName..':BOOL; //'..Comment..'\n')    
    f_out:write('//--------------------------------------------------------------------------------')
    else  
  f_out:write('\n'..'No rules * '..TypeSig..' * '..ustName..' * '..Comment..'\n')
  f_out:write('//--------------------------------------------------------------------------------')
  end
end
end 
f_out:write('\n')
f_out:write('IF algGVL.ImitOn THEN algGVL.alg.GR_nRdy :=  FALSE; END_IF;'..'\n')
f_out:write('//---------------------------------------------------------------------'..'\n')
f_out:write('algGVL.GPA_TS.GR_Rdy := NOT (algGVL.alg.HR_nRdy OR algGVL.alg.GR_nRdy);'..'\n')
--f_out:write('//--------------------------------------------------------------------------------'..'\n')
f_out:flush() 
f_out:close()	
--struct strFR
local f_out_1 = io.open('strPPU_GR.txt','w+'); -- open file
f_out_1:write('TYPE strPPU_GR :'..'\n')
f_out_1:write('STRUCT'..'\n')
for i=1,#GPA_PPU_GR do
  f_out_1:write('    '..GPA_PPU_GR[i])
end
f_out_1:write('END_STRUCT'..'\n')
f_out_1:write('END_TYPE'..'\n')
f_out_1:flush() 
f_out_1:close()	
--[[
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
--]]