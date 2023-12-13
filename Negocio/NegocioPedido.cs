using Data;
using Dominio;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;

namespace Negocio
{
    public class NegocioPedido
    {
        DatabaseAccess datos = null;
        List<Pedido> pedidos = null;

        public List<ItemCarrito> listaCarrito { get; set; }
        Pedido pedido;

        public List<ItemCarrito> ArticulosPedido { get; set; }

        public List<Pedido> ListarPedidos()
        {
            datos = new DatabaseAccess();
            pedidos = new List<Pedido>();

            try
            {
                datos.SetProcedure("sp_ListarPedidos");
                datos.ReadData();

                while (datos.Reader.Read())
                {
                    pedido = new Pedido();
                    pedido.IdPedido = (int)datos.Reader["IDPedido"];
                    pedido.IdUsuario = (int)datos.Reader["IDUsuario"];
                    pedido.Cantidad = (int)datos.Reader["CantidadArticulos"];
                    pedido.Usuario = datos.Reader["Usuario"].ToString();
                    pedido.fecha = (DateTime)datos.Reader["Fecha"];
                    pedido.Estado = datos.Reader["Estado"].ToString();
                    pedido.DireccionEntrega = datos.Reader["Direccion"].ToString();
                    pedido.Descuento = (decimal)datos.Reader["Descuento"];
                    pedido.precioTotal = (decimal)datos.Reader["PrecioTotal"];

                    pedidos.Add(pedido);
                }
                return pedidos;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.CloseConnection();
            }
        }

        public Pedido ListarPedidos(int id)
        {
            datos = new DatabaseAccess();

            try
            {
                datos.SetProcedure("sp_ListarPedidosPorID");
                datos.SetParameter("@id", id);

                datos.ReadData();

                while (datos.Reader.Read())
                {
                    pedido = new Pedido();
                    pedido.IdPedido = (int)datos.Reader["IdPedido"];
                    pedido.IdUsuario = (int)datos.Reader["IdUsuarios"];
                    pedido.Usuario = datos.Reader["Usuario"].ToString();
                    pedido.Cantidad = (int)datos.Reader["Cantidad"];
                    pedido.fecha = (DateTime)datos.Reader["Fecha"];
                    pedido.Estado = datos.Reader["Estado"].ToString();
                    pedido.DireccionEntrega = datos.Reader["DireccionEntrega"].ToString();
                    pedido.Descuento = (decimal)datos.Reader["Descuento"];
                    pedido.precioTotal = (decimal)datos.Reader["PrecioTotal"];
                }
                return pedido;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.CloseConnection();
            }
        }

        public List<Pedido> ListarPedidos(string filtro)
        {
            datos = new DatabaseAccess();

            try
            {
                datos.SetProcedure("sp_ListarPedidosPorFiltro");
                datos.SetParameter("@filtro", filtro);

                datos.ReadData();

                pedidos = new List<Pedido>();
                while (datos.Reader.Read())
                {
                    pedido = new Pedido();
                    pedido.IdPedido = (int)datos.Reader["IdPedido"];
                    pedido.IdUsuario = (int)datos.Reader["IdUsuarios"];
                    pedido.Usuario = datos.Reader["Usuario"].ToString();
                    pedido.Cantidad = (int)datos.Reader["Cantidad"];
                    pedido.fecha = (DateTime)datos.Reader["Fecha"];
                    pedido.Estado = datos.Reader["Estado"].ToString();
                    pedido.DireccionEntrega = datos.Reader["DireccionEntrega"].ToString();
                    pedido.Descuento = (decimal)datos.Reader["Descuento"];
                    pedido.precioTotal = (decimal)datos.Reader["PrecioTotal"];
                    pedidos.Add(pedido);
                }
                return pedidos;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.CloseConnection();
            }
        }

        public int CrearPedido(Pedido pedido, string tipo)
        {
            datos = new DatabaseAccess();

            try
            {
                int totalItems = (pedido.totalItems == null) ? pedido.Cantidad : pedido.totalItems.Count;

                datos.SetProcedure("sp_AgregarPedido");
                datos.SetParameter("@IdUsuario", pedido.IdUsuario);
                datos.SetParameter("@Cantidad", totalItems);
                datos.SetParameter("@Estado", pedido.Estado);
                datos.SetParameter("@DireccionEntrega", pedido.DireccionEntrega);
                datos.SetParameter("@Descuento", pedido.Descuento);
                datos.SetParameter("@PrecioTotal", pedido.precioTotal);

                datos.ExecuteNonQuery();

                return 1;
            }
            catch
            {
                return 0;
            }
            finally
            {
                datos.CloseConnection();
            }
        }

        public void ModificarPedido(Pedido pedido)
        {
            datos = new DatabaseAccess();

            try
            {
                datos.SetProcedure("sp_ModificarPedido");
                datos.SetParameter("@IdPedido", pedido.IdPedido);
                datos.SetParameter("@IdUsuario", pedido.IdUsuario);
                datos.SetParameter("@Cantidad", pedido.Cantidad);
                datos.SetParameter("@Fecha", pedido.fecha); 
                datos.SetParameter("@Estado", pedido.Estado);
                datos.SetParameter("@DireccionEntrega", pedido.DireccionEntrega);
                datos.SetParameter("@Descuento", pedido.Descuento);
                datos.SetParameter("@PrecioTotal", pedido.precioTotal);

                datos.ExecuteNonQuery();
            }
            catch (SqlException ex)
            {
                throw ex;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.CloseConnection();
            }
        }

