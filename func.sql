
-- 24. Удаление функции
DROP FUNCTION IF EXISTS get_next_value;

-- 25. Удаление таблиц
DROP TABLE IF EXISTS spec;
DROP TABLE IF EXISTS test;
DROP TABLE IF EXISTS test2;

CREATE TABLE IF NOT EXISTS spec (
    id SERIAL PRIMARY KEY,
    table_name VARCHAR(255) NOT NULL,
    column_name VARCHAR(255) NOT NULL,
    current_max_value INT NOT NULL
);


INSERT INTO spec (table_name, column_name, current_max_value)
VALUES ('spec', 'id', 1);

CREATE OR REPLACE FUNCTION get_next_value(p_table_name VARCHAR, p_column_name VARCHAR)
RETURNS INT AS $$
DECLARE
    v_current_max INT;
    v_special_id INT;
BEGIN
    -- Проверяем, есть ли запись в таблице spec
    SELECT id, current_max_value INTO v_special_id, v_current_max
    FROM spec
    WHERE table_name = p_table_name AND column_name = p_column_name;

    IF FOUND THEN
        -- Если запись есть, инкрементируем значение
        UPDATE spec
        SET current_max_value = current_max_value + 1
        WHERE id = v_special_id;

        RETURN v_current_max + 1;
    ELSE
        -- Если записи нет, ищем максимальное значение в запрашиваемой таблице
        EXECUTE format('SELECT COALESCE(MAX(%I), 0) FROM %I', p_column_name, p_table_name)
        INTO v_current_max;

        -- Рекурсивно вызываем функцию для получения следующего идентификатора для таблицы spec
        v_special_id := get_next_value('spec', 'id');

        -- Вставляем новую запись в таблицу spec
        INSERT INTO spec (id, table_name, column_name, current_max_value)
        VALUES (v_special_id, p_table_name, p_column_name, v_current_max + 1);

        RETURN v_current_max + 1;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- 4. Вызов функции с параметрами 'spec', 'id'
SELECT get_next_value('spec', 'id'); -- Должно вернуть 2

-- 5. Распечатка содержимого таблицы spec
SELECT * FROM spec; -- Должна быть 1 строка "(1, spec, id, 2)"

-- 6. Вызов функции с параметрами 'spec', 'id'
SELECT get_next_value('spec', 'id'); -- Должно вернуть 3

-- 7. Распечатка содержимого таблицы spec
SELECT * FROM spec; -- Должна быть 1 строка "(1, spec, id, 3)"

-- 8. Создание новой таблицы test
CREATE TABLE test (
    id INT
);

-- 9. Добавление записи в таблицу test
INSERT INTO test (id) VALUES (10);

-- 10. Вызов функции с параметрами 'test', 'id'
SELECT get_next_value('test', 'id'); -- Должно вернуть 11

-- 11. Распечатка содержимого таблицы spec
SELECT * FROM spec; -- Должно быть 2 строки "(1, spec, id, 4)" "(4, test, id, 11)"

-- 12. Вызов функции с параметрами 'test', 'id'
SELECT get_next_value('test', 'id'); -- Должно вернуть 12

-- 13. Распечатка содержимого таблицы spec
SELECT * FROM spec; -- Должно быть 2 строки "(1, spec, id, 4)" "(4, test, id, 12)"

-- 14. Создание таблицы test2
CREATE TABLE test2 (
    num_value1 INT,
    num_value2 INT
);

-- 15. Вызов функции с параметрами 'test2', 'num_value1'
SELECT get_next_value('test2', 'num_value1'); -- Должно вернуть 1

-- 16. Распечатка содержимого таблицы spec
SELECT * FROM spec; -- Должно быть 3 строки "(1, spec, id, 5)" "(4, test, id, 12), (5, test2, num_value1, 1)"

-- 17. Вызов функции с параметрами 'test2', 'num_value1'
SELECT get_next_value('test2', 'num_value1'); -- Должно вернуть 2

-- 18. Распечатка содержимого таблицы spec
SELECT * FROM spec; -- Должно быть 3 строки "(1, spec, id, 5)" "(4, test, id, 12), (5, test2, num_value1, 2)"

-- 19. Добавление записи в таблицу test2
INSERT INTO test2 (num_value1, num_value2) VALUES (2, 13);

-- 20. Вызов функции с параметрами 'test2', 'num_value2'
SELECT get_next_value('test2', 'num_value2'); -- Должно вернуть 14

-- 21. Распечатка содержимого таблицы spec
SELECT * FROM spec; -- Должно быть 4 строки "(1, spec, id, 6)" "(4, test, id, 12), (5, test2, num_value1, 2), (6, test2, num_value2, 14)"

-- 22. Вызов функции с параметрами 'test2', 'num_value1' 5 раз
SELECT get_next_value('test2', 'num_value1'); -- Должно вернуть 3
SELECT get_next_value('test2', 'num_value1'); -- Должно вернуть 4
SELECT get_next_value('test2', 'num_value1'); -- Должно вернуть 5
SELECT get_next_value('test2', 'num_value1'); -- Должно вернуть 6
SELECT get_next_value('test2', 'num_value1'); -- Должно вернуть 7

-- 23. Распечатка содержимого таблицы spec
SELECT * FROM spec ORDER BY id; -- Должно быть 4 строки "(1, spec, id, 6)" "(4, test, id, 12), (5, test2, num_value1, 7), (6, test2, num_value2, 14)"

