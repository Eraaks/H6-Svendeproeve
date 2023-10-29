using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Svendeproeve_KlatreApp_API.FirebaseDocuments;
using Svendeproeve_KlatreApp_API.Services;
using Svendeproeve_KlatreApp_API.Services.SubServices;

namespace Svendeproeve_KlatreApp_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class GripsController : ControllerBase
    {
        private readonly FirebaseService _firebaseService;

        public GripsController(FirebaseService firebaseService)
        {
            _firebaseService = firebaseService;
        }

        [HttpPost("/Grips/CreateNewGripsCollection/")]
        public async Task CreateNewGripsCollection(GripsDocument grip)
        {
            await _firebaseService.CreateNewGripsCollection(grip);
        }

        [HttpGet("/Grips/GetGrips/")]
        public async Task<List<GripsDocument>> GetGrips()
        {
            return await _firebaseService.GetGrips();
        }
    }
}
