--[[print("Start!")
package.loadlib("wx","*")
print("1")
local width, height = wx.wxDisplaySize()
local bitmap = wx.wxBitmap(width, height, -1)
local memDC = wx.wxMemoryDC()
memDC:SelectObject(bitmap)
memDC:Blit(0, 0, width, height, wx.wxScreenDC(), 0, 0)
memDC:SelectObject(wx.wxNullBitmap)
bitmap:SaveFile("screenshot.png", wx.wxBITMAP_TYPE_PNG)
print("End!")]]--
setlayout (0419)     -- включили русскую раскладку
sendex ("Dfcz/Gegrby")     -- Вася.Пупкин (смотрим на клавиатуру)
setlayout (0409)     -- включили английскую раскладку
sendex ("~2gmail.com")     -- @gmail.com