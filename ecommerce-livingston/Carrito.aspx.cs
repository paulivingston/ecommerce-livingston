using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio;
using Negocio;

namespace ecommerce_livingston
{
    public partial class Carrito : System.Web.UI.Page
    {
        NegocioItemCarrito items;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {

                if (!IsPostBack)
                {
                    items = Session["listaCarrito"] as NegocioItemCarrito;
                    var listaItems = items?.Items;

                    CargarPantallaCarrito(listaItems);
                }
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        public void CargarPantallaCarrito(List<ItemCarrito> lista)
        {
            if (lista != null && lista.Count > 0)
            {
                divResumen.Visible = false;
                divCarritoVacio.Visible = false;
                divCarrito.Visible = true;
            }
            else
            {
                divResumen.Visible = false;
                divCarrito.Visible = false;
                divCarritoVacio.Visible = true;
            }
        }

    }
}
