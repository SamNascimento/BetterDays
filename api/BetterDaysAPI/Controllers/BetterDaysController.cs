using BetterDaysAPI.Helpers.Dto;
using BetterDaysAPI.Helpers.Post;
using BetterDaysAPI.Models;
using BetterDaysAPI.Repositories;
using Microsoft.AspNetCore.Mvc;

namespace BetterDaysAPI.Controllers
{
    [ApiController]
    [Route("api")]
    public class BetterDaysController : ControllerBase 
    {
        protected readonly IConfiguration _conf;
        public BetterDaysController(IConfiguration configuration)
        {
            _conf = configuration;
        }

        #region Usuário

        /// <summary>
        /// Cadastra um usuário através da lista de cadastro
        /// </summary>
        /// <param name="dados"></param>
        /// <returns></returns>
        [HttpPost("usuario/cadastrar")]
        public IActionResult CadastrarUsuario(UsuarioPost dados)
        {
            var rep = new BetterDaysRepository(_conf);

            var usuario = rep.CadastrarUsuario(dados);

            var dto = new UsuarioDto(usuario);

            return Ok(dto);
        }

        /// <summary>
        /// Loga-se com um usuário caso as credenciais estejam certas
        /// </summary>
        /// <param name="dados"></param>
        /// <returns></returns>
        [HttpPost("usuario/logar")]
        public IActionResult LogarUsuario(UsuarioPost dados)
        {
            var rep = new BetterDaysRepository(_conf);

            var usuario = rep.LogarUsuario(dados);

            var dto = new UsuarioDto(usuario);

            return Ok(dto);
        }

        #endregion

        #region Diário

        /// <summary>
        /// Obtém os detalhes de uma única anotação
        /// </summary>
        /// <param name="idDiario"></param>
        /// <returns></returns>
        [HttpGet("diario/{idDiario:long}/anotacao")]
        public IActionResult ObterAnotacaoDiario(long idDiario)
        {
            var rep = new BetterDaysRepository(_conf);

            var anotacao = rep.ObterAnotacaoDiarioPorId(idDiario);

            var dto = new DiarioDto(anotacao);

            return Ok(dto);
        }

        /// <summary>
        /// Obtém as anotações de um usuário
        /// </summary>
        /// <param name="idUsuario">Id do usuário logado</param>
        /// <returns></returns>
        [HttpGet("diario/usuario/{idUsuario:long}")]
        public IActionResult ObterAnotacoesDiario(long idUsuario)
        {
            var rep = new BetterDaysRepository(_conf);

            var anotacoesDiario = rep.ObterAnotacoesDiario(idUsuario);

            var dto = anotacoesDiario.Select(a => new DiarioDto(a));

            return Ok(dto);
        }

        /// <summary>
        /// Cria uma anotação no diário do usuário em questão
        /// </summary>
        /// <param name="dados"></param>
        /// <returns></returns>
        [HttpPost("diario")]
        public IActionResult CriarAnotacao(DiarioPost dados)
        {
            var rep = new BetterDaysRepository(_conf);

            var anotacao = rep.CriarAnotacaoDiario(dados);

            var dto = new DiarioDto(anotacao);

            return Ok(dto);
        }

        /// <summary>
        /// Edita o registro de uma anotação específica
        /// </summary>
        /// <param name="dados"> Dados que serão passados para edição </param>
        /// <param name="idDiario"> Id da anotação que será editada </param>
        /// <returns></returns>
        [HttpPost("diario/editar/{idDiario:long}")]
        public IActionResult EditarAnotacao(DiarioPost dados, long idDiario)
        {
            var rep = new BetterDaysRepository(_conf);

            var anotacao = rep.EditarAnotacaoDiario(dados, idDiario);

            var dto = new DiarioDto(anotacao);

            return Ok(dto);
        }

        /// <summary>
        /// Exclui o registro no banco daquela anotação
        /// </summary>
        /// <param name="idDiario"></param>
        /// <returns></returns>
        [HttpDelete("diario/deletar/{idDiario:long}")]
        public IActionResult DeletarAnotacao(long idDiario)
        {
            var rep = new BetterDaysRepository(_conf);

            rep.ExcluirAnotacaoDiario(idDiario);

            return Ok();
        }

        #endregion

        #region Lista de Metas

        /// <summary>
        /// Obtém os detalhes de uma única meta
        /// </summary>
        /// <param name="idMeta"></param>
        /// <returns></returns>
        [HttpGet("meta/{idMeta:long}")]
        public IActionResult ObterMeta(long idMeta)
        {
            var rep = new BetterDaysRepository(_conf);

            var meta = rep.ObterMetaPorId(idMeta);

            var dto = new ListaMetasDto(meta);

            return Ok(dto);
        }

        /// <summary>
        /// Obtém as metas de um usuário
        /// </summary>
        /// <param name="idUsuario">Id do usuário logado</param>
        /// <returns></returns>
        [HttpGet("meta/usuario/{idUsuario:long}")]
        public IActionResult ObterListaMetas(long idUsuario)
        {
            var rep = new BetterDaysRepository(_conf);

            var listaMetas = rep.ObterListaMetas(idUsuario);

            var dto = listaMetas.Select(l => new ListaMetasDto(l));

            return Ok(dto);
        }

        /// <summary>
        /// Cria uma meta para o usuário em questão
        /// </summary>
        /// <param name="dados"></param>
        /// <returns></returns>
        [HttpPost("meta")]
        public IActionResult CriarMeta(MetaPost dados)
        {
            var rep = new BetterDaysRepository(_conf);

            var meta = rep.CriarMeta(dados);

            var dto = new ListaMetasDto(meta);

            return Ok(dto);
        }

        /// <summary>
        /// Edita o registro de uma meta específica
        /// </summary>
        /// <param name="dados"> Dados que serão repassados para edição </param>
        /// <param name="idMeta"> Id da meta editada </param>
        /// <returns></returns>
        [HttpPost("meta/editar/{idMeta:long}")]
        public IActionResult EditarMeta(MetaPost dados, long idMeta)
        {
            var rep = new BetterDaysRepository(_conf);

            var meta = rep.EditarMeta(dados, idMeta);

            var dto = new ListaMetasDto(meta);

            return Ok(dto);
        }

        /// <summary>
        /// Troca o status de conclusão de uma meta
        /// </summary>
        /// <param name="idMeta"></param>
        /// <returns></returns>
        [HttpPut("meta/changeconclusao/{idMeta:long}")]
        public IActionResult EditarStatusConclusao(long idMeta)
        {
            var rep = new BetterDaysRepository(_conf);

            var meta = rep.AlterarEstadoConclusao(idMeta);

            var dto = new ListaMetasDto(meta);

            return Ok(dto);
        }

        /// <summary>
        /// Exclui o registro no banco daquela emta
        /// </summary>
        /// <param name="idMeta"></param>
        /// <returns></returns>
        [HttpDelete("meta/deletar/{idMeta:long}")]
        public IActionResult DeletarMeta(long idMeta)
        {
            var rep = new BetterDaysRepository(_conf);

            rep.ExcluirMeta(idMeta);

            return Ok();
        }

        #endregion
    }
}