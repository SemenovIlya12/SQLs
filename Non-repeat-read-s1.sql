DROP TABLE IF EXISTS accounts, temp1, temp2;

CREATE TABLE IF NOT EXISTS accounts (
    id SERIAL PRIMARY KEY,
    user_name VARCHAR(100) NOT NULL,
    balance DECIMAL(10, 2) NOT NULL
);

INSERT INTO accounts (user_name, balance) VALUES
('Client1', 1000.00),
('Client2', 500.00);

-- #!
BEGIN;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;  -- неповторяющееся чтение (READ COMMITTED/REPEATABLE READ)


CREATE TEMP TABLE temp1 AS SELECT balance FROM accounts WHERE user_name = 'Client1';


SELECT pg_sleep(6);


CREATE TEMP TABLE temp2 AS SELECT balance FROM accounts WHERE user_name = 'Client1';

-- Завершение транзакции
COMMIT;

SELECT * from temp2;
