-- 1. Crear la base de datos
CREATE DATABASE demo_kimball;
GO

USE demo_kimball;
GO

-- 2. Crear Dimensión Cliente
CREATE TABLE Dim_Cliente (
    id_cliente INT PRIMARY KEY, -- Cargaremos esto desde Python
    nombre VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    fecha_registro DATE
);

-- 3. Crear Tabla de Hechos Ventas
CREATE TABLE Fact_Ventas (
    id_venta INT PRIMARY KEY,
    id_cliente INT,
    cantidad INT,
    precio_unitario DECIMAL(10,2),
    fecha DATE,
    -- Relación de llave foránea
    CONSTRAINT FK_Ventas_Cliente FOREIGN KEY (id_cliente) 
    REFERENCES Dim_Cliente(id_cliente)
);