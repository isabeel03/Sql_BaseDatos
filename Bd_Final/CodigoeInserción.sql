

-- Tabla Cliente
CREATE TABLE Cliente (
    Id_Cliente VARCHAR(20) PRIMARY KEY,
    Cli_Gmail VARCHAR(50),
    Cli_Telefono INTEGER,
    Cli_Nombre VARCHAR(50),
    Cli_Direccion VARCHAR(100)
);

-- Tabla Proveedores
CREATE TABLE Proveedores (
    Id_Proveedor VARCHAR(20) PRIMARY KEY,
    Pro_TipoServicio VARCHAR(50),
    Pro_Localizacion VARCHAR(50)
);

-- Tabla Empleado
CREATE TABLE Empleado (
    Id_Persona VARCHAR(20) PRIMARY KEY,
    Em_Salario INTEGER,
    Em_FechaContrato DATE,
    Em_Puesto VARCHAR(30),
    Em_Nombre VARCHAR(50)
);

-- Tabla Reserva (relacionada con Cliente)
CREATE TABLE Reserva (
    Id_Reserva VARCHAR(20) PRIMARY KEY,
    Id_Cliente VARCHAR(20),
    Re_Mesa INTEGER,
    Re_FechaReserva DATE,
    Re_NumeroPersonas INTEGER,
    FOREIGN KEY (Id_Cliente) REFERENCES Cliente(Id_Cliente)
);

-- Tabla Orden (relacionada con Reserva, Cliente y Empleado)
CREATE TABLE Orden (
    Id_Orden VARCHAR(20) PRIMARY KEY,
    Id_Reserva VARCHAR(20),
    Id_Cliente VARCHAR(20),
    Id_Persona VARCHAR(20),
    Or_Platillos INTEGER,
    Or_Fecha DATE,
    FOREIGN KEY (Id_Reserva) REFERENCES Reserva(Id_Reserva),
    FOREIGN KEY (Id_Cliente) REFERENCES Cliente(Id_Cliente),
    FOREIGN KEY (Id_Persona) REFERENCES Empleado(Id_Persona)
);

-- Tabla Boleta (relacionada con Empleado)
CREATE TABLE Boleta (
    Id_Boleta INTEGER PRIMARY KEY,
    Id_Persona VARCHAR(20),
    Bo_Monto INTEGER,
    Bo_Datos INTEGER,
    Bo_Metodo VARCHAR(30),
    FOREIGN KEY (Id_Persona) REFERENCES Empleado(Id_Persona)
);

-- Tabla Insumos (relacionada con Proveedores)
CREATE TABLE Insumos (
    Id_Productos VARCHAR(20) PRIMARY KEY,
    In_Descripcion VARCHAR(50),
    In_Precio DECIMAL(6,2),
    In_Tipo VARCHAR(20), -- comida o bebida
    Id_Proveedor VARCHAR(20),
    FOREIGN KEY (Id_Proveedor) REFERENCES Proveedores(Id_Proveedor)
);


-- Tabla Cliente
INSERT INTO Cliente VALUES
('CLI01','jose@gmail.com',999123456,'Jose','Lima'),
('CLI02','ana@gmail.com',987654321,'Ana','Arequipa'),
('CLI03','luis@gmail.com',922334455,'Luis','Cusco'),
('CLI04','rosa@hotmail.com',923112233,'Rosa','Piura'),
('CLI05','carlos@gmail.com',911998877,'Carlos','Trujillo'),
('CLI06','elena@hotmail.com',918273645,'Elena','Tacna'),
('CLI07','pedro@gmail.com',955667788,'Pedro','Iquitos'),
('CLI08','diana@hotmail.com',965443322,'Diana','Lambayeque'),
('CLI09','alicia@gmail.com',912345678,'Alicia','Chiclayo'),
('CLI10','jorge@gmail.com',934567890,'Jorge','Callao');

