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
            
        }
    }
}