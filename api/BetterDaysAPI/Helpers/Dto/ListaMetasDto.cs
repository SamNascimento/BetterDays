using BetterDaysAPI.Models;

namespace BetterDaysAPI.Helpers.Dto
{
    public class ListaMetasDto
    {
        public long idMetas { get; set; }
        public long idUsuario { get; set; }
        public DateTime dataRegistro { get; set; }
        public string titulo { get; set; }
        public string descricao { get; set; }
        public bool isConcluido { get; set; }

        public ListaMetasDto(ListaMetas metas)
        {
            idMetas      = metas.idMetas;
            idUsuario    = metas.idUsuario;
            dataRegistro = metas.dataRegistro;
            titulo       = metas.titulo;
            descricao    = metas.descricao;
            isConcluido  = metas.isConcluido;
        }
    }
}
