using BetterDaysAPI.Helpers.Post;
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

        #region Usuário

        public Usuario ObterUsuarioPorId(long idUsuario)
        {
            var usuario = _ef.Usuario
                .FirstOrDefault(u => u.idUsuario == idUsuario);

            if (usuario == null)
            {
                throw new Exception("Usuário não existe");
            }

            return usuario;
        }

        public Usuario LogarUsuario(UsuarioPost dados)
        {
            var usuario = _ef.Usuario
                .FirstOrDefault(u => u.loginUsuario == dados.loginUsuario && u.senhaUsuario == dados.senhaUsuario);

            if (usuario == null)
                throw new Exception("Login não encontrado");

            return usuario;
        }
        
        public Usuario CadastrarUsuario(UsuarioPost dados)
        {
            if (dados.nome == null)
                throw new Exception("Todos os dados são necessários");

            var loginExistente = _ef.Usuario.FirstOrDefault(u => u.loginUsuario == dados.loginUsuario);

            var temLoginUnico = loginExistente == null;

            if (!temLoginUnico)
                throw new Exception("Nome de usuário já está em uso");

            var usuario = new Usuario
            {
                nome         = dados.nome,
                loginUsuario = dados.loginUsuario,
                senhaUsuario = dados.senhaUsuario
            };

            _ef.Usuario.Add(usuario);
            _ef.SaveChanges();

            return usuario;
        }

        #endregion

        #region Diário

        public Diario ObterAnotacaoDiarioPorId(long idDiario)
        {
            var anotacao = _ef.Diario
                .FirstOrDefault(d => d.idDiario == idDiario);

            if (anotacao == null)
                throw new Exception("Anotação não encontrada");

            return anotacao;
        }

        public IEnumerable<Diario> ObterAnotacoesDiario(long idUsuario)
        {
            var anotacoes = _ef.Diario
                .Where(d => d.idUsuario == idUsuario)
                .OrderByDescending(d => d.dataRegistro);

            return anotacoes;
        }

        public Diario CriarAnotacaoDiario(DiarioPost dados)
        {
            if (dados.idUsuario == null || dados.titulo == null || dados.nota == null)
                throw new Exception("Todos os dados são necessário");

            var usuario = ObterUsuarioPorId(dados.idUsuario.GetValueOrDefault());

            var anotacao = new Diario
            {
                Usuario      = usuario,
                dataRegistro = DateTime.Now,
                titulo       = dados.titulo,
                nota         = dados.nota
            };

            _ef.Diario.Add(anotacao);
            _ef.SaveChanges();

            return anotacao;
        }

        public Diario EditarAnotacaoDiario(DiarioPost dados, long idDiario)
        {
            var anotacao = ObterAnotacaoDiarioPorId(idDiario);

            anotacao.titulo = dados.titulo;
            anotacao.nota   = dados.nota;

            _ef.Diario.Update(anotacao);
            _ef.SaveChanges();

            return anotacao;
        }

        public void ExcluirAnotacaoDiario(long idDiario)
        {
            var anotacao = ObterAnotacaoDiarioPorId(idDiario);

            _ef.Diario.Remove(anotacao);
            _ef.SaveChanges();
        }

        #endregion

        #region Lista de Metas

        public ListaMetas ObterMetaPorId(long idMeta)
        {
            var meta = _ef.ListaMetas
                .FirstOrDefault(d => d.idMetas == idMeta);

            if (meta == null)
                throw new Exception("Meta não encontrada");

            return meta;
        }

        public IEnumerable<ListaMetas> ObterListaMetas(long idUsuario)
        {
            var metas = _ef.ListaMetas
                .Where(d => d.idUsuario == idUsuario)
                .OrderByDescending(d => d.dataRegistro);

            return metas;
        }

        public ListaMetas CriarMeta(MetaPost dados)
        {
            if (dados.idUsuario == null || dados.titulo == null || dados.descricao == null)
                throw new Exception("Todos os dados são necessário");

            var usuario = ObterUsuarioPorId(dados.idUsuario.GetValueOrDefault());

            var meta = new ListaMetas
            {
                Usuario      = usuario,
                dataRegistro = DateTime.Now,
                titulo       = dados.titulo,
                descricao    = dados.descricao,
                isConcluido  = false
            };

            _ef.ListaMetas.Add(meta);
            _ef.SaveChanges();

            return meta;
        }

        public ListaMetas EditarMeta (MetaPost dados, long idMeta)
        {
            var meta = ObterMetaPorId(idMeta);

            meta.titulo    = dados.titulo;
            meta.descricao = dados.descricao;

            _ef.ListaMetas.Update(meta);
            _ef.SaveChanges();

            return meta;
        }

        public ListaMetas AlterarEstadoConclusao (long idMeta)
        {
            var meta = ObterMetaPorId(idMeta);

            if (meta.isConcluido == false)
                meta.isConcluido = true;
            else 
                meta.isConcluido = false;

            _ef.ListaMetas.Update(meta);
            _ef.SaveChanges();

            return meta;
        }

        public void ExcluirMeta(long idMeta)
        {
            var meta = ObterMetaPorId(idMeta);

            _ef.ListaMetas.Remove(meta);
            _ef.SaveChanges();
        }

        #endregion
    }
}