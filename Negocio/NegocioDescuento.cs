using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dominio;
using Data;

namespace Negocio
{
    public class NegocioDescuento
    {
        DatabaseAccess datos = null;
        List<Descuento> descuentos = null;

        public List<Descuento> ListarDescuentos()
        {
            datos = new DatabaseAccess();
            try
            {
                datos = new DatabaseAccess();
                descuentos = new List<Descuento>();

                datos.SetProcedure("sp_ListarDescuentos");
                datos.ReadData();

                while (datos.Reader.Read())
                {
                    descuentos.Add(new Descuento((int)datos.Reader["Id"], datos.Reader["Codigo"].ToString(), (int)datos.Reader["Porcentaje"], (bool)datos.Reader["Estado"]));
                }
                return descuentos;
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

        public int AplicarDescuento(string cod)
        {
            datos = new DatabaseAccess();
            try
            {
                datos.SetProcedure("sp_AplicarDescuento");
                datos.SetParameter("@Codigo", cod);

                return datos.ExecuteScalar();
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

        public int AgregarDescuento(Descuento descuento)
        {
            datos = new DatabaseAccess();
            try
            {
                datos.SetProcedure("sp_AgregarCuponDescuento");
                datos.SetParameter("@Codigo", descuento.Codigo);
                datos.SetParameter("@Porcentaje", descuento.Porcentaje);

                return datos.ExecuteScalar();
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

        public void CambiarEstadoDescuento(int id, bool estado)
        {
            datos = new DatabaseAccess();
            try
            {
                datos.SetProcedure("sp_CambiarEstadoDescuento");
                datos.SetParameter("@Id", id);
                datos.SetParameter("@Estado", estado);

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

        public void EliminarDescuento(int id)
        {
            datos = new DatabaseAccess();
            try
            {
                datos.SetProcedure("sp_EliminarDescuento");
                datos.SetParameter("@Id", id);

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
