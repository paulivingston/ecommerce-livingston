--drop database ECOMMERCELIVINGSTON

create database ECOMMERCELIVINGSTON
go
use ECOMMERCELIVINGSTON
go
USE [ECOMMERCELIVINGSTON]
GO

------------TABLAS------------

CREATE TABLE MARCAS (
	Id INT IDENTITY(1,1) not null PRIMARY KEY,
	Descripcion varchar(50) not null,
	ImagenUrl VARCHAR(1000)NOT NULL
)

GO

CREATE TABLE CATEGORIAS (
	Id INT IDENTITY(1,1) not null PRIMARY KEY,
	Descripcion varchar(50) not null,
	ImagenUrl VARCHAR(1000)NOT NULL
)

GO

CREATE TABLE ARTICULOS(
	Id INT PRIMARY KEY NOT NULL,
	Nombre VARCHAR(50) NULL,
	Descripcion VARCHAR(300) NULL,
	IdMarca INT NULL,
	IdCategoria INT NULL,
	ImagenUrl VARCHAR(1000) NULL,
	Precio DECIMAL NULL,
	Estado BIT NOT NULL,
	Stock INT NOT NULL
)

GO

CREATE TABLE IMAGENES(
	Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	IdArticulo INT NULL,
	ImagenUrl VARCHAR(1000)NOT NULL,
)

GO

CREATE TABLE PEDIDOS(
	IdPedido INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	IdUsuarios INT NOT NULL,
	Cantidad INT NOT NULL,
	Fecha DATE NOT NULL,
	Estado VARCHAR(20) NOT NULL,
	DireccionEntrega VARCHAR(100) NOT NULL,
	Descuento DECIMAL NULL,
	PrecioTotal DECIMAL NOT NULL,
	pagado BIT NOT NULL,
	enviado BIT NOT NULL
)

GO

CREATE TABLE USUARIOS(
	Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Nombre VARCHAR(30) NOT NULL,
	Apellido VARCHAR(30) NOT NULL,
	DNI INT NOT NULL,
	Mail VARCHAR(30) NOT NULL,
	Clave VARCHAR(30) NOT NULL,
	Direccion VARCHAR(100) NOT NULL,
	Nivel CHAR NOT NULL, -- 0 admin 1 empleado 2 cliente �?
	ImagenUrl VARCHAR (MAX) NOT NULL,
	Activo BIT NOT NULL DEFAULT 1
)

GO

CREATE TABLE PEDIDO_ARTICULO(
	Id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	IdPedido INT NOT NULL FOREIGN KEY REFERENCES PEDIDOS (IdPedido),
	IdArticulo INT NOT NULL FOREIGN KEY REFERENCES ARTICULOS (Id),
	Cantidad INT NOT NULL
)

GO

CREATE TABLE DESCUENTOS(
	Id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	Codigo VARCHAR(30) NOT NULL,
	Porcentaje INT NOT NULL,
	Estado BIT NOT NULL
)

GO

------------FIN TABLAS------------



------------STORE PROCEDURES------------

--ARTICULOS

CREATE PROCEDURE sp_ListarArticulos
AS
BEGIN
	SELECT 
		A.Id, 
		A.Nombre, 
		A.Descripcion, 
		A.IdMarca, 
		ISNULL(M.Descripcion,'Sin Marca') AS 'Marca', 
		A.IdCategoria, 
		ISNULL(C.Descripcion,'Sin Categoria') AS 'Categoria', 
		A.Precio, 
		A.Estado, 
		A.Stock, 
		A.ImagenUrl 
	FROM ARTICULOS AS A 
	LEFT JOIN MARCAS AS M 
	ON A.IdMarca = M.Id 
	LEFT JOIN CATEGORIAS AS C 
	ON A.IdCategoria = C.Id
END 
GO


CREATE PROCEDURE sp_ListarArticulosActivos
AS
BEGIN
	SELECT 
		A.Id, 
		A.Nombre, 
		A.Descripcion, 
		A.IdMarca, 
		M.Descripcion AS 'Marca', 
		A.IdCategoria, 
		C.Descripcion AS 'Categoria', 
		A.Precio,  
		A.Stock, 
		A.ImagenUrl 
	FROM ARTICULOS AS A 
	INNER JOIN MARCAS AS M 
	ON A.IdMarca = M.Id 
	INNER JOIN CATEGORIAS AS C 
	ON A.IdCategoria = C.Id
	WHERE A.Estado=1
	AND A.Stock>0
END 
GO

CREATE PROCEDURE [dbo].[sp_ListarArticulosPorID]
@Id int
AS
BEGIN
	SELECT 
		A.Id AS 'Id', 
		A.Nombre AS 'Nombre', 
		A.Descripcion AS 'Descripcion', 
		A.IdMarca AS 'IdMarca', 
		ISNULL(M.Descripcion, 'Sin Marca') AS 'Marca', 
		A.IdCategoria AS 'IdCategoria', 
		ISNULL(C.Descripcion,'Sin Categoria') AS 'Categoria', 
		A.Precio AS 'Precio', 
		A.Estado AS 'Estado', 
		A.Stock AS 'Stock', 
		A.ImagenUrl AS 'ImagenUrl' 
	FROM ARTICULOS AS A 
	LEFT JOIN MARCAS AS M 
	ON A.IdMarca = M.Id 
	LEFT JOIN CATEGORIAS AS C 
	ON A.IdCategoria = C.Id
	WHERE A.Id = @id
