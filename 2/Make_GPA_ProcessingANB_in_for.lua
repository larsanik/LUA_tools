os.execute( "chcp 65001 > nul" )
dofile('decode_Ansi_Utf8.lua'); --функция (внешняя) трансляции строк в utf8
--Таблица с данными полученная
dofile('APS.lua') 
for i=1,#APS_Struct do
  ending = ''
  pref= ''
  flt=''
  UH=string.gsub(AnsiToUtf8(APS_Struct[i].UH), ',', '.')
  UL=string.gsub(AnsiToUtf8(APS_Struct[i].UL), ',', '.')
  Name=AnsiToUtf8(APS_Struct[i].Name)
  Comment=AnsiToUtf8(APS_Struct[i].Comment)
  ustName=AnsiToUtf8(APS_Struct[i].ustName)
  TypeSig=AnsiToUtf8(APS_Struct[i].TypeSig)
  Type=AnsiToUtf8(APS_Struct[i].Type)
  if UL ~= '' then ending = '_n'    end
  if UH ~= '' then ending = '_v'    end
  if TypeSig == 'Calc_AI' then pref = 'GPA_CalcPar' flt = 'fault' end
  if TypeSig == 'AI' then pref = 'GPA_AI_ToHMI'  flt = 'fault_common' end
  if ending ~= '' and (TypeSig == 'AI' or TypeSig == 'Calc_AI' ) then
    print('//'..Comment)
    print('algGVL.GPA_ANB.'..ustName..ending..' := VGALG.fnANB_Processing(algGVL.GPA_ANB_Settings.'..ustName..ending..',algGVL.'..pref..'.'..Name..'.PV,algGVL.'..pref..'.'..Name..'.'..flt..',algGVL.GPA_Ust.'..ustName..ending..', algGVL.GPA_ANB_Internal.'..ustName..ending..');')
    if string.find (Type, 'АО') ~= nil then 
      print('algGVL.'..pref..'.'..Name..'.as := algGVL.GPA_ANB.'..ustName..ending..';')
    elseif string.find (Type, 'ПС') ~= nil then 
      print('algGVL.'..pref..'.'..Name..'.ps := algGVL.GPA_ANB.'..ustName..ending..';')
    else
      print('algGVL.'..pref..'.'..Name..'.os := algGVL.GPA_ANB.'..ustName..ending..';')
    end
  end
end



--algGVL.GPA_ANB.As_Nst_v := VGALG.fnANB_Processing(algGVL.GPA_ANB_Settings.As_Nst_v,algGVL.GPA_CalcPar.Nst.PV,algGVL.GPA_CalcPar.Nst.fault,algGVL.GPA_Ust.As_Nst_v, algGVL.GPA_ANB_Internal.As_Nst_v);
--algGVL.GPA_CalcPar.Nst.as := algGVL.GPA_ANB.As_Nst_v;
--//algGVL.GPA_CalcPar.Nst.ps
