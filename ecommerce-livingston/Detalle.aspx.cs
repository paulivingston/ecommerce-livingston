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
    public partial class Detalle : System.Web.UI.Page
    {
        protected List<string> listImg;
        protected List<Articulo> listArt = null;
        protected Articulo art = null;
        protected int id = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                List<Articulo> articulos = null;
                if (Session["listaPrincipal"] != null)
                    articulos = (List<Articulo>)Session["listaPrincipal"];

                if (Request.Params["idProd"] != null && articulos != null)
                {
                    NegocioArticulo listaArticulos = new NegocioArticulo();
                    id = int.Parse(Request.Params["idProd"]);
                    listImg = listaArticulos.ListarImgArt(id);
                    listArt = new List<Articulo>();

                    art = articulos.Find(itm => itm.Id == id);
                    listArt.Add(art);

                    rptDetalleArt.DataSource = listArt;
                    rptDetalleArt.DataBind();
                }
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx");
            }

        }
    }
}