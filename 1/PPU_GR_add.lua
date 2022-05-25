--Функции генерации UUID
modules = {uuid4 = "uuid4.lua"} 
uuid4= require("uuid4") -- не забудь поставить директрию файла как текущую))))
--Функции преобразования кодировок utf8<-->ansi 
dofile('decode_Ansi_Utf8.lua');

--Таблица с данными полученная
dofile('PPU_GR_List.txt') 
--Начало и конец файла
Template_Alarm_Start = (''.."\n"
..'<Data>'.."\n"
..'    <CompositeFBType Name="T_PPU_GR_Add" Comment="Для создания дополнительных ППУ ГР" UUID="ACB751174AAFE17F2A6C428C8C84D712">'.."\n"
..'        <InterfaceList>'.."\n"
..'            <InputVars>'.."\n"
..'                <VarDeclaration Name="PrefAb" Type="STRING" InitialValue="&apos;&apos;" UUID="15CAEFA64E05F05E2E69EA9FFA392D2D" />'.."\n"
..'                <VarDeclaration Name="NameRU" Type="STRING" InitialValue="&apos;&apos;" UUID="9F1E9D344B2923E08A507A8FFFF20C05" />'.."\n"
..'            </InputVars>'.."\n"
..'        </InterfaceList>'.."\n"
..'        <FBNetwork>'.."\n"
)				
                

Template_Alarm_End = (''.."\n"               
..'            </DataConnections>'.."\n"
..'        </FBNetwork>'.."\n"
..'    </CompositeFBType>'.."\n"
..'</Data>'.."\n"
)

-- пока так
IO_Struct = PPU_GR_Struct_Name
Pref_HMI_Str = 'PPU_GR.'

--генерим таблицу с UUID
UUID = {}
for n=1,#IO_Struct do curr_UUID = string.upper(string.gsub(uuid4.getUUID(), '-', '')) 
table.insert(UUID, curr_UUID)
end

--if Fild_Serch == 'PS' then 
     
   Source = 'ГР'
   Category = '10200'
   
   --ќткрываем(создаем) выходной файл файл мнемосхем    
   local f_struct = io.open('T_PPU_GR_Add.txt',"w+");
   f_struct:write(Template_Alarm_Start)
	
	cur=0
	for i=1, #IO_Struct  do
	  if string.find(IO_Struct[i].Type, 'PPU_GR') ~= nil then
    cur = cur+1
	  x_FB = cur*250
	  
	   
	   --MComent = AnsiToUtf8(string.gsub(IO_Struct[i].Comment, '"', ''))
     MComent = string.gsub(IO_Struct[i].Comment, '"', '')
     --print(IO_Struct[i].Comment)
	   --ќпредел¤ем данные по плгоритмическим иминам, если имен нет берем им¤ из адреса
       NameAlg = IO_Struct[i].NameAPS 
       TAG = IO_Struct[i].Type
       
       
	   	  --Записываем входные данные   
		 f_struct:write('            <FB Name="Alarm_'..cur..'_'..AnsiToUtf8(NameAlg)..'" Type="TBaseAlarm" TypeUUID="FDF3516743AD251E202F19AC8317F746" UUID="'..UUID[i]..'" X="0.0" Y="'..x_FB..'">'.."\n")
         f_struct:write('<VarValue Variable="Name" Value="&apos;'..MComent..'&apos;" Type="STRING" />'.."\n")
	     f_struct:write('<VarValue Variable="Source" Value="&apos;'..Source..'&apos;" Type="STRING" />'.."\n")
         f_struct:write('<VarValue Variable="Category" Value="'..Category..'" Type="DINT" />'.."\n")
		 f_struct:write('<VarValue Variable="TagID" Value="&apos;'..AnsiToUtf8(NameAlg)..'_ID'..'&apos;" Type="STRING" />'.."\n")
		 f_struct:write('<VarValue Variable="NameAlg" Value="&apos;'..AnsiToUtf8(NameAlg)..'&apos;" Type="STRING" />'.."\n")
		 f_struct:write('<VarValue Variable="PrefStr" Value="&apos;'..Pref_HMI_Str..'&apos;" Type="STRING" />'.."\n")
		 f_struct:write('<VarValue Variable="TAG" Value="&apos;'..TAG..'&apos;" Type="STRING" />'.."\n")
		 f_struct:write('</FB>'.."\n")
	  end
     	  
	end
	cur=0
		--Записываем середину
	f_struct:write('            <DataConnections>'.."\n")
	    --Записываем связи      
	for i=1, #IO_Struct  do

	  if string.find(IO_Struct[i].Type, 'PPU_GR') ~= nil then
	  cur = cur+1
	    
		NameAlg = PPU_GR_Struct_Name[i].NameAPS 
        	
    	f_struct:write('<Connection Source="PrefAb" Destination="'..'Alarm_'..cur..'_'..AnsiToUtf8(NameAlg)..'.PrefAb" SourceUUID="15CAEFA64E05F05E2E69EA9FFA392D2D" DestinationUUID="'..UUID[i]..'.BF006B714315657CEF6F149C7EA85201" />'.."\n")
        f_struct:write('<Connection Source="NameRU" Destination="'..'Alarm_'..cur..'_'..AnsiToUtf8(NameAlg)..'.NameRU" SourceUUID="9F1E9D344B2923E08A507A8FFFF20C05" DestinationUUID="'..UUID[i]..'.8ABFE2D44BF39DC62F090CAA97DA29C7" />'.."\n")
		end
	 
    end
	cur=0
	
    f_struct:write(Template_Alarm_End)
	f_struct:flush() 
    f_struct:close()	
--end