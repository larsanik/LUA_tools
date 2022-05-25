os.execute( "chcp 65001 > nul" )
local computername = os.getenv('COMPUTERNAME')
dofile('decode_Ansi_Utf8.lua'); --функция (внешняя) трансляции строк в utf8
--Таблица с данными полученная
dofile('APS.lua') 

--перечни внутренних сигналов
GPA_PPU_HR={}
GPA_PPU_GR={}

local f_out = io.open('Check_HR.txt','w+'); -- open file
-- hat
f_out:write('//***************************************'..'\n')
f_out:write('//*  Date: '..os.date('%d/%m/%Y %X')..'\n')
f_out:write('//*  Place: '..computername..'\n')
f_out:write('//***************************************'..'\n')
f_out:write('\n')
f_out:write('//Контроль ХР'..'\n')
f_out:write('algGVL.alg.JumpToHR := algGVL.GPA_BTN.HR or algGVL.alg.JumpToHR and not (algGVL.GPA_Mode.HR or algGVL.GPA_BTN.Repair or algGVL.GPA_BTN.GR);'..'\n')
f_out:write('algGVL.alg.Chk_HR := (algGVL.drm.KPK.complete or algGVL.drm.PZM.complete or algGVL.drm.Crank.complete or algGVL.drm.NOs.complete or algGVL.drm.NOb.complete or algGVL.alg.JumpToHR or algGVL.alg.PZ_end or algGVL.alg.Chk_HR) and not (algGVL.GPA_BTN.Repair or algGVL.GPA_BTN.GR or algGVL.GPA_BTN.Pusk or algGVL.tmo.OverTime_HR or algGVL.GPA_Mode.GR or algGVL.alg.flashRemont);'..'\n')
f_out:write('algGVL.alg.HR_nRdy := FALSE;'..'\n')
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
  
  if Type == 'ХР' then 
  if TypeSig == 'AI' or  TypeSig == 'Calc_AI' then --only for AI&Calc_AI
    if UL ~= '' then ending = '_n'    end
    if UH ~= '' then ending = '_v'    end
    f_out:write('//Поз. '..i..', '..Comment..'\n')
    f_out:write('algGVL.GPA_PPU_HR.'..ustName..' := (algGVL.alg.Chk_HR OR algGVL.alg.Chk_GR) AND algGVL.GPA_ANB.'..ustName..ending..protect..'; algGVL.alg.HR_nRdy := algGVL.alg.HR_nRdy or algGVL.GPA_PPU_HR.'..ustName..';'..'\n')
    table.insert(GPA_PPU_HR, ustName..':BOOL; //'..Comment..'\n')
    f_out:write('//--------------------------------------------------------------------------------'..'\n')
  elseif TypeSig == 'DI' then --only for DI
    f_out:write('//Поз. '..i..', '..Comment..'\n')
    f_out:write('algGVL.GPA_PPU_HR.'..ustName..' := (algGVL.alg.Chk_HR OR algGVL.alg.Chk_GR) AND algGVL.GPA_DI.'..Name..protect..'; algGVL.alg.HR_nRdy := algGVL.alg.HR_nRdy or algGVL.GPA_PPU_HR.'..ustName..';'..'\n')
    table.insert(GPA_PPU_HR, ustName..':BOOL; //'..Comment..'\n')
    f_out:write('//--------------------------------------------------------------------------------'..'\n')
  elseif TypeSig == 'NOT DI' then --only for NOT DI
    f_out:write('//Поз. '..i..', '..Comment..'\n')
    f_out:write('algGVL.GPA_PPU_HR.'..ustName..' := (algGVL.alg.Chk_HR OR algGVL.alg.Chk_GR) AND NOT algGVL.GPA_DI.'..Name..protect..'; algGVL.alg.HR_nRdy := algGVL.alg.HR_nRdy or algGVL.GPA_PPU_HR.'..ustName..';'..'\n')
    table.insert(GPA_PPU_HR, ustName..':BOOL; //'..Comment..'\n')    
    f_out:write('//--------------------------------------------------------------------------------'..'\n')
  elseif TypeSig == 'FR' then --only for FR
    f_out:write('//Поз. '..i..', '..Comment..'\n')
    f_out:write('algGVL.GPA_PPU_HR.'..ustName..' := (algGVL.alg.Chk_HR OR algGVL.alg.Chk_GR) AND NOT algGVL.GPA_FR.'..ustName..protect..'; algGVL.alg.HR_nRdy := algGVL.alg.HR_nRdy or algGVL.GPA_PPU_HR.'..ustName..';'..'\n')
    table.insert(GPA_PPU_HR, ustName..':BOOL; //'..Comment..'\n')        
    f_out:write('//--------------------------------------------------------------------------------'..'\n')
    elseif TypeSig == 'LG' then --only for LG
    f_out:write('//Поз. '..i..', '..Comment..'\n')
    f_out:write('algGVL.GPA_PPU_HR.'..ustName..' := (algGVL.alg.Chk_HR OR algGVL.alg.Chk_GR) AND NOT algGVL.alg.'..ustName..protect..'; algGVL.alg.HR_nRdy := algGVL.alg.HR_nRdy or algGVL.GPA_PPU_HR.'..ustName..';'..'\n')
    table.insert(GPA_PPU_HR, ustName..':BOOL; //'..Comment..'\n')    
    f_out:write('//--------------------------------------------------------------------------------'..'\n')
    elseif TypeSig == 'SR' then --only for SR
    f_out:write('//Поз. '..i..', '..Comment..'\n')
    f_out:write('algGVL.GPA_PPU_HR.'..ustName..' := (algGVL.alg.Chk_HR OR algGVL.alg.Chk_GR) AND NOT algGVL.GPA_SR.'..ustName..protect..'; algGVL.alg.HR_nRdy := algGVL.alg.HR_nRdy or algGVL.GPA_PPU_HR.'..ustName..';'..'\n')
    table.insert(GPA_PPU_HR, ustName..':BOOL; //'..Comment..'\n')    
    f_out:write('//--------------------------------------------------------------------------------'..'\n')
    else  
  f_out:write('No rules * '..TypeSig..' * '..ustName..' * '..Comment..'\n')
  f_out:write('//--------------------------------------------------------------------------------'..'\n')
  end
end
end 
f_out:write('\n')
f_out:write('IF algGVL.ImitOn THEN algGVL.alg.HR_nRdy :=  FALSE; END_IF;'..'\n')
f_out:write('//---------------------------------------------------------------------'..'\n')
f_out:write('algGVL.GPA_TS.HR_Rdy := NOT algGVL.alg.HR_nRdy;'..'\n')
--f_out:write('//--------------------------------------------------------------------------------'..'\n')
f_out:flush() 
f_out:close()	
--struct strFR
local f_out_1 = io.open('strPPU_HR.txt','w+'); -- open file
f_out_1:write('TYPE strPPU_HR :'..'\n')
f_out_1:write('STRUCT'..'\n')
for i=1,#GPA_PPU_HR do
  f_out_1:write('    '..GPA_PPU_HR[i])
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