END 
GO

CREATE PROCEDURE sp_CrearArticulo
@Id int,
@nombre varchar(50),
@descripcion varchar(150),
@idMarca int,
@idCategoria int,
@precio decimal(18,0),
@estado bit,
@stock int,
@imagenUrl varchar(1000)
AS
BEGIN
	INSERT INTO ARTICULOS (
		ID,
		Nombre,
		Descripcion,
		IdMarca,
		IdCategoria,
		Precio,
		Estado,
		Stock,
		ImagenUrl
	) 
	VALUES (
		@Id,
		@nombre,
		@descripcion,
		@idMarca,
		@idCategoria,
		@precio,
		@estado,
		@stock,
		@imagenUrl
	)
END 
GO

CREATE PROCEDURE sp_ModificarArticulo
@id int,
@nombre varchar(50),
@descripcion varchar(150),
@idMarca int,
@idCategoria int,
@precio decimal(18,0),
@stock int,
@imagenUrl varchar(1000)
AS
BEGIN
	UPDATE ARTICULOS 
	SET 
		Nombre = @nombre, 
		Descripcion = @descripcion, 
		IdMarca = @idMarca, 
		IdCategoria = @idCategoria, 
		Precio = @precio, 
		Stock = @stock, 
		ImagenUrl = @imagenUrl 
	WHERE Id = @id
END 
GO

CREATE PROCEDURE sp_EliminarArticulo
@id int
AS 
BEGIN
	UPDATE ARTICULOS 
	SET Estado=0
	WHERE Id = @id
END 
GO

CREATE PROCEDURE [dbo].[sp_CambiarEstadoArticulo]
@id int,
@estado bit
AS
BEGIN
	UPDATE ARTICULOS 
	SET Estado = @estado 
	WHERE Id = @id
END
GO

CREATE PROCEDURE [dbo].[sp_CantidadArticulos]
AS
BEGIN
	select count(*) AS 'Articulos' 
	from ARTICULOS 
	where ESTADO=1
END
GO

CREATE PROCEDURE [dbo].[sp_ListarImgArt]
@id int
AS
BEGIN
	SELECT ImagenUrl 
	FROM IMAGENES 
	WHERE IdArticulo = @id
END
GO

--CATEGORIAS

CREATE PROCEDURE sp_ListarCategorias
AS
BEGIN
	SELECT 
		Id, 
		Descripcion, 
		ImagenUrl
	FROM CATEGORIAS
END
GO

CREATE PROCEDURE sp_CrearCategoria
@descripcion varchar(50), 
@ImagenUrl varchar(1000)
AS
BEGIN
	INSERT INTO CATEGORIAS (
		Descripcion, 
		ImagenUrl
	) 
	VALUES (
		@descripcion, 
		@ImagenUrl
	)
END
GO

CREATE PROCEDURE sp_ModificarCategoria
@id int, 
@descripcion varchar(50), 
@ImagenUrl varchar(1000)
AS
BEGIN
	UPDATE CATEGORIAS 
	SET 
		Descripcion = @descripcion, 
		ImagenUrl = @ImagenUrl 
	WHERE Id = @id
END
GO

CREATE PROCEDURE sp_EliminarCategoria
@id int
AS
BEGIN
	UPDATE A
	SET A.Estado = 0
	FROM ARTICULOS A 
	LEFT JOIN CATEGORIAS c ON A.IdCategoria=C.Id
	WHERE C.Id = @id

	DELETE FROM CATEGORIAS 
	WHERE Id = @id
END
GO

CREATE PROCEDURE [dbo].[sp_ComprobarIdCategoria]
@id int
AS
BEGIN
	SELECT count(*) as 'Id'
	FROM CATEGORIAS 
	WHERE Id = @id
END
GO

CREATE PROCEDURE [dbo].[sp_ExisteCategoria]
@descripcion varchar(50)
AS
BEGIN
	SELECT Id 
	FROM CATEGORIAS 
	WHERE Descripcion = @descripcion
END
GO

CREATE PROCEDURE [dbo].[sp_CantidadCategorias]
AS
BEGIN
	select count(*) AS 'Categorias' 
	from CATEGORIAS
END
GO

--MARCAS

CREATE PROCEDURE sp_ListarMarcas
AS
BEGIN
	SELECT 
		Id, 
		Descripcion, 
		ImagenUrl
	FROM MARCAS
END
GO

CREATE PROCEDURE sp_CrearMarca
@descripcion varchar(50), 
@ImagenUrl varchar(1000)
AS
BEGIN
	INSERT INTO MARCAS (
		Descripcion, 
		ImagenUrl
	) 
	VALUES (
		@descripcion, 
		@ImagenUrl
	)
END
GO

CREATE PROCEDURE sp_ModificarMarca
@id int, 
@descripcion varchar(50), 
@ImagenUrl varchar(1000)
AS
BEGIN
	UPDATE MARCAS 
	SET 
		Descripcion = @descripcion, 
		ImagenUrl = @ImagenUrl 
	WHERE Id = @id
END
GO

CREATE PROCEDURE sp_EliminarMarca
@id int
AS
BEGIN
	UPDATE A
	SET A.Estado = 0
	FROM ARTICULOS A 
	LEFT JOIN MARCAS M ON A.IdMarca=M.Id
	WHERE M.Id = @id

	DELETE FROM MARCAS 
	WHERE Id = @id
END
GO

