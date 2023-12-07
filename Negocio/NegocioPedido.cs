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

        public List<Pedido> ListarPedidos(int id)
        {
            datos = new DatabaseAccess();

            try
            {
                datos.SetProcedure("sp_ListarPedidosPorID");
                datos.SetParameter("@id", id);

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

        public void CrearPedido(Pedido pedido, string tipo)
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

                datos.ReadData();

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
    }
}

