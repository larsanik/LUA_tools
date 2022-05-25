--Настройки ведомости и Таблица с данными 
dofile('Par_List_Nev.txt') 


for s=1,2 do -- smen 1
if s==1 then 
  szOutFile = szOutFile1
  szSmena = szSmena1
  szTime = szTime1
  end
if s==2 then --smen 2
  szOutFile = szOutFile2
  szSmena = szSmena2
  szTime = szTime2
  end


--Начало и конец файла
Template_SV_Start = (''.."\n"
..'<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">'.."\n"
..'<html><head><meta charset="utf-8"  name="qrichtext" content="1" /><style type="text/css">'.."\n"
..'p, li { white-space: pre-wrap; }'.."\n"
..'</style></head><body style=" font-family:\'Arial Narrow\'; font-size:12pt; font-weight:400; font-style:normal;">'.."\n"
..'<p align="center" style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:\'MS Shell Dlg 2\'; font-size:14pt; font-weight:600;">'..szPlace..'</span></p>'.."\n"
..'<p align="center" style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:\'MS Shell Dlg 2\'; font-size:14pt; font-weight:600;">'..szObject..'</span></p>'.."\n"
..'<p align="center" style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:\'MS Shell Dlg 2\'; font-size:14pt; font-weight:600;">'..szUnit..'</span></p>'.."\n"
..'<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:\'MS Shell Dlg 2\'; font-size:14pt; font-weight:600;">	</span><span style=" font-family:\'MS Shell Dlg 2\'; font-size:14pt; font-weight:600;">Дата</span><span style=" font-family:\'MS Shell Dlg 2\'; font-size:14pt; font-weight:600;">	</span>  <span style=" font-family:\'PT Sans\'; text-decoration: ;  "><!--RPT DT:TODAY"%Y.%m.%d" --></span> <span style=" font-size:14pt;">		</span></p>'.."\n"
..'<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><br /></p>'.."\n"
..'<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:14pt;">	</span><span style="font-family:\'MS Shell Dlg 2\'; font-size:14pt; font-weight:600;">'..szSmena..'</span></p>'.."\n"
..'<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style="font-family:\'MS Shell Dlg 2\'; font-size:14pt; font-weight:600;">		Сменный инженер	_______________________      Сменный машинист _______________________</span></p>'.."\n"
..'<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-weight:600;"><br /></p>'.."\n"
..'<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-weight:600;"><br /></p>'.."\n"
..'<table border="1" style=" margin-top:0px; margin-bottom:0px; margin-left:10px; margin-right:0px;" width="100%" cellspacing="1" cellpadding="1" bgcolor="#ffffff">'.."\n"
..'<tr>'.."\n"
..'<td colspan="2">'.."\n"
..'<p align="right" style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style="font-family:\'MS Shell Dlg 2\'; font-size:14pt; font-weight:600;">Время</span></p></td>'.."\n"
--..'<td width="100">'.."\n"
)				
                

Template_SV_End = (''.."\n"               
..'</table>'.."\n"
..'<p align="center" style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:\'MS Shell Dlg 2\'; font-size:8pt;"><br /></p>'.."\n"
..'<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:\'MS Shell Dlg 2\'; font-size:8pt; font-weight:600;"><br /></p>'.."\n"
..'<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:\'MS Shell Dlg 2\'; font-size:8pt;"><br /></p></body></html>'.."\n"
)


   
--Отткрываем(создаем) выходной файл файл     
local f_struct = io.open(szOutFile,"w+");
f_struct:write(Template_SV_Start)
   
for i=1,#szTime do -- вертикальные столбики со временем
  if szTime[i] < 0 then szTime_t = 24 + szTime[i] else szTime_t = szTime[i] end -- для предыдущих суток
  f_struct:write('<td width="100">'.."\n")
  f_struct:write('<p align="center" style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:\'MS Shell Dlg 2\'; font-size:14pt; font-weight:600;">'..tostring(szTime_t)..':00</span></p></td>'.."\n")
end   
f_struct:write('</tr>'.."\n") --дописываем хвостик

for i=1,#tbSVData do 
  -- analogs
  if tbSVData[i].Type == 'AI' then
    f_struct:write('<tr>'.."\n") --начало строки
    f_struct:write('<td width="200">'.."\n"
    ..'<p align="center" style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;">'..tbSVData[i].Comment..'</p></td>'.."\n"
    ..'<td width="40">'.."\n"
    ..'<p align="center" style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;">'..tbSVData[i].Mes..'</p></td>'.."\n")
    for j=1,# szTime do
      if szTime[j] < 0 then sign = '' else sign = '+' end
      f_struct:write('<td>'.."\n"
      ..'<p align="center" style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:\'PT Sans\'; text-decoration: ;  "><!--lua do '.."\n"
      ..'local arc = Core(os.today()'..sign..szTime[j]..'*3600).'..tbSVData[i].Name..';'.."\n"
      ..'if arc.res==0 then'.."\n"
      ..'local s=string.format(\'%.2f\', arc.val)'.."\n"
      ..'print(s);'.."\n"
      ..'else '.."\n"
      ..'print(\'НД\');'.."\n"
      ..'end;'.."\n"
      ..'end;            --></span> </p></td>'.."\n")
    end
    f_struct:write('</tr>'.."\n") --конец строки
  end
  -- disrets
  if tbSVData[i].Type == 'DI' then
    f_struct:write('<tr>'.."\n") --начало строки
    f_struct:write('<td width="200">'.."\n"
    ..'<p align="center" style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;">'..tbSVData[i].Comment..'</p></td>'.."\n"
    ..'<td width="40">'.."\n"
    ..'<p align="center" style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;">'..tbSVData[i].Mes..'</p></td>'.."\n")
    for j=1,# szTime do
      if szTime[j] < 0 then sign = '' else sign = '+' end
      f_struct:write('<td>'.."\n"
      ..'<p align="center" style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:\'PT Sans\'; text-decoration: ;  "><!--lua do '.."\n"
      ..'local arc = Core(os.today()'..sign..szTime[j]..'*3600).'..tbSVData[i].Name..';'.."\n"
      ..'if arc.res==0 then'.."\n"
      ..'if arc.val then'.."\n"
      ..'print(\'1\');'.."\n"
      ..'end;'.."\n"
      ..'if not arc.val then'.."\n"
      ..'print(\'0\');'.."\n"
      ..'end;'.."\n"
      ..'else '.."\n"
      ..'print(\'НД\');'.."\n"
      ..'end;'.."\n"
      ..'end;            --></span> </p></td>'.."\n")
    end
    f_struct:write('</tr>'.."\n") --конец строки
  end
end
--write tail
f_struct:write(Template_SV_End)
--cslose file
f_struct:flush() 
f_struct:close()	

end
--end