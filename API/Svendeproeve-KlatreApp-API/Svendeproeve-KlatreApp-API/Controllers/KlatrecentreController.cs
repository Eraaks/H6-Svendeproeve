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

        [HttpPatch("/UpdateRouteCompleters/{climbingCenterName}&{userUID}")]
        public async Task UpdateRouteCompleters(List<AreaRoutes> routes, string climbingCenterName, string userUID)
        {
            await _fireBaseService.UpdateRouteCompleters(routes, climbingCenterName, userUID);
        }

        [HttpGet("/GetClimbingCentre/")]
        public async Task<List<ClimbingCenterDocument>> GetClimbingCentre()
        {
            return await _fireBaseService.GetClimbingCentre();
        }

        [HttpGet("/GetClimbingCentreNames/")]
        public async Task<List<string>> GetClimbingCentreNames()
        {
            return await _fireBaseService.GetClimbingCentreNames();
        }
    }
}