CREATE PROCEDURE [dbo].[sp_CantidadMarcas]
AS
BEGIN
	select count(*) AS 'Marcas' 
	from MARCAS
END
GO

CREATE PROCEDURE [dbo].[sp_ComprobarIdMarca]
@id int
AS
BEGIN
	SELECT count(*) as 'Id'
	FROM MARCAS 
	WHERE Id = @id
END
GO

--USUARIOS

CREATE PROCEDURE [dbo].[sp_ListarUsuarios]
AS
BEGIN
	SELECT 
		Id, 
		Nombre, 
		Apellido, 
		DNI, 
		Mail, 
		Clave, 
		Direccion, 
		Nivel, 
		ImagenUrl, 
		Activo 
	FROM USUARIOS
END
GO

CREATE PROCEDURE [dbo].[sp_ListarUsuariosLogin]
@Mail varchar(30)
AS
BEGIN
	SELECT 
		Id, 
		Nombre, 
		Apellido, 
		DNI, 
		Mail, 
		Clave, 
		Direccion, 
		Nivel, 
		ImagenUrl, 
		Activo 
	FROM USUARIOS
	WHERE Mail = @Mail 
END
GO

CREATE PROCEDURE [dbo].[sp_ListarUsuariosPorID]
@id int
AS
BEGIN
	SELECT 
		Id, 
		Nombre, 
		Apellido, 
		DNI, 
		Mail, 
		Clave, 
		Direccion, 
		Nivel, 
		ImagenUrl, 
		Activo 
	FROM USUARIOS
	WHERE Id = @id
END
GO

CREATE PROCEDURE [dbo].[sp_CrearUsuario]
@Nombre varchar(30), 
@Apellido varchar(30), 
@DNI int, 
@Mail varchar(30), 
@Clave varchar(30), 
@Direccion varchar(100), 
@Nivel char(1), 
@UrlImagen  varchar(max), 
@Activo bit
AS
BEGIN
	INSERT INTO USUARIOS (
		Nombre, 
		Apellido, 
		DNI, 
		Mail, 
		Clave, 
		Direccion, 
		Nivel, 
		ImagenUrl, 
		Activo
	) 
	VALUES (
		@Nombre, 
		@Apellido, 
		@DNI, 
		@Mail, 
		@Clave, 
		@Direccion, 
		@Nivel, 
		@UrlImagen, 
		@Activo
	)

END
GO

CREATE PROCEDURE [dbo].[sp_ModificarUsuario]
@Id int,
@Nombre varchar(30), 
@Apellido varchar(30), 
@DNI int, 
@Mail varchar(30), 
@Clave varchar(30), 
@Direccion varchar(100), 
@Nivel char(1), 
@UrlImagen  varchar(max), 
@Activo bit
AS
BEGIN
	UPDATE USUARIOS 
	SET 
		Nombre = @Nombre, 
		Apellido = @Apellido, 
		DNI = @DNI, 
		Mail = @Mail, 
		Clave = @Clave, 
		Direccion = @Direccion, 
		Nivel = @Nivel, 
		ImagenUrl = @UrlImagen, 
		Activo = @Activo 
	WHERE Id = @Id
END
GO

CREATE PROCEDURE [dbo].[sp_EliminarUsuario]
@Id int
AS
BEGIN
	DELETE FROM USUARIOS 
	WHERE Id = @id
END
GO

CREATE PROCEDURE [dbo].[sp_AltaUsuario]
@Id int
AS
BEGIN
	UPDATE USUARIOS 
	SET Activo = 1 
	WHERE Id = @id
END
GO

CREATE PROCEDURE [dbo].[sp_BajaUsuario]
@Id int
AS
BEGIN
	UPDATE USUARIOS 
	SET Activo = 0 
	WHERE Id = @id
END
GO

CREATE PROCEDURE [dbo].[sp_CantidadUsuarios]
AS
BEGIN
	select count(*) AS 'Usuarios' 
	from USUARIOS 
	where Activo=1
END
GO

CREATE PROCEDURE [dbo].[sp_ComprobarIdUsuario]
@id int
AS
BEGIN
	SELECT COUNT(*) 
	FROM USUARIOS 
	WHERE Id = @id
END
GO


--PEDIDO

CREATE PROCEDURE [dbo].[sp_ListarPedidos]
AS BEGIN
	SELECT  P.IdPedido as 'IDPedido',
			P.IdUsuarios as 'IDUsuario', 
			U.Nombre+' '+U.Apellido as 'Usuario',
			P.Cantidad as 'CantidadArticulos', 
			P.Fecha as 'Fecha',
			P.Estado as 'Estado', 
			P.DireccionEntrega as 'Direccion', 
			P.Descuento as 'Descuento', 
			P.PrecioTotal as 'PrecioTotal',
			P.pagado as 'Pagado',
			P.enviado as 'Enviado'
	FROM PEDIDOS P 
	INNER JOIN USUARIOS U 
	ON P.IdUsuarios = U.Id
END
GO

CREATE PROCEDURE [dbo].[sp_ListarPedidosPorFiltro]
@filtro varchar(20)
AS BEGIN
	SELECT 
		IdPedido, 
		IdUsuarios,
		U.Nombre+' '+U.Apellido as 'Usuario', 
		Cantidad, 
		Fecha, 
		Estado, 
		DireccionEntrega, 
		Descuento, 
		PrecioTotal,
		pagado,
		enviado
	FROM PEDIDOS 
	INNER JOIN USUARIOS U 
	ON IdUsuarios = U.Id 
	WHERE Estado = @filtro
