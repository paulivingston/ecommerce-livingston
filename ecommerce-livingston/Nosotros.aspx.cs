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
    public partial class Nosotros : System.Web.UI.Page
    {
        protected List<string> ImgNos;
        protected List<Articulo> ArtNos = null;
        protected Articulo art = null;
        protected int idMatch = 0;

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
                    idMatch = int.Parse(Request.Params["idProd"]);
                    ImgNos = listaArticulos.ListarImgArt(idMatch);
                    ArtNos = new List<Articulo>();

                    art = articulos.Find(itm => itm.Id == idMatch);
                    ArtNos.Add(art);

                    rptDetalleArt.DataSource = ArtNos;
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