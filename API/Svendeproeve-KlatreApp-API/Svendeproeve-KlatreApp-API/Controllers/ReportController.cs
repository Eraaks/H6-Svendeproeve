using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Octokit;
using Svendeproeve_KlatreApp_API.Services;
using Svendeproeve_KlatreApp_API.Services.SubServices;

namespace Svendeproeve_KlatreApp_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ReportController : ControllerBase
    {
        private readonly FirebaseService _firebaseService;

        public ReportController(FirebaseService firebaseService)
        {
            _firebaseService = firebaseService;
        }

        [HttpPost("/CreateIssue/{title}&{description}&{isBug}")]
        public async Task<Issue> CreateIssue(string title, string description, bool isBug)
        {
            return await _firebaseService.CreateIssue(title, description, isBug);
        }

        [HttpGet("/GetIssues/")]
        public async Task<IReadOnlyList<Issue>> GetIssues()
        {
            return await _firebaseService.GetIssues();
        }
    }
}
