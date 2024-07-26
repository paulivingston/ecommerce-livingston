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
        NegocioDescuento NegocioDescuento;
        Usuario usuario;
        NegocioItemCarrito items;
        NegocioPedido NegocioPedido;
        Articulo articulo;
        public bool logged = false;
        protected int descuento = 0;
        protected decimal totalAcumulado = 0;
        public decimal TotalAcumulado
        {
            get { return totalAcumulado; }
            set { totalAcumulado = value; }
        }
        protected decimal subtotal = 0;


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

                // count icono carrito
                if (Session["countCarrito"] == null) Session.Add("countCarrito", 0);
                CantidadCarrito();

                //total carrito
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

        //GUARDAR EN SESION
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

            subtotal = total;

            if (Session["descuento"] != null)
            {
                descuento = Convert.ToInt32(Session["descuento"]);
                if (descuento > 0) total -= (total /= descuento);
            }

            Session["totalCarrito"] = total;
            return total;
        }

        public void CantidadCarrito()
        {
            if (Session["countCarrito"] == null) Session.Add("countCarrito", 0);
            int count = 0;

            if (Session["listaCarrito"] != null)
            {
                var itemList = ((NegocioItemCarrito)Session["listaCarrito"]).Items;
                foreach (var item in itemList) count += item.Cantidad;
            }

            Session["countCarrito"] = count;

            SiteMaster masterPage = (SiteMaster)Master;
            if (count > 0)
            {
                Label lblcantidad = (Label)Master.FindControl("lblTotalArticulos");
                if (lblcantidad != null)
                {
                    lblcantidad.Text = count.ToString();
                    masterPage.Flag = true;
                }
            }
            else
            {
                masterPage.Flag = false;
            }
        }


        //CARGAR DISTINTAS PARTES
        public void CargarPantallaCarrito(List<ItemCarrito> lista)
        {
            if (lista != null && lista.Count > 0)
            {
                divResumen.Visible = false;
                divCarritoVacio.Visible = false;
                divCarrito.Visible = true;
                divMediosDePago.Visible = false;

                dgvCarrito.DataSource = lista;
                dgvCarrito.DataBind();
                totalAcumulado = TotalCarrito(lista);
            }
            else
            {
                divResumen.Visible = false;
                divCarrito.Visible = false;
                divCarritoVacio.Visible = true;
                divMediosDePago.Visible = false;
            }
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
                    divRegistroOLoginNecesario.Visible = false;
                    divMediosDePago.Visible = true;
                }
                else
                {
                    divRegistroOLoginNecesario.Visible = true;
                    divMediosDePago.Visible = false;
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



        //BOTONES CARRITO
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

                CantidadCarrito();
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

                List<Articulo> listaPrincipal = (List<Articulo>)Session["listaPrincipal"];
                articulo = listaPrincipal.Find(art => art.Id == id);

                if(articulo.Stock>itemMatch.Cantidad) { 
                    if (itemMatch != null && itemMatch.Cantidad >= 0)
                        items.ModificarCantidad(id, ++itemMatch.Cantidad);

                    dgvCarrito.DataSource = items.Items;
                    dgvCarrito.DataBind();

                    totalAcumulado = TotalCarrito(items.Items);

                    CantidadCarrito();
                } 
                else
                {
                    Mensajes.Mensajes.MensajePopUp(this, "No disponemos de más unidades de este artículo");
                    return;
                }
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

                if (itemMatch.Cantidad == 1) items.EliminarItem(id);
                else items.ModificarCantidad(id, --itemMatch.Cantidad);

                dgvCarrito.DataSource = items.Items;
                dgvCarrito.DataBind();

                totalAcumulado = TotalCarrito(items.Items);

                CantidadCarrito();
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
            Session.Remove("descuento");
            Response.Redirect("Carrito.aspx", false);
        }

        protected void btnAplicarDescuento_Click(object sender, EventArgs e)
        {
            if(!string.IsNullOrEmpty(txtCuponDescuento.Text))
            {
                NegocioDescuento = new NegocioDescuento();
                descuento = Convert.ToInt32(NegocioDescuento.AplicarDescuento(txtCuponDescuento.Text));

                if (descuento>0)
                {
                    if (Session["descuento"] == null) Session.Add("descuento", descuento);
                    else Session["descuento"] = descuento;

                    items = Session["listaCarrito"] as NegocioItemCarrito;
                    var lista = items?.Items;
                    totalAcumulado = TotalCarrito(lista);

                    Mensajes.Mensajes.MensajePopUp(this, "Cupon Aplicado Correctamente");
                    return;
                }
                else
                {
                    Mensajes.Mensajes.MensajePopUp(this, "El cupon no existe o no se encuentra activo");
                    return;
                }
            }
            else
            {
                Mensajes.Mensajes.MensajePopUp(this, "Debe ingresar el codigo si quiere aplicar a algun descuento");
                return;
            }
            
        }

        protected void btnContinuarCompra_Click(object sender, EventArgs e)
        {
            Response.Redirect("Carrito.aspx?text=ok", false);
        }

        protected void btnConfirmarPedido_Click(object sender, EventArgs e)
        {
            try
            {
                //Valido el form
                if (ValidarDebito() || ValidarCredito())
                {
                    //Valido usuario
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

                        //Genero pedido
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

                            Session["listaCarrito"] = null;

                            Session.Add("mensajeEnDefault", "Pedido Cargado Correctamente. Le llegará un mail a su casilla de correo con la información del pedido.");
                            Response.Redirect("Default.aspx", false);
                        }
                        else
                        {
                            Mensajes.Mensajes.MensajePopUp(this, "Ocurrio Un Error al Cargar el Pedido");
                        }
                    }
                } 
                else
                {
                    Mensajes.Mensajes.MensajePopUp(this, "Hay campos erróneos o vacíos");
                    return;
                }
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        private bool ValidarDebito()
        {
            if (string.IsNullOrEmpty(nombreDebito.Value) || !nombreDebito.Value.All(char.IsLetter) ||
                string.IsNullOrEmpty(numeroDebito.Value) || (!numeroDebito.Value.All(char.IsDigit) && !numeroDebito.Value.All(char.IsNumber)) ||
                string.IsNullOrEmpty(fechaVenDebito.Value) ||
                string.IsNullOrEmpty(codSegDebito.Value) || (!codSegDebito.Value.All(char.IsDigit) && !codSegDebito.Value.All(char.IsNumber)) ||
                string.IsNullOrEmpty(dniDebito.Value) || (!dniDebito.Value.All(char.IsDigit) && !dniDebito.Value.All(char.IsNumber))
                )
            {
                return false;
            }
            return true;
        }

        private bool ValidarCredito()
        {
            if (string.IsNullOrEmpty(nombreCredito.Value) || !nombreCredito.Value.All(char.IsLetter) || 
                string.IsNullOrEmpty(numeroCredito.Value) || (!numeroCredito.Value.All(char.IsDigit) && !numeroCredito.Value.All(char.IsNumber)) ||
                string.IsNullOrEmpty(fechaVenCredito.Value) ||
                string.IsNullOrEmpty(codSegCredito.Value) || (!codSegCredito.Value.All(char.IsDigit) && !codSegCredito.Value.All(char.IsNumber)) ||
                string.IsNullOrEmpty(dniCredito.Value) || (!dniCredito.Value.All(char.IsDigit) && !dniCredito.Value.All(char.IsNumber))
                )
            {
                return false;
            }
            return true;
        }


        //MENSAJES
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
