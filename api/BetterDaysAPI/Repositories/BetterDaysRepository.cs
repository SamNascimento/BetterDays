using BetterDaysAPI.Models;

namespace BetterDaysAPI.Repositories
{
    public class BetterDaysRepository
    {
        private readonly string _conn;
        private readonly EFEntities _ef;

        public BetterDaysRepository(IConfiguration configuration)
        {
            _conn = configuration.GetValue<string>("connection");
            _ef = new EFEntities(_conn);
        }

        public IEnumerable<Diario> ObterAnotacoesDiario(long idUsuario)
        {
            var anotacoes = _ef.Diario
                .Where(d => d.idUsuario == idUsuario)
                .OrderByDescending(d => d.dataRegistro);

            return anotacoes;
        }
    }
}