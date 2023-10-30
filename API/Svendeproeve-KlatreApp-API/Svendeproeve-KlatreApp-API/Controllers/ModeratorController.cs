using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Svendeproeve_KlatreApp_API.FirebaseDocuments;
using Svendeproeve_KlatreApp_API.Services;

namespace Svendeproeve_KlatreApp_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize(Roles = "Moderator, Admin")]
    public class ModeratorController : ControllerBase
    {
        private readonly FirebaseService _fireStoreService;
        public ModeratorController(FirebaseService firestoreService)
        {
            _fireStoreService = firestoreService;
        }

        [HttpPost("/NewClimbingCenter/{climbingCenterName}&{description}&{location}&{defaultModerators}")]
        public async Task NewClimbingCenter(string climbingCenterName, string description, string location, string defaultModerators, List<Areas> areas)
        {
            await _fireStoreService.AddClimbingCenter(new ClimbingCenterDocument
            {
                CenterName = climbingCenterName,
                Description = description,
                Location = location,
                Moderator_Code = Guid.NewGuid().ToString(),
                Moderators = new List<string> { defaultModerators },
                Areas = areas
            }, climbingCenterName);
        }

        [HttpGet("/RequestModeratorCode/{climbingCenterName}&{userUID}")]
        public async Task<string> RequestModeratorCode(string climbingCenterName, string userUID)
        {
            return await _fireStoreService.RequestModeratorCode(climbingCenterName, userUID);
        }

        //[HttpPost("/AddAreasToClimbingCenter/{climbingCenterName}")]
        //public async Task AddAreasToClimbingCenter(string climbingCenterName, List<Areas> areas)
        //{
        //    await _fireStoreService.AddClimbingAreas(climbingCenterName, areas);
        //}
    }
}
