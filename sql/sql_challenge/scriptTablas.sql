
-- crea una tabla llamada user
CREATE TABLE "user" (
id INTEGER PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR(50),
email VARCHAR(50),
address VARCHAR(50)
);

--crea una tabla llamada product
CREATE TABLE product (
id INTEGER PRIMARY KEY,
product VARCHAR(50),
stock INTEGER,
available_for_selling VARCHAR(50)
 );

 --crea una tabla para registrar las ventas
CREATE TABLE sales (
id SERIAL PRIMARY KEY,
id_product INTEGER,
name_product VARCHAR(50),
id_customer VARCHAR(50),
amount INTEGER,
status VARCHAR);




