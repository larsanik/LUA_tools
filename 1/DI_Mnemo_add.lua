--Конвертер
dofile('decode_Ansi_Utf8.lua');
--Функции генерации UUID
modules = {uuid4 = "uuid4.lua"} 
uuid4= require("uuid4") -- не забудь поставить директрию файла как текущую))))
--function Make_Mnemo_Signal_DI(FolderAb,Pref_HMI_Str)
FolderAb = ''
Pref_HMI_Str = 'S2M.'

Template_Signals_DIO_Start = (''.."\n"
..'<Data>             '.."\n"
..'    <GraphicsCompositeFBType Name="T_DI_Mnemo_Add" UUID="0F397E90489C820499255F95C09D4A1E">             '.."\n"
..'        <InterfaceList>             '.."\n"
..'            <EventOutputs>			  '.."\n"
..'                <Event Name="mouseLBPress" Comment="mouse left button press event " UUID="299295AF47A6CCAC26009C964C5B47C5" />			  '.."\n"
..'                <Event Name="mouseLBRelease" Comment="mouse left button release event" UUID="8DE6001343803CF639F332B16CC30079" />			  '.."\n"
..'                <Event Name="mouseRBPress" Comment="mouse right button press event " UUID="5DE993F543E00267EF077D89D3D01B5B" />             '.."\n"
..'                <Event Name="mouseRBRelease" Comment="mouse right button release event" UUID="0AB0718D41E90B02F75425B41E39C1F0" />             '.."\n"
..'                <Event Name="mouseEnter" Comment="mouse enter event" UUID="AA1D53154C9D3E9C25B0ADA056F82B5D" />             '.."\n"
..'                <Event Name="mouseLeave" Comment="mouse leave event" UUID="C21BC0A24A8E157AF50BC59A1635CD7B" />             '.."\n"
..'                <Event Name="mouseLBDblClick" Comment="mouse double click event" UUID="1BD263D2412FA33DA367C5B3480C9F0A" />             '.."\n"
..'            </EventOutputs>             '.."\n"
..'            <InputVars>             '.."\n"
..'                <VarDeclaration Name="pos" Type="TPos" Comment="position of the object" InitialValue="(x:=0,y:=0)" UUID="599604C246641AA6BA0E508C9ABF7EA4" />             '.."\n"
..'                <VarDeclaration Name="angle" Type="LREAL" Comment="angle of rotation of the object" InitialValue="0" UUID="00FC1D804A2DE5A83DE85390D640AC3D" />             '.."\n"
..'                <VarDeclaration Name="enabled" Type="BOOL" InitialValue="TRUE" UUID="15B097034B9BBE7CCD78E0A466A64239" />             '.."\n"
..'                <VarDeclaration Name="moveable" Type="BOOL" InitialValue="FALSE" UUID="6D62810D46DF8C4B27E62DBEBA63194B" />             '.."\n"
..'                <VarDeclaration Name="visible" Type="BOOL" Comment="visibility of the object" InitialValue="TRUE" UUID="EAC5288F431A370F7493EF98A2C613D5" />             '.."\n"
..'                <VarDeclaration Name="zValue" Type="LREAL" Comment="z-level of the object" InitialValue="0" UUID="29E9E6AD475BD9B49E6F40B0328374A7" />             '.."\n"
..'                <VarDeclaration Name="hint" Type="STRING" Comment="hint of the object" InitialValue="&apos;&apos;" UUID="9001F21244C66932FB81B7B021B085BA" />             '.."\n"
..'                <VarDeclaration Name="size" Type="TSize" Comment="size of the rectangle" InitialValue="(width:=50,height:=50)" UUID="1555B4384D69683C33FCB4A79B1A0932" />             '.."\n"
..'                <VarDeclaration Name="PrefAb" Type="STRING" InitialValue="&apos;&apos;" UUID="BC235C584A1EB6143114E781839D3DE1" />             '.."\n"
..'                <VarDeclaration Name="NameRU" Type="STRING" InitialValue="&apos;&apos;" UUID="45D696EE4157CCC32B7D6D9E252868A5" />             '.."\n"
..'            </InputVars>             '.."\n"
..'        </InterfaceList>             '.."\n"
..'        <FBNetwork>             '.."\n"
)				
                

Template_Signals_DIO_End = (''.."\n"               
..'            </DataConnections>		'.."\n"
..'        </FBNetwork>		'.."\n"
..'    </GraphicsCompositeFBType>		'.."\n"
..'</Data>		'.."\n"
)

--Таблица с данными для DI 
dofile('DI_Mnemo_List.txt')


