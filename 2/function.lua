function Class()
	local class = {}

	-- Метатаблица для класса.
	local mClass = {__index = class}

	-- Функция, которая возвращает "объект" данного класса.
	function class.instance()
		return setmetatable({}, mClass)
	end
	return class
end


-- Пока без двоеточий.
Rectangle = Class()

function Rectangle.new(x, y, w, h)
	local self = Rectangle.instance()
        self.x = x or 0
        self.y = y or 0
	self.w = w or 10
	self.h = h or 10
	return self
end


function Rectangle.area(self)
	return self.w * self.h
end

-- Инстанцируем
rect = Rectangle.new(10, 20, 30, 40)

print('rect.area(rect)', rect.area(rect))
print('rect:area()',     rect:area())    
