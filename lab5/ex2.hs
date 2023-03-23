-- Определим следующий набор операций над строками:
-- Очистка: удаление всех символов из строки
-- Удаление: удаление всех вхождений указанного символа
-- Замена: замена всех вхождений одного символа на другой
-- Добавление: добавление в начало строки указанного символа
-- Разработайте тип данных, характеризующий операции над строками. Определите следующие функции:
-- 1) process, получающая в качестве аргумента действие и строку и возвращающая строку, модифицированную в соответствие с указанным действием.
-- 2) processAll, аналогичная предыдущей, но получающая список действий и выполняющая их по порядку.
-- 3) deleteAll, принимающая две строки и удаляющей из второй строки все символы первой. При реализации обязательно использовать функцию processAll.

-- data - это ключевое слово, которое используется для определения нового типа данных
-- Action - это имя типа данных
data Action = Clear | Delete Char | Substitute Char Char | Add Char

-- xs - строка, которую мы модифицируем 
process :: Action -> String -> String
process Clear xs = "" -- очистка
-- filter (/= c) xs - это функция, которая принимает на вход список и функцию, которая применяется к каждому элементу списка
-- и возвращает список, составленный из элементов, для которых функция вернула True
-- (/= c) - это функция, которая проверяет, не равен ли элемент символу c
process (Delete c) xs = filter (/= c) xs -- удаление
-- map (\x -> if x == c then d else x) xs - это функция, которая принимает на вход список и функцию, которая применяется к каждому элементу списка
-- и возвращает список, составленный из результатов применения функции к каждому элементу
-- (\x -> if x == c then d else x) - это функция, которая проверяет, равен ли элемент символу c, если да, то возвращает символ d, иначе возвращает элемент
process (Substitute c d) xs = map (\x -> if x == c then d else x) xs -- замена
-- c : xs - это функция, которая добавляет символ c в начало строки xs
process (Add c) xs = c : xs -- добавление

processAll :: [Action] -> String -> String
processAll [] xs = xs
processAll (x:xs) ys = processAll xs (process x ys)

deleteAll :: String -> String -> String
-- map Delete xs - это функция, которая принимает на вход список и функцию, которая применяется к каждому элементу списка
-- и возвращает список, составленный из результатов применения функции к каждому элементу
-- Delete - это функция, которая принимает на вход символ и возвращает действие Delete
deleteAll xs ys = processAll (map Delete xs) ys
main =
  print (process Clear "Hello world!") >>
  print (process (Delete 'l') "Hello world!") >>
  print (process (Substitute 'e' 'i') "eigenvalue") >>
  print (process (Add 'a') "Hello world!") >>
  print (processAll [Clear, Delete 'l', Substitute 'e' 'i', Add 'a'] "eigenvalue") >>
  print (deleteAll "Hello world!" "Hello world!")