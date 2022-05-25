os.execute( "chcp 65001 > nul" )
dofile('decode_Ansi_Utf8.lua'); --функция (внешняя) трансляции строк в utf8
--Таблица с данными полученная
dofile('AM.lua') 
print('//*****************************************************************')
print('//*        Привязка концевиков драйвера к иммитатору им           *')
print('//*****************************************************************')
for i=1,#AM_Struct do
print('//'..AnsiToUtf8(AM_Struct[i].Comment))
Type=AnsiToUtf8(AM_Struct[i].Type)
Name=AnsiToUtf8(AM_Struct[i].Name)
iCon=AnsiToUtf8(AM_Struct[i].iCon)
iCoff=AnsiToUtf8(AM_Struct[i].iCoff)

  if Type=='AM_1x1' then
    print('algGVL.GPA_DI_DRV.'..Name..'_ON := iOn_im[amGVL.'..Name..'];')
    end-- ИМ 1Q 1FB
  if Type=='AM_1x2' then
    print('algGVL.GPA_DI_DRV.'..Name..'_ON := iOn_im[amGVL.'..Name..'];')
    print('algGVL.GPA_DI_DRV.'..Name..'_OF := iOff_im[amGVL.'..Name..'];')
    end-- ИМ 1Q 2FB
  if Type=='AM_2x1' then
    print('algGVL.GPA_DI_DRV.'..Name..'_ON := iOn_im[amGVL.'..Name..'];')
    end-- ИМ 2Q 1FB
  if Type=='AM_2x2' then
    print('algGVL.GPA_DI_DRV.'..Name..'_ON := iOn_im[amGVL.'..Name..'];')
    print('algGVL.GPA_DI_DRV.'..Name..'_OF := iOff_im[amGVL.'..Name..'];')
    end-- ИМ 2Q 2FB
  if Type=='AM_2x2_fH' then
    print('algGVL.GPA_DI_DRV.'..Name..'_ON := iOn_im[amGVL.'..Name..'];')
    print('algGVL.GPA_DI_DRV.'..Name..'_OF := iOff_im[amGVL.'..Name..'];')
    end-- ИМ 2Q(Fors+Hold) 2FB
  if Type=='AM_1x1_inv' then
    print('algGVL.GPA_DI_DRV.'..Name..'_OF := iOff_im[amGVL.'..Name..'];')    
    end-- ИМ 1Q 1FB с командой/конечником OFF
  if Type=='AM_1x2_inv' then
    print('algGVL.GPA_DI_DRV.'..Name..'_ON := iOn_im[amGVL.'..Name..'];')
    print('algGVL.GPA_DI_DRV.'..Name..'_OF := iOff_im[amGVL.'..Name..'];')
    end-- ИМ 1Q 2FB с командой OFF и двумя конечниками
  if Type=='AM_1x1_cfb' then
    print('algGVL.GPA_DI_DRV.'..Name..'_OF := iOff_im[amGVL.'..Name..'];')
    end-- ИМ 1Q 1FB с командой ON/ конечником OF
  if Type=='AM_2x2_fPos' then
    print('algGVL.GPA_DI_DRV.'..Name..'_ON := iOn_im[amGVL.'..Name..'];')
    print('algGVL.GPA_DI_DRV.'..Name..'_OF := iOff_im[amGVL.'..Name..'];')
    end-- ИМ 2Q с удержанием каждого положения 2 FB
  --[[
  if Type=='AM_AxA' then
    print('    States_anAM[anamGVL.'..Name..'].modeManual := NOT algGVL.GPA_TS.DU_IM;')
	  --print('    alganAM[anamGVL.'..Name..'].on := FALSE;')
	  --print('    alganAM[anamGVL.'..Name..'].off := FALSE;')
    --print('    IoAnAM[anamGVL.'..Name..'].iOn := algGVL.GPA_DI.'..Name..'_ON;')
    --print('    IoAnAM[anamGVL.'..Name..'].iOff  := algGVL.GPA_DI.'..Name..'_OF;')
    print('    IoAnAM[anamGVL.'..Name..'].iPos := algGVL.GPA_AI_ToHMI.'..Name..'.PV;')
    print('    IoAnAM[anamGVL.'..Name..'].iCpos := algGVL.GPA_AI_ToHMI.'..Name..'_KCU.PV;')    
    print('    IoAnAM[anamGVL.'..Name..'].qPos := algGVL.GPA_AO.'..Name..';')        
    if iCon=='1' then print('    IoAnAM[anamGVL.'..Name..'].iCon := algGVL.GPA_DI.'..Name..'_ON_KCU;') else print('    IoAnAM[anamGVL.'..Name..'].iCon := TRUE;') end
    if iCoff=='1' then print('    IoAnAM[anamGVL.'..Name..'].iCoff := algGVL.GPA_DI.'..Name..'_OF_KCU;') else print('    IoAnAM[anamGVL.'..Name..'].iCoff := TRUE;') end
    --print('    algGVL.GPA_DO.'..Name..'_ON := IoAnAM[anamGVL.'..Name..'].qOn;')
    --print('    algGVL.GPA_DO.'..Name..'_OF := IoAnAM[anamGVL.'..Name..'].qOff;')
    end-- ИМ AO управление AI положение
  if Type=='AM_AxAD' then
    print('    States_anAM[anamGVL.'..Name..'].modeManual := NOT algGVL.GPA_TS.DU_IM;')
	  --print('    alganAM[anamGVL.'..Name..'].on := FALSE;')
	  --print('    alganAM[anamGVL.'..Name..'].off := FALSE;')    print('    IoAnAM[anamGVL.'..Name..'].iOn := algGVL.GPA_DI.'..Name..'_ON;')
    print('    IoAnAM[anamGVL.'..Name..'].iOff  := algGVL.GPA_DI.'..Name..'_OF;')
    print('    IoAnAM[anamGVL.'..Name..'].iPos := algGVL.GPA_AI_ToHMI.'..Name..'.PV;')
    print('    IoAnAM[anamGVL.'..Name..'].iCpos := algGVL.GPA_AI_ToHMI.'..Name..'_KCU.PV;')    
    print('    IoAnAM[anamGVL.'..Name..'].qPos := algGVL.GPA_AO.'..Name..';')        
    if iCon=='1' then print('    IoAnAM[anamGVL.'..Name..'].iCon := algGVL.GPA_DI.'..Name..'_ON_KCU;') else print('    IoAnAM[anamGVL.'..Name..'].iCon := TRUE;') end
    if iCoff=='1' then print('    IoAnAM[anamGVL.'..Name..'].iCoff := algGVL.GPA_DI.'..Name..'_OF_KCU;') else print('    IoAnAM[anamGVL.'..Name..'].iCoff := TRUE;') end
    --print('    algGVL.GPA_DO.'..Name..'_ON := IoAnAM[anamGVL.'..Name..'].qOn;')
    --print('    algGVL.GPA_DO.'..Name..'_OF := IoAnAM[anamGVL.'..Name..'].qOff;')
    end-- ИМ AO управление AI, DI положение
  if Type=='AM_DxA' then
    print('    States_anAM[anamGVL.'..Name..'].modeManual := NOT algGVL.GPA_TS.DU_IM;')
	  print('    alganAM[anamGVL.'..Name..'].on := FALSE;')
	  print('    alganAM[anamGVL.'..Name..'].off := FALSE;')
    --print('    IoAnAM[anamGVL.'..Name..'].iOn := algGVL.GPA_DI.'..Name..'_ON;')
    --print('    IoAnAM[anamGVL.'..Name..'].iOff  := algGVL.GPA_DI.'..Name..'_OF;')
    print('    IoAnAM[anamGVL.'..Name..'].iPos := algGVL.GPA_AI_ToHMI.'..Name..'.PV;')
    --print('    IoAnAM[anamGVL.'..Name..'].iCpos := algGVL.GPA_AI_ToHMI.'..Name..'_KCU.PV;')    
    --print('    IoAnAM[anamGVL.'..Name..'].qPos := algGVL.GPA_AO.'..Name..';')        
    if iCon=='1' then print('    IoAnAM[anamGVL.'..Name..'].iCon := algGVL.GPA_DI.'..Name..'_ON_KCU;') else print('    IoAnAM[anamGVL.'..Name..'].iCon := TRUE;') end
    if iCoff=='1' then print('    IoAnAM[anamGVL.'..Name..'].iCoff := algGVL.GPA_DI.'..Name..'_OF_KCU;') else print('    IoAnAM[anamGVL.'..Name..'].iCoff := TRUE;') end
    print('    algGVL.GPA_DO.'..Name..'_ON := IoAnAM[anamGVL.'..Name..'].qOn;')
    print('    algGVL.GPA_DO.'..Name..'_OF := IoAnAM[anamGVL.'..Name..'].qOff;')
    end-- ИМ DO управление AI положение
--]]
end

