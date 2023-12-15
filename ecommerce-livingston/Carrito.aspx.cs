using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio;
using Negocio;
using Mensajes;

namespace ecommerce_livingston
{
    public partial class Carrito : System.Web.UI.Page
    {
        NegocioUsuario NegocioUsuario;
        Usuario usuario;
        NegocioItemCarrito items;
        NegocioPedido NegocioPedido;
        public bool logged = false;
        protected decimal totalAcumulado = 0;
        public decimal TotalAcumulado
        {
            get { return totalAcumulado; }
            set { totalAcumulado = value; }
        }
        public bool Flag { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    items = Session["listaCarrito"] as NegocioItemCarrito;
                    var listaItems = items?.Items;

                    if (Request.QueryString["text"] == "ok")
                    {
                        NegocioUsuario = new NegocioUsuario();
                        usuario = (Usuario)Session["usuarioActual"];
                        CargarPantallaFinalizarCompra(NegocioUsuario.IsLogged(usuario), listaItems);
                    }
                    else
                    {
                        CargarPantallaCarrito(listaItems);
                    }
                }

                if (Session["totalCarrito"] != null)
                {
                    totalAcumulado = (decimal)Session["totalCarrito"];
                }
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        public decimal TotalCarrito(List<ItemCarrito> lista)
        {
            decimal total = 0.00M;
            if (lista == null)
                return 0.00M;

            if (Session["totalCarrito"] == null)
                Session.Add("totalCarrito", 0.00M);

            foreach (ItemCarrito item in lista)
            {
                if (total >= 0)
                    total += (item.Precio * item.Cantidad);
            }

            Session["totalCarrito"] = total;
            return total;
        }

        public void CantidadCarrito(string modo, int idMath = 0)
        {
            if (Session["countCarrito"] == null)
                Session.Add("countCarrito", 0);

            int count = (int)Session["countCarrito"];
            if (modo == "suma") { count++; }
            else if (modo == "resta") { if (count > 0) count--; }
            else if (modo == "eliminar" && count > 0)
            {
                count = 0;
                var itemList = ((NegocioItemCarrito)Session["listaCarrito"]).Items;
                foreach (var item in itemList) count += item.Cantidad;
            }
            Session["countCarrito"] = count;

            Label lblcantidad = (Label)Master.FindControl("lblTotalArticulos");
            if (lblcantidad != null)
            {
                lblcantidad.Text = count.ToString();
                Flag = true;
            }
        }

