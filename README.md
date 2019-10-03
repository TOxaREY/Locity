# Locity
#### июль 2019

#### Географический тест  Справочник Игра
#### Проверяй Запоминай Играй
#### Угадай местоположение 1134 городов в 188 странах

Проект  Locity в начале был задуман как игра, со временем обзавелся новой концепцией – справочник и игра.  
При старте приложения мы можем наблюдать Москву на карте XVI века.

По окончании загрузки, становятся доступны два варианты использования приложения. Если мы выбираем справочник, то переходим тапом по значку info.

![](https://github.com/TOxaREY/Locity/blob/master/markdown/1.png?raw=true)

В целом приложение использует созданную вручную базу данных из простой таблицы excel, путем её экспорта в формат .db, что делает приложение автономным (офлайн). На стороне устройства базу данных обрабатывает фреймворк на основе [SQLite.swift](https://github.com/stephencelis/SQLite.swift)

Локализация приложения так же решена в базе данных. Основные надписи остаются на английском, но название городов и стран приложение получает из базы данных, предварительно проверив при старте какая клавиатура установлена основной на устройстве. База представляет из себя названия на 7-ми языках и условные координаты 6-ти городов, включая столицу, стран мира.

![](https://github.com/TOxaREY/Locity/blob/master/markdown/2.png?raw=true)

Карта каждой страны создана на основе [GMT](http://gmt.soest.hawaii.edu) и написанного скрипта облегчающего работу. В базе записывается ссылка на файл .png карты. Карты всех стран имеют единый размер, поэтому мы получаем при помощи Photoshop условные координаты городов и заносим в базу. Если приложение запущено на устройстве семейства X, то вычисляется дельта для поправки в координаты.

![](https://github.com/TOxaREY/Locity/blob/master/markdown/3.png?raw=true)

При выборе использования приложения как игры, тапаем по стрелке. В игре существуют два уровня сложность (тяжелый и легкий).  На любом уровне первым делом происходит выбор материка. От полного рандома пришлось отказаться, так как в мире процент стран Океании находиться в пределе 5%, тогда как на остальных континентах этот показатель равен приблизительно 20-25%. На основании этого в формулу была введена поправка, дающая реальное распределение стран по континентам (проверено на многочисленных тестах). В итоге имеем рандом по 4 континентам и 5% вероятность выпадения Океании.

![](https://github.com/TOxaREY/Locity/blob/master/markdown/4.png?raw=true)

Собственным методом решен вопрос размера шрифта надписей. Как только будут получены данные из базы, приложение проверяет название с максимально заданным шрифтом и если надпись помещается на экран выводит её. В противном случаем цикл проверяет с каждой итерацией размер шрифта -0,5 и в итоге находит его размер для отображения всей надписи. Делается это для двух мест: в центре экрана; и наверху и внизу, чтобы получить два оптимальных размера шрифта и отобразить анимацию.

![](https://github.com/TOxaREY/Locity/blob/master/markdown/5.png?raw=true)

Сам игровой процесс различается в зависимости от уровня сложности. На легком уровне, при загрузке страны выбираются рандомом 3 города из шести и отображаются на карте. Остается угадать местоположение предлагаемого города. На сложном уровне, предлагается только название города, и в зависимости от точности угадывания начисляются баллы. В конце раунда у обоих уровней всегда можно проверить (узнать, запомнить на будущее) расположение всех 6-ти городов страны, тапнув по инфо.

![](https://github.com/TOxaREY/Locity/blob/master/markdown/6.png?raw=true)

1/5 всех стран мира имеют вытянутую горизонтальную форму относительно севера. Для максимально крупного отображения территории, карта разворачивается против часовой стрелки на 90 градусов. Информация о развороте карты и соответственно названий, так же берется из базы.  Названия проверяются методами (ограничениями) перед их отображением и если они не попадают в размер экрана происходит корректировка самой программой.

![](https://github.com/TOxaREY/Locity/blob/master/markdown/7.png?raw=true)

Ну и на конец, после 5-ти раундов (3 попытки в каждом), есть возможность записать свои результаты или удалить старые. Таблица результатов создана на основе CoreData. После сохранения данных, наш кораблик-путешественник возвращается домой. Спасибо!!!

![](https://github.com/TOxaREY/Locity/blob/master/markdown/8.png?raw=true)

### [App Store](https://itunes.apple.com/ru/app/locity/id1453073879?mt=8)