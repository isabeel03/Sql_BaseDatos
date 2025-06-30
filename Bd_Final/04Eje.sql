

-- 1. Clientes y sus respectivas reservas
SELECT C.Cli_Nombre, C.Cli_Direccion, R.Re_FechaReserva, R.Re_NumeroPersonas
FROM Cliente C
JOIN Reserva R ON C.Id_Cliente = R.Id_Cliente;

-- 2. Detalle de órdenes con nombres de cliente y empleado
SELECT O.Id_Orden, C.Cli_Nombre AS Cliente, E.Em_Nombre AS Empleado, O.Or_Platillos, O.Or_Fecha
FROM Orden O
JOIN Cliente C ON O.Id_Cliente = C.Id_Cliente
JOIN Empleado E ON O.Id_Persona = E.Id_Persona;

-- 3. Insumos y tipo de servicio de su proveedor
SELECT I.In_Descripcion, I.In_Precio, I.In_Tipo, P.Pro_TipoServicio, P.Pro_Localizacion
FROM Insumos I
JOIN Proveedores P ON I.Id_Proveedor = P.Id_Proveedor;

-- 4. Boletas emitidas con el nombre del empleado
SELECT B.Id_Boleta, E.Em_Nombre, B.Bo_Monto, B.Bo_Metodo
FROM Boleta B
JOIN Empleado E ON B.Id_Persona = E.Id_Persona;


--PROCEDIMIENTOS ALMACENADOS

DROP PROCEDURE IF EXISTS sp_InsertarCliente;
GO
-- Procedimiento 1: Insertar un nuevo cliente
CREATE PROCEDURE sp_InsertarCliente
    @Id_Cliente VARCHAR(20),
    @Cli_Gmail VARCHAR(50),
    @Cli_Telefono INT,
    @Cli_Nombre VARCHAR(50),
    @Cli_Direccion VARCHAR(100)
AS
BEGIN
    INSERT INTO Cliente VALUES (@Id_Cliente, @Cli_Gmail, @Cli_Telefono, @Cli_Nombre, @Cli_Direccion);
END;
GO

DROP PROCEDURE IF EXISTS sp_InsumosPorTipo;
GO

-- Procedimiento 2: Consultar insumos por tipo
CREATE PROCEDURE sp_InsumosPorTipo
    @Tipo VARCHAR(20)
AS
BEGIN
    SELECT * FROM Insumos WHERE In_Tipo = @Tipo;
END;
GO

DROP PROCEDURE IF EXISTS sp_ActualizarSalario;
GO

-- Procedimiento 3: Actualizar salario de empleado
CREATE PROCEDURE sp_ActualizarSalario
    @Id_Persona VARCHAR(20),
    @NuevoSalario INT
AS
BEGIN
    UPDATE Empleado SET Em_Salario = @NuevoSalario WHERE Id_Persona = @Id_Persona;
END;
GO


DROP PROCEDURE IF EXISTS sp_EliminarReserva;
GO 
-- Procedimiento 4: Eliminar una reserva por ID
CREATE PROCEDURE sp_EliminarReserva
    @Id_Reserva VARCHAR(20)
AS
BEGIN
    DELETE FROM Reserva WHERE Id_Reserva = @Id_Reserva;
END;
GO



--- Creacion de usuarios
--CONTROL DE ACCESO
---Crear usuario clienteConsulta con acceso solo de lectura en la tabla Cliente


CREATE LOGIN clienteConsulta 
WITH PASSWORD = '123456', 
CHECK_POLICY = OFF;

CREATE USER clienteConsulta FOR LOGIN clienteConsulta;
GRANT SELECT ON dbo.Cliente TO clienteConsulta;

--Crear usuario reservasUser con permisos de lectura y escritura sobre la tabla Reserva
CREATE LOGIN reservasUser WITH PASSWORD = '123456', CHECK_POLICY = OFF;

CREATE USER reservasUser FOR LOGIN reservasUser;
GRANT SELECT, INSERT, UPDATE, DELETE ON dbo.Reserva TO reservasUser;

-----Crear usuario empleadoRead con permiso solo de lectura sobre Empleado y Boleta

CREATE LOGIN empleadoRead WITH PASSWORD = '123456', CHECK_POLICY = OFF;

CREATE USER empleadoRead FOR LOGIN empleadoRead;
GRANT SELECT ON dbo.Empleado TO empleadoRead;
GRANT SELECT ON dbo.Boleta TO empleadoRead;

---Crear usuario insumoManager con permiso solo para insertar en la tabla 
--Insumos (pero no modificar ni borrar)--

CREATE LOGIN insumoManager WITH PASSWORD = '123456', CHECK_POLICY = OFF;

CREATE USER insumoManager FOR LOGIN insumoManager;
GRANT INSERT ON dbo.Insumos TO insumoManager;
DENY UPDATE, DELETE ON dbo.Insumos TO insumoManager;


-----CONTROL DE TRANSACCIONES

--- Registrar una reserva y asegurarse de que falle todo si algo sale mal
BEGIN TRY
    BEGIN TRANSACTION;

    INSERT INTO Reserva (Id_Reserva, Id_Cliente, Re_Mesa, Re_FechaReserva, Re_NumeroPersonas)
    VALUES ('RES11', 'CLI01', 2, GETDATE(), 3);

    COMMIT;
END TRY
BEGIN CATCH
    ROLLBACK;
    PRINT 'Error al registrar la reserva: ' + ERROR_MESSAGE();
END CATCH

----Actualizar salario de un empleado
BEGIN TRY
    BEGIN TRANSACTION;

    UPDATE Empleado
    SET Em_Salario = 2500
    WHERE Id_Persona = 'EMP01';

    COMMIT;
END TRY
BEGIN CATCH
    ROLLBACK;
    PRINT 'Error al actualizar salario: ' + ERROR_MESSAGE();
END CATCH

---Insertar orden y registrar fecha al mismo tiempo

BEGIN TRY
    BEGIN TRANSACTION;

    INSERT INTO Orden (Id_Orden, Id_Reserva, Id_Cliente, Id_Persona, Or_Platillos, Or_Fecha)
    VALUES ('ORD11', 'RES01', 'CLI01', 'EMP02', 2, GETDATE());

    COMMIT;
END TRY
BEGIN CATCH
    ROLLBACK;
    PRINT 'Error al registrar la orden: ' + ERROR_MESSAGE();
END CATCH

---Insertar nueva boleta y validar monto
BEGIN TRY
    BEGIN TRANSACTION;

    INSERT INTO Boleta (Id_Boleta, Id_Persona, Bo_Monto, Bo_Datos, Bo_Metodo)
    VALUES (11, 'EMP01', 180, 150, 'Efectivo');

    COMMIT;
END TRY
BEGIN CATCH
    ROLLBACK;
    PRINT 'Error al registrar la boleta: ' + ERROR_MESSAGE();
END CATCH