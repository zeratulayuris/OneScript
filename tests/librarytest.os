﻿#Использовать "testlib"
#Использовать "customlib"

Перем юТест;

Функция ПолучитьСписокТестов(Знач Тесты) Экспорт
	юТест = Тесты;
	
	Список = Новый Массив;
	Список.Добавить("ТестДолжен_ИспользоватьВстроенныйЗагрузчик");
	Список.Добавить("ТестДолжен_ИспользоватьПользовательскийЗагрузчик");
	
	Возврат Список;
	
КонецФункции

Процедура ТестДолжен_ИспользоватьВстроенныйЗагрузчик() Экспорт
	
	А = "";
	ОбщиеФункции.Скажи("Привет", А); 
	юТест.ПроверитьРавенство("Привет", А);
	юТест.ПроверитьРавенство(1, ОбщиеФункции.Один());
	
КонецПроцедуры

Процедура ТестДолжен_ИспользоватьПользовательскийЗагрузчик() Экспорт
	
	Супер = Новый СуперТип();
	
	Супер.А = 1;
	юТест.ПроверитьРавенство(1, Супер.А);
	юТест.ПроверитьРавенство("Привет", Супер.Привет());
	
	НекийОбщийМодуль.УстановитьПоСсылке(Супер.А);
	юТест.ПроверитьРавенство(100, Супер.А);
	
КонецПроцедуры
