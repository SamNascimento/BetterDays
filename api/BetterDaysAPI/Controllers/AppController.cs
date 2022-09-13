using Microsoft.AspNetCore.Mvc;

namespace BetterDaysAPI.Controllers
{
    [ApiController]
    [Route("")]
    public class AppController : ControllerBase
    {
        private readonly string html =
        @"
        <html>
        <head>
          <meta charset=""UTF8"">
          <title>Better Days</title>
        </head>
        <body>
          <img src=""images/logo.png"" alt=""Better Days""></img>
          <h1>BETTER DAYS SERVICE</h1>
        </body>
        <style>
          body {
            background-color: hsl(231, 43%, 68%);
            color: white;
            width: 1000px;
            margin: 0 auto;
            padding-top: 30px;
          }
          h1 {
            text-align: center;
          }
          img {
            width: 100%;
            height: 500px;
          }
        </style>
        </html>
        "
        .Replace("\t", "")
        .Replace("\n", "");

        [HttpGet]
        public IActionResult HelloWorld()
        {
            return Content(html, "text/html");
        }
    }
}