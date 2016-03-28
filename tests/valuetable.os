﻿///////////////////////////////////////////////////////////////////////
//
// Тест проверки работы таблицы значений
// 
//
///////////////////////////////////////////////////////////////////////

Перем юТест;

////////////////////////////////////////////////////////////////////
// Программный интерфейс

Функция Версия() Экспорт
	Возврат "0.1";
КонецФункции

Функция ПолучитьСписокТестов(ЮнитТестирование) Экспорт
	
	юТест = ЮнитТестирование;
	ВсеТесты = Новый Массив;
	
	ВсеТесты.Добавить("ТестДолжен_СоздатьТаблицуЗначений");
	ВсеТесты.Добавить("ТестДолжен_СоздатьУдалитьКолонки");
	ВсеТесты.Добавить("ТестДолжен_СоздатьУдалитьСтроки");
	ВсеТесты.Добавить("ТестДолжен_ПереместитьСтроки");
	ВсеТесты.Добавить("ТестДолжен_ОтработатьСДанными");
	
	ВсеТесты.Добавить("ТестДолжен_ВыгрузитьКолонкуВМассив");
	ВсеТесты.Добавить("ТестДолжен_НайтиСтрокуВТаблице");
	ВсеТесты.Добавить("ТестДолжен_НайтиНесколькоСтрокВТаблице");
	ВсеТесты.Добавить("ТестДолжен_СкопироватьТаблицуПолностью");
	ВсеТесты.Добавить("ТестДолжен_СкопироватьТаблицуПоМассивуСтрок");
	ВсеТесты.Добавить("ТестДолжен_СкопироватьТаблицуНесколькоКолонок");
	ВсеТесты.Добавить("ТестДолжен_ПроверитьСверткуБезУказанияКолонок");
	
	Возврат ВсеТесты;
	
КонецФункции

Процедура ТестДолжен_СоздатьТаблицуЗначений() Экспорт

	Перем Т;
	
	Т = Новый ТаблицаЗначений;
	КоличествоДобавляемыхКолонокСтрок = 5;
	
	Для Инд = 1 По КоличествоДобавляемыхКолонокСтрок Цикл
		
		Т.Колонки.Добавить("К" + Инд);
		Т.Добавить();
		
	КонецЦикла;

	юТест.ПроверитьРавенство(Т.Колонки.Количество(), КоличествоДобавляемыхКолонокСтрок);
	юТест.ПроверитьРавенство(Т.Количество(), КоличествоДобавляемыхКолонокСтрок);
	
КонецПроцедуры

Процедура ТестДолжен_СоздатьУдалитьКолонки() Экспорт

	Перем Т;
	
	Т = Новый ТаблицаЗначений;
	
	К1 = Т.Колонки.Добавить("К1");
	К2 = Т.Колонки.Добавить("К2");
	К3 = Т.Колонки.Добавить("К3");
	К4 = Т.Колонки.Добавить("К4");
	К5 = Т.Колонки.Добавить("К5");
	
	юТест.ПроверитьРавенство(Т.Колонки.Количество(), 5);
	
	// Удаление колонки по ссылке
	Т.Колонки.Удалить(К3);
	
	юТест.ПроверитьРавенство(Т.Колонки.Количество(), 4);
	юТест.ПроверитьРавенство(Т.Колонки.Найти("К3"), Неопределено);
	юТест.ПроверитьРавенство(Т.Колонки.Найти("К2"), К2);
	
	Строка1 = Т.Добавить();
	Строка2 = Т.Добавить();
	
	К6 = Т.Колонки.Добавить("К6");
	
	// Доступность К6 после добавления строк
	
	Попытка
		
		Строка1["К6"] = 123;
		юТест.ПроверитьРавенство(Строка1["К6"], 123);
		
	Исключение
	
		юТест.ПроверитьИстину(Ложь, "Колонка К6 не доступна!");
		
	КонецПопытки;
	
	// Удаление колонки по индексу
	Т.Колонки.Удалить(0);
	
	юТест.ПроверитьРавенство(Т.Колонки.Количество(), 4);
	юТест.ПроверитьРавенство(Т.Колонки.Найти("К1"), Неопределено);
	юТест.ПроверитьРавенство(Т.Колонки.Найти("К2"), К2);

	// Удаление колонки по имени
	Т.Колонки.Удалить("К4");
	
	юТест.ПроверитьРавенство(Т.Колонки.Количество(), 3);
	юТест.ПроверитьРавенство(Т.Колонки.Найти("К4"), Неопределено);
	юТест.ПроверитьРавенство(Т.Колонки.Найти("К2"), К2);
	
	// Недоступность удалённой колонки
	
	Попытка
	
		Значение = Строка1["К1"];
		юТест.ПроверитьИстину(Ложь, "Доступна удалённая колонка!");
		
	Исключение
	
	КонецПопытки;

