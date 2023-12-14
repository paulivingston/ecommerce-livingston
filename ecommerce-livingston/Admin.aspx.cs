using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio;
using Mensajes;
using Negocio;

namespace ecommerce_livingston
{
    public partial class Admin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        public void btnVerDetallePedido_Click(object sender, EventArgs e)
        {

        }

        protected void btnFiltrarEstadoUsuarios_Click(object sender, EventArgs e)
        {
        }
        protected void btnFiltrarUsuarios_Click(object sender, EventArgs e)
        {

        }

        protected void btnLimpiarFiltrosUsuarios_Click(object sender, EventArgs e)
        {
        }
    }
}