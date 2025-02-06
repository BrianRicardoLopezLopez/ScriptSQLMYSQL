-- Crear la base de datos "CursoSQL"
CREATE DATABASE CursoSQL;
 
-- Seleccionar la base de datos "CursoSQL" para utilizarla en las operaciones siguientes
USE CursoSQL;
 
-- Crear la tabla "Productos" con sus columnas y la restricción de clave primaria
CREATE TABLE Productos (
    ID_Producto_PK INT NOT NULL AUTO_INCREMENT,  -- Columna de identificación única para cada producto (clave primaria), que se incrementa automáticamente
    nombre VARCHAR(255) NOT NULL,                  -- Columna para el nombre del producto, admite hasta 255 caracteres y es obligatoria
    precio DECIMAL(6,2) NOT NULL,                  -- Columna para el precio del producto, con 6 dígitos en total y 2 decimales, es obligatoria
    descripcion TEXT NOT NULL,                     -- Columna para la descripción del producto, admite texto de longitud variable y es obligatoria   tipo VARCHAR(50) NOT NULL,                     -- Columna para especificar el tipo o categoría del producto, admite hasta 50 caracteres y es obligatoria
    Marca VARCHAR(50) NOT NULL,                    -- Columna para la marca del producto, admite hasta 50 caracteres y es obligatoria
    PRIMARY KEY(ID_Producto_PK)                     -- Establece la columna "ID_Producto_PK" como la clave primaria de la tabla
);


-- Insertar un registro en la tabla productos --
INSERT INTO Productos (nombre, precio, descripcion, Marca) 
VALUES( 
	'Galaxy S6', -- Nombre del Producto --
	359.99, -- El precio del Producto
    'El Samsumg Galaxy S6 con Pantalla de 5.1, Procesador Octa-Core y Conectividad 4G LTE', -- La Descripcion del Producto --
    'Samsung' -- La Marca del Producto --
);

INSERT INTO Productos (nombre, precio, descripcion, tipo, Marca)
VALUES
  -- Insertar el procesador Intel i5
  ('i5', 200.00, 'Procesador Intel i5 de alto rendimiento', 'Laptop', 'Intel'),
  
  -- Insertar un monitor de 24 pulgadas
  ('Monitor 24', 150.00, 'Monitor LED de 24 pulgadas para uso general', 'Monitor', 'LG'),
  
  -- Insertar la laptop Macbook Air
  ('Macbook Air', 999.99, 'Laptop ligera y eficiente de Apple', 'Laptop', 'Apple'),
  
  -- Insertar una pantalla con resolución Full HD
  ('Full HD', 120.00, 'Pantalla con resolución Full HD ideal para multimedia', 'Monitor', 'Samsung'),
  
  -- Insertar la laptop Macbook Pro
  ('Macbook Pro', 1299.99, 'Laptop de alto rendimiento para profesionales', 'Laptop', 'Apple'),
  
  -- Insertar el procesador Intel i13
  ('i13', 300.00, 'Procesador Intel i13 de última generación', 'Laptop', 'Intel'),
  
  -- Insertar un producto de la marca LG (puede ser cualquier dispositivo)
  ('LG', 250.00, 'Producto representativo de la marca LG', 'Telefono', 'LG'),
  
  -- Insertar un producto de la marca Motorola
  ('Motorola', 180.00, 'Producto representativo de la marca Motorola', 'Telefono', 'Motorola'),
  
  -- Insertar el procesador AMD Ryzen 5
  ('ryzen 5', 220.00, 'Procesador AMD Ryzen 5 para gaming y productividad', 'Laptop', 'AMD'),
  
  -- Insertar el procesador AMD Ryzen 3
  ('ryzen 3', 180.00, 'Procesador AMD Ryzen 3 ideal para tareas básicas', 'Laptop', 'AMD');

-- Muestra todos los registros de la tabla Productos
SELECT * FROM Productos;

-- Muestra todos los registros con una condicion que muestre el producto como tipo Laptop
SELECT * FROM Productos WHERE tipo = 'Laptop';

SELECT * FROM Productos WHERE marca = 'AMD' AND precio <200;

SELECT * FROM Productos WHERE tipo = 'Laptop' or precio<400 ORDER BY precio;

-- Agrega una columna llamada "tipo" de tipo VARCHAR(50) a la tabla Productos
ALTER TABLE Productos ADD COLUMN tipo INT;
ALTER TABLE Productos ADD COLUMN marca INT;
 
 
-- Actualiza el registro en la tabla Productos donde la columna ID_Producto_PK es igual a 1,
-- estableciendo el nombre a 'Galaxy S6' y, en teoría, el valor de "tipo" a 'Telefono'
UPDATE Productos SET nombre = 'Galaxy S6', tipo = 'Telefono' WHERE ID_Producto_PK = 1;
UPDATE Productos SET precio = 1399.99 WHERE ID_Producto_PK = 10;
UPDATE Productos SET precio = 999.99 WHERE ID_Producto_PK = 11;


-- Nota: No Debe de ser ejecutado
-- Elimina la columna "tipo" de la tabla Productos
ALTER TABLE Productos DROP COLUMN tipo;
ALTER TABLE Productos DROP COLUMN marca;

-- Crear la tabla "Marcas" con campos "id" y "nombre"
CREATE TABLE Marcas (
    id_Marca INT NOT NULL,   -- Identificador único de la marca
    nombre VARCHAR(50) NOT NULL,        -- Nombre de la marca
    PRIMARY KEY (id_Marca )                  -- Establece la columna "id" como clave primaria
);
 
