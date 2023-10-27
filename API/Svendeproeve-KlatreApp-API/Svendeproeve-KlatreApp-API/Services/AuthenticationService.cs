using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

namespace Svendeproeve_KlatreApp_API.Services
{
    public class AuthenticationService
    {
        private readonly FirestoreService _fireStoreService;
        private readonly IConfiguration _configuration;
        public AuthenticationService(FirestoreService firestoreService, IConfiguration configuration)
        {
            _fireStoreService = firestoreService;
            _configuration = configuration;
        }
        public async Task<bool> Authenticate(string fireBaseSecret)
        {
            var compareValueResult = await _fireStoreService.CompareSecretValues(fireBaseSecret);
            return compareValueResult;
        }

        public async Task<string> GenerateTokenAsync(string userUID)
        {
            var isModerator = await _fireStoreService.CheckIfUserModerator(userUID);
            var role = isModerator ? "Moderator" : "User";
            var securityKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration["JWT:Key"]));
            var credentials = new SigningCredentials(securityKey, SecurityAlgorithms.HmacSha512);
            var claims = new[]
            {
                new Claim(ClaimTypes.NameIdentifier, userUID),
                new Claim(ClaimTypes.Role, role)
            };
            var token = new JwtSecurityToken(_configuration["JWT:Issuer"],
                _configuration["JWT:Audience"],
                claims,
                expires: DateTime.Now.AddHours(1),
                signingCredentials: credentials
                );

            return new JwtSecurityTokenHandler().WriteToken(token);
        }
    }
}
