using Dominio;
using Negocio;
using Mensajes;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace ecommerce_livingston
{
    public partial class SiteMaster : MasterPage
    {
        private Usuario user = null;
        public int itemsCarrito { get; set; }
        public bool Flag { get; set; }
        public Usuario usuario { get { return user; } }
        public string preUrl { get { return Request.UrlReferrer.ToString(); } }

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (Session["countCarrito"] == null)
                    Session.Add("countCarrito", 0);

                if (Convert.ToInt32(Session["countCarrito"]) > 0)
                {
                    lblTotalArticulos.Text = Session["countCarrito"].ToString();
                    Flag = true;
                }
                else
                {
                    Flag = false;
                }

                if (Session["usuarioActual"] != null)
                {
                    btnLoggin.Visible = false;
                    btnSignOut.Visible = true;

                    var user = (Usuario)Session["usuarioActual"];
                    if (user.Nivel.ToUpperInvariant() == "A") 
                    {
                        btnIrAdmin.Visible = true;
                        btnIrMisPedidos.Visible = false;
                    }
                    else
                    {
                        btnIrAdmin.Visible = false;
                        btnIrMisPedidos.Visible = true;
                    }
                }
                else
                {
                    btnLoggin.Visible = true;
                    btnSignOut.Visible = false;
                }

                mensajes();

            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        private void mensajes()
        {
            try
            {
                if (Session["mensajeEnMaster"] != null)
                {
                    Mensajes.Mensajes.MensajePopUp(this, Session["mensajeEnMaster"].ToString());
                    Session.Remove("mensajeEnMaster");
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void btnFiltroRapido_Click(object sender, EventArgs e)
        {
            try
            {
                string str = tbFiltroRapido.Text;
                if (!string.IsNullOrWhiteSpace(str))
                    Response.Redirect("Productos.aspx?text=" + str, false);
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnCerrarModal_Click(object sender, EventArgs e)
        {
            lblUsuarioNoExiste.Visible = false;
        }

        protected void btnIngresar_Click(object sender, EventArgs e)
        {
            try
            {
                string pass = txtClaveLogin.Text;
                string mail = txtMailLogin.Text;
                string paginaActual = Page.Request.Url.ToString();

                if (!string.IsNullOrWhiteSpace(pass) && !string.IsNullOrWhiteSpace(mail))
                {
                    NegocioUsuario negocioUsuario = new NegocioUsuario();
                    user = negocioUsuario.ListarUsuarios(mail);
                    if (user != null && user.Clave==pass)
                    {
                        Console.WriteLine(user.Activo);
                        if (user.Activo == true)
                        {
                            Session.Add("usuarioActual", user);
                            Session.Add("mensajeEnMaster", $"Bienvenido {user.Nombre}!");

                            if (user.Nivel.ToUpperInvariant() == "A")
                            {
                                Response.Redirect("Admin.aspx", false);
                                return;
                            }

                            Response.Redirect(paginaActual, false);
                            btnLoggin.Visible = false;
                            btnSignOut.Visible = true;
                        }
                        else
                        {
                            lblUsuarioNoExiste.Visible = true;
                            lblRespuestaLoggin.Text = "Usuario inactivo";
                        }
                    }
                    else if(user != null)
                    {
                        lblUsuarioNoExiste.Visible = true;
                        lblRespuestaLoggin.Text = "Contraseña incorrecta";
                    }
                    else
                    {
                        lblUsuarioNoExiste.Visible = true;
                        lblRespuestaLoggin.Text = "Usuario No Encontrado";
                    }
                }
                else
                {
                    lblUsuarioNoExiste.Visible = true;
                    lblRespuestaLoggin.Text = "Por favor complete todos los campos";
                }
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnSignOut_Click(object sender, EventArgs e)
        {
            try
            {
                Session.Remove("usuarioActual");
                Session.Remove("listaCarrito");
                Session.Remove("countCarrito");
                Response.Redirect("Default.aspx", false);
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnRegistro_Click(object sender, EventArgs e)
        {
            Response.Redirect("Registro.aspx", false);
        }
    }
}