-- mi caso de prueba es con 
--datos de prueba
--            (id, first_name,    last_name,  email,                  address)
--costumer  = (7,  'Selie',       'Shyram',   'sshyram6@dropbox.com', '96029 Dahle Terrace');

--          (id,  product,                stock,  available_for_selling) 
--product = (20,  'Grapefruit - Pink',    '3471', true);


BEGIN;

-- Consulta para verificar el disponible
SELECT * FROM product WHERE id = 20 AND stock > 3000;

 
-- Consulta para verificar si se puede vender el producto
SELECT * FROM product WHERE id = 20 AND available_for_selling = 'true';

-- Actualizando stock
IF UPDATE product
SET stock = stock - 3000
WHERE id = 20 ;

-- registrando venta
INSERT INTO sales(id_product, name_product, id_customer, amount, status) VALUES (
20,
(SELECT product FROM product WHERE id = 20),
(SELECT id FROM "user" WHERE first_name = 'Selie' AND last_name = 'Shyram'),
3000,
(SELECT available_for_selling FROM product WHERE id = 20)
);

COMMIT;