--Определение сколько будет файлов
local a,b = math.modf(#DI_Struct/64)
if b ~= 0 then num = a + 1 
else num = a
end 
--Определяем сколько элементов в последней группе не используются
num_last_group = 64 - (#DI_Struct - (num-1)*64)
--На лист помещается 64 AI
UUID = {}
for j=1,num do 
   --Открываем(создаем) выходной файл файл мнемосхем   
    f_struct = io.open('DI_Mnemo_Add_'..j..'.txt',"w"); 
   --Записываем начало
   f_struct:write(Template_Signals_DIO_Start)

    --Определяем попадание в последнюю группу
	if j==num then last_group = 1 else last_group = 0 end
	
  --генерим таблицу с UUID
  --UUID = {}
  for i=(j*64-63), (j*64 - num_last_group * last_group)  do curr_UUID = string.upper(string.gsub(uuid4.getUUID(), '-', '')) 
  table.insert(UUID, curr_UUID)
  end
  print(UUID[1])
  print(j)
  print(i)
  for i=(j*64-63), (j*64 - num_last_group * last_group)  do
      --расчитываем координаты сдвиг параметра на мнемосхеме
	    if  i <= j*64 -32 then
		 MX = 60  MY = (i - 64*(j-1))*23 - 23
        else
		 MX = 570 MY = (i-32 - 64*(j-1))*23 - 23 
		end		
	  --расчитывае координату х FB
	    x_FB = 500*i
      --определяем видимость
	    if string.find(DI_Struct[i].Name, 'Reserv') == nil then Mvisible = 'TRUE' else   Mvisible = 'FALSE' end
		if DI_Struct[i].Name ~= '' then NameAlg = DI_Struct[i].Name 
        else
           NameAlg = string.gsub(DI_Struct[i].Address, '%p', '_')
		   NameAlg = string.gsub(NameAlg, '%s', '_')
        end  
	  --удаляем  не правильные кавычки " из коментария
	     MComent = string.gsub(DI_Struct[i].Comment, '"', '')
	  --заполняем справку
         Mhint = DI_Struct[i].Address..': '..MComent..', ['..DI_Struct[i].TypeCh..']'..'\n'..DI_Struct[i].AdrCh
      
             
      --Записываем входные данные   
		 f_struct:write('<FB Name="DGI_'..i..'_'..AnsiToUtf8(NameAlg)..'" Type="TBase_DI_DO" TypeUUID="5298F3F94A79E35B818384B694BB561B" UUID="'..UUID[i]..'" X="0.0" Y="'..x_FB..'">'.."\n")
         f_struct:write('<VarValue Variable="pos" Value="(x:='..MX..',y:='..MY..')" Type="TPos" />'.."\n")
         f_struct:write('<VarValue Variable="HINT" Value="&apos;'..Mhint..'&apos;" Type="STRING" />'.."\n")
		 f_struct:write('<VarValue Variable="FORCE_PERMIT" Value="TRUE" Type="BOOL" />'.."\n")
         f_struct:write('<VarValue Variable="Name" Value="&apos;'..MComent..'&apos;" Type="STRING" />'.."\n")
		 f_struct:write('<VarValue Variable="PrefStr" Value="&apos;'..Pref_HMI_Str..'&apos;" Type="STRING" />'.."\n")
		 f_struct:write('<VarValue Variable="SourseD" Value="&apos;д.вх.&apos;" Type="STRING" />'.."\n")
		 f_struct:write('<VarValue Variable="NameAlg" Value="&apos;'..AnsiToUtf8(NameAlg)..'&apos;" Type="STRING" />'.."\n")
		 f_struct:write('<VarValue Variable="TagID" Value="&apos;'..AnsiToUtf8(NameAlg)..MComent..'&apos;" Type="STRING" />'.."\n")
         f_struct:write('<VarValue Variable="VisibleD" Value="'..Mvisible..'" Type="BOOL" />'.."\n")
         f_struct:write('</FB>'.."\n")
	end
	--Записываем середину
	f_struct:write('            <DataConnections>'.."\n")
    --Записываем связи      
    for i=(j*64-63), (j*64 - num_last_group * last_group) do
	    if DI_Struct[i].Name ~= '' then NameAlg = DI_Struct[i].Name 
        else
           NameAlg = string.gsub(DI_Struct[i].Address, '%p', '_')
		   NameAlg = string.gsub(NameAlg, '%s', '_')
        end 	
    	f_struct:write('<Connection Source="PrefAb" Destination="'..'DGI_'..i..'_'..AnsiToUtf8(NameAlg)..'.PrefAb" SourceUUID="BC235C584A1EB6143114E781839D3DE1" DestinationUUID="'..UUID[i]..'.FB48BEA74A28EB85591DC0B68AA08A74" />'.."\n")
        f_struct:write('<Connection Source="NameRU" Destination="'..'DGI_'..i..'_'..AnsiToUtf8(NameAlg)..'.NameRU" SourceUUID="45D696EE4157CCC32B7D6D9E252868A5" DestinationUUID="'..UUID[i]..'.524F2EBB4524C97C16682CAD9668D4CC" />'.."\n")
    end
   f_struct:write(Template_Signals_DIO_End)
   f_struct:flush()
   f_struct:close()   
--   end
end

--end