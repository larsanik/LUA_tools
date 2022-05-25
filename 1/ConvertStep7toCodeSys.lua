print('Имя файла без расширения (файл должен иметь расширение SCL):')
local answer = io.read()
print('Обрабатывается файл ' .. answer..'.SCL')
f_source = io.open('g:/Projects/0_1_NevskoePHG/Software/SourceFromStep7/'..answer..'.SCL',"r");
f_convert = io.open('g:/Projects/0_1_NevskoePHG/Software/SourceFromStep7/'..answer..'_CoSy.EXP',"w+");
for line in f_source:lines() do
  add1 = ''
  add2 = ''
  --if string.find(line,'DATA_BLOCK') ~= nil then add = ' :' end
  --line=string.gsub(line,'DATA_BLOCK','TYPE')
  line=string.gsub(line,'bool','BOOL')
  line=string.gsub(line,'real','REAL')
  line=string.gsub(line,'byte','BYTE')
  line=string.gsub(line,'word','WORD')
  line=string.gsub(line,'dword','DWORD')
  line=string.gsub(line,'int','INT')
  line=string.gsub(line,'string','STRING')
  line=string.gsub(line,'not','NOT')
  line=string.gsub(line,'true','TRUE')
  line=string.gsub(line,'false','FALSE')
  line=string.gsub(line,'for','FOR')
  line=string.gsub(line,'do','DO')
  line=string.gsub(line,'end_for','END_FOR')
  line=string.gsub(line,'if','IF')
  line=string.gsub(line,'then','THEN')
  line=string.gsub(line,'end_if','END_IF')
  line=string.gsub(line,'and','AND')  
  line=string.gsub(line,'or','OR  ')  
  if string.find(line,'//') ~= nil then add1 = '*)' end
  if string.find(line,'//') == 1 then add2 = '*)' end
  line=string.gsub(line,'//','(*')
  --line=string.gsub(line,'BEGIN','')
  --line=string.gsub(line,'END_DATA_BLOCK','(END_TYPE')
  --if line ~= '' then   
    f_convert:write(line..add1..add2..'\n');
  --  end
  end
f_convert:flush();
f_convert:close();
f_source:close();
print('Результат в файле '..answer..'_CoSy.EXP')