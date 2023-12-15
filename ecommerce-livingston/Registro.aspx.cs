using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Negocio;
using Dominio;
using Mensajes;

namespace ecommerce_livingston
{
    public partial class Registro : System.Web.UI.Page
    {
        NegocioUsuario NegocioUsuario;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                btnRegistroUsu.Enabled = true;
            }
        }

        protected void btnRegistroUsu_Click(object sender, EventArgs e)
        {
            try
            {
                if (Page.IsValid)
                {
                    //valido
                    if (string.IsNullOrEmpty(txtNombre.Text) ||
                        string.IsNullOrEmpty(txtApellido.Text) ||
                        string.IsNullOrEmpty(txtDni.Text) ||
                        string.IsNullOrEmpty(txtMail.Text) ||
                        string.IsNullOrEmpty(txtPassword.Text) ||
                        string.IsNullOrEmpty(txtDomicilio.Text) ||
                        !txtDni.Text.All(char.IsDigit) && !txtDni.Text.All(char.IsNumber) ||
                        !txtNombre.Text.All(char.IsLetter) ||
                        !txtApellido.Text.All(char.IsLetter) ||
                        !txtMail.Text.Contains("@") ||
                        !txtMail.Text.Contains("."))

                    {
                        Mensajes.Mensajes.MensajePopUp(this, "Hay campos erróneos o vacíos");
                        return;
                    }

                    //cargo usuario
                    Usuario usuario = new Usuario();
                    usuario.Nombre = txtNombre.Text;
                    usuario.Apellido = txtApellido.Text;
                    usuario.Dni = int.Parse(txtDni.Text);
                    usuario.Mail = txtMail.Text;
                    usuario.Clave = txtPassword.Text;
                    usuario.Direccion = txtDomicilio.Text;
                    usuario.Nivel = "C";
                    usuario.UrlImgUsuario = "img/usuarios/default.png";
                    usuario.Activo = true;

                    //creo usuario
                    NegocioUsuario = new NegocioUsuario();
                    int res = NegocioUsuario.CrearUsuario(usuario);

                    if (res > 0)
                    {
                        Mensajes.Mensajes.MensajePopUp(this, "Usuario Registrado Exitosamente");

                    }
                    else
                    {
                        Mensajes.Mensajes.MensajePopUp(this, "No se pudo crear el usuario");
                    }

                    Session.Add("usuarioActual", usuario);
                    Session.Add("mensajeEnMaster", $"Bienvenido {usuario.Nombre}!");

                    //vuelve a compra o a inicio
                    if (Request.QueryString["text"] == "registroCompra")
                    {
                        Response.Redirect("Carrito.aspx?text=ok", false);
                    }
                    else
                    {
                        Response.Redirect("Default.aspx", false);
                    }
                }
                else
                {
                    Mensajes.Mensajes.MensajePopUp(this, "Hubo error en una validación");
                    return;
                }
            }
            catch (Exception ex)
            {
                Session.Add("Error", ex);
                Response.Redirect("Error.aspx", false);
            }
        }

        #region Validaciones
        protected void customValidatorNombre_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string nombre = txtNombre.Text;
            bool isValid = !string.IsNullOrWhiteSpace(nombre) && System.Text.RegularExpressions.Regex.IsMatch(nombre, "^[A-Za-z\\s]+$");
            args.IsValid = isValid;
            customValidatorNombre.ErrorMessage = "El nombre debe contener solo letras y espacios.";
            customValidatorNombre.Visible = false;
        }
        protected void customValidatorApellido_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string apellido = txtApellido.Text;
            bool isValid = !string.IsNullOrWhiteSpace(apellido) && System.Text.RegularExpressions.Regex.IsMatch(apellido, "^[A-Za-z\\s]+$");
            args.IsValid = isValid;
            customValidatorApellido.ErrorMessage = "El apellido es obligatorio solo se permiten letras.";
            customValidatorApellido.Visible = false;
        }

        protected void customValidatorDocumento_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string dni = txtDni.Text;
            bool isValid = !string.IsNullOrWhiteSpace(dni) && System.Text.RegularExpressions.Regex.IsMatch(dni, @"^\d+$"); /*Para que solo acepte 8 digitos  @"^\d{8}$"  */
            args.IsValid = isValid;
            customValidatorDocumento.ErrorMessage = "El DNI solo debe tener números";
            customValidatorDocumento.Visible = false;
        }

        protected void customValidatorMail_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string mail = txtMail.Text;
            bool isValid = !string.IsNullOrWhiteSpace(mail) && System.Text.RegularExpressions.Regex.IsMatch(mail, @"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$");
            args.IsValid = isValid;
            customValidatorMail.ErrorMessage = "Ingrese un mail correcto";
            customValidatorMail.Visible = false;
        }

        protected void customValidatorDomicilio_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string domicilio = txtDomicilio.Text;
            bool isValid = !string.IsNullOrWhiteSpace(domicilio) && System.Text.RegularExpressions.Regex.IsMatch(domicilio, "^[A-Za-z0-9\\s.,-]+$");
            args.IsValid = isValid;
            customValidatorDomicilio.ErrorMessage = "Ingrese un domicilio válido";
            customValidatorDomicilio.Visible = false;
        }

        protected void customValidatorPassword_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string password = txtPassword.Text;
            bool isValid = !string.IsNullOrWhiteSpace(password) && System.Text.RegularExpressions.Regex.IsMatch(password, "^(?=.*[A-Za-z])(?=.*\\d).+$");
            args.IsValid = isValid;
            customValidatorPassword.ErrorMessage = "La clave debe contener al menos un número y letra";
            customValidatorPassword.Visible = false;

        }
        #endregion Validaciones

    }

}