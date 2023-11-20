using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Svendeproeve_KlatreApp_API.FirebaseDocuments;
using Svendeproeve_KlatreApp_API.Services;

namespace Svendeproeve_KlatreApp_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class KlatrecentreController : ControllerBase
    {
        private readonly FirebaseService _fireBaseService;

        public KlatrecentreController(FirebaseService fireBaseService)
        {
            _fireBaseService = fireBaseService;
        }

        [HttpGet("/GetCenterRoutes/{centerName}")]
        public async Task<List<Areas>> GetCenterRoutes(string centerName)
        {
            return await _fireBaseService.GetCenterRoutes(centerName);
        }

        [HttpPatch("/UpdateRouteCompleters/{climbingCenterName}&{areaName}&{routeID}&{userUID}&{flashed}")]
        public async Task UpdateRouteCompleters(List<AreaRoutes> routes, string climbingCenterName, string areaName, string userUID, bool flashed)
        {
            await _fireBaseService.UpdateRouteCompleters(routes, climbingCenterName, areaName, userUID, flashed);
        }
    }
}