        public void EliminarPedido(int id)
        {
            datos = new DatabaseAccess();
            try
            {
                datos.SetProcedure("sp_EliminarPedido");
                datos.SetParameter("@id", id);

                datos.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.CloseConnection();
            }
        }

        public void ModificarEstado(int id, string estado)
        {
            datos = new DatabaseAccess();

            try
            {
                datos.SetProcedure("sp_EliminarPedido");
                datos.SetParameter("@estado", estado);
                datos.SetParameter("@id", id);

                datos.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.CloseConnection();
            }
        }

        public Pedido CargarPedido(List<ItemCarrito> lista, Usuario usuario, decimal total, string dirEntrega = null, decimal descuento = 0.00M)
        {
            try
            {
                pedido = new Pedido();

                pedido.IdUsuario = usuario.Id;
                pedido.Usuario = usuario.Nombre + usuario.Apellido;
                pedido.fecha = DateTime.Now;
                pedido.Estado = "INICIADO";
                pedido.DireccionEntrega = dirEntrega ?? usuario.Direccion;
                pedido.totalItems = new List<ItemCarrito>(lista);
                pedido.Cantidad = lista.Sum(itm => itm.Cantidad); // articulos distintos, no unidades totales

                //Aca podriamos calcular nuevamente el total a partir de info en lista y llamar un metodo para calcular el total final si usamos descuento
                pedido.Descuento = descuento > 0.00M ? descuento : 0.00M;
                pedido.precioTotal = total;

                return pedido;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public void CargarIdPedido(List<ItemCarrito> items, int idPedido)
        {
            try
            {
                items.ForEach(itm => itm.IdPedido = idPedido);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public List<ItemCarrito> ListarArticulosPedido()
        {
            datos = new DatabaseAccess();
            ArticulosPedido = new List<ItemCarrito>();
            ItemCarrito item;

            try
            {
                datos.SetProcedure("sp_ListarArticulosPedido");
                datos.ReadData();
                
                while (datos.Reader.Read())
                {
                    item = new ItemCarrito();
                    item.Id = (int)datos.Reader["IdArticulo"];
                    item.IdPedido = (int)datos.Reader["IdPedido"];
                    item.Cantidad = (int)datos.Reader["Cantidad"];
                    ArticulosPedido.Add(item);
                }
                return ArticulosPedido;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.CloseConnection();
            }
        }

        
        public List<ItemCarrito> ListarArticulosPedido(int id)
        {
            datos = new DatabaseAccess();
            ArticulosPedido = new List<ItemCarrito>();
            ItemCarrito item;

            try
            {
                datos.SetProcedure("sp_ListarArticulosPedidoPorID");
                datos.SetParameter("@id", id);
                datos.ReadData();

                while (datos.Reader.Read())
                {
                    item = new ItemCarrito();
                    item.Id = (int)datos.Reader["IdArticulo"];
                    item.IdPedido = (int)datos.Reader["IdPedido"];
                    item.Cantidad = (int)datos.Reader["Cantidad"];
                    ArticulosPedido.Add(item);
                }
                return ArticulosPedido;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.CloseConnection();
            }
        }

        public int AgregarArticuloPedido(ItemCarrito item)
        {
            datos = new DatabaseAccess();
            try
            {
                datos.SetProcedure("sp_AgregarArticuloPedido");
                datos.SetParameter("@IdPedido", item.IdPedido);
                datos.SetParameter("@IdArticulo", item.Id);
                datos.SetParameter("@Cantidad", item.Cantidad);

                datos.ExecuteNonQuery();

                return 1;
            }
            catch
            {
                return 0;
            }
            finally
            {
                datos.CloseConnection();
            }
        }

        public int AgregarArticuloPedido(List<ItemCarrito> items)
        {
            datos = new DatabaseAccess();

            try
            {
                datos.SetProcedure("sp_AgregarArticuloPedido");
                int cont = 0;

                foreach (ItemCarrito item in items)
                {
                    datos.SetParameter("@IdPedido", item.IdPedido);
                    datos.SetParameter("@IdArticulo", item.Id);
                    datos.SetParameter("@Cantidad", item.Cantidad);
                    datos.ExecuteNonQuery();
                    cont += 1;
                    datos.DisposeParameters();
                }
                return cont;
            }
            catch 
            {
                return 0;
            }
            finally
            {
                datos.CloseConnection();
            }
        }

        public int EditarArticuloPedido(ItemCarrito item)
        {
            datos = new DatabaseAccess();
            try
            {
                datos.SetProcedure("sp_EditarArticuloPedido");
                datos.SetParameter("@IdPedido", item.IdPedido);
                datos.SetParameter("@IdArticulo", item.Id);
                datos.SetParameter("@Cantidad", item.Cantidad);

                datos.ExecuteNonQuery();

                return 1;
            }
            catch
            {
                return 0;
            }
            finally
            {
                datos.CloseConnection();
            }
        }

        public int EliminarArticuloPedido(int idArt, int idPed)
        {
            datos = new DatabaseAccess();

            try
            {
                datos.SetProcedure("sp_EliminarArticuloPedido");
                datos.SetParameter("@IdPedido", idPed);
                datos.SetParameter("@IdArticulo", idArt);

                datos.ExecuteNonQuery();

                return 1;
            }
            catch
            {
                return 0;
            }
            finally
            {
                datos.CloseConnection();
            }
        }

    }
}

