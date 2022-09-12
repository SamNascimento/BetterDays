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

        #region usuário

        /// <summary>
        /// Obtém os dados de um usuário por um ID
        /// </summary>
        /// <param name="idUsuario"></param>
        /// <returns></returns>
        public Usuario ObterUsuarioPorId(long idUsuario)
        {
            var usuario = _ef.Usuario
                .FirstOrDefault(u => u.idUsuario == idUsuario);

            if (usuario == null)
            {
                throw new Exception("usuário não existe");
            }

            return usuario;
        }
        
        /// <summary>
        /// Loga-se com um usuário caso as credenciais estejam certas
        /// </summary>
        /// <param name="dados"></param>
        /// <returns></returns>
        public Usuario LogarUsuario(UsuarioPost dados)
        {
            var usuario = _ef.Usuario
                .FirstOrDefault(u => u.loginUsuario == dados.loginUsuario && u.senhaUsuario == dados.senhaUsuario);

            if (usuario == null)
                throw new Exception("Login não encontrado");

            return usuario;
        }
        
        /// <summary>
        /// Cadastra um usuário através da lista de cadastro
        /// </summary>
        /// <param name="dados"></param>
        /// <returns></returns>
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

        /// <summary>
        /// Obtém os detalhes de uma única anotação
        /// </summary>
        /// <param name="idDiario"></param>
        /// <returns></returns>
        public Diario ObterAnotacaoDiarioPorId(long idDiario)
        {
            var anotacao = _ef.Diario
                .FirstOrDefault(d => d.idDiario == idDiario);

            if (anotacao == null)
                throw new Exception("Anotação não encontrada");

            return anotacao;
        }

        /// <summary>
        /// Obtém as anotações de um usuário
        /// </summary>
        /// <param name="idUsuario"></param>
        /// <returns></returns>
        public IEnumerable<Diario> ObterAnotacoesDiario(long idUsuario)
        {
            var anotacoes = _ef.Diario
                .Where(d => d.idUsuario == idUsuario)
                .OrderByDescending(d => d.dataRegistro);

            return anotacoes;
        }

        /// <summary>
        /// Cria uma anotação no diário do usuário em questão
        /// </summary>
        /// <param name="dados"></param>
        /// <returns></returns>
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

        /// <summary>
        /// Edita o registro de uma anotação específica
        /// </summary>
        /// <param name="dados"></param>
        /// <param name="idDiario"></param>
        /// <returns></returns>
        public Diario EditarAnotacaoDiario(DiarioPost dados, long idDiario)
        {
            var anotacao = ObterAnotacaoDiarioPorId(idDiario);

            anotacao.titulo = dados.titulo;
            anotacao.nota   = dados.nota;

            _ef.Diario.Update(anotacao);
            _ef.SaveChanges();

            return anotacao;
        }

        /// <summary>
        /// Exclui o registro no banco daquela anotação
        /// </summary>
        /// <param name="idDiario"></param>
        public void ExcluirAnotacaoDiario(long idDiario)
        {
            var anotacao = ObterAnotacaoDiarioPorId(idDiario);

            _ef.Diario.Remove(anotacao);
            _ef.SaveChanges();
        }

        #endregion

        #region Lista de Metas

        /// <summary>
        /// Obtém os detalhes de uma única meta
        /// </summary>
        /// <param name="idMeta"></param>
        /// <returns></returns>
        public ListaMetas ObterMetaPorId(long idMeta)
        {
            var meta = _ef.ListaMetas
                .FirstOrDefault(d => d.idMetas == idMeta);

            if (meta == null)
                throw new Exception("Meta não encontrada");

            return meta;
        }
        
        /// <summary>
        /// Obtém as metas de um usuário
        /// </summary>
        /// <param name="idUsuario"></param>
        /// <returns></returns>
        public IEnumerable<ListaMetas> ObterListaMetas(long idUsuario)
        {
            var metas = _ef.ListaMetas
                .Where(d => d.idUsuario == idUsuario)
                .OrderByDescending(d => d.dataRegistro);

            return metas;
        }

        /// <summary>
        /// Cria uma meta para o usuário em questão
        /// </summary>
        /// <param name="dados"></param>
        /// <returns></returns>
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

        /// <summary>
        /// Edita o registro de uma meta específica
        /// </summary>
        /// <param name="dados"></param>
        /// <param name="idMeta"></param>
        /// <returns></returns>
        public ListaMetas EditarMeta (MetaPost dados, long idMeta)
        {
            var meta = ObterMetaPorId(idMeta);

            meta.titulo    = dados.titulo;
            meta.descricao = dados.descricao;

            _ef.ListaMetas.Update(meta);
            _ef.SaveChanges();

            return meta;
        }

        /// <summary>
        /// Troca o status de conclusão de uma meta
        /// </summary>
        /// <param name="idMeta"></param>
        /// <returns></returns>
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

        /// <summary>
        /// Exclui o registro no banco daquela emta
        /// </summary>
        /// <param name="idMeta"></param>
        public void ExcluirMeta(long idMeta)
        {
            var meta = ObterMetaPorId(idMeta);

            _ef.ListaMetas.Remove(meta);
            _ef.SaveChanges();
        }

        #endregion
    }
}