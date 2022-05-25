--Таблица с данными полученная
dofile('PPU_GR_List.txt') 
for i=1,#PPU_GR_Struct_Name do
--for i=0,47 do
--print('//'..PPU_GR_Struct_Name[i].Comment)
--print('PPU_GR.'..PPU_GR_Struct_Name[i].NameAPS..' := LG.PPU_GR_Check AND  NOT '..PPU_GR_Struct_Name[i].Name..';')
--print('                    PPU_GR.'..PPU_GR_Struct_Name[i].NameAPS..' OR')
print(PPU_GR_Struct_Name[i].Name..' := true;')
end