        public void CargarPantallaCarrito(List<ItemCarrito> lista)
        {
            if (lista != null && lista.Count > 0)
            {
                divResumen.Visible = false;
                divCarritoVacio.Visible = false;
                divCarrito.Visible = true;

                dgvCarrito.DataSource = lista;
                dgvCarrito.DataBind();
                totalAcumulado = TotalCarrito(lista);
            }
            else
            {
                divResumen.Visible = false;
                divCarrito.Visible = false;
                divCarritoVacio.Visible = true;
            }
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            try
            {
                int id = int.Parse(((Button)sender).CommandArgument);
                items = Session["listaCarrito"] as NegocioItemCarrito;

                items.EliminarItem(id);

                dgvCarrito.DataSource = items.Items;
                dgvCarrito.DataBind();

                totalAcumulado = TotalCarrito(items.Items);

                CantidadCarrito("eliminar", id);
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnSumar_Click(object sender, EventArgs e)
        {
            try
            {
                int id = int.Parse(((Button)sender).CommandArgument);
                items = Session["listaCarrito"] as NegocioItemCarrito;
                ItemCarrito itemMatch = items.Items.Find(itm => itm.Id == id);

                if (itemMatch != null && itemMatch.Cantidad >= 0)
                    items.ModificarCantidad(id, ++itemMatch.Cantidad);

                dgvCarrito.DataSource = items.Items;
                dgvCarrito.DataBind();

                totalAcumulado = TotalCarrito(items.Items);

                CantidadCarrito("suma");
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnRestar_Click(object sender, EventArgs e)
        {
            try
            {
                int id = int.Parse(((Button)sender).CommandArgument);
                items = Session["listaCarrito"] as NegocioItemCarrito;
                ItemCarrito itemMatch = items.Items.Find(itm => itm.Id == id);

                if (itemMatch != null && itemMatch.Cantidad > 0) 
                    items.ModificarCantidad(id, --itemMatch.Cantidad);

                dgvCarrito.DataSource = items.Items;
                dgvCarrito.DataBind();

                totalAcumulado = TotalCarrito(items.Items);

                CantidadCarrito("resta");
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnDetalles_Click(object sender, EventArgs e)
        {
            try
            {
                int id = int.Parse(((Button)sender).CommandArgument);
                Response.Redirect("Detalle.aspx?idProd=" + id, false);
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnEliminarListaCarrito_Click(object sender, EventArgs e)
        {
            Session.Remove("listaCarrito");
            Session.Remove("countCarrito");
            Response.Redirect("Carrito.aspx", false);
        }

        protected void btnConfirmarPedido_Click(object sender, EventArgs e)
        {
            try
            {
                NegocioPedido = new NegocioPedido();
                NegocioUsuario = new NegocioUsuario();
                usuario = (Usuario)Session["usuarioActual"];

                if (NegocioUsuario.IsLogged(usuario))
                {
                    items = Session["listaCarrito"] as NegocioItemCarrito;
                    List<ItemCarrito> lista = items.Items;

                    if (lista == null)
                    {
                        Mensajes.Mensajes.MensajePopUp(this, "No hay articulos en el carrito");
                        return;
                    }

                    Pedido pedido = NegocioPedido.CargarPedido(lista, usuario, totalAcumulado);

                    
                    int resArticulos = 0;

                    int resPedido = (int)NegocioPedido.CrearPedido(pedido);
                    if (resPedido == 0)
                    {
                        Mensajes.Mensajes.MensajePopUp(this, "Ocurrio Un Error al Cargar el Pedido");
                        return;
                    }
                    else
                    {
                        NegocioPedido.CargarIdPedido(pedido.totalItems, resPedido);
                        resArticulos = NegocioPedido.AgregarArticuloPedido(pedido.totalItems);
                    }

                    if (resArticulos == pedido.totalItems.Count)
                    {
                        EmailService emailService = new EmailService();
                        Usuario user = Session["usuarioActual"] as Usuario;
                        emailService.ArmarCorreo(user.Mail, "Ojo de Aguila", newHtmlMsj(user));
                        emailService.EnviarCorreo();
                        Mensajes.Mensajes.MensajePopUp(this, "Pedido Cargado Correctamente.");

                        Response.Redirect("Default.aspx", false);
                    }
                    else
                    {
                        Mensajes.Mensajes.MensajePopUp(this, "Ocurrio Un Error al Cargar el Pedido");
                    }
                }
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnContinuarCompra_Click(object sender, EventArgs e)
        {
            Response.Redirect("Carrito.aspx?text=ok", false);
        }

        public void CargarPantallaFinalizarCompra(bool logged, List<ItemCarrito> lista)
        {
            if (lista != null && lista.Count > 0)
            {
                divCarritoVacio.Visible = false;
                divCarrito.Visible = false;
                divResumen.Visible = true;

                if (logged)
                {
                    divBtnConfirmarReserva.Visible = true;
                    divRegistroOLoginNecesario.Visible = false;
                }
                else
                {
                    divRegistroOLoginNecesario.Visible = true;
                    divBtnConfirmarReserva.Visible = false;
                }
                    

                rptCarrito.DataSource = lista;
                rptCarrito.DataBind();
                totalAcumulado = TotalCarrito(lista);
            }
            else
            {
                divCarritoVacio.Visible = true;
                divCarrito.Visible = false;
                divResumen.Visible = false;
            }
        }

        private string newHtmlMsj(Usuario usuario)
        {
            string html = "<div> " +
                "<h4>Ojo de Aguila</h4> " +
                "<p>Gracias por su compra, " + usuario.Nombre + "</p> " +
                "<p>El pedido se encuentra en proceso de preparación</p> " +
                "<p>En breve recibirá un mail con la confirmación del pedido</p> " +
                "<p>Saludos</p> " +
                "</div>";
            return html;
        }

    }
}
