os.execute( "chcp 65001 > nul" )
dofile('decode_Ansi_Utf8.lua'); --функция (внешняя) трансляции строк в utf8
--Таблица с данными полученная
dofile('AM.lua') 
for i=1,#AM_Struct do
Type=AnsiToUtf8(AM_Struct[i].Type)
if Type=='AM_1x0' then   Type=1  end-- ИМ 1Q 0FB
if Type=='AM_1x1' then   Type=2  end-- ИМ 1Q 1FB
if Type=='AM_1x2' then   Type=3  end-- ИМ 1Q 2FB
if Type=='AM_2x1' then   Type=4  end-- ИМ 2Q 1FB
if Type=='AM_2x2' then   Type=5  end-- ИМ 2Q 2FB
if Type=='AM_2x2_fH' then   Type=6  end-- ИМ 2Q(Fors+Hold) 2FB
if Type=='AM_1x1_inv' then   Type=7  end-- ИМ 1Q 1FB с командой/конечником OFF
if Type=='AM_1x2_inv' then   Type=8  end-- ИМ 1Q 2FB с командой OFF и двумя конечниками
if Type=='AM_1x1_cfb' then   Type=9  end-- ИМ 1Q 1FB с командой ON/ конечником OF
if Type=='AM_2x2_fPos' then   Type=10  end-- ИМ 2Q с удержанием каждого положения 2 FB
if Type=='AM_AxA' then   Type=20  end-- ИМ AO управление AI положение
if Type=='AM_AxAD' then   Type=21  end-- ИМ AO управление AI, DI положение
if Type=='AM_DxA' then   Type=22  end-- ИМ DO управление AI положение

	print('						(ActId := '..i..',') 
	print('							ActType := '..Type..',')
	print('							changeCounter := 2,')
	print('							delayChangeOvertimeAlert := '..AnsiToUtf8(AM_Struct[i].dCOA)..',')
	print('							delayQTimeout := '..AnsiToUtf8(AM_Struct[i].dQT)..',')
	print('							delayExtraOn := '..AnsiToUtf8(AM_Struct[i].dEOn)..',')
	print('							delayExtraOff := '..AnsiToUtf8(AM_Struct[i].dEOff)..',')
	print('							delayNotMoveAlert := '..AnsiToUtf8(AM_Struct[i].dNMA)..',')
	print('							delayCircBrkAlert := '..AnsiToUtf8(AM_Struct[i].dCBA)..'),') 
end