КонецПроцедуры

Процедура ТестДолжен_СоздатьУдалитьСтроки() Экспорт

	Перем Т;
	
	Т = Новый ТаблицаЗначений;
	
	К1 = Т.Колонки.Добавить("К1");
	К2 = Т.Колонки.Добавить("К2");
	К3 = Т.Колонки.Добавить("К3");
	К4 = Т.Колонки.Добавить("К4");
	К5 = Т.Колонки.Добавить("К5");
	
	С1 = Т.Добавить();
	С2 = Т.Добавить();
	С2_5 = Т.Добавить();
	С3 = Т.Добавить();
	С4 = Т.Добавить();
	
	Т.Удалить(С2_5);
	
	юТест.ПроверитьРавенство(Т.Количество(), 4);
	
	юТест.ПроверитьРавенство(Т.Получить(0), С1);
	юТест.ПроверитьРавенство(Т.Получить(1), С2);
	юТест.ПроверитьРавенство(Т.Получить(2), С3);
	юТест.ПроверитьРавенство(Т.Получить(3), С4);
	
	юТест.ПроверитьРавенство(Т[0], С1);
	юТест.ПроверитьРавенство(Т[1], С2);
	юТест.ПроверитьРавенство(Т[2], С3);
	юТест.ПроверитьРавенство(Т[3], С4);
	
	юТест.ПроверитьРавенство(Т.Индекс(С1), 0);
	юТест.ПроверитьРавенство(Т.Индекс(С2), 1);
	юТест.ПроверитьРавенство(Т.Индекс(С3), 2);
	юТест.ПроверитьРавенство(Т.Индекс(С4), 3);
	
	Обошли = Новый Соответствие;
	Для Каждого мСтрокаТаблицы Из Т Цикл
	
		Обошли.Вставить(мСтрокаТаблицы, Истина);
	
	КонецЦикла;
	
	юТест.ПроверитьИстину(Обошли.Получить(С1), "Обход бегунком");
	юТест.ПроверитьИстину(Обошли.Получить(С2), "Обход бегунком");
	юТест.ПроверитьИстину(Обошли.Получить(С3), "Обход бегунком");
	юТест.ПроверитьИстину(Обошли.Получить(С4), "Обход бегунком");
	
КонецПроцедуры

Функция ПроверитьПорядок(Т, П1, П2, П3, П4, П5)

	Массив = Новый Массив;
	Массив.Добавить(П1);
	Массив.Добавить(П2);
	Массив.Добавить(П3);
	Массив.Добавить(П4);
	Массив.Добавить(П5);

	Для Инд = 0 По 4 Цикл
	
		Если Т[Инд].Индекс <> Массив[Инд] Тогда
			Возврат Ложь;
		КонецЕсли;
	
	КонецЦикла;
	
	Возврат Истина;

КонецФункции

Процедура ТестДолжен_ПереместитьСтроки() Экспорт
	
	Перем Т;
	
	Т = Новый ТаблицаЗначений;
	Т.Колонки.Добавить("Индекс");
	
	Для Инд = 1 По 5 Цикл
		Т.Добавить().Индекс = Инд;
	КонецЦикла;
	
	С1 = Т[0];
	С2 = Т[1];
	С3 = Т[2];
	С4 = Т[3];
	С5 = Т[4];
	
	// Проверим крайние случаи
	Т.Сдвинуть(С1, -1);
	юТест.ПроверитьРавенство(Т.Индекс(С1), 4);
	
	Т.Сдвинуть(С1, 1);
	юТест.ПроверитьРавенство(Т.Индекс(С1), 0);
	
	// Проверим цикличность
	Т.Сдвинуть(С1, 5);
	юТест.ПроверитьРавенство(Т.Индекс(С1), 0);
	
	Т.Сдвинуть(С1, 10);
	юТест.ПроверитьРавенство(Т.Индекс(С1), 0);
	
	Т.Сдвинуть(С1, 15);
	юТест.ПроверитьРавенство(Т.Индекс(С1), 0);
	
	Т.Сдвинуть(С1, -5);
	юТест.ПроверитьРавенство(Т.Индекс(С1), 0);
	
	Т.Сдвинуть(С1, -10);
	юТест.ПроверитьРавенство(Т.Индекс(С1), 0);
	
	Т.Сдвинуть(С1, -15);
	юТест.ПроверитьРавенство(Т.Индекс(С1), 0);
	
	// Проверим обычное перемещение
	
	Т.Сдвинуть(С2, -1);
	ПроверитьПорядок(Т, 2, 1, 3, 4, 5);
	
	Т.Сдвинуть(С1, 2);
	ПроверитьПорядок(Т, 2, 3, 4, 1, 5);
	
