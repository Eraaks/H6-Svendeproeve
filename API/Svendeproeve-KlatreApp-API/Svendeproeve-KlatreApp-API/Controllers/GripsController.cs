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

        [HttpGet("/Grips/GetGrip/{gripName}")]
        public async Task<GripsDocument> GetGrip(string gripName)
        {
            return await _firebaseService.GetGrip(gripName);
        }

        [HttpGet("/Grips/GetGrips/")]
        public async Task<List<GripsDocument>> GetGrips()
        {
            return await _firebaseService.GetGrips();
        }

        [HttpPatch("/Grips/UpdateGrip/{gripName}&{fieldToChange}&{newValue}")]
        public async Task UpdateGrip(string gripName, string fieldToChange, string newValue)
        {
            await _firebaseService.UpdateGrip(gripName, fieldToChange, newValue);
        }

        [HttpDelete("/Grips/DeleteGrip/{gripName}")]
        public async Task DeleteGrip(string gripName)
        {
            await _firebaseService.DeleteGrip(gripName);
        }
    }
}
