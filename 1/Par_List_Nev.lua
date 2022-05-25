--Настройки ведомости и Таблица с данными 
dofile('Par_List_Nev.txt') 

  szOutFile = szOutFile1
  szSmena = szSmena1
  szTime = szTime1

--Начало и конец файла
Template_SV_Start = (''.."\n"
..'<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">'.."\n"
..'<html><head><meta charset="utf-8"  name="qrichtext" content="1" /><style type="text/css">'.."\n"
..'p, li { white-space: pre-wrap; }'.."\n"
..'</style></head><body style=" font-family:\'Arial Narrow\'; font-size:12pt; font-weight:400; font-style:normal;">'.."\n"
..'<p align="center" style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:\'MS Shell Dlg 2\'; font-size:14pt; font-weight:600;">'..szPlace..'</span></p>'.."\n"
..'<p align="center" style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:\'MS Shell Dlg 2\'; font-size:14pt; font-weight:600;">'..szObject..'</span></p>'.."\n"
..'<p align="center" style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:\'MS Shell Dlg 2\'; font-size:14pt; font-weight:600;">'..szUnit..'</span></p>'.."\n"
..'<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:\'MS Shell Dlg 2\'; font-size:14pt; font-weight:600;">	Дата:	</span> <span style=" font-family:\'PT Sans\'; text-decoration: ;  "><!--RPT DT:TODAY"%d.%m.%Y" --></span> </p>'.."\n"
..'<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:\'MS Shell Dlg 2\'; font-size:14pt; font-weight:600;">	Время: </span>  <span style=" font-family:\'PT Sans\'; text-decoration: ;  "><!--RPT DT:NOW"%H.%M.%S" --></span> <span style=" font-size:14pt;">		</span></p>'.."\n"

..'<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><br /></p>'.."\n"
..'<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-size:14pt;">	</span><span style="font-family:\'MS Shell Dlg 2\'; font-size:14pt; font-weight:600;">'..szSmena..'</span></p>'.."\n"
..'<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style="font-family:\'MS Shell Dlg 2\'; font-size:14pt; font-weight:600;">		Сменный инженер	_______________________      Сменный машинист _______________________</span></p>'.."\n"
..'<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-weight:600;"><br /></p>'.."\n"
..'<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-weight:600;"><br /></p>'.."\n"
..'<table border="1" style=" margin-top:0px; margin-bottom:0px; margin-left:10px; margin-right:0px;" width="100%" cellspacing="1" cellpadding="1" bgcolor="#ffffff">'.."\n"
..'<tr>'.."\n"

--..'<td colspan="2">'.."\n"
--..'<p align="center" style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style="font-family:\'MS Shell Dlg 2\'; font-size:14pt; font-weight:600;">Время</span></p></td>'.."\n"
--..'<td width="100">'.."\n"
--..'<p align="center" style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" text-decoration: ;  "><!--RPT DT:NOW"%H.%M.%S" --></span> </p></td></tr>'.."\n"


..'<td>'.."\n"
..'<p align="center" style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;">Параметр</p></td>'.."\n"
..'<td>'.."\n"
..'<p align="center" style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;">Ед.изм.</p></td>'.."\n"
..'<td>'.."\n"
..'<p align="center" style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;">Значение</p></td>'.."\n"


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
   

for i=1,#tbSVData do 
  -- analogs
  if tbSVData[i].Type == 'AI' then
    f_struct:write('<tr>'.."\n") --начало строки
    f_struct:write('<td>'.."\n"
    ..'<p align="center" style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;">'..tbSVData[i].Comment..'</p></td>'.."\n"
    ..'<td>'.."\n"
    ..'<p align="center" style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;">'..tbSVData[i].Mes..'</p></td>'.."\n")
    --for j=1,# szTime do
--      if szTime[j] < 0 then sign = '' else sign = '+' end
      f_struct:write('<td>'.."\n"
      ..'<p align="center" style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;"><span style=" font-family:\'PT Sans\'; text-decoration: ;  "><!--lua do '.."\n"
      ..'local arc = Core(os.time()-3).'..tbSVData[i].Name..';'.."\n"
      ..'if arc.res==0 then'.."\n"
      ..'local s=string.format(\'%.2f\', arc.val)'.."\n"
      ..'print(s);'.."\n"
      ..'else '.."\n"
      ..'print(\'НД\');'.."\n"
      ..'end;'.."\n"
      ..'end;            --></span> </p></td>'.."\n")
    --end
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
      ..'local arc = Core(os.time()-3).'..tbSVData[i].Name..';'.."\n"
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
