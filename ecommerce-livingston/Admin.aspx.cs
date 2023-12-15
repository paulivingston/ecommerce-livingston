using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Dominio;
using Mensajes;
using Negocio;
using System.Web.UI.HtmlControls;
using System.Data.SqlClient;

//falta estadisticas
//falta solucionar filtros tipo dropdown
//falta marca y categoria en tabla de articulos
//aplicar filtro articulo

namespace ecommerce_livingston
{
    public partial class Admin : System.Web.UI.Page
    {
        NegocioPedido NegocioPedido;
        List<Pedido> Pedidos;
        Pedido pedido;
        List<ItemCarrito> ArticulosPedido;
        NegocioUsuario NegocioUsuario;
        List<Usuario> Usuarios;
        Usuario usuario;
        NegocioArticulo NegocioArticulo;
        List<Articulo> Articulos;
        Articulo articulo;
        NegocioMarca NegocioMarca;
        List<Marca> Marcas;
        Marca marca;
        NegocioCategoria NegocioCategoria;
        List<Categoria> Categorias;
        Categoria categoria;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                //falta validacion admin
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        #region OPCIONES MENU


        //pedidos
        private void CargarPedidos()
        {
            NegocioPedido = new NegocioPedido();
            Pedidos = NegocioPedido.ListarPedidos();
            dgvAdminPedidos.DataSource = Pedidos;
            dgvAdminPedidos.DataBind();

            divEstadisticas.Visible = false;
            sectionAdminUsuarios.Visible = false;
            sectionModificarUsuario.Visible = false;
            panelAdminMarcas.Visible = false;
            sectionNuevaMarca.Visible = false;
            panelAdminCategorias.Visible = false;
            sectionNuevaCategoria.Visible = false;

            sectionAdminPedidos.Visible = true;
            sectionAdminPedidosTodos.Visible = true;
            dgvAdminPedidos.Visible = true;
            sectionAdminPedidoIndividual.Visible = false;
        }

        protected void btnPedidosTodos_Click(object sender, EventArgs e)
        {
            CargarPedidos();
        }

        //articulos