-- Tabla Proveedores
INSERT INTO Proveedores VALUES
('PROV01','Bebidas','Lima'),
('PROV02','Carnes','Arequipa'),
('PROV03','Lacteos','Cusco'),
('PROV04','Verduras','Piura'),
('PROV05','Panaderia','Trujillo'),
('PROV06','Licores','Tacna'),
('PROV07','Embutidos','Lambayeque'),
('PROV08','Pescados','Callao'),
('PROV09','Salsas','Chiclayo'),
('PROV10','Gaseosas','Iquitos');

-- Tabla Empleado
INSERT INTO Empleado VALUES
('EMP01',1500,'2023-01-10','Mozo','Mario'),
('EMP02',2000,'2022-03-15','Cocinero','Lucia'),
('EMP03',1200,'2021-06-05','Bartender','Carlos'),
('EMP04',1300,'2020-02-28','Anfitrion','Roxana'),
('EMP05',1500,'2022-12-12','Mozo','Andres'),
('EMP06',2200,'2021-08-21','Chef','Teresa'),
('EMP07',1000,'2023-05-10','Cajero','Bruno'),
('EMP08',1800,'2023-07-17','Supervisor','Sandra'),
('EMP09',1400,'2021-11-30','Ayudante','Ricardo'),
('EMP10',1600,'2022-04-03','Mozo','Valeria');

-- Tabla Reserva
INSERT INTO Reserva VALUES
('RES01','CLI01',3,'2025-06-01',4),
('RES02','CLI02',5,'2025-06-02',2),
('RES03','CLI03',1,'2025-06-03',6),
('RES04','CLI04',7,'2025-06-04',3),
('RES05','CLI05',4,'2025-06-05',5),
('RES06','CLI06',2,'2025-06-06',1),
('RES07','CLI07',6,'2025-06-07',4),
('RES08','CLI08',8,'2025-06-08',3),
('RES09','CLI09',9,'2025-06-09',6),
('RES10','CLI10',10,'2025-06-10',2);

-- Tabla Orden
INSERT INTO Orden VALUES
('ORD01','RES01','CLI01','EMP01',3,'2025-06-01'),
('ORD02','RES02','CLI02','EMP02',5,'2025-06-02'),
('ORD03','RES03','CLI03','EMP03',2,'2025-06-03'),
('ORD04','RES04','CLI04','EMP04',4,'2025-06-04'),
('ORD05','RES05','CLI05','EMP05',1,'2025-06-05'),
('ORD06','RES06','CLI06','EMP06',3,'2025-06-06'),
('ORD07','RES07','CLI07','EMP07',6,'2025-06-07'),
('ORD08','RES08','CLI08','EMP08',2,'2025-06-08'),
('ORD09','RES09','CLI09','EMP09',4,'2025-06-09'),
('ORD10','RES10','CLI10','EMP10',5,'2025-06-10');

-- Tabla Boleta
INSERT INTO Boleta VALUES
(1,'EMP01',150,123,'Efectivo'),
(2,'EMP02',230,124,'Yape'),
(3,'EMP03',120,125,'Plin'),
(4,'EMP04',180,126,'Tarjeta'),
(5,'EMP05',100,127,'Efectivo'),
(6,'EMP06',210,128,'Yape'),
(7,'EMP07',300,129,'Tarjeta'),
(8,'EMP08',250,130,'Efectivo'),
(9,'EMP09',130,131,'Plin'),
(10,'EMP10',200,132,'Efectivo');

-- Tabla Insumos (relacionados a proveedores)
INSERT INTO Insumos VALUES
('PROD01','Cerveza',8.50,'bebida','PROV01'),
('PROD02','Pizza',25.00,'comida','PROV05'),
('PROD03','Papas Fritas',10.00,'comida','PROV04'),
('PROD04','Inka Kola',5.50,'bebida','PROV10'),
('PROD05','Tequila',15.00,'bebida','PROV06'),
('PROD06','Alitas BBQ',18.00,'comida','PROV02'),
('PROD07','Pisco Sour',12.00,'bebida','PROV06'),
('PROD08','Ceviche',20.00,'comida','PROV08'),
('PROD09','Gaseosa',6.00,'bebida','PROV10'),
('PROD10','Hamburguesa',22.00,'comida','PROV07');