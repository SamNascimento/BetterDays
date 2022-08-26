using BetterDaysAPI.Models;

namespace BetterDaysAPI.Helpers.Dto
{
    public class UsuarioDto
    {
        public long idUsuario { get; set; }
        public string nome { get; set; } = "";
        public string loginUsuario { get; set; } = "";

        public UsuarioDto(Usuario usuario)
        {
            idUsuario    = usuario.idUsuario;
            nome         = usuario.nome;
            loginUsuario = usuario.loginUsuario;
        }

    }
}