        private void CargarArticulos()
        {
            try
            {
                //vistas
                divEstadisticas.Visible = false;
                sectionAdminPedidos.Visible = false;
                sectionAdminPedidoIndividual.Visible = false;
                sectionAdminUsuarios.Visible = false;
                sectionModificarUsuario.Visible = false;
                panelAdminCategorias.Visible = false;
                sectionNuevaCategoria.Visible = false;
                panelAdminMarcas.Visible = false;
                sectionNuevaMarca.Visible = false;

                sectionAdminArticulos.Visible = true;
                dgvAdminArticuloIndividual.Visible = false;
                sectionNuevoArticulo.Visible = false;

                //filtros
                NegocioMarca = new NegocioMarca();
                NegocioCategoria = new NegocioCategoria();

                ddlFiltroMarca.DataSource = NegocioMarca.ListarMarcas();
                ddlFiltroMarca.DataValueField = "Id";
                ddlFiltroMarca.DataTextField = "Descripcion";
                ddlFiltroMarca.DataBind();
                rptMarcas.DataSource = NegocioMarca.ListarMarcas();
                rptMarcas.DataBind();

                ddlFiltroCategoria.DataSource = NegocioCategoria.ListarCategorias();
                ddlFiltroCategoria.DataValueField = "Id";
                ddlFiltroCategoria.DataTextField = "Descripcion";
                ddlFiltroCategoria.DataBind();
                rptCategorias.DataSource = NegocioCategoria.ListarCategorias();
                rptCategorias.DataBind();

                //articulos
                NegocioArticulo = new NegocioArticulo();
                Articulos = NegocioArticulo.ListarArticulos();

                if (Session["listaPrincipal"]==null)
                    Session.Add("listaPrincipal", new List<Articulo>());

                Session["listaPrincipal"] = Articulos;
                
                dgvAdminArticulo.DataSource = Articulos;
                dgvAdminArticulo.DataBind();
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void CargaDdl()
        {
            try
            {
                NegocioCategoria = new NegocioCategoria();
                NegocioMarca = new NegocioMarca();
                ddlCategoria.DataSource = NegocioCategoria.ListarCategorias();
                ddlCategoria.DataTextField = "Descripcion";
                ddlCategoria.DataValueField = "Id";
                ddlCategoria.DataBind();
                ddlMarca.DataSource = NegocioMarca.ListarMarcas();
                ddlMarca.DataTextField = "Descripcion";
                ddlMarca.DataValueField = "Id";
                ddlMarca.DataBind();
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private void CargarNuevoArticulo()
        {
            //vistas
            divEstadisticas.Visible = false;
            sectionAdminPedidos.Visible = false;
            sectionAdminPedidoIndividual.Visible = false;
            sectionAdminUsuarios.Visible = false;
            sectionModificarUsuario.Visible = false;
            panelAdminCategorias.Visible = false;
            sectionNuevaCategoria.Visible = false;
            panelAdminMarcas.Visible = false;
            sectionNuevaMarca.Visible = false;

            sectionAdminArticulos.Visible = false;
            dgvAdminArticuloIndividual.Visible = false;
            sectionNuevoArticulo.Visible = true;
            tituloEditarArticulo.Visible = false;
            btnAgregar.Text = "Crear Articulo";
            btnEliminarArticulo.Visible = false;

            //cargar ddls
            CargaDdl();
        }
        private void CargarMarcas()
        {
            NegocioMarca = new NegocioMarca();
            Marcas = NegocioMarca.ListarMarcas();
            dgvAdminMarca.DataSource = Marcas;
            dgvAdminMarca.DataBind();

            divEstadisticas.Visible = false;
            sectionAdminPedidos.Visible = false;
            sectionAdminPedidoIndividual.Visible = false;
            sectionAdminUsuarios.Visible = false;
            sectionModificarUsuario.Visible = false;
            panelAdminCategorias.Visible = false;
            sectionNuevaCategoria.Visible = false;
            sectionAdminArticulos.Visible = false;
            dgvAdminArticuloIndividual.Visible = false;
            sectionNuevoArticulo.Visible = false;

            panelAdminMarcas.Visible = true;
            sectionNuevaMarca.Visible = false;
        }

        private void CargarCategorias()
        {
            NegocioCategoria = new NegocioCategoria();
            Categorias = NegocioCategoria.ListarCategorias();
            dgvAdminCate.DataSource = Categorias;
            dgvAdminCate.DataBind();

            divEstadisticas.Visible = false;
            sectionAdminPedidos.Visible = false;
            sectionAdminPedidoIndividual.Visible = false;
            sectionAdminUsuarios.Visible = false;
            sectionModificarUsuario.Visible = false;
            panelAdminMarcas.Visible = false;
            sectionNuevaMarca.Visible = false;
            sectionAdminArticulos.Visible = false;
            dgvAdminArticuloIndividual.Visible = false;
            sectionNuevoArticulo.Visible = false;

            panelAdminCategorias.Visible = true;
            sectionNuevaCategoria.Visible = false;
        }


        protected void btnArticulosTodos_Click(object sender, EventArgs e)
        {
            CargarArticulos();
        }
        protected void btnNuevoArticulo_Click(object sender, EventArgs e)
        {
            CargarNuevoArticulo();
        }
        protected void btnMarcas_Click(object sender, EventArgs e)
        {
            CargarMarcas();
        }
        protected void btnCategorias_Click(object sender, EventArgs e)
        {
            CargarCategorias();
        }


        //usuarios
        private void CargarUsuarios()
        {
            NegocioUsuario = new NegocioUsuario();
            Usuarios = NegocioUsuario.ListarUsuarios();
            dgvAdminUsuario.DataSource = Usuarios;
            dgvAdminUsuario.DataBind();

            divEstadisticas.Visible = false;
            sectionAdminPedidos.Visible = false;
            sectionAdminPedidoIndividual.Visible = false;
            panelAdminMarcas.Visible = false;
            sectionNuevaMarca.Visible = false;
            panelAdminCategorias.Visible = false;
            sectionNuevaCategoria.Visible = false;
            sectionAdminArticulos.Visible = false;
            dgvAdminArticuloIndividual.Visible = false;
            sectionNuevoArticulo.Visible = false;

            sectionAdminUsuarios.Visible=true;
            lblAdministracionUsuarios.Visible = true;
            filtrosUsuarios.Visible = true;
            sectionModificarUsuario.Visible = false;
            

        }

        protected void btnUsuariosTodos_Click(object sender, EventArgs e)
        {
            CargarUsuarios();
        }

        protected void btnAgregarNuevoUsuario_Click(object sender, EventArgs e)
        {
            btnGuardarUsuario.Text = "Agregar Usuario";

            txtId.Text = string.Empty;
            txtNombre.Text = string.Empty;
            txtApellido.Text = string.Empty;
            txtEmail.Text = string.Empty;
            txtClave.Text = string.Empty;
            txtDni.Text = string.Empty;
            txtDomicilio.Text = string.Empty;

            dgvAdminUsuario.Visible = false;
            btnAltaUsuario.Visible = false;
            btnBajaUsuario.Visible = false;
            btnEliminarUsuario.Visible = false;
            sectionModificarUsuario.Visible = true;
            lblAdministracionUsuarios.Visible = true;
            divEstadisticas.Visible = false;
            filtrosUsuarios.Visible = false;
        }

        #endregion


        #region SUBMENU PEDIDOS
        //submenu pedidos


        private void CargarPedido(Pedido pedido)
        {
            ddlIdUsuarioModificarPedido.DataSource = new NegocioUsuario().ListarUsuarios();
            ddlIdUsuarioModificarPedido.DataTextField = "Id" + ' ' + "Nombre" + ' ' + "Apellido";
            ddlIdUsuarioModificarPedido.DataValueField = "Id";
            ddlIdUsuarioModificarPedido.DataBind();

            if (pedido == null) return;
            txtIdPedidoEditar.Text = pedido.IdPedido.ToString();
            ddlIdUsuarioModificarPedido.SelectedValue = pedido.IdUsuario.ToString();
            txtEstadoModificarPedido.Text = pedido.Estado; //ver de poner ddl con opciones
            txtFechaModificarPedido.Text = pedido.fecha.ToString();
            txtDescuentoModificarPedido.Text = pedido.Descuento.ToString();
            txtTotalModificarPedido.Text = pedido.PrecioTotal;
            txtCantidadTotalModificarPedido.Text = pedido.CantidadTotal.ToString();
        }

        private void CalcularTotalesPedido(List<ItemCarrito> lista)
        {
            decimal nuevoTotal = 0;
            int nuevaCantidad = 0;

            lista.ForEach(itm => nuevoTotal += itm.Cantidad * itm.Precio);
            lista.ForEach(itm => nuevaCantidad += itm.Cantidad);

            if (nuevoTotal < 0) nuevoTotal = 0;

            txtTotalModificarPedido.Text = string.Format("{0:C2}", nuevoTotal);
            txtNuevoTotal.Text = string.Format("{0:C2}", nuevoTotal);
            txtNuevoTotal.Visible = true;
            txtCantidadTotalModificarPedido.Text = nuevaCantidad.ToString();
            dgvArticulosPedido.DataSource = lista;
            dgvArticulosPedido.DataBind();
        }

        protected void btnOrdenarPrecioPedidos_Click(object sender, EventArgs e)
        {
            try
            {
                divEstadisticas.Visible = false;
                NegocioPedido = new NegocioPedido();
                Pedidos = NegocioPedido.ListarPedidos();

                if (((Button)sender).CommandName == "MAYOR")
                    Pedidos = Pedidos.OrderByDescending(itm => itm.precioTotal).ToList();
                else if (((Button)sender).CommandName == "MENOR")
                    Pedidos = Pedidos.OrderBy(itm => itm.precioTotal).ToList();

                dgvAdminPedidos.DataSource = Pedidos;
                dgvAdminPedidos.DataBind();

            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnEstadosPedidosFiltros_Click(object sender, EventArgs e)
        {
            try
            {
                divEstadisticas.Visible = false;
                NegocioPedido = new NegocioPedido();
                Pedidos = NegocioPedido.ListarPedidos();

                string estado = ((Button)sender).CommandName;
                if (estado == "btnIniciado")
                    Pedidos = Pedidos.Where(itm => itm.Estado == "INICIADO").ToList();
                else if (estado == "btnFinalizado")
                    Pedidos = Pedidos.Where(itm => itm.Estado == "FINALIZADO").ToList();
                else if (estado == "btnCancelado")
                    Pedidos = Pedidos.Where(itm => itm.Estado == "CANCELADO").ToList();

                dgvAdminPedidos.DataSource = Pedidos;
                dgvAdminPedidos.DataBind();
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnFiltrosPersonalizados_Click(object sender, EventArgs e)
        {
            try
            {
                divEstadisticas.Visible = false;
                NegocioPedido = new NegocioPedido();
                Pedidos = NegocioPedido.ListarPedidos();

                int idPedidoUser = string.IsNullOrWhiteSpace(txtFiltroIdUser_Pedido.Text) ? 0 : Convert.ToInt32(txtFiltroIdUser_Pedido.Text);
                int idPedido = string.IsNullOrWhiteSpace(txtFiltroIdPedido_Pedido.Text) ? 0 : Convert.ToInt32(txtFiltroIdPedido_Pedido.Text);
                string nombreUser = string.IsNullOrWhiteSpace(txtFiltroNombreUsuario_Pedido.Text) ? string.Empty : txtFiltroNombreUsuario_Pedido.Text;
                DateTime fechaDesde = string.IsNullOrWhiteSpace(txtFiltroFecha.Text) ? DateTime.MinValue : Convert.ToDateTime(txtFiltroFecha.Text);

                if (idPedidoUser != 0)
                    Pedidos.RemoveAll(itm => itm.IdUsuario != idPedidoUser);
                if (idPedido != 0)
                    Pedidos.RemoveAll(itm => itm.IdPedido != idPedido);
                if (nombreUser != string.Empty)
                    Pedidos.RemoveAll(itm => itm.Usuario.ToUpperInvariant() != nombreUser.ToUpperInvariant());
                if (fechaDesde != DateTime.MinValue)
                    Pedidos.RemoveAll(itm => itm.fecha.Date != fechaDesde.Date);

                dgvAdminPedidos.DataSource = Pedidos;
                dgvAdminPedidos.DataBind();
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnLimpiarFiltrosPedidos_Click(object sender, EventArgs e)
        {
            try
            {
                CargarPedidos();
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnCancelarTerminarPedido(object sender, EventArgs e)
        {
            int idPedido = int.Parse(((Button)sender).CommandArgument);
            string tipo = ((Button)sender).CommandName;
            if (tipo == "Cancelar")
            {
                try
                {
                    NegocioPedido = new NegocioPedido();
                    NegocioPedido.ModificarEstado(idPedido, "CANCELADO");
                    dgvAdminPedidos.DataSource = NegocioPedido.ListarPedidos();
                    dgvAdminPedidos.DataBind();
                }
                catch (Exception ex)
                {
                    Session.Add("error", ex);
                    Response.Redirect("Error.aspx", false);
                }
            }
            else if (tipo == "Finalizar")
            {
                try
                {
                    NegocioPedido = new NegocioPedido();
                    NegocioPedido.ModificarEstado(idPedido, "FINALIZADO");
                    dgvAdminPedidos.DataSource = NegocioPedido.ListarPedidos();
                    dgvAdminPedidos.DataBind();
                }
                catch (Exception ex)
                {
                    Session.Add("error", ex);
                    Response.Redirect("Error.aspx", false);
                }
            }
        }

        protected void ibtModificarPedido_Click(object sender, EventArgs e)
        {
            try
            {
                int id = Convert.ToInt32(((ImageButton)sender).CommandArgument);
                Session.Add("idPedidoEditar", id);

                //pedido
                NegocioPedido = new NegocioPedido();
                pedido = NegocioPedido.ListarPedidos(id);
                dgvAdminPedido.DataSource = pedido;
                dgvAdminPedido.DataBind();

                //articulos del pedido
                Session.Add("PedidoArticulosListaEdit", NegocioPedido.ListarArticulosPedido(id));
                ArticulosPedido = Session["PedidoArticulosListaEdit"] as List<ItemCarrito>;
                dgvArticulosPedido.DataSource = ArticulosPedido;
                dgvArticulosPedido.DataBind();

                int total = 0;
                ArticulosPedido.ForEach(x => total += x.Cantidad);
                pedido.CantidadTotal = total;
                CargarPedido(pedido);

                ddlAgregarArticuloPedido.DataSource = new NegocioArticulo().ListarArticulos();
                ddlAgregarArticuloPedido.DataTextField = "Nombre";
                ddlAgregarArticuloPedido.DataValueField = "Id";
                ddlAgregarArticuloPedido.DataBind();

                //cambio vistas
                sectionAdminPedidoIndividual.Visible = true;
                sectionAdminPedidosTodos.Visible = false;
                dgvAdminPedido.Visible = true;
                dgvArticulosPedido.Visible = true;
                seccionEditarPedidos.Visible = true;
                accordionPedidoArticulos.Visible = true;
                txtTotalModificarPedido.Enabled = false;
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnAgregarArticuloPedido_Click(object sender, EventArgs e)
        {
            

            if (Session["idPedidoEditar"] == null)
            {
                Session["MensajeError"] = "Ha ocurrido un error al validar la informacion del pedido";
                Response.Redirect("Error.aspx", false);
                return;
            }

            int idPedido = (int)Session["idPedidoEditar"];
            
            int idArticulo = int.Parse(ddlAgregarArticuloPedido.SelectedValue);
            List<ItemCarrito> listaArticulosPedido = Session["PedidoArticulosListaEdit"] as List<ItemCarrito>;

            //si es el primer articulo
            if (listaArticulosPedido == null)
            {
                listaArticulosPedido = new List<ItemCarrito>();
                Session.Add("PedidoArticulosListaEdit", listaArticulosPedido);
            }

            //si el articulo ya existia en la lista
            if (listaArticulosPedido.Find(itm => itm.Id == idArticulo) != null)
            {
                listaArticulosPedido.Find(itm => itm.Id == idArticulo).Cantidad += 1;
            }
            else
            {
            //agregar articulo
                Articulo art = new NegocioArticulo().ListarArticulos(idArticulo);
                ItemCarrito newItem = new ItemCarrito()
                {
                    Id = idArticulo,
                    Cantidad = 1,
                    Nombre = art.Nombre,
                    Categoria = art.Categoria.Descripcion,
                    Descripcion = art.Descripcion,
                    Estado = art.Estado ? "Alta" : "Baja",
                    IdPedido = idPedido,
                    Precio = art.Precio,
                    ImagenUrl = art.ImagenUrl,
                    Marca = art.Marca.Descripcion,
                    Stock = art.Stock,
                };
                listaArticulosPedido.Add(newItem);
            }

            //calculo nuevos totales y asigno
            CalcularTotalesPedido(listaArticulosPedido);
        }

        protected void btnBuscarArticuloPorIDPedido_Click(object sender, EventArgs e)
        {
            try
            {
                int id = int.Parse(txtBuscarArticuloPorIDPedido.Text);
                NegocioArticulo = new NegocioArticulo();
                dgvBuscarArticuloPorIDPedido.DataSource = NegocioArticulo.ListarArticulos(id);
                dgvBuscarArticuloPorIDPedido.DataBind();
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }
        
        protected void btnAgregarArtPedido_Click(object sender, EventArgs e)
        {
            try
            {
                int idArticulo = int.Parse(((ImageButton)sender).CommandArgument);
                List<ItemCarrito> listaArticulosPedido = Session["PedidoArticulosListaEdit"] as List<ItemCarrito>;

                listaArticulosPedido.Find(itm => itm.Id == idArticulo).Cantidad += 1;

                //calculo nuevos totales y asigno
                CalcularTotalesPedido(listaArticulosPedido);
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnRestarArtPedido_Click(object sender, EventArgs e)
        {
            int idArticulo = int.Parse(((ImageButton)sender).CommandArgument);
            List<ItemCarrito> listaArticulosPedido = Session["PedidoArticulosListaEdit"] as List<ItemCarrito>;
            
            listaArticulosPedido.Find(itm => itm.Id == idArticulo).Cantidad -= 1; //restamos aca el item
            if (listaArticulosPedido.Find(itm => itm.Id == idArticulo).Cantidad == 0)
            {
                listaArticulosPedido.RemoveAll(itm => itm.Id == idArticulo);
            }

            //calculo nuevos totales y asigno
            CalcularTotalesPedido(listaArticulosPedido);
        }

        protected void btnEliminarArtPedido_Click(object sender, EventArgs e)
        {
            try
            {
                int idArticulo = int.Parse(((ImageButton)sender).CommandArgument);
                List<ItemCarrito> listaArticulosPedido = Session["PedidoArticulosListaEdit"] as List<ItemCarrito>;

                listaArticulosPedido.RemoveAll(itm => itm.Id == idArticulo);

                //calculo nuevos totales y asigno
                CalcularTotalesPedido(listaArticulosPedido);
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnConfirmarPedido_Click(object sender, EventArgs e)
        {
            try
            {
                NegocioPedido = new NegocioPedido();
                Pedido pedido = new Pedido();
                
                if (string.IsNullOrWhiteSpace(txtIdPedidoEditar.Text))
                {
                    lblErrorPedidos.Visible = true;
                    lblErrorPedidosText.Text = "Id pedido no puede estar vacio";
                    return;
                }
                if (string.IsNullOrWhiteSpace(txtIdUsuarioModificarPedido.Text))
                {
                    lblErrorPedidos.Visible = true;
                    lblErrorPedidosText.Text = "Id usuario no puede estar vacio";
                    return;
                }
                if (string.IsNullOrWhiteSpace(txtEstadoModificarPedido.Text))
                {
                    lblErrorPedidos.Visible = true;
                    lblErrorPedidosText.Text = "Estado no puede estar vacio";
                    return;
                }
                if (string.IsNullOrWhiteSpace(txtFechaModificarPedido.Text))
                {
                    lblErrorPedidos.Visible = true;
                    lblErrorPedidosText.Text = "Fecha no puede estar vacio";
                    return;
                }
                if (string.IsNullOrWhiteSpace(txtDescuentoModificarPedido.Text) || !txtDescuentoModificarPedido.Text.All(c => char.IsDigit(c) || char.IsNumber(c)))
                {
                    lblErrorPedidos.Visible = true;
                    lblErrorPedidosText.Text = "Descuento no puede estar vacio y tiene que ser un numero";
                    return;
                }
                if (string.IsNullOrWhiteSpace(txtCantidadTotalModificarPedido.Text) || !txtCantidadTotalModificarPedido.Text.All(c => char.IsDigit(c) || char.IsNumber(c)))
                {
                    lblErrorPedidos.Visible = true;
                    lblErrorPedidosText.Text = "Cantidad no puede estar vacio y tiene que ser un numero";
                    return;
                }

                CargarPedido(pedido);
                
                int res = 0;
                //busco sesion actual y error si no existe
                List<ItemCarrito> listaArticulosPedido = Session["PedidoArticulosListaEdit"] as List<ItemCarrito>;
                if (listaArticulosPedido == null)
                {
                    Mensajes.Mensajes.MensajePopUp(this, "No hay articulos en Pedido");
                    return;
                }
                //nuevas cantidades
                int resTotal = listaArticulosPedido.Sum(x => x.Cantidad);
                if (resTotal != pedido.Cantidad)
                {
                    Mensajes.Mensajes.MensajePopUp(this, "Cantidades distintas, verificar");
                }
                //edito pedido
                res = NegocioPedido.ModificarPedido(pedido);

                //elimino y vuelvo a agregar
                for (int i = 0; i < listaArticulosPedido.Count; i++)
                {
                    NegocioPedido.EliminarArticuloPedido(pedido.IdPedido);
                }
                res += NegocioPedido.AgregarArticuloPedido(listaArticulosPedido);

                //respuesta
                if (res >= 1)
                {
                    Mensajes.Mensajes.MensajePopUp(this, "Pedido editado con exito");
                    dgvAdminPedido.DataSource = new NegocioPedido().ListarPedidos(pedido.IdPedido);
                    dgvAdminPedido.DataBind();
                }
                else if (res == 0)
                    Mensajes.Mensajes.MensajePopUp(this, "Ocurrio un error al intentar guardar los cambios");
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnEliminarArticulosPedido_Click(object sender, EventArgs e)
        {
            try
            {
                NegocioPedido = new NegocioPedido();
                int res = NegocioPedido.EliminarPedido((int)Session["idPedidoEditar"]);

                if (res == 1)
                {
                    Session["MensajeExito"] = "Pedido eliminado";
                    CargarPedidos();
                }
                else
                {
                    Mensajes.Mensajes.MensajePopUp(this, "Error al eliminar pedido");
                }
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnVolverListaPedidos_Click(object sender, EventArgs e)
        {
            sectionAdminPedidosTodos.Visible = true;
            dgvAdminPedidos.Visible = true;
            dgvAdminPedido.Visible = false;
            sectionAdminPedidoIndividual.Visible = false;

            dgvArticulosPedido.Visible = false;
            seccionEditarPedidos.Visible = false;
            CargarUsuarios();
        }


        #endregion


        #region SUBMENU ARTICULOS

        //filtros
        private List<Articulo> filtrarLista(object param, string tipoParam = null)
        {
            try
            {
                if (Session["listaPrincipal"] == null)
                    return null;
                if (Session["listaFiltrada"] == null)
                    Session.Add("listaFiltrada", new List<Articulo>());

                List<Articulo> listaPrincipal = (List<Articulo>)Session["listaPrincipal"];
                List<Articulo> listaFiltrada = (List<Articulo>)Session["listaFiltrada"];

                if (param is string)
                {
                    string match = param as string;

                    if (tipoParam == "estado")
                    {
                        if (match == "Activo")
                            listaFiltrada = listaPrincipal.FindAll(art => art.Estado == true);
                        else if (match == "Inactivo")
                            listaFiltrada = listaPrincipal.FindAll(art => art.Estado == false);
                    }
                    else
                    {
                        listaFiltrada = listaPrincipal.FindAll(
                            x => (x.Nombre.ToUpperInvariant().Contains(match.ToUpperInvariant()) ||
                            x.Marca.Descripcion.ToUpperInvariant().Contains(match.ToUpperInvariant()))
                            );
                    }
                }
                else if (param is int)
                {
                    int match = (int)param;

                    if (tipoParam == "idCate")
                        listaFiltrada = listaPrincipal.FindAll(art => art.Categoria.Id == match);
                    else if (tipoParam == "idMarca")
                        listaFiltrada = listaPrincipal.FindAll(art => art.Marca.Id == match);
                }
                Session["listaFiltrada"] = listaFiltrada;
                return listaFiltrada;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected void btnFiltroMarca_Click(object sender, EventArgs e)
        {
            try
            {
                dgvAdminArticulo.DataSource = filtrarLista(int.Parse(((Button)sender).CommandArgument), "idMarca");
                dgvAdminArticulo.DataBind();
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnFiltroCate_Click(object sender, EventArgs e)
        {
            try
            {
                dgvAdminArticulo.DataSource = filtrarLista(int.Parse(((Button)sender).CommandArgument), "idCate");
                dgvAdminArticulo.DataBind();
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnFiltroEstadoAlta_Click(object sender, EventArgs e)
        {
            try
            {
                dgvAdminArticulo.DataSource = filtrarLista(((Button)sender).CommandArgument, "estado");
                dgvAdminArticulo.DataBind();
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnFiltroEstadoBaja_Click(object sender, EventArgs e)
        {
            try
            {
                dgvAdminArticulo.DataSource = filtrarLista(((Button)sender).CommandArgument, "estado");
                dgvAdminArticulo.DataBind();
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnFiltro_Click(object sender, EventArgs e)
        {
            try
            {
                List<Articulo> listaArticulos;
                List<Articulo> listaFiltrada;

                if (Session["listaFiltrada"] == null)
                    Session.Add("listaFiltrada", new List<Articulo>());

                listaArticulos = (List<Articulo>)Session["listaPrincipal"];
                if (listaArticulos == null) return;

                listaFiltrada = listaArticulos.FindAll(x =>
                    x.Categoria.Descripcion.Contains(ddlFiltroCategoria.Text)
                    && x.Marca.Descripcion.Contains(ddlFiltroMarca.Text));

                Session["listaFiltrada"] = listaFiltrada;
                dgvAdminArticulo.DataSource = listaFiltrada;
                dgvAdminArticulo.DataBind();
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx");
            }
        }

        protected void btnFiltroPrecioDesc_Click(object sender, EventArgs e)
        {
            try
            {
                List<Articulo> listaArticulos;
                if (Session["listaFiltrada"] == null)
                    listaArticulos = (List<Articulo>)Session["listaPrincipal"];
                else
                    listaArticulos = (List<Articulo>)Session["listaFiltrada"];

                dgvAdminArticulo.DataSource = listaArticulos?.OrderByDescending(Productos => Productos.Precio).ToList();
                dgvAdminArticulo.DataBind();

            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx");
            }

        }

        protected void btnFiltroPrecioAsc_Click(object sender, EventArgs e)
        {
            try
            {
                List<Articulo> listaArticulos;
                if (Session["listaFiltrada"] == null)
                    listaArticulos = (List<Articulo>)Session["listaPrincipal"];
                else
                    listaArticulos = (List<Articulo>)Session["listaFiltrada"];

                dgvAdminArticulo.DataSource = listaArticulos?.OrderBy(Productos => Productos.Precio).ToList();
                dgvAdminArticulo.DataBind();
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx");
            }

        }

        protected void btnBorrarFilros_Click(object sender, EventArgs e)
        {
            Session.Remove("listaFiltrada");
            CargarArticulos();
        }


        //lista

        

        private void CargarArticuloEnformulario(Articulo art)
        {
            tbIdArt.Text = art.Id.ToString();
            tbNombreArt.Text = art.Nombre;
            tbDescripArt.Text = art.Descripcion;
            tbPrecioArt.Text = art.Precio.ToString();
            tbStockArt.Text = art.Stock.ToString();
            CargaDdl();
            tbImgArt.Text = art.ImagenUrl;
            imgNuevoArt.ImageUrl = art.ImagenUrl;
        }

        protected void btnEditarArticulo_Click(object sender, EventArgs e)
        {
            try
            {
                NegocioArticulo = new NegocioArticulo();
                int id = int.Parse(((Button)sender).CommandArgument);

                articulo = NegocioArticulo.ListarArticulos(id);

                CargarArticuloEnformulario(articulo);
                ddlCategoria.SelectedValue = articulo.Categoria.Id.ToString();
                ddlMarca.SelectedValue = articulo.Marca.Id.ToString();

                dgvAdminArticuloIndividual.Visible = true;
                dgvAdminArticulo.Visible = false;
                sectionNuevoArticulo.Visible = true;
                tituloNuevoArticulo.Visible = false;
                tituloEditarArticulo.Visible = true;
                btnAgregar.Text = "Guardar Cambios";
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnCambiarEstadoArticulo_Click(object sender, EventArgs e)
        {
            NegocioArticulo = new NegocioArticulo();
            int id = int.Parse(((Button)sender).CommandArgument);

            string estado = ((Button)sender).CommandName;
            if (estado == "ALTA")
                NegocioArticulo.CambiarEstado(id, true);
            else if (estado == "BAJA")
                NegocioArticulo.CambiarEstado(id, false);

            Articulos = NegocioArticulo.ListarArticulos();
            dgvAdminArticulo.DataSource = Articulos;
            dgvAdminArticulo.DataBind();
        }

        protected void dgvAdmin_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            dgvAdminArticulo.PageIndex = e.NewPageIndex;
            CargarArticulos();
        }

        //nuevo articulo

        protected void tbImgArt_TextChanged(object sender, EventArgs e)
        {
            imgNuevoArt.ImageUrl = tbImgArt.Text;
        }




        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            try
            {
                string tipo = ((Button)sender).Text; 
                marca = new Marca();
                marca.Id = Convert.ToInt32(ddlMarca.SelectedValue);
                marca.Descripcion = ddlMarca.SelectedItem.ToString();
                categoria = new Categoria();
                categoria.Id = Convert.ToInt32(ddlCategoria.SelectedValue);
                categoria.Descripcion = ddlCategoria.SelectedItem.ToString();

                NegocioArticulo = new NegocioArticulo();
                articulo = new Articulo();

                //valido
                if (string.IsNullOrWhiteSpace(tbIdArt.Text) || !tbIdArt.Text.All(c => char.IsNumber(c)))
                {
                    lblRespuestaError.Text = "Debe ingresar un ID y tiene que ser un numero";
                    lblErrorArticulos.Visible = true;
                    sectionNuevoArticulo.Visible = true;
                    return;
                }
                if (string.IsNullOrWhiteSpace(tbNombreArt.Text))
                {
                    lblRespuestaError.Text = "Debe Ingresar un Nombre";
                    lblErrorArticulos.Visible = true;
                    sectionNuevoArticulo.Visible = true;
                    return;
                }
                if (string.IsNullOrWhiteSpace(tbPrecioArt.Text))
                {
                    lblRespuestaError.Text = "Debe ingresar un Precio";
                    lblErrorArticulos.Visible = true;
                    sectionNuevoArticulo.Visible = true;
                    return;
                } //falta validar si es solo numero
                
                if (string.IsNullOrWhiteSpace(tbStockArt.Text))
                {
                    lblRespuestaError.Text = "Debe ingresar un stock";
                    lblErrorArticulos.Visible = true;
                    sectionNuevoArticulo.Visible = true;
                    return;
                }
                if (!tbStockArt.Text.All(c => char.IsDigit(c) || char.IsNumber(c)))
                {
                    lblRespuestaError.Text = "El Stock esta mal Ingresado";
                    lblErrorArticulos.Visible = true;
                    sectionNuevoArticulo.Visible = true;
                    return;
                }

                decimal result = decimal.Parse(tbPrecioArt.Text);

                if (result < 0 || int.Parse(tbStockArt.Text) < 0)
                {
                    lblRespuestaError.Text = "El Precio/Stock no puede ser negativo";
                    lblErrorArticulos.Visible = true;
                    sectionNuevoArticulo.Visible = true;
                    return;
                }
                articulo.Id = Convert.ToInt32(tbIdArt.Text);
                articulo.Nombre = tbNombreArt.Text;
                articulo.Descripcion = tbDescripArt.Text;
                articulo.ImagenUrl = tbImgArt.Text;
                articulo.Precio = result;
                articulo.Marca = marca;
                articulo.Categoria = categoria;
                articulo.Estado = true;
                articulo.Stock = int.Parse(tbStockArt.Text);

                //guardo
                if (btnAgregar.Text == "Crear Articulo")
                {
                    if (NegocioArticulo.CrearArticulo(articulo) == 1)
                    {
                        Mensajes.Mensajes.MensajePopUp(this, "Articulo Creado Exitosamente");
                        CargarArticulos();
                    }
                }
                else if (btnAgregar.Text == "Guardar Cambios")
                {
                    if (NegocioArticulo.ModificarArticulo(articulo) == 1)
                    {
                        Mensajes.Mensajes.MensajePopUp(this, "Articulo Modificado Exitosamente");
                        CargarArticulos();
                    }
                }
                else
                {
                    Mensajes.Mensajes.MensajePopUp(this, "Hubo un error en la creacion/modificacion del articulo");
                } 
            }
            catch (Exception ex)
            {
                Session.Add("Error", ex);
                Response.Redirect("Error.aspx", false);
            }

        } //revisar validaciones

        
        protected void btnLinkVolverListaArticulos_Click(object sender, EventArgs e)
        {
            NegocioArticulo = new NegocioArticulo();
            dgvAdminArticulo.DataSource = NegocioArticulo.ListarArticulos();
            dgvAdminArticulo.DataBind();
            sectionAdminArticulos.Visible=true;
            dgvAdminArticulo.Visible = true;
            dgvAdminArticuloIndividual.Visible = false;
        }


        protected void btnEliminarArticulo_Click(object sender, EventArgs e)
        {
            try
            {
                int idMatch = int.Parse(tbIdArt.Text);
                NegocioArticulo = new NegocioArticulo();
                if (NegocioArticulo.EliminarArticulo(idMatch) > 0)
                {

                    Mensajes.Mensajes.MensajePopUp(this, "Articulo Eliminado");
                    CargarArticulos();
                }
                else
                {
                    Mensajes.Mensajes.MensajePopUp(this, "Hubo un error en la eliminacion del articulo");
                }
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }


        #endregion


        #region SUBMENU MARCAS

        protected void btnAgregarMarca_Click(object sender, EventArgs e)
        {
            panelAdminMarcas.Visible = false;
            sectionNuevaMarca.Visible = true;
        }

        protected void btnEliminarMarca_Click(object sender, EventArgs e)
        {
            //busco card
            NegocioMarca = new NegocioMarca();
            Button btn = (Button)sender;
            RepeaterItem repeaterItem = (RepeaterItem)btn.NamingContainer;
            var card = (HtmlGenericControl)repeaterItem.FindControl("cardMarca");
            
            //obtengo id y elimino
            var lblId = (Label)card.FindControl("lblIdMarca");
            NegocioMarca.EliminarMarca(Convert.ToInt32(lblId.Text));

            //vuelvo a cargar
            CargarMarcas();
        }

        protected void btnEditarMarca_Click(object sender, EventArgs e)
        {
            //busco card
            NegocioMarca = new NegocioMarca();
            Button btn = (Button)sender;
            RepeaterItem repeaterItem = (RepeaterItem)btn.NamingContainer;
            var card = (HtmlGenericControl)repeaterItem.FindControl("cardMarca");
            
            //obtengo datos
            var lblMarca = (Label)card.FindControl("lblMarca");
            var txtMarca = (TextBox)card.FindControl("txtMarca");
            var lblUrlMarca = (Label)card.FindControl("lblUrlMarca");
            var tbUrlImgMarca = (TextBox)card.FindControl("tbUrlImgMarca");

            //asigno el valor a los textbox
            txtMarca.Text = lblMarca.Text;
            tbUrlImgMarca.Text = lblUrlMarca.Text;

            //cambio vistas
            lblMarca.Visible = false;
            txtMarca.Visible = true;
            lblUrlMarca.Visible = false;
            tbUrlImgMarca.Visible = true;

            var btnGuardarMarca = (Button)card.FindControl("btnGuardarMarca");
            btnGuardarMarca.Visible = true;
            var btnEditarMarca = (Button)card.FindControl("btnEditarMarca");
            btnEditarMarca.Visible = false;
        }

        protected void btnGuardarMarca_Click(object sender, EventArgs e)
        {
            //busco card
            NegocioMarca = new NegocioMarca();
            Button btn = (Button)sender;
            RepeaterItem repeaterItem = (RepeaterItem)btn.NamingContainer;
            var card = (HtmlGenericControl)repeaterItem.FindControl("cardMarca");

            //obtengo datos
            var lblIdMarca = (Label)card.FindControl("lblIdMarca");
            var lblMarca = (Label)card.FindControl("lblMarca");
            var txtMarca = (TextBox)card.FindControl("txtMarca");
            var lblUrlMarca = (Label)card.FindControl("lblUrlMarca");
            var tbUrlImgMarca = (TextBox)card.FindControl("tbUrlImgMarca");

            
            if (string.IsNullOrWhiteSpace(lblIdMarca.Text) || string.IsNullOrWhiteSpace(txtMarca.Text) || string.IsNullOrWhiteSpace(tbUrlImgMarca.Text))
            {
                Mensajes.Mensajes.MensajePopUp(this, "Faltan completar campos");
                return;
            }
            else
            {
                //guardo
                marca = new Marca();
                NegocioMarca = new NegocioMarca();

                marca.Id = int.Parse(lblIdMarca.Text);
                marca.Descripcion = txtMarca.Text;
                marca.ImagenUrl = tbUrlImgMarca.Text;

                //modifico
                NegocioMarca.ModificarMarca(marca);
                Mensajes.Mensajes.MensajePopUp(this, "Marca modificada con exito!");
            }
            //asigno el valor a los label
            lblMarca.Text = txtMarca.Text;
            lblUrlMarca.Text = tbUrlImgMarca.Text;

            //cambio vistas
            lblMarca.Visible = true;
            txtMarca.Visible = false;
            lblUrlMarca.Visible = false;
            tbUrlImgMarca.Visible = false;

            var btnGuardarMarca = (Button)card.FindControl("btnGuardarMarca");
            btnGuardarMarca.Visible = false;
            var btnEditarMarca = (Button)card.FindControl("btnEditarMarca");
            btnEditarMarca.Visible = true;
        }

        protected void tbUrlImgNuevaMarca_TextChanged(object sender, EventArgs e)
        {
            imgNuevaMarca.ImageUrl = tbUrlImgNuevaMarca.Text;
        }

        protected void btnGuardarNewMarca_Click(object sender, EventArgs e)
        {
            marca = new Marca();
            NegocioMarca = new NegocioMarca();

            if (string.IsNullOrWhiteSpace(tbNombreMarca.Text) || string.IsNullOrWhiteSpace(tbUrlImgNuevaMarca.Text))
            {
                Mensajes.Mensajes.MensajePopUp(this, "Faltan completar campos");
                return;
            }
            else
            {
                marca.Descripcion = tbNombreMarca.Text;
                marca.ImagenUrl = tbUrlImgNuevaMarca.Text;

                NegocioMarca.CrearMarca(marca);
                Mensajes.Mensajes.MensajePopUp(this, "Nueva marca registrada con exito!");

                CargarMarcas();
            }
        }

        protected void btnVolverMarca_Click(object sender, EventArgs e)
        {
            CargarMarcas();
        }

        protected void tbUrlImgMarca_TextChanged(object sender, EventArgs e)
        {
            TextBox tbUrlImgMarca = (TextBox)sender;
            RepeaterItem repeaterItem = (RepeaterItem)tbUrlImgMarca.NamingContainer;
            System.Web.UI.WebControls.Image imgMarca = (Image)repeaterItem.FindControl("imgMarca");
            imgMarca.ImageUrl = tbUrlImgMarca.Text;
        }





        #endregion


        #region SUBMENU CATEGORIAS

        protected void btnAgregarCategoria_Click(object sender, EventArgs e)
        {
            panelAdminCategorias.Visible = false;
            sectionNuevaCategoria.Visible = true;
        }

        protected void btnEliminarCategoria_Click(object sender, EventArgs e)
        {
            //busco card
            NegocioCategoria = new NegocioCategoria();
            Button btn = (Button)sender;
            RepeaterItem repeaterItem = (RepeaterItem)btn.NamingContainer;
            var card = (HtmlGenericControl)repeaterItem.FindControl("cardCategoria");

            //obtengo id y elimino
            var lblId = (Label)card.FindControl("lblIdCategoria");
            NegocioCategoria.EliminarCategoria(Convert.ToInt32(lblId.Text));

            //vuelvo a cargar
            CargarCategorias();
        }

        protected void btnEditarCategoria_Click(object sender, EventArgs e)
        {
            //busco card
            NegocioCategoria = new NegocioCategoria();
            Button btn = (Button)sender;
            RepeaterItem repeaterItem = (RepeaterItem)btn.NamingContainer;
            var card = (HtmlGenericControl)repeaterItem.FindControl("cardCategoria");

            //obtengo datos
            var lblCategoria = (Label)card.FindControl("lblCategoria");
            var txtCategoria = (TextBox)card.FindControl("txtCategoria");
            var lblUrlCategoria = (Label)card.FindControl("lblUrlCategoria");
            var tbUrlImgCategoria = (TextBox)card.FindControl("tbUrlImgCategoria");

            //asigno el valor a los textbox
            txtCategoria.Text = lblCategoria.Text;
            tbUrlImgCategoria.Text = lblUrlCategoria.Text;

            //cambio vistas
            lblCategoria.Visible = false;
            txtCategoria.Visible = true;
            lblUrlCategoria.Visible = false;
            tbUrlImgCategoria.Visible = true;

            var btnGuardarCategoria = (Button)card.FindControl("btnGuardarCategoria");
            btnGuardarCategoria.Visible = true;
            var btnEditarCategoria = (Button)card.FindControl("btnEditarCategoria");
            btnEditarCategoria.Visible = false;
        }

        protected void btnGuardarCategoria_Click(object sender, EventArgs e)
        {
            //busco card
            NegocioCategoria = new NegocioCategoria();
            Button btn = (Button)sender;
            RepeaterItem repeaterItem = (RepeaterItem)btn.NamingContainer;
            var card = (HtmlGenericControl)repeaterItem.FindControl("cardCategoria");

            //obtengo datos
            var lblIdCategoria = (Label)card.FindControl("lblIdCategoria");
            var lblCategoria = (Label)card.FindControl("lblCategoria");
            var txtCategoria = (TextBox)card.FindControl("txtCategoria");
            var lblUrlCategoria = (Label)card.FindControl("lblUrlCategoria");
            var tbUrlImgCategoria = (TextBox)card.FindControl("tbUrlImgCategoria");


            if (string.IsNullOrWhiteSpace(lblIdCategoria.Text) || string.IsNullOrWhiteSpace(txtCategoria.Text) || string.IsNullOrWhiteSpace(tbUrlImgCategoria.Text))
            {
                Mensajes.Mensajes.MensajePopUp(this, "Faltan completar campos");
                return;
            }
            else
            {
                //guardo
                categoria = new Categoria();
                NegocioCategoria = new NegocioCategoria();

                categoria.Id = int.Parse(lblIdCategoria.Text);
                categoria.Descripcion = txtCategoria.Text;
                categoria.ImagenUrl = tbUrlImgCategoria.Text;

                //modifico
                NegocioCategoria.ModificarCategoria(categoria);
                Mensajes.Mensajes.MensajePopUp(this, "Categoria modificada con exito!");
            }
            //asigno el valor a los label
            lblCategoria.Text = txtCategoria.Text;
            lblUrlCategoria.Text = tbUrlImgCategoria.Text;

            //cambio vistas
            lblCategoria.Visible = true;
            txtCategoria.Visible = false;
            lblUrlCategoria.Visible = false;
            tbUrlImgCategoria.Visible = false;

            var btnGuardarCategoria = (Button)card.FindControl("btnGuardarCategoria");
            btnGuardarCategoria.Visible = false;
            var btnEditarCategoria = (Button)card.FindControl("btnEditarCategoria");
            btnEditarCategoria.Visible = true;
        }

        protected void tbUrlImgNuevaCategoria_TextChanged(object sender, EventArgs e)
        {
            imgNuevaCate.ImageUrl = tbUrlImgCate.Text;
        }

        protected void btnGuardarNewCategoria_Click(object sender, EventArgs e)
        {
            categoria = new Categoria();
            NegocioCategoria = new NegocioCategoria();

            if (string.IsNullOrWhiteSpace(tbNombreCate.Text) || string.IsNullOrWhiteSpace(tbUrlImgCate.Text))
            {
                Mensajes.Mensajes.MensajePopUp(this, "Faltan completar campos");
                return;
            }
            else
            {
                categoria.Descripcion = tbNombreCate.Text;
                categoria.ImagenUrl = tbUrlImgCate.Text;

                NegocioCategoria.CrearCategoria(categoria);
                Mensajes.Mensajes.MensajePopUp(this, "Nueva categoria registrada con exito!");

                CargarCategorias();
            }
        }

        protected void volverCategoria_Click(object sender, EventArgs e)
        {
            CargarCategorias();
        }

        protected void tbUrlImgCate_TextChanged(object sender, EventArgs e)
        {
            TextBox tbUrlImgCategoria = (TextBox)sender;
            RepeaterItem repeaterItem = (RepeaterItem)tbUrlImgCategoria.NamingContainer;
            System.Web.UI.WebControls.Image imgCategoria = (Image)repeaterItem.FindControl("imgCategoria");
            imgCategoria.ImageUrl = tbUrlImgCategoria.Text;
        }

        #endregion


        #region SUBMENU USUARIOS

        //submenu usuarios

        private void CargarUsuarioEditar(int id)
        {
            NegocioUsuario = new NegocioUsuario();
            usuario = NegocioUsuario.ListarUsuarios(id);
            txtNombre.Text = usuario.Nombre;
            txtApellido.Text = usuario.Apellido;
            txtEmail.Text = usuario.Mail;
            txtClave.Text = usuario.Clave;
            txtDni.Text = usuario.Dni.ToString();
            txtDomicilio.Text = usuario.Direccion;
            ddlTipoUsuario.SelectedValue = usuario.Nivel.ToString();
            txtId.Text = usuario.Id.ToString();
        }

        protected void btnFiltrarEstadoUsuarios_Click(object sender, EventArgs e)
        {
            try
            {
                NegocioUsuario = new NegocioUsuario();
                Usuarios = NegocioUsuario.ListarUsuarios();

                string estado = ((Button)sender).CommandName;
                if (estado == "ACTIVO")
                    Usuarios = Usuarios.Where(itm => itm.Activo).ToList();
                else if (estado == "INACTIVO")
                    Usuarios = Usuarios.Where(itm => !itm.Activo).ToList();

                dgvAdminUsuario.DataSource = Usuarios;
                dgvAdminUsuario.DataBind();
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void btnFiltrarUsuarios_Click(object sender, EventArgs e)
        {
            try
            {
                NegocioUsuario = new NegocioUsuario();
                Usuarios = NegocioUsuario.ListarUsuarios();

                int idUsuario = string.IsNullOrWhiteSpace(txtIdFiltro_Usuario.Text) ? 0 : Convert.ToInt32(txtIdFiltro_Usuario.Text);
                int dni = string.IsNullOrWhiteSpace(txtDNIFiltro_Usuario.Text) ? 0 : Convert.ToInt32(txtDNIFiltro_Usuario.Text);
                string nombre = string.IsNullOrWhiteSpace(txtNombreFiltro_Usuario.Text) ? string.Empty : txtNombreFiltro_Usuario.Text;
                string apellido = string.IsNullOrWhiteSpace(txtApellidoFiltro_Usuario.Text) ? string.Empty : txtApellidoFiltro_Usuario.Text;

                if (idUsuario != 0)
                    Usuarios.RemoveAll(itm => itm.Id != idUsuario);
                if (dni != 0)
                    Usuarios.RemoveAll(itm => itm.Dni != dni);
                if (nombre != string.Empty)
                    Usuarios.RemoveAll(itm => itm.Nombre.ToUpperInvariant() != nombre.ToUpperInvariant());
                if (apellido != string.Empty)
                    Usuarios.RemoveAll(itm => itm.Apellido.ToUpperInvariant() != apellido.ToUpperInvariant());

                dgvAdminUsuario.DataSource = Usuarios;
                dgvAdminUsuario.DataBind();
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }
        
        protected void btnLimpiarFiltrosUsuarios_Click(object sender, EventArgs e)
        {
            try
            {
                CargarUsuarios();
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void ibtEditarUsuario_Click(object sender, EventArgs e)
        {
            sectionModificarUsuario.Visible = true;
            dgvAdminUsuario.Visible = false;
            CargarUsuarioEditar(int.Parse((sender as ImageButton).CommandArgument));
            btnAltaUsuario.Visible = true;
            btnBajaUsuario.Visible = true;
            btnEliminarUsuario.Visible = true;
            filtrosUsuarios.Visible = false;
        }

        protected void btnCambiarEstadoUsuario_Click(object sender, EventArgs e)
        {
            NegocioUsuario = new NegocioUsuario();
            int id = int.Parse(((Button)sender).CommandArgument);

            string estado = ((Button)sender).CommandName;
            if (estado == "ALTA")
                NegocioUsuario.AltaUsuario(id);
            else if (estado == "BAJA")
                NegocioUsuario.BajaUsuario(id);

            Usuarios = NegocioUsuario.ListarUsuarios();
            dgvAdminUsuario.DataSource = Usuarios;
            dgvAdminUsuario.DataBind();
        }

        protected void btnEliminarUsuario_Click(object sender, EventArgs e)
        {
            usuario = new Usuario();
            NegocioUsuario = new NegocioUsuario();
            usuario.Id = int.Parse(txtId.Text);
            NegocioUsuario.EliminarUsuario(usuario.Id);
            CargarUsuarios();
        }

        protected void btnGuardarUsuario_Click(object sender, EventArgs e)
        {
            try
            {
                //validaciones
                if (Page.IsValid)
                {
                    if (string.IsNullOrEmpty(txtNombre.Text) || string.IsNullOrEmpty(txtApellido.Text) || string.IsNullOrEmpty(txtDni.Text) || string.IsNullOrEmpty(txtEmail.Text) || string.IsNullOrEmpty(txtClave.Text) || string.IsNullOrEmpty(txtDomicilio.Text))
                    {
                        Mensajes.Mensajes.MensajePopUp(this, "Hay campos erróneos o vacíos");
                        return;
                    }

                    //asigno a usuario
                    usuario = new Usuario();
                    usuario.Nombre = txtNombre.Text;
                    usuario.Apellido = txtApellido.Text;
                    usuario.Mail = txtEmail.Text;
                    usuario.Clave = txtClave.Text;
                    usuario.Dni = int.Parse(txtDni.Text);
                    usuario.Direccion = txtDomicilio.Text;
                    usuario.UrlImgUsuario = "img/usuarios/default.png";
                    usuario.Nivel = ddlTipoUsuario.SelectedValue.ToString();
                    usuario.Activo = true;
                    NegocioUsuario = new NegocioUsuario();

                    //agregar
                    int res = 0;
                    if (btnGuardarUsuario.Text == "Agregar Usuario")
                    {
                        btnGuardarUsuario.Text = "Guardar Cambios";
                        NegocioUsuario.CrearUsuario(usuario);
                        Mensajes.Mensajes.MensajePopUp(this, "Usuario Agregado Exitosamente");
                        res++;
                    }
                    //modificar
                    else if (btnGuardarUsuario.Text == "Guardar Cambios")
                    {
                        NegocioUsuario.ModificarUsuario(usuario);
                        Mensajes.Mensajes.MensajePopUp(this, "Registro Modificado Exitosamente");
                        res++;
                    }

                    if (res == 0)
                        Mensajes.Mensajes.MensajePopUp(this, "Ocurrio un Error Inesperado"); // va a tirar dos msj si no guarda, mejorar para manejar el error

                    //recargo
                    Usuarios = NegocioUsuario.ListarUsuarios();
                    dgvAdminUsuario.DataSource = Usuarios;
                    dgvAdminUsuario.DataBind();
                    dgvAdminUsuario.Visible = true;
                    sectionModificarUsuario.Visible = false;
                    CargarUsuarios();
                }
                else
                {
                    Mensajes.Mensajes.MensajePopUp(this, "Hubo error en una validación");
                }
            }
            catch (Exception ex)
            {
                Session.Add("Error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        protected void lnkVolverListaUsuarios_Click(object sender, EventArgs e)
        {
            dgvAdminUsuario.Visible = true;
            sectionModificarUsuario.Visible = false;
            CargarUsuarios();
            
        }


        #endregion






    }
}