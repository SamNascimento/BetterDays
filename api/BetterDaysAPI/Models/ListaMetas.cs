namespace BetterDaysAPI.Models
{
    public class ListaMetas
    {
        public long idMetas { get; set; }
        public long idUsuario { get; set; }
        public DateTime dataRegistro { get; set; }
        public string titulo { get; set; }
        public string descricao { get; set; }
        public bool isConcluido { get; set; }

        public virtual Usuario Usuario { get; set; }
    }
}