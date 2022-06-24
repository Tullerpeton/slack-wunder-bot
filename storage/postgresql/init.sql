CREATE USER bot WITH password 'qwerty123';


DROP DATABASE IF EXISTS bot_db;
CREATE DATABASE bot_db
    WITH OWNER bot
    ENCODING 'utf8';
GRANT ALL PRIVILEGES ON database bot_db TO bot;
\connect bot_db;

DROP TABLE IF EXISTS data_users CASCADE;
CREATE TABLE data_users (
    id SERIAL NOT NULL PRIMARY KEY,
    tag TEXT,
    points INTEGER
);