END
GO

CREATE PROCEDURE [dbo].[sp_ListarPedidosPorID]
@id int
AS BEGIN
	SELECT 
		IdPedido, 
		IdUsuarios,
		U.Nombre+' '+U.Apellido as 'Usuario', 
		Cantidad, 
		Fecha, 
		Estado, 
		DireccionEntrega, 
		Descuento, 
		PrecioTotal,
		pagado,
		enviado
	FROM PEDIDOS 
	INNER JOIN USUARIOS U 
	ON IdUsuarios = U.Id 
	WHERE IdPedido = @id
END
GO

CREATE PROCEDURE [dbo].[sp_ListarPedidosPorUsuario]
@id INT
AS BEGIN
	SELECT  P.IdPedido as 'IDPedido',
			P.IdUsuarios as 'IDUsuario', 
			U.Nombre+' '+U.Apellido as 'Usuario',
			P.Cantidad as 'CantidadArticulos', 
			P.Fecha as 'Fecha',
			P.Estado as 'Estado', 
			P.DireccionEntrega as 'Direccion', 
			P.Descuento as 'Descuento', 
			P.PrecioTotal as 'PrecioTotal',
			P.pagado as 'Pagado',
			P.enviado as 'Enviado'
	FROM PEDIDOS P 
	INNER JOIN USUARIOS U 
	ON P.IdUsuarios = U.Id
	WHERE IdUsuarios=@id
END
GO

CREATE PROCEDURE [dbo].[sp_CrearPedido] 
@IdUsuario int,
@Cantidad int,
@Estado varchar(20),
@DireccionEntrega varchar(20),
@Descuento decimal,
@PrecioTotal decimal,
@pagado bit,
@enviado bit

AS
BEGIN
	INSERT INTO PEDIDOS (
		IdUsuarios, 
		Cantidad, 
		Fecha, 
		Estado, 
		DireccionEntrega, 
		Descuento, 
		PrecioTotal,
		pagado,
		enviado
		)
	VALUES (
		@IdUsuario, 
		@Cantidad, 
		GETDATE(), 
		@Estado, 
		@DireccionEntrega, 
		@Descuento, 
		@PrecioTotal,
		@pagado,
		@enviado
		)

		SELECT @@IDENTITY AS 'Id'
END
GO

CREATE PROCEDURE [dbo].[sp_ModificarPedido] 
@IdPedido int,
@IdUsuario int,
@Cantidad int,
@Fecha date,
@Estado varchar(20),
@DireccionEntrega varchar(20),
@Descuento decimal,
@PrecioTotal decimal,
@pagado bit,
@enviado bit
AS
BEGIN
	UPDATE PEDIDOS 
	SET 
		IdUsuarios = @IdUsuario, 
		Cantidad = @Cantidad, 
		Fecha = @Fecha, 
		Estado = @Estado, 
		DireccionEntrega = @DireccionEntrega, 
		Descuento = @Descuento, 
		PrecioTotal = @PrecioTotal,
		pagado=@pagado,
		enviado=@enviado
	WHERE IdPedido = @IdPedido
END
GO

CREATE PROCEDURE [dbo].[sp_ModificarEstadoPedido] 
@id int,
@estado varchar(20)

AS
BEGIN
	IF(@estado='FINALIZADO')
		BEGIN
			UPDATE PEDIDOS 
			SET 
				Estado = @estado, 
				enviado=1
			WHERE IdPedido = @id
		END
	ELSE IF (@estado='CANCELADO')
		BEGIN
			UPDATE PEDIDOS 
			SET 
				Estado = @estado
			WHERE IdPedido = @id

			UPDATE A
			SET A.Stock=A.Stock+PA.Cantidad
			FROM ARTICULOS A
			INNER JOIN PEDIDO_ARTICULO PA
			ON A.Id=PA.IdArticulo
			WHERE PA.IdPedido=@id;
		END
END
GO

CREATE PROCEDURE [dbo].[sp_EliminarPedido]
@id int
AS
BEGIN
	DELETE FROM PEDIDOS 
	WHERE IdPedido = @id

	DELETE FROM PEDIDO_ARTICULO 
	WHERE IdPedido = @Id
END
GO

CREATE PROCEDURE [dbo].[sp_CantidadPedidos]
AS
BEGIN
	SELECT COUNT(*) AS 'Cantidad'
	FROM PEDIDOS 
	WHERE 
		ESTADO='FINALIZADO' 
		OR ESTADO='INICIADO'
END
GO

CREATE PROCEDURE [dbo].[sp_CantidadPedidosMesAnterior]
AS
BEGIN
	SELECT COUNT(*) AS 'Cantidad'
	FROM PEDIDOS 
	WHERE 
		ESTADO='FINALIZADO' 
		OR ESTADO='INICIADO'
		AND MONTH(Fecha)=MONTH(GETDATE())-1
END
GO

CREATE PROCEDURE [dbo].[sp_PedidosCompletados]
AS
BEGIN
	select count(*) AS 'Completados'
	from PEDIDOS 
	where Estado ='FINALIZADO'
END
GO

CREATE PROCEDURE [dbo].[sp_PedidosPendientes]
AS
BEGIN
	select count(*) AS 'Pendientes'
	from pedidos 
	where Estado='INICIADO'
END
GO

CREATE PROCEDURE [dbo].[sp_PedidosCancelados]
AS
BEGIN
	select count(*) AS 'Cancelados'
	from pedidos 
	where Estado='CANCELADO'
