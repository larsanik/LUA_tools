os.execute( "chcp 65001 > nul" )
dofile('decode_Ansi_Utf8.lua'); --функция (внешняя) трансляции строк в utf8
--Таблица с данными полученная
dofile('APS.lua') 
--List={}

--algGVL.GPA_Alarms.Fire := 1;//Пожар 
--algGVL.GPA_Alarms.AOs := 2;//Аварийный останов со стравливанием 
--algGVL.GPA_Alarms.AOb := 3;//Аварийный останов без стравливания 
--algGVL.GPA_Alarms.VOs := 4;//Вынужденный останов со стравливанием 
--algGVL.GPA_Alarms.VOb := 5;//Вынужденный останов без стравливания 
--algGVL.GPA_Alarms.AS := 6;//Авариная сигнализация без останова 
--algGVL.GPA_Alarms.PS := 7;//Предупредительная сигнализация 
--algGVL.GPA_Alarms.OS := 8;//Ограничительная сигнализация 


for i=1,#APS_Struct do
  ending = ''
  alarms = ''
  UH=string.gsub(AnsiToUtf8(APS_Struct[i].UH), ',', '.')
  UL=string.gsub(AnsiToUtf8(APS_Struct[i].UL), ',', '.')
  if UL ~= '' then ending = '_n'    end
  if UH ~= '' then ending = '_v'    end
  ustName=AnsiToUtf8(APS_Struct[i].ustName)
  Comment=AnsiToUtf8(APS_Struct[i].Comment)
  if string.find (ustName, 'Ab_') ~= nil then alarms = 'AOb' end
  if string.find (ustName, 'As_') ~= nil then alarms = 'AOs' end
  if string.find (ustName, 'GR_') ~= nil then alarms = 'OS' end
  if string.find (ustName, 'HR_') ~= nil then alarms = 'OS' end
  if string.find (ustName, 'Nb_') ~= nil then alarms = 'VOb' end
  if string.find (ustName, 'Ns_') ~= nil then alarms = 'VOs' end
  if string.find (ustName, 'P_') ~= nil then alarms = 'PS' end
  print('   algGVL.GPA_APS_Internal.'..ustName..'.target := algGVL.GPA_Alarms.'..alarms..'; //'..Comment)
end