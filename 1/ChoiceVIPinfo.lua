f_source = io.open('g:/Projects/0_1_NevskoePHG/Software/Export/Conf_PLC.EXP',"r");
f_convert = io.open('g:/Projects/0_1_NevskoePHG/Software/Export/input_2.txt',"w+");
for line in f_source:lines() do
  if string.find(line,'_SECTION_NAME') ~= nil then add=line end
  --i=i+1
  if string.find(line,'_SYMBOLIC_NAME: \'PLC14_') ~= nil and string.find(add,'INPUT') ~= nil then 
    add=string.gsub(add,'_SECTION_NAME: \'','')
    add=string.gsub(add,'_INPUT','')
    add=string.gsub(add,'\'',';')
    --f_convert:write(add); 
    line=string.gsub(line,'_SYMBOLIC_NAME: \'','')
    line=string.gsub(line,'\'','')
    f_convert:write('MB_'..line..' := '.. line..';'..'\n'); 
    end
  end
f_convert:flush();
f_convert:close();
f_source:close();
print('Результат в файле out.txt')