END
GO


--PEDIDO ARTICULO

CREATE PROCEDURE [dbo].[sp_ListarArticulosPedido]
AS
BEGIN
	SELECT 
		IdPedido, 
		IdArticulo, 
		Cantidad 
	FROM PEDIDO_ARTICULO
END
GO

CREATE PROCEDURE [dbo].[sp_ListarArticulosPedidoPorID]
@id int
AS
BEGIN
SELECT 
		PA.IdArticulo, 
		A.Nombre, 
		A.Descripcion, 
		M.Descripcion AS 'Marca', 
		C.Descripcion AS 'Categoria', 
		PA.Cantidad,
		A.Precio
	FROM PEDIDO_ARTICULO AS PA
	INNER JOIN ARTICULOS AS A 
	ON PA.IdArticulo=A.Id
	INNER JOIN MARCAS AS M 
	ON A.IdMarca = M.Id 
	INNER JOIN CATEGORIAS AS C 
	ON A.IdCategoria = C.Id
	WHERE PA.IdPedido = @id
END
GO

CREATE PROCEDURE [dbo].[sp_AgregarArticuloPedido]
@IdPedido int,
@IDArticulo int,
@Cantidad int
AS
BEGIN
	IF (SELECT Stock FROM ARTICULOS WHERE ID=@IDArticulo) >= @Cantidad
	BEGIN
		UPDATE ARTICULOS
		SET Stock=Stock-@Cantidad
		WHERE Id=@IDArticulo;

		INSERT INTO PEDIDO_ARTICULO 
		VALUES (
			@IdPedido, 
			@IdArticulo, 
			@Cantidad
		);
		UPDATE PEDIDOS
		SET Cantidad=(SELECT SUM(Cantidad) FROM PEDIDO_ARTICULO WHERE IdPedido=@IdPedido)
		WHERE IdPedido=@IdPedido;
	END
	ELSE
	BEGIN
		DELETE FROM PEDIDOS
		WHERE IdPedido = @IdPedido;

		SELECT 0;
	END
END
GO

--CREATE PROCEDURE [dbo].[sp_EditarArticuloPedido]
--@IdPedido int,
--@IDArticulo int,
--@Cantidad int
--AS
--BEGIN
--	UPDATE PEDIDO_ARTICULO 
--	SET 
--		IdArticulo = @IdArticulo, 
--		Cantidad = @Cantidad 
--	WHERE IdPedido = @IdPedido
--END
--GO

CREATE PROCEDURE [dbo].[sp_EliminarArticuloPedido]
@IdPedido int
AS
BEGIN
	DELETE FROM PEDIDO_ARTICULO 
	WHERE IdPedido = @IdPedido
END
GO

--REPORTES

CREATE PROCEDURE [dbo].[sp_RecaudacionPromedio]
AS
BEGIN
	SELECT ISNULL(AVG(PrecioTotal),0) AS 'Recaudacion'
	FROM PEDIDOS
	WHERE Estado!='CANCELADO'
END
GO

CREATE PROCEDURE [dbo].[sp_RecaudacionTotal]
AS
BEGIN
	SELECT ISNULL(SUM(PrecioTotal),0) AS 'Recaudacion'
	FROM PEDIDOS
	WHERE Estado!='CANCELADO'
END
GO

CREATE PROCEDURE [dbo].[sp_RecaudacionMes]
AS
BEGIN
	SELECT ISNULL(SUM(PrecioTotal),0) AS 'Recaudacion'
	FROM PEDIDOS
	WHERE Estado!='CANCELADO'
	AND MONTH(Fecha) = MONTH(GETDATE())
	AND YEAR(Fecha) = YEAR(GETDATE())
END
GO

CREATE PROCEDURE [dbo].[sp_RecaudacionMesAnterior]
AS
BEGIN
	SELECT ISNULL(SUM(PrecioTotal),0) AS 'Recaudacion'
	FROM PEDIDOS
	WHERE Estado!='CANCELADO'
	AND MONTH(Fecha) = MONTH(GETDATE())-1
	AND YEAR(Fecha) = YEAR(GETDATE())
END
GO

--DESCUENTO

CREATE PROCEDURE [dbo].[sp_ListarDescuentos]
AS
BEGIN
	SELECT 
		Id,
		Codigo,
		Porcentaje, 
		Estado 
	FROM DESCUENTOS
END
GO

CREATE PROCEDURE [dbo].[sp_AplicarDescuento]
@Codigo VARCHAR(30)
AS
BEGIN
	SELECT Porcentaje
	FROM DESCUENTOS
	WHERE Codigo=@Codigo
	AND Estado=1
END
GO

CREATE PROCEDURE [dbo].[sp_AgregarCuponDescuento]
@Codigo VARCHAR(30),
@Porcentaje INT
AS
BEGIN
	IF(SELECT COUNT(Codigo) FROM DESCUENTOS WHERE Codigo=@Codigo)=0 
	BEGIN
		INSERT INTO [dbo].[DESCUENTOS]
			   ([Codigo],
			   [Porcentaje],
			   [Estado])
		 VALUES
			   (@Codigo, 
			   @Porcentaje,
			   1)

		RETURN 1;
	END
	ELSE
	BEGIN
		RETURN 0;
	END
END
GO

CREATE PROCEDURE [dbo].[sp_CambiarEstadoDescuento]
@Id VARCHAR(30),
@Estado BIT
AS
BEGIN
	UPDATE DESCUENTOS
	SET Estado = @Estado
	WHERE Id=@Id
