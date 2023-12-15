using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Data;
using Dominio;

namespace Negocio
{
    public class NegocioUsuario
    {
        DatabaseAccess datos;
        List<Usuario> usuarios;
        Usuario usuario;

        
        public List<Usuario> ListarUsuarios()
        {
            datos = new DatabaseAccess();
            usuarios = new List<Usuario>();

            try
            {
                datos.SetProcedure("sp_ListarUsuarios");
                datos.ReadData();

                while (datos.Reader.Read())
                {
                    usuario = new Usuario();
                    usuario.Id = (int)datos.Reader["Id"];
                    usuario.Nombre = datos.Reader["Nombre"].ToString();
                    usuario.Apellido = datos.Reader["Apellido"].ToString();
                    usuario.Dni = (int)datos.Reader["DNI"];
                    usuario.Mail = datos.Reader["Mail"].ToString();
                    usuario.Clave = datos.Reader["Clave"].ToString();
                    usuario.Direccion = datos.Reader["Direccion"].ToString();
                    usuario.Nivel = datos.Reader["Nivel"].ToString();
                    usuario.UrlImgUsuario = datos.Reader["ImagenUrl"].ToString();
                    usuario.Activo = (bool)datos.Reader["Activo"];
                    usuarios.Add(usuario);
                }
                return usuarios;
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

        public Usuario ListarUsuarios(int id)
        {
            datos = new DatabaseAccess();

            try
            {
                datos.SetProcedure("sp_ListarUsuariosPorID");
                datos.SetParameter("@Id", id);
                datos.ReadData();

                while (datos.Reader.Read())
                {
                    usuario = new Usuario();
                    usuario.Id = (int)datos.Reader["Id"];
                    usuario.Nombre = datos.Reader["Nombre"].ToString();
                    usuario.Apellido = datos.Reader["Apellido"].ToString();
                    usuario.Dni = (int)datos.Reader["DNI"];
                    usuario.Mail = datos.Reader["Mail"].ToString();
                    usuario.Clave = datos.Reader["Clave"].ToString();
                    usuario.Direccion = datos.Reader["Direccion"].ToString();
                    usuario.Nivel = datos.Reader["Nivel"].ToString();
                    usuario.UrlImgUsuario = datos.Reader["ImagenUrl"].ToString();
                    usuario.Activo = (bool)datos.Reader["Activo"];
                }
                return usuario;
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

        public Usuario ListarUsuarios(string mail)
        {
            datos = new DatabaseAccess();

            try
            {
                datos.SetProcedure("sp_ListarUsuariosLogin");
                datos.SetParameter("@Mail", mail);
                datos.ReadData();

                while (datos.Reader.Read())
                {
                    usuario = new Usuario();
                    usuario.Id = (int)datos.Reader["Id"];
                    usuario.Nombre = datos.Reader["Nombre"].ToString();
                    usuario.Apellido = datos.Reader["Apellido"].ToString();
                    usuario.Dni = (int)datos.Reader["DNI"];
                    usuario.Mail = datos.Reader["Mail"].ToString();
                    usuario.Clave = datos.Reader["Clave"].ToString();
                    usuario.Direccion = datos.Reader["Direccion"].ToString();
                    usuario.Nivel = datos.Reader["Nivel"].ToString();
                    usuario.UrlImgUsuario = datos.Reader["ImagenUrl"].ToString();
                    usuario.Activo = (bool)datos.Reader["Activo"];
                }
                return usuario;
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

        public void CrearUsuario(Usuario usuario)
        {
            datos = new DatabaseAccess();
            try
            {
                datos.SetProcedure("sp_CrearUsuario");
                datos.SetParameter("@Nombre", usuario.Nombre);
                datos.SetParameter("@Apellido", usuario.Apellido);
                datos.SetParameter("@DNI", usuario.Dni);
                datos.SetParameter("@Mail", usuario.Mail);
                datos.SetParameter("@Clave", usuario.Clave);
                datos.SetParameter("@Direccion", usuario.Direccion);
                datos.SetParameter("@Nivel", usuario.Nivel);
                datos.SetParameter("@UrlImagen", usuario.UrlImgUsuario);
                datos.SetParameter("@Activo", usuario.Activo);

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
        
        public void ModificarUsuario(Usuario usuario)
        {
            datos = new DatabaseAccess();
            try
            {
                datos.SetProcedure("sp_ModificarUsuario");
                datos.SetParameter("@Id", usuario.Id);
                datos.SetParameter("@Nombre", usuario.Nombre);
                datos.SetParameter("@Apellido", usuario.Apellido);
                datos.SetParameter("@DNI", usuario.Dni);
                datos.SetParameter("@Mail", usuario.Mail);
                datos.SetParameter("@Clave", usuario.Clave);
                datos.SetParameter("@Direccion", usuario.Direccion);
                datos.SetParameter("@Nivel", usuario.Nivel);
                datos.SetParameter("@UrlImagen", usuario.UrlImgUsuario);
                datos.SetParameter("@Activo", usuario.Activo);

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

        
        public void EliminarUsuario(int id)
        {
            datos = new DatabaseAccess();
            try
            {
                datos.SetProcedure("sp_EliminarUsuario");
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
        
        public void AltaUsuario(int id)
        {
            datos = new DatabaseAccess();
            try
            {
                datos.SetProcedure("sp_AltaUsuario");
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
        
        public void BajaUsuario(int id)
        {
            datos = new DatabaseAccess();
            try
            {
                datos.SetProcedure("sp_BajaUsuario");
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
        
        public int ComprobarId(int id)
        {
            datos = new DatabaseAccess();
            try
            {
                datos.SetProcedure("sp_ComprobarIdUsuario");
                datos.SetParameter("@id", id);

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

        public bool IsLogged(Usuario usuario)
        {
            return usuario != null;
        }

        public bool IsAdmin(Usuario usuario)
        {
            if (usuario == null)
                return false;
            else
            {
                if (usuario.Nivel.ToUpperInvariant() == "A")
                    return true;
                else
                    return false;
            }
        }

    }
}
