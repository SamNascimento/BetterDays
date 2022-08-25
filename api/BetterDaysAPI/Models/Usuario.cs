namespace BetterDaysAPI.Models
{
    public class Usuario 
    {
        public long idUsuario { get; set; }
        public string nome { get; set; } = "";
        public string loginUsuario { get; set; } = "";
        public string senhaUsuario { get; set; } = "";

        public virtual IEnumerable<Diario> Diarios { get; set; }
        public virtual IEnumerable<ListaMetas> ListaMetas { get; set; }
    }
}