КонецПроцедуры

Процедура ТестДолжен_ОтработатьСДанными() Экспорт

	Перем Т;
	
	Т = Новый ТаблицаЗначений;
	
	Т.Колонки.Добавить("Количество");
	Т.Колонки.Добавить("Цена");
	Т.Колонки.Добавить("Сумма");
	
	Для Инд = 1 По 5 Цикл
	
		НоваяСтрока = Т.Добавить();
		НоваяСтрока.Количество = Инд;
	
	КонецЦикла;
	
	Цены = Новый Массив;
	Цены.Добавить(100);
	Цены.Добавить(50);
	Цены.Добавить(30);
	Цены.Добавить(32.3);
	Цены.Добавить(16);
	
	Т.ЗагрузитьКолонку(Цены, "Цена");
	
	мСумма = 0;
	Для Каждого мСтрока Из Т Цикл
	
		мСтрока.Сумма = мСтрока.Количество * мСтрока.Цена;
		мСумма = мСумма + мСтрока.Сумма;
	
	КонецЦикла;
	
	юТест.ПроверитьРавенство(Т.Итог("Сумма"), мСумма);
	
	
	Т.Свернуть("", "Сумма");
	
	юТест.ПроверитьРавенство(Т[0].Сумма, мСумма);

КонецПроцедуры

Процедура ТестДолжен_ВыгрузитьКолонкуВМассив() Экспорт
	
	Т = Новый ТаблицаЗначений;
	Т.Колонки.Добавить("Ключ");
	Т.Колонки.Добавить("Значение");
	
	ЭталонКлючей = Новый Массив;
	ЭталонЗначений = Новый Массив;
	
	Для Сч = 1 По 5 Цикл
		С = Т.Добавить();
		С.Ключ = "Ключ" + Строка(Сч);
		С.Значение = Сч;
		
		ЭталонКлючей.Добавить(С.Ключ);
		ЭталонЗначений.Добавить(С.Значение);
		
	КонецЦикла;
	
	юТест.ПроверитьИстину(МассивыИдентичны(Т.ВыгрузитьКолонку("Ключ"), ЭталонКлючей), "Массивы ключей должны совпадать");
	юТест.ПроверитьИстину(МассивыИдентичны(Т.ВыгрузитьКолонку("Значение"), ЭталонЗначений), "Массивы значений должны совпадать");
	
КонецПроцедуры

Функция МассивыИдентичны(Знач Проверяемый, Знач Эталон)
	Если Проверяемый.Количество() <> Эталон.Количество() Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Для Сч = 0 По Проверяемый.Количество()-1 Цикл
		Если Проверяемый[Сч] <> Эталон[Сч] Тогда
			Возврат Ложь;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Истина;
	
КонецФункции

Процедура ТестДолжен_НайтиСтрокуВТаблице() Экспорт
	Т = Новый ТаблицаЗначений;
	Т.Колонки.Добавить("Ключ");
	Т.Колонки.Добавить("Значение");
	
	Для Сч = 1 По 5 Цикл
		С = Т.Добавить();
		С.Ключ = "Ключ" + Строка(Сч);
		С.Значение = Сч;
	КонецЦикла;
	
	ИскомаяСтрока = Т.Найти("Ключ2", "Ключ");
	юТест.ПроверитьЛожь(ИскомаяСтрока = Неопределено, "Строка должна быть найдена");
	юТест.ПроверитьРавенство(ИскомаяСтрока.Значение, 2);
	
КонецПроцедуры

Процедура ТестДолжен_НайтиНесколькоСтрокВТаблице() Экспорт
	Т = Новый ТаблицаЗначений;
	Т.Колонки.Добавить("Ключ");
	Т.Колонки.Добавить("Значение");
	
	Для Сч = 1 По 8 Цикл
		С = Т.Добавить();
		
		Если Сч % 2 Тогда
			С.Ключ = "Истина";
			С.Значение = Истина;
		Иначе
			С.Ключ = "Ложь";
			С.Значение = Ложь;
		КонецЕсли;
		
	КонецЦикла;
	
	КлючиПоиска = Новый Структура("Ключ,Значение", "Истина", Истина);
	НайденныеСтроки = Т.НайтиСтроки(КлючиПоиска);
	
	юТест.ПроверитьРавенство(НайденныеСтроки.Количество(), 4, "Количество строк должно совпадать с эталоном");
	
	Для Каждого Стр Из НайденныеСтроки Цикл
		юТест.ПроверитьРавенство(Стр.Ключ, "Истина");
		юТест.ПроверитьРавенство(Стр.Значение, Истина);
	КонецЦикла;
	
КонецПроцедуры

