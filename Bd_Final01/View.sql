CREATE VIEW ClientesReservas AS
SELECT C.Cli_Nombre, C.Cli_Direccion, R.Re_FechaReserva, R.Re_NumeroPersonas
FROM Cliente C
JOIN Reserva R ON C.Id_Cliente = R.Id_Cliente;
GO

CREATE VIEW DetalleOrdenes AS
SELECT O.Id_Orden, C.Cli_Nombre AS Cliente, E.Em_Nombre AS Empleado, O.Or_Platillos, O.Or_Fecha
FROM Orden O
JOIN Cliente C ON O.Id_Cliente = C.Id_Cliente
JOIN Empleado E ON O.Id_Persona = E.Id_Persona;
GO

CREATE VIEW InsumosProveedores AS
SELECT I.In_Descripcion, I.In_Precio, I.In_Tipo, P.Pro_TipoServicio, P.Pro_Localizacion
FROM Insumos I
JOIN Proveedores P ON I.Id_Proveedor = P.Id_Proveedor;
GO

CREATE VIEW BoletasConEmpleado AS
SELECT B.Id_Boleta, E.Em_Nombre, B.Bo_Monto, B.Bo_Metodo
FROM Boleta B
JOIN Empleado E ON B.Id_Persona = E.Id_Persona;
GO

CREATE VIEW ClientesMasFrecuentes AS
SELECT 
    C.Id_Cliente,
    C.Cli_Nombre,
    COUNT(O.Id_Orden) AS Numero_Ordenes
FROM Cliente C
JOIN Orden O ON C.Id_Cliente = O.Id_Cliente
GROUP BY C.Id_Cliente, C.Cli_Nombre
ORDER BY Numero_Ordenes DESC;
GO