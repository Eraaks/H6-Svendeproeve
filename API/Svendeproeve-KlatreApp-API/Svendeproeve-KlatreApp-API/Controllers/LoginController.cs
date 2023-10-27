using FirebaseAdmin;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using Svendeproeve_KlatreApp_API.Services;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace Svendeproeve_KlatreApp_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LoginController : ControllerBase
    {
        private readonly AuthenticationService _authenticationService;
        public LoginController(AuthenticationService authenticationService)
        {
            _authenticationService = authenticationService;
        }

        [HttpPost("/Login/{fireBaseSecret}&{userUID}")]
        public async Task<ActionResult> Login(string fireBaseSecret, string userUID)
        {
            var user = _authenticationService.Authenticate(fireBaseSecret).Result;
            if (user == true)
            {
                var token = await _authenticationService.GenerateTokenAsync(userUID);
                return Ok(token);
            }   
            
            return NotFound("AuthenticationService Failed");
        }
    }
}
