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

        #region OBTER

        [HttpGet("usuario/{idUsuario:long}/diario")]
        public IActionResult ObterAnotacoesDiario(long idUsuario)
        {
            var rep = new BetterDaysRepository(_conf);

            var anotacoesDiario = rep.ObterAnotacoesDiario(idUsuario);

            return Ok(anotacoesDiario);
        }

        #endregion
    }
}