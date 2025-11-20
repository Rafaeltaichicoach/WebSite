-- Creación de la tabla de Clientes
CREATE TABLE clientes (
    id_cliente VARCHAR(20) primary key not null, 
    nombre VARCHAR(20), 
    email VARCHAR(100), 
    telefono VARCHAR(15), 
    direccion VARCHAR(255), 
    fecha_nacimiento VARCHAR(50), 
    genero VARCHAR(10), 
    fecha_registro VARCHAR(50)
);

-- Inserción de datos en la tabla Clientes
INSERT INTO clientes (id_cliente, nombre, email, telefono, direccion, fecha_nacimiento, genero, fecha_registro) 
VALUES 
    ('A-1153', 'Mariana', 'mari@gmail.com', '932168465', 'Av. Valparaiso 102', '05-02-1988', 'femenino', '25-05-2023'),
    ('A-1234', 'Petronila', 'pac@gmail.com', '987654321', 'Los tulipanes 610', '25-03-1957', 'femenino', '28-02-2020'),
    ('A-4567', 'Javiera', 'jav@gmail.com', '912345678', 'Los acacios 456', '30-04-1984', 'femenino', '26-02-2020'),
    ('A-7895', 'Sandra', 'sand@gmail.com', '945678351', 'Las Rosas 102', '27-05-1980', 'femenino', '10-03-2021'),
    ('A-9516', 'Andrea', 'andy@gmail.com', '978413218', 'Pedro Montt 3020', '10-04-1995', 'femenino', '11-06-2022');

select * from clientes

-- Creación de la tabla de Productos
CREATE TABLE productos (
    id_producto VARCHAR(20) primary key not null, 
    nombre_producto VARCHAR(100), 
    marca VARCHAR(50), 
    categoria VARCHAR(50), 
    precio NUMERIC, 
    stock NUMERIC, 
    descripcion VARCHAR(100)
);

-- Inserción de datos en la tabla Productos
INSERT INTO productos (id_producto, nombre_producto, marca, categoria, precio, stock, descripcion) 
VALUES 
    ('B-01', 'Circus Fantasy EDP 100 ml', 'Britney Spears', 'Perfumes', '23990', '12', 'formato grande'),
    ('B-03', 'Fantasy Midnight EDP 100 ml', 'Britney Spears', 'Perfumes', '18990', '10', 'formato grande'),
    ('B-04', 'Curious EDP 100 ml', 'Britney Spears', 'Perfumes', '15990', '11', 'formato grande'),
    ('B-05', 'Believe EDP 100 ml', 'Britney Spears', 'Perfumes', '19990', '15', 'formato grande'),
    ('B-06', 'Naked Fantasy EDP 100 ml', 'Britney Spears', 'Perfumes', '14990', '20', 'formato grande');

select * from productos

-- Creación de la tabla de Pedidos
CREATE TABLE pedidos (
    id_pedidos VARCHAR(20) primary key not null, 
    id_cliente VARCHAR(10), 
    fecha_pedido VARCHAR(20), 
    metodo_pago VARCHAR(50), 
    estado VARCHAR(20)
);

-- Inserción de datos en la tabla Pedidos
INSERT INTO pedidos (id_pedidos, id_cliente, fecha_pedido, metodo_pago, estado) 
VALUES 
    ('J-635', 'A-7895', '10-03-2021', 'efectivo', 'procesado'),
    ('J-763', 'A-1153', '25-05-2023', 'debito', 'enviado'),
    ('J-852', 'A-4567', '26-02-2020', 'debito', 'enviado'),
    ('J-857', 'A-9516', '11-06-2022', 'efectivo', 'pendiente'),
    ('J-965', 'A-1234', '28-02-2020', 'credito', 'procesado');

-- Creación de la tabla de Detalle_Pedido
CREATE TABLE detalle_pedido (
    id_detalle_pedido VARCHAR(50) primary key not null, 
    id_pedidos VARCHAR(20), 
    id_producto VARCHAR(20), 
    cantidad NUMERIC, 
    fecha_pedido VARCHAR(50)
);

-- Inserción de datos en la tabla Detalle_Pedido
INSERT INTO detalle_pedido (id_detalle_pedido, id_pedidos, id_producto, cantidad, fecha_pedido)
VALUES 
    ('P-236', 'J-965', 'B-01', 1, '28-02-2020'),
    ('P-428', 'J-763', 'B-04', 2, '25-05-2023'),
    ('P-563', 'J-852', 'B-03', 1, '26-02-2020'),
    ('P-589', 'J-635', 'B-06', 2, '10-03-2021'),
    ('P-829', 'J-857', 'B-05', 1, '11-06-2022');

-- Creación de la tabla de Historial_Compras
CREATE TABLE historial_compras (
    id_historial VARCHAR(50) primary key not null, 
    id_cliente VARCHAR(20), 
    id_producto VARCHAR(20), 
    fecha_compra VARCHAR(50), 
    monto_total NUMERIC
);

-- Inserción de datos en la tabla Historial_Compras
INSERT INTO historial_compras (id_historial, id_cliente, id_producto, fecha_compra, monto_total) 
VALUES 
    ('adpiuv', 'A-1153', 'B-04', '25-05-2023', '31980'),
    ('aeoiru', 'A-9516', 'B-05', '11-06-2022', '19990'),
    ('alidjbv', 'A-4567', 'B-03', '26-02-2020', '18990'),
    ('kajsdv', 'A-1234', 'B-01', '28-02-2020', '23990'),
    ('vbaofi', 'A-7895', 'B-06', '10-03-2021', '29980');