Функция СоздатьТаблицуСДанными()
	
	Т = Новый ТаблицаЗначений;
	Т.Колонки.Добавить("Ключ");
	Т.Колонки.Добавить("Значение");
	Т.Колонки.Добавить("К3");
	
	Для Сч = 1 По 5 Цикл
		С = Т.Добавить();
		С.Ключ = "Ключ" + Строка(Сч);
		С.Значение = Сч;
		С.К3 = "К3-" + Сч
	КонецЦикла;
	
	Возврат Т;
	
КонецФункции

Процедура ТестДолжен_СкопироватьТаблицуПолностью() Экспорт
	
	Т = СоздатьТаблицуСДанными();
	Т2 = Т.Скопировать();
	
	юТест.ПроверитьНеравенство(Т, Т2);
	юТест.ПроверитьРавенство(Т.Количество(), Т2.Количество());
	Для Сч = 0 По Т.Количество() - 1 Цикл
		С1 = Т[сч];
		С2 = Т2[сч];
		юТест.ПроверитьРавенство(С1.Ключ, С2.Ключ, "Равенство Ключей в строке " + Сч);
		юТест.ПроверитьРавенство(С1.Значение, С2.Значение, "Равенство Значений в строке " + Сч);
		юТест.ПроверитьРавенство(С1.К3, С2.К3, "Равенство КЗ в строке " + Сч);
		юТест.ПроверитьНеравенство(С1, С2);
	КонецЦикла;
	
КонецПроцедуры

Процедура ТестДолжен_СкопироватьТаблицуПоМассивуСтрок() Экспорт
	
	Т = СоздатьТаблицуСДанными();
	
	МассивСтрок = Новый Массив;
	МассивСтрок.Добавить(Т[0]);
	МассивСтрок.Добавить(Т[2]);
	Т2 = Т.Скопировать(МассивСтрок);
	
	юТест.ПроверитьНеравенство(Т, Т2);
	юТест.ПроверитьРавенство(2, Т2.Количество());
	Для Сч = 0 По Т2.Количество() - 1 Цикл
		С1 = МассивСтрок[сч];
		С2 = Т2[сч];
		юТест.ПроверитьРавенство(С1.Ключ, С2.Ключ, "Равенство Ключей в строке " + Сч);
		юТест.ПроверитьРавенство(С1.Значение, С2.Значение, "Равенство Значений в строке " + Сч);
		юТест.ПроверитьРавенство(С1.К3, С2.К3, "Равенство КЗ в строке " + Сч);
		юТест.ПроверитьНеравенство(С1, С2);
	КонецЦикла;
	
КонецПроцедуры

Процедура ТестДолжен_СкопироватьТаблицуНесколькоКолонок() Экспорт
	
	Т = СоздатьТаблицуСДанными();
	
	МассивСтрок = Новый Массив;
	МассивСтрок.Добавить(Т[0]);
	МассивСтрок.Добавить(Т[2]);
	Т2 = Т.Скопировать(МассивСтрок, "Ключ, Значение");
	
	юТест.ПроверитьНеравенство(Т, Т2);
	юТест.ПроверитьРавенство(2, Т2.Количество());
	юТест.ПроверитьРавенство(2, Т2.Колонки.Количество());
	Для Сч = 0 По Т2.Количество() - 1 Цикл
		С1 = МассивСтрок[сч];
		С2 = Т2[сч];
		юТест.ПроверитьРавенство(С1.Ключ, С2.Ключ, "Равенство Ключей в строке " + Сч);
		юТест.ПроверитьРавенство(С1.Значение, С2.Значение, "Равенство Значений в строке " + Сч);
		юТест.ПроверитьНеравенство(С1, С2);
	КонецЦикла;
	
КонецПроцедуры

Процедура ТестДолжен_ПроверитьСверткуБезУказанияКолонок() Экспорт

	Перем Т;
	
	Т = Новый ТаблицаЗначений;
	Т.Колонки.Добавить("Колонка1");
	
	Т.Добавить().Колонка1 = "Значение1";
	Т.Добавить().Колонка1 = "Значение2";
	
	Т.Добавить().Колонка1 = "Значение1";
	Т.Добавить().Колонка1 = "Значение2";
	
	// Вызываем свёртку БЕЗ указания второго параметра
	Т.Свернуть("Колонка1");
	
	Т.Сортировать("Колонка1");
	
	юТест.ПроверитьРавенство(Т.Количество(), 2, "После свёртки должно остаться 2 строки");
	юТест.ПроверитьРавенство(Т.Получить(0).Колонка1, "Значение1", "Свёртка по значениям");
	юТест.ПроверитьРавенство(Т.Получить(1).Колонка1, "Значение2", "Свёртка по значениям");

КонецПроцедуры
