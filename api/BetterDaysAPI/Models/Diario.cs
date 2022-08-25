namespace BetterDaysAPI.Models
{
    public class Diario
    {
        public long idDiario { get; set; }
        public long idUsuario { get; set; }
        public DateTime dataRegistro { get; set; }
        public string titulo { get; set; }
        public string nota { get; set; }

        public virtual Usuario Usuario { get; set; }
    }
}