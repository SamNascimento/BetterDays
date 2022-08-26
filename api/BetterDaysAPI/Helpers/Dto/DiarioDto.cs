using BetterDaysAPI.Models;

namespace BetterDaysAPI.Helpers.Dto
{
    public class DiarioDto
    {
        public long idDiario { get; set; }
        public long idUsuario { get; set; }
        public DateTime dataRegistro { get; set; }
        public string titulo { get; set; }
        public string nota { get; set; }

        public DiarioDto(Diario diario)
        {
            idDiario     = diario.idDiario;
            idUsuario    = diario.idUsuario;
            dataRegistro = diario.dataRegistro;
            titulo       = diario.titulo;
            nota         = diario.nota;
        }
    }
}