END
GO

CREATE PROCEDURE [dbo].[sp_EliminarDescuento]
@Id VARCHAR(30)
AS
BEGIN
	DELETE FROM DESCUENTOS
	WHERE Id=@Id
END
GO



------------FIN STORE PROCEDURES------------


------------INSERTS------------

INSERT [dbo].[ARTICULOS] ([Id], [Nombre], [Descripcion], [IdMarca], [IdCategoria], [ImagenUrl], [Precio], [Estado], [Stock]) VALUES 
(0, 'Aviadores Retro', 'Un clásico reinventado con monturas metálicas finas y lentes ligeramente degradadas, ideal para un look atemporal.', 1, 1, N'https://www.masvision.com.ar/cdn/shop/products/0RB3025__001_58_000A_8_1_870x435.jpg?v=1707401289', CAST(50000 AS Decimal(18, 0)), 1, 500)
,(1, 'Wayfarer Urbanos', 'El modelo Wayfarer con un toque moderno, en colores vibrantes y materiales resistentes, perfecto para el día a día en la ciudad.', 2, 1, N'https://www.masvision.com.ar/cdn/shop/files/b04dbd239a5328de3d36fe86b2ec5c5d5487283f_jpg_870x435.webp?v=1714076430', CAST(52000 AS Decimal(18, 0)), 1, 10000)
,(2, 'Cat Eye Felinos', 'Monturas en forma de ojo de gato, con detalles elegantes y lentes polarizadas, para un estilo sofisticado y femenino.', 3, 1, N'https://www.masvision.com.ar/cdn/shop/files/BOSTON-MBLK-REVO-RED---FRENTE--PRINCIPAL-WEB_869x427.jpg?v=1683208233', CAST(55000 AS Decimal(18, 0)), 1, 300)
,(3, 'Redondos Vintage', 'Lentes redondas de gran tamaño con monturas de acetato, evocando el espíritu hippie de los años 70.', 4, 1, N'https://www.masvision.com.ar/cdn/shop/files/UL---C3---PERFIL_871x428.jpg?v=1683204061', CAST(36000 AS Decimal(18, 0)), 1, 5)
,(4, 'Sport Shield', 'Gafas deportivas envolventes con lentes intercambiables y protección UV máxima, ideales para actividades al aire libre.', 1, 1, N'https://www.masvision.com.ar/cdn/shop/products/MARILYN23AGALERIA-WEB-SBLK-940_871x428.jpg?v=1674065465', CAST(46000 AS Decimal(18, 0)), 1, 50)
,(5, 'Oversized Glam', 'Lentes extra grandes y monturas llamativas, para un look atrevido y lleno de personalidad.', 2, 1, N'https://www.masvision.com.ar/cdn/shop/files/20500003217121_800x503.webp?v=1710344137', CAST(76000 AS Decimal(18, 0)), 1, 50)
,(6, 'Clásicos de Carey', 'Monturas de carey con un diseño atemporal, combinando elegancia y durabilidad.', 3, 1, N'https://www.masvision.com.ar/cdn/shop/files/original_png-0OO9290__929020__P21__shad__cfr_870x435.png?v=1702567122', CAST(58000 AS Decimal(18, 0)), 1, 150)
,(7, 'Rectangulares Minimalistas', 'Lentes rectangulares con monturas finas y discretas, perfectas para un estilo casual y versátil.', 4, 1, N'https://www.masvision.com.ar/cdn/shop/products/0KP4069__J248_000A_870x435.jpg?v=1681154198', CAST(31000 AS Decimal(18, 0)), 1, 350)
,(8, 'Butterfly Chic', 'Monturas en forma de mariposa con detalles metálicos, para un look femenino y sofisticado.', 4, 1, N'https://www.masvision.com.ar/cdn/shop/files/0KP4073__K644_060A_870x435.jpg?v=1707163369', CAST(91000 AS Decimal(18, 0)), 1, 250)
,(9, 'Metalicos Futuristicas', 'Monturas metálicas con formas geométricas y lentes espejados, para un estilo vanguardista y moderno.', 4, 1, N'https://www.masvision.com.ar/cdn/shop/products/AGALERIA-WEB-SBLK053-S10-POL_871x428.jpg?v=1680534128', CAST(72000 AS Decimal(18, 0)), 1, 50)
,(10, 'Clásicos de Biblioteca', 'Monturas redondas de acetato en tonos cálidos, perfectas para los amantes de la lectura tradicional.', 1, 1, N'https://www.masvision.com.ar/cdn/shop/products/MARILYN23AGALERIA-WEB-SBLK-940_871x428.jpg?v=1674065465', CAST(63000 AS Decimal(18, 0)), 1, 5000)
,(11, 'Urbanos y Flexibles', 'Lentes rectangulares de policarbonato ultraligero y flexibles, ideales para el día a día y actividades al aire libre.', 1, 2, 'https://www.masvision.com.ar/cdn/shop/products/PCDA_Hazel_col01_RX_Frente_870x574.jpg?v=1674487566', CAST(23000 AS Decimal(18, 0)), 1, 500)
,(12, 'Elegancia Discreta', 'Monturas de metal finas y delicadas, con lentes ligeramente tintadas para reducir el cansancio visual.', 2, 2, 'https://www.masvision.com.ar/cdn/shop/products/PCDA_Hazel_col01_RX_Frente_870x574.jpg?v=1674487566', CAST(36000 AS Decimal(18, 0)), 1, 500)
,(13, 'Vintage Chic', 'Monturas de carey con un diseño retro, combinando estilo y comodidad.', 2, 2, 'https://www.masvision.com.ar/cdn/shop/products/PCDA_Hazel_col01_RX_Frente_870x574.jpg?v=1674487566', CAST(28000 AS Decimal(18, 0)), 1, 500)
,(14, 'Lentes de Lupa', 'Monturas con lentes de aumento extra para tareas de precisión como manualidades o trabajos detallados.', 2, 2, 'https://www.masvision.com.ar/cdn/shop/products/PCDA_Hazel_col01_RX_Frente_870x574.jpg?v=1674487566', CAST(45000 AS Decimal(18, 0)), 1, 500)
,(15, 'Sport Reading', 'Gafas deportivas con lentes graduadas, perfectas para leer mientras haces ejercicio.', 3, 2, 'https://www.masvision.com.ar/cdn/shop/products/PCDA_Hazel_col01_RX_Frente_870x574.jpg?v=1674487566', CAST(31000 AS Decimal(18, 0)), 1, 500)
,(16, 'FreshDaily Comfort', 'Lentes de contacto diarias desechables diseñadas para brindar una máxima comodidad durante todo el día. Ideales para ojos sensibles y para quienes buscan una solución práctica y higiénica.', 4, 3, 'https://www.masvision.com.ar/cdn/shop/products/Air-Optix-Plus-Hydraglyde-multifocal-550x440_550x440.jpg?v=1701444968', CAST(75000 AS Decimal(18, 0)), 1, 50)
,(17, 'AquaLens', 'Lentes de contacto hidrogel de silicona de reemplazo quincenal con alto contenido de agua para mantener tus ojos hidratados y saludables. Diseñadas para usuarios que buscan una opción duradera y cómoda.', 4, 3, 'https://www.masvision.com.ar/cdn/shop/products/Air-Optix-Plus-Hydraglyde-multifocal-550x440_550x440.jpg?v=1701444968', CAST(93000 AS Decimal(18, 0)), 1, 10)
,(18, 'AstigmatismComfort', 'Lentes de contacto tóricas mensuales diseñadas para corregir el astigmatismo y brindar una visión clara y estable en todas las direcciones.', 1, 3, 'https://www.masvision.com.ar/cdn/shop/products/Air-Optix-Plus-Hydraglyde-multifocal-550x440_550x440.jpg?v=1701444968', CAST(63000 AS Decimal(18, 0)), 1, 1)
,(19, 'Storm Chaser', 'Goggles de alta montaña con tratamiento antiempañamiento y ventilación activa, diseñados para enfrentar las condiciones más extremas.', 3, 4, 'https://acdn.mitiendanube.com/stores/600/169/products/ziro-c2-vista-2_final1-7bc2b67baf1b98968d16527473812183-480-0.webp', CAST(102000 AS Decimal(18, 0)), 1, 1)
,(20, 'Freeride Force', 'Goggles robustos y duraderos, con correa ajustable y sistema de ventilación para un máximo confort.', 2, 4, 'https://acdn.mitiendanube.com/stores/600/169/products/ziro-c2-vista-2_final1-7bc2b67baf1b98968d16527473812183-480-0.webp', CAST(98000 AS Decimal(18, 0)), 1, 1)