ALTER TABLE pedidos ADD CONSTRAINT fkid_clientes foreign key(id_cliente) references clientes(id_cliente) ON DELETE CASCADE;
ALTER TABLE detalle_pedido ADD CONSTRAINT fkid_pedidos foreign key(id_pedidos) references pedidos(id_pedidos) ON DELETE CASCADE;
ALTER TABLE detalle_pedido ADD CONSTRAINT fkid_producto foreign key(id_producto) references productos(id_producto) ON DELETE CASCADE;
ALTER TABLE historial_compras ADD CONSTRAINT fkid_cliente foreign key(id_cliente) references clientes(id_cliente) ON DELETE CASCADE;
ALTER TABLE historial_compras ADD CONSTRAINT fkid_producto foreign key(id_producto) references productos(id_producto) ON DELETE CASCADE;

-- Procedimiento almacenado: análisis y código
CREATE PROCEDURE saludar(nombre TEXT)
LANGUAGE plpgsql
AS $$
BEGIN
	RAISE NOTICE '¡Hola, %!', nombre;
END;
$$;

CALL saludar('Mariana');

-- Análisis de vista y código
Combinar información de varias tablas: clientes, historial_compras y productos
Respuesta a preguntas: 
¿Qué producto ha comprado el cliente?
¿Cuánto ha gastado?
¿En qué fecha realizó la compra?
¿Que categoria de producto prefiere?

CREATE VIEW vista_historial_compras AS
SELECT
	c.id_cliente,
	c.nombre AS nombre_cliente,
	c.email,
	p.nombre_producto,
	p.categoria,
	hc.fecha_compra,
	hc.monto_total
FROM historial_compras hc
JOIN clientes c ON hc.id_cliente = c.id_cliente
JOIN productos p ON hc.id_producto = p.id_producto;

SELECT * FROM vista_historial_compras;

--Función con parámetro: análisis y código
--Obtener el monto total gastado por un cliente específico.

CREATE OR REPLACE FUNCTION total_gastado_por_cliente(cliente_id VARCHAR)
RETURNS NUMERIC AS $$
DECLARE
	total NUMERIC;
BEGIN
	SELECT COALESCE(SUM(monto_total), 0)
	INTO total
	FROM historial_compras
	WHERE id_cliente = cliente_id;

	RETURN total;
END;
$$ LANGUAGE plpgsql;

SELECT total_gastado_por_cliente('A-1153');

CREATE OR REPLACE FUNCTION total_gastado_por_cliente(cliente_id VARCHAR DEFAULT 'A-1234')
RETURNS NUMERIC AS $$
DECLARE
    total NUMERIC;
BEGIN
    SELECT COALESCE(SUM(monto_total), 0)
    INTO total
    FROM historial_compras
    WHERE id_cliente = cliente_id;

    RETURN total;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION total_gastado_general()
RETURNS NUMERIC AS $$
DECLARE
    total NUMERIC;
BEGIN
    SELECT COALESCE(SUM(monto_total), 0)
    INTO total
    FROM historial_compras;

    RETURN total;
END;
$$ LANGUAGE plpgsql;

SELECT total_gastado_general();

--Trigger: análisis y código
--Crear tabla resumen:
CREATE TABLE resumen_clientes (
	id_cliente VARCHAR(20) PRIMARY KEY,
	total_gastado NUMERIC DEFAULT 0
);
-- Función que se ejecutará con el trigger
CREATE OR REPLACE FUNCTION actualizar_total_gastado()
RETURNS TRIGGER AS $$
BEGIN
	-- Si el cliente ya existe en resumen_clientes, actualiza el total
	IF EXISTS (SELECT 1 FROM resumen_clientes WHERE id_cliente = NEW.id_cliente) THEN
		UPDATE resumen_clientes
		SET total_gastado = total_gastado + NEW.monto_total
		WHERE id_cliente = NEW.id_cliente;
	ELSE
		--Si no existe, lo inserta
		INSERT INTO resumen_clientes (id_cliente, total_gastado)
		VALUES (NEW.id_cliente, NEW.monto_total);
	END IF;

	RETURN NEW;
END;
$$ LANGUAGE plpgsql

CREATE TRIGGER trg_actualizar_total_gastado
AFTER INSERT ON historial_compras
FOR EACH ROW
EXECUTE FUNCTION actualizar_total_gastado();

INSERT INTO historial_compras (id_historial, id_cliente, id_producto, fecha_compra, monto_total)
VALUES ('nuevo123', 'A-1153', 'B-01', '23-10-2025', 10000);

-- Trigger que llama a la función  después de insertar en historial_compras
CREATE TRIGGER trigger_actualizar_total
AFTER INSERT ON historial_compras
FOR EACH ROW
EXECUTE FUNCTION actualizar_total_gastado();
-- Con este trigger, cada vez que se inserta una nueva compra en historial_compras, el trigger:
-- Verifica si el cliente ya tiene un resumen
-- Si lo tiene, suma el nuevo monto
-- Si no tiene, crea el registro inicial

-- Inserta una nueva compra
INSERT INTO historial_compras (id_historial, id_cliente, id_producto, fecha_compra, monto_total)
VALUES ('test001', 'A-1153', 'B-01', '23-10-2025', 10000);

-- Verifica el resumen actualizado
SELECT * FROM resumen_clientes WHERE id_cliente = 'A-1153';