
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

CREATE OR REPLACE FUNCTION trigger_function()
RETURNS TRIGGER AS $$
DECLARE
    current_max INT;
BEGIN
    -- Получаем текущий максимум из таблицы spec
    SELECT current_max_value INTO current_max
    FROM spec
    WHERE table_name = TG_TABLE_NAME AND column_name = TG_ARGV[0];

    -- Проверяем, превышает ли новое значение текущий максимум
    IF NEW.id > current_max THEN
        -- Обновляем спец. таблицу
        UPDATE spec
        SET current_max_value = NEW.id
        WHERE table_name = TG_TABLE_NAME AND column_name = TG_ARGV[0];
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION create_trigger(p_table_name VARCHAR, p_column_name VARCHAR)
RETURNS VOID AS $$
BEGIN
    -- Генерируем SQL-запрос для создания триггера
    EXECUTE format(
        'CREATE TRIGGER trigger '
        'AFTER INSERT OR UPDATE ON %I '
        'FOR EACH ROW '
        'EXECUTE FUNCTION trigger_function(%L);',
        p_table_name, p_column_name
    );
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_next_value(p_table_name VARCHAR, p_column_name VARCHAR)
RETURNS INT AS $$
DECLARE
    current_max INT;
    spec_id INT;
BEGIN
    -- Проверяем, есть ли запись в таблице spec
    SELECT id, current_max_value INTO spec_id, current_max
    FROM spec
    WHERE table_name = p_table_name AND column_name = p_column_name;

    IF FOUND THEN
        -- Если запись есть, инкрементируем значение
        UPDATE spec
        SET current_max_value = current_max_value + 1
        WHERE id = spec_id;

        RETURN current_max + 1;
    ELSE
        -- Если записи нет, ищем максимальное значение в запрашиваемой таблице
        EXECUTE format('SELECT COALESCE(MAX(%I), 0) FROM %I', p_column_name, p_table_name)
        INTO current_max;

        -- Рекурсивно вызываем функцию для получения следующего идентификатора для таблицы spec
        spec_id := get_next_value('spec', 'id');


		-- Создаём триггер для этой таблицы и столбца
        PERFORM create_trigger(p_table_name, p_column_name);
		
        -- Вставляем новую запись в таблицу spec
        INSERT INTO spec (id, table_name, column_name, current_max_value)
        VALUES (spec_id, p_table_name, p_column_name, current_max + 1);

        RETURN current_max + 1;
    END IF;
END;
$$ LANGUAGE plpgsql;




CREATE TABLE test (
    id INT
);

SELECT get_next_value('test', 'id');

INSERT INTO test (id) VALUES (20);

SELECT * FROM spec;

INSERT INTO test (id) VALUES (6);

SELECT * FROM spec;

INSERT INTO test (id) VALUES (199);

SELECT * FROM spec;

CREATE TABLE test2 (
	id INT
);

SELECT get_next_value('test2', 'id');

INSERT INTO test2 (id) VALUES (5);


SELECT * FROM spec;

