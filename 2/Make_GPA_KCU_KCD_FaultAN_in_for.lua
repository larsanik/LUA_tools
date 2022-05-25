os.execute( "chcp 65001 > nul" )
dofile('decode_Ansi_Utf8.lua'); --функция (внешняя) трансляции строк в utf8
--Таблица с данными полученная
dofile('IO_DI.lua') 
local f_out = io.open('GPA_KCU_KCD_FaultAN.txt','w+'); -- открытие фа
algGVL.alg.GR_anPar_fault :=
for i=1,#DI_Struct do
  Name = AnsiToUtf8(DI_Struct[i].Name)
  if string.find(Name, 'KCD') ~= nil then
    print(Name)
    end
end

--[[
//Аналоговые параметры неисправны
algGVL.alg.GR_anPar_fault :=
//--------------------------------------------------------------------------------
//Дискртеные датчики неисправны
algGVL.alg.GR_kcd_fault :=
//--------------------------------------------------------------------------------
//Цепи механизмов неисправны
algGVL.alg.GR_kcu_fault :=
//--------------------------------------------------------------------------------
]]--