INSERT [dbo].[IMAGENES] ([IdArticulo], [ImagenUrl]) VALUES 
(1, 'https://www.masvision.com.ar/cdn/shop/products/0RB3025__001_58_000A_8_1_870x435.jpg?v=1707401289')
,(1, 'https://www.masvision.com.ar/cdn/shop/products/Ray-Ban-RB3025-001-58_1_640x333.jpg?v=1707401289')
,(2, 'https://www.masvision.com.ar/cdn/shop/files/b04dbd239a5328de3d36fe86b2ec5c5d5487283f_jpg_870x435.webp?v=1714076430')
,(2, 'https://www.masvision.com.ar/cdn/shop/files/4bc2d49ee73dcb290bb0ef0823506c12b060b6e5_jpg_870x435.webp?v=1714076430')
,(3, 'https://www.masvision.com.ar/cdn/shop/files/BOSTON-MBLK-REVO-RED---FRENTE--PRINCIPAL-WEB_869x427.jpg?v=1683208233')
,(4, 'https://www.masvision.com.ar/cdn/shop/files/UL---C3---PERFIL_871x428.jpg?v=1683204061')
,(5, 'https://www.masvision.com.ar/cdn/shop/files/20500003217121_800x503.webp?v=1710344137')
,(5, 'https://www.masvision.com.ar/cdn/shop/files/205000032171212_800x503.webp?v=1710344137')
,(5, 'https://www.masvision.com.ar/cdn/shop/files/205000032171213_800x503.webp?v=1710344137')
,(6, 'https://www.masvision.com.ar/cdn/shop/files/original_png-0OO9290__929020__P21__shad__cfr_870x435.png?v=1702567122')
,(6, 'https://www.masvision.com.ar/cdn/shop/files/original_png-0OO9290__929020__P21__shad__qt_870x435.png?v=1702567122')
,(6, 'https://www.masvision.com.ar/cdn/shop/files/original_png-0OO9290__929020__P21__shad__lt_870x435.png?v=1702567122')
,(7, 'https://www.masvision.com.ar/cdn/shop/products/0KP4069__J248_000A_870x435.jpg?v=1681154198')
,(7, 'https://www.masvision.com.ar/cdn/shop/products/0KP4069__J248_030A_870x435.jpg?v=1681154198')
,(8, 'https://www.masvision.com.ar/cdn/shop/files/0KP4073__K644_000A_870x435.jpg?v=1707163369')
,(8, 'https://www.masvision.com.ar/cdn/shop/files/0KP4073__K644_060A_870x435.jpg?v=1707163369')
,(9, 'https://www.masvision.com.ar/cdn/shop/products/AGALERIA-WEB-SBLK053-S10-POL_871x428.jpg?v=1680534128')
,(9, 'https://www.masvision.com.ar/cdn/shop/files/GALERIA-WEB-SBLK053-S10-POL_871x428.jpg?v=1710870861')
,(10, 'https://www.masvision.com.ar/cdn/shop/products/AGALERIA-WEB-SBLK053-S10-POL_871x428.jpg?v=1680534128')
,(11, 'https://www.masvision.com.ar/cdn/shop/products/PCDA_Hazel_col01_RX_Frente_870x574.jpg?v=1674487566')
,(12, 'https://www.masvision.com.ar/cdn/shop/products/PCDA_Hazel_col01_RX_Frente_870x574.jpg?v=1674487566')
,(13, 'https://www.masvision.com.ar/cdn/shop/products/PCDA_Hazel_col01_RX_Frente_870x574.jpg?v=1674487566')
,(14, 'https://www.masvision.com.ar/cdn/shop/products/PCDA_Hazel_col01_RX_Frente_870x574.jpg?v=1674487566')
,(15, 'https://www.masvision.com.ar/cdn/shop/products/PCDA_Hazel_col01_RX_Frente_870x574.jpg?v=1674487566')
,(16, 'https://www.masvision.com.ar/cdn/shop/products/Air-Optix-Plus-Hydraglyde-multifocal-550x440_550x440.jpg?v=1701444968')
,(17, 'https://www.masvision.com.ar/cdn/shop/products/Air-Optix-Plus-Hydraglyde-multifocal-550x440_550x440.jpg?v=1701444968')
,(18, 'https://www.masvision.com.ar/cdn/shop/products/Air-Optix-Plus-Hydraglyde-multifocal-550x440_550x440.jpg?v=1701444968')
,(19, 'https://acdn.mitiendanube.com/stores/600/169/products/ziro-c2-vista-2_final1-7bc2b67baf1b98968d16527473812183-480-0.webp')
,(20, 'https://acdn.mitiendanube.com/stores/600/169/products/ziro-c2-vista-2_final1-7bc2b67baf1b98968d16527473812183-480-0.webp')


