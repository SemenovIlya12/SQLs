
-- #1
-- Начало транзакции
BEGIN;

-- Изменение данных
UPDATE accounts SET balance = balance - 100 WHERE user_name = 'Client1';

-- Фиксация изменений
COMMIT;