﻿using Microsoft.AspNetCore.Authorization;
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

        private string ReplaceWSpace(string content)
        {
            return content.Replace(" ", "");
        }

        [HttpPost("/NewClimbingCenter/{climbingCenterName}&{description}&{location}&{defaultModerators}")]
        public async Task NewClimbingCenter(string climbingCenterName, string description, string location, string defaultModerators, List<Areas> areas)
        {
            climbingCenterName = ReplaceWSpace(climbingCenterName);
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
            climbingCenterName = ReplaceWSpace(climbingCenterName);
            return await _fireStoreService.RequestModeratorCode(climbingCenterName, userUID);
        }

        [HttpPost("/AddAreasToClimbingCenter/{climbingCenterName}")]
        public async Task AddAreaToClimbingCenter(string climbingCenterName, Areas area)
        {
            climbingCenterName = ReplaceWSpace(climbingCenterName);
            await _fireStoreService.AddAreaToClimbingCenter(climbingCenterName, area);
        }

        [HttpPost("/AddRoutesToArea/{climbingCenterName}&{climbingArea}&{changerUserUID}")]
        public async Task AddClimbingRoutes(string climbingCenterName, string climbingArea, List<AreaRoutes> areaRoutes, string changerUserUID)
        {
            climbingCenterName = ReplaceWSpace(climbingCenterName);
            await _fireStoreService.AddClimbingRoutes(climbingCenterName, climbingArea, areaRoutes, changerUserUID);
        }

        [HttpGet("/GetClimbingCentre/")]
        public async Task<List<ClimbingCenterDocument>> GetClimbingCentre()
        {
            return await _fireStoreService.GetClimbingCentre();
        }

        [HttpDelete("/DeleteClimbingRoute/{climbingCenterName}&{climbingArea}&{problemId}")]
        public async Task DeleteClimbingRoute(string climbingCenterName, string climbingArea, string problemId)
        {
            climbingCenterName = ReplaceWSpace(climbingCenterName);
            await _fireStoreService.DeleteClimbingRoute(climbingCenterName, climbingArea, problemId);
        }
        [HttpDelete("/DeleteClimbingArea/{climbingCenterName}&{climbingArea}&{problemId}")]
        public async Task DeleteClimbingArea(string climbingCenterName, string climbingArea, string problemId)
        {
            climbingCenterName = ReplaceWSpace(climbingCenterName);
            await _fireStoreService.DeleteClimbingArea(climbingCenterName, climbingArea, problemId);
        }

        [HttpPatch("/UpdateClimbingRoutes/{centerName}&{areaName}&{problemId}&{fieldToChange}&{newValue}")]
        public async Task UpdateClimbingRoutes(string centerName, string areaName, string fieldToChange, string newValue, string problemId)
        {
            await _fireStoreService.UpdateClimbingRoutes(centerName, areaName, fieldToChange, newValue, problemId);
        }
        [HttpPatch("/UpdateClimbingArea/{centerName}&{areaName}&{fieldToChange}&{newValue}")]
        public async Task UpdateClimbingArea(string centerName, string areaName, string fieldToChange, string newValue)
        {
            await _fireStoreService.UpdateClimbingArea(centerName, areaName, fieldToChange, newValue);
        }

    }
}
