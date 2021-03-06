﻿
&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Если НЕ ЗначениеЗаполнено(Объект.Ссылка) Тогда
		
		Объект.АлгоритмПолучения = 	"
		|//В результате работы алгоритма должна получиться таблица значений с именем ""ТаблицаЗначений"" и наличием обязательной колонки ""ЗначениеМетрики""
		|//Содержимое таблицы должно иметь тип ""Строка"", за исключение колонки ""ЗначениеМетрики"" - она должна быть числом
		|
		|ТаблицаЗначений = Новый ТаблицаЗначений;
		|ГСЧ = Новый ГенераторСлучайныхЧисел();
		|	
		|ТаблицаЗначений.Колонки.Добавить(""label"", Новый ОписаниеТипов(""Строка""));
		|ТаблицаЗначений.Колонки.Добавить(""ЗначениеМетрики"", Новый ОписаниеТипов(""Число""));
		|
		|НоваяСтрока = ТаблицаЗначений.добавить();
		|НоваяСтрока.label = ""Показатель_1"";
		|НоваяСтрока.ЗначениеМетрики = 	ГСЧ.СлучайноеЧисло(0,100);
		|
		|НоваяСтрока = ТаблицаЗначений.добавить();
		|НоваяСтрока.label = ""Показатель_2"";
		|НоваяСтрока.ЗначениеМетрики = ГСЧ.СлучайноеЧисло(0,50);";
		
	КонецЕсли; 
	
	УстановитьДоступностьЭлементовМетрики();
	
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьДоступностьЭлементовМетрики()
	
	Если Объект.ТипДоставкиМетрики = ПредопределенноеЗначение("Перечисление.prСпособыДоставкиМетрик.push") Тогда
		Объект.ИспользоватьПредварительныйРасчет 				= Ложь;
		Элементы.ИспользоватьПредварительныйРасчет.Доступность 	= Ложь;
	Иначе 
		Элементы.ИспользоватьПредварительныйРасчет.Доступность 	= Истина;
	КонецЕсли;

	Если Объект.ИспользоватьПредварительныйРасчет Тогда 
		Элементы.СрокДействияПредварительногоРасчета.Доступность = Истина;
	Иначе
		Элементы.СрокДействияПредварительногоРасчета.Доступность = Ложь;
		Объект.СрокДействияПредварительногоРасчета = Дата('00010101');
	КонецЕсли;
	
КонецПроцедуры


&НаКлиенте
Процедура ТестАлгоритмаРасчета(Команда)
	
	Если Модифицированность ИЛИ НЕ ЗначениеЗаполнено(Объект.Ссылка) Тогда
		Сообщить("Перед выполнением тестирования объект необходимо записать!");
		Возврат;
	КонецЕсли; 
	
	РезультатПроверки = prРасчетМетрикPrometheusСервер.ПроверитьАлгоритмРасчетаМетрики(Объект.Ссылка, Объект.ИмяМетрики, Объект.ТипМетрики, Объект.АлгоритмПолучения);
	
	Если РезультатПроверки.Ошибка Тогда
		Сообщить(РезультатПроверки.ОписаниеОшибки);
	Иначе
		Сообщить("Тест алгоритма расчета завершен. Итоговая метрика:" + Символы.ПС + РезультатПроверки.Результат);
	КонецЕсли; 
	  	
КонецПроцедуры

&НаКлиенте
Процедура ИспользоватьПредварительныйРасчетПриИзменении(Элемент)
	УстановитьДоступностьЭлементовМетрики();
КонецПроцедуры

&НаКлиенте
Процедура ТипОбработкиПриИзменении(Элемент)
	УстановитьДоступностьЭлементовМетрики();
КонецПроцедуры