-- Crear la tabla "Tipo_de_Producto" con campos "id" y "nombre"
CREATE TABLE Tipo_de_Producto (
    id_Tipo INT NOT NULL,   -- Identificador único del tipo de producto
    nombre VARCHAR(50) NOT NULL,        -- Nombre del tipo de producto
    PRIMARY KEY (id_Tipo)                  -- Establece la columna "id" como clave primaria
);

select * from Marcas;
Select * from Tipo_de_Producto;

ALTER TABLE Productos
ADD CONSTRAINT fk_productos_marca
FOREIGN KEY (marca) REFERENCES Marcas(id_Marca);

ALTER TABLE Productos
ADD CONSTRAINT fk_productos_tipo
FOREIGN KEY (tipo) REFERENCES Tipo_de_Producto(id_Tipo);

ALTER TABLE Productos
MODIFY COLUMN tipo INT NOT NULL;
ALTER TABLE Productos
MODIFY COLUMN marca INT NOT NULL;


INSERT INTO Marcas (id_Marca, nombre) 
VALUES
    (1, 'Samsung'),
    (2, 'Intel'),
    (3, 'LG'),
    (4, 'Apple'),
    (5, 'AMD'),
    (6, 'Motorola');

INSERT INTO Tipo_de_Producto (id_Tipo, nombre) 
VALUES
    (1, 'Laptop'),
    (2, 'Monitor'),
    (3, 'Telefono');
    
-- Actualizar la tabla Productos para asignar las claves foráneas correspondientes
UPDATE Productos
SET marca = (SELECT id_Marca FROM Marcas WHERE nombre = 'Samsung'),
    tipo = (SELECT id_Tipo FROM Tipo_de_Producto WHERE nombre = 'Telefono')
WHERE nombre = 'Galaxy S6';

UPDATE Productos
SET marca = (SELECT id_Marca FROM Marcas WHERE nombre = 'Intel'),
    tipo = (SELECT id_Tipo FROM Tipo_de_Producto WHERE nombre = 'Laptop')
WHERE nombre = 'i5';

UPDATE Productos
SET marca = (SELECT id_Marca FROM Marcas WHERE nombre = 'LG'),
    tipo = (SELECT id_Tipo FROM Tipo_de_Producto WHERE nombre = 'Monitor')
WHERE nombre = 'Monitor 24';

UPDATE Productos
SET marca = (SELECT id_Marca FROM Marcas WHERE nombre = 'Apple'),
    tipo = (SELECT id_Tipo FROM Tipo_de_Producto WHERE nombre = 'Laptop')
WHERE nombre = 'Macbook Air';

UPDATE Productos
SET marca = (SELECT id_Marca FROM Marcas WHERE nombre = 'Samsung'),
    tipo = (SELECT id_Tipo FROM Tipo_de_Producto WHERE nombre = 'Monitor')
WHERE nombre = 'Full HD';

UPDATE Productos
SET marca = (SELECT id_Marca FROM Marcas WHERE nombre = 'Apple'),
    tipo = (SELECT id_Tipo FROM Tipo_de_Producto WHERE nombre = 'Laptop')
WHERE nombre = 'Macbook Pro';

UPDATE Productos
SET marca = (SELECT id_Marca FROM Marcas WHERE nombre = 'Intel'),
    tipo = (SELECT id_Tipo FROM Tipo_de_Producto WHERE nombre = 'Laptop')
WHERE nombre = 'i13';

UPDATE Productos
SET marca = (SELECT id_Marca FROM Marcas WHERE nombre = 'LG'),
    tipo = (SELECT id_Tipo FROM Tipo_de_Producto WHERE nombre = 'Telefono')
WHERE nombre = 'LG';

UPDATE Productos
SET marca = (SELECT id_Marca FROM Marcas WHERE nombre = 'Motorola'),
    tipo = (SELECT id_Tipo FROM Tipo_de_Producto WHERE nombre = 'Telefono')
WHERE nombre = 'Motorola';

UPDATE Productos
SET marca = (SELECT id_Marca FROM Marcas WHERE nombre = 'AMD'),
    tipo = (SELECT id_Tipo FROM Tipo_de_Producto WHERE nombre = 'Laptop')
WHERE nombre = 'ryzen 5';

UPDATE Productos
SET marca = (SELECT id_Marca FROM Marcas WHERE nombre = 'AMD'),
    tipo = (SELECT id_Tipo FROM Tipo_de_Producto WHERE nombre = 'Laptop')
WHERE nombre = 'ryzen 3';

SET SQL_SAFE_UPDATES = 0;
SET SQL_SAFE_UPDATES = 1;


-- hacer un match exaecto, expecciones regulares
SELECT * FROM Productos WHERE nombre LIKE 'M%';

SELECT * FROM Productos WHERE descripcion LIKE '%Intel%';

-- Solo una vez y no te lo trae repetido
SELECT DISTINCT Tipo FROM Productos;
SELECT * FROM Productos;

UPDATE Productos SET precio = NULL WHERE ID_Producto_PK = 2; 

SELECT * FROM Productos WHERE precio IS NULL;

SELECT p.nombre, p.precio, m.nombre FROM Productos AS p INNER JOIN Marcas as m on p.marca = m.id_Marca;