INSERT [dbo].[CATEGORIAS] ([Descripcion], [ImagenUrl]) VALUES 
('SUN', 'https://www.masvision.com.ar/cdn/shop/files/VULKGENIEMBLKGREENEMERALD_800x_5a25ed4d-aacd-488e-b6b0-c432016884b6_800x503.jpg?v=1699153586')
,('OPTICS', 'https://www.masvision.com.ar/cdn/shop/products/PCDA_Hazel_col01_RX_Frente_870x574.jpg?v=1674487566')
,('CONTACTS', 'https://www.masvision.com.ar/cdn/shop/products/Air-Optix-Plus-Hydraglyde-multifocal-550x440_550x440.jpg?v=1701444968')
,('GOGGLES', 'https://acdn.mitiendanube.com/stores/600/169/products/ziro-c2-vista-2_final1-7bc2b67baf1b98968d16527473812183-480-0.webp')


INSERT [dbo].[MARCAS] ([Descripcion], [ImagenUrl]) VALUES 
('Ray-Ban', 'https://www.masvision.com.ar/cdn/shop/files/marca_Ray-Ban_small.png?v=1697029603')
,('Vulk', 'https://www.masvision.com.ar/cdn/shop/files/marca_Vulk_small.png?v=1697029603')
,('Vogue', 'https://www.masvision.com.ar/cdn/shop/files/marca_Vogue_small.png?v=1697029603')
,('Rusty', 'https://www.masvision.com.ar/cdn/shop/files/marca_Rusty_small.png?v=1697029603')


INSERT [dbo].[USUARIOS] ([Nombre], [Apellido], [DNI], [Mail], [Clave], [Direccion], [Nivel], [ImagenUrl], [Activo]) VALUES 
('Pepito', 'Admin', 40215203, 'pepito.admin@gmail.com', 'password2', 'donde vive pepito 456', 'A', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwD5S3sw60LDdyNbWwv0Od9IBWQ1vYaAMLEmwizhyb-8HkWJsB5tU2F7ljmaRyfzArkq4&usqp=CAU', 1)
,('Pepe', 'Pepa', 26302125, 'pepe.pepa@gmail.com', 'password1', 'donde vive pepe 123', 'C', 'https://dthezntil550i.cloudfront.net/f4/latest/f41908291942413280009640715/1280_960/1b2d9510-d66d-43a2-971a-cfcbb600e7fe.png', 1)
,('Otro Pepe', 'No Admin', 39654852, 'otro.pepe@gmail.com', 'password2', 'donde vive pepito 456', 'C', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQwD5S3sw60LDdyNbWwv0Od9IBWQ1vYaAMLEmwizhyb-8HkWJsB5tU2F7ljmaRyfzArkq4&usqp=CAU', 0)

------------FIN INSERTS------------