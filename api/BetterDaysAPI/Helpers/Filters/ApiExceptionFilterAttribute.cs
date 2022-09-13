using BetterDaysAPI.Helpers.Exceptions;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using System.Net;

namespace BetterDaysAPI.Helpers.Filters
{
    public class ApiExceptionFilterAttribute : ExceptionFilterAttribute
    {
        public override void OnException(ExceptionContext context)
        {
            var ex             = context.Exception;
            var httpStatusCode = HttpStatusCode.InternalServerError;
            var message        = "Ops. Aconteceu algum erro inesperado!";

            (httpStatusCode, message) = ex switch {
                ArgumentNullException
                    => (HttpStatusCode.NotFound, ex.Message),
                
                UnauthorizedAccessException
                    => (HttpStatusCode.Forbidden, ex.Message),

                HttpBadRequestException
                    => (HttpStatusCode.BadRequest, ex.Message),

                ArgumentException or
                Exception
                    => (HttpStatusCode.Conflict, ex.Message),

                _ => (HttpStatusCode.InternalServerError, "Ops. Aconteceu algum erro inesperado!"),
            };

            context.Result = new ObjectResult(message) { StatusCode = (int)httpStatusCode };
        }
    }
}