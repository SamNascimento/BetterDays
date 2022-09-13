namespace BetterDaysAPI.Helpers.Exceptions
{
    public class HttpBadRequestException : Exception
    {
        public HttpBadRequestException() : base() { }
        public HttpBadRequestException(string msg) : base(msg) { }
        public HttpBadRequestException(string msg, Exception inner) : base(msg, inner) { }
    }
}