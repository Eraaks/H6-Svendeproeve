using FirebaseAdmin.Auth;
using Google.Cloud.Firestore;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Svendeproeve_KlatreApp_API.FirebaseDocuments;
using Svendeproeve_KlatreApp_API.Services;
using Svendeproeve_KlatreApp_API.Services.SubServices;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Svendeproeve_KlatreApp_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize]
    public class ProfileDataController : ControllerBase
    {
        private readonly FirebaseService _fireStoreService;

        public ProfileDataController(FirebaseService firestoreService)
        {
            _fireStoreService = firestoreService;
        }

        [HttpPost("/NewProfileDataAsync/{userUID}&{email}")]
        public async Task NewProfileDataAsync(string userUID, string email, string moderatorCode = "Empty")
        {
            Send_Collection send_CollectionSouth = new Send_Collection()
            {
                ID = Guid.NewGuid().ToString(),
                Area = "",
                Grade = "2",
                Points = 200,
                Tries = 2,
                SendDate = DateTime.Today.Ticks,
            };
            Climbing_History historySouth = new Climbing_History()
            {
                ID = userUID,
                Estimated_Grade = "2",
                Location = "",
                Total_Points = 200,
                Send_Collections = new List<Send_Collection>() { send_CollectionSouth }
            };
            await _fireStoreService.AddProfileData(new ProfileDataDocument
            {
                ID = userUID,
                Follows_Me = new List<string>() { "" },
                Friend_Ids = new List<string>() { "" },
                Saved_Exercises = new List<string>() { },
                Saved_Workouts = new List<string>() { },
                User_Email = email,
                Selected_Gym = "BetaBouldersSouth",
                Climbing_History = new List<Climbing_History>() { historySouth }
            });

            if (moderatorCode != null && moderatorCode != "Empty") await _fireStoreService.CheckModeratorCodeAndAddToCenter(moderatorCode, userUID);
        }

        [HttpGet("/GetProfileData/{userUID}")]
        public async Task<ProfileDataDocument> GetProfileData(string userUID)
        {
            return await _fireStoreService.GetProfileData(userUID);
        }

        [HttpPatch("/UpdateProfileData/{userUID}")]
        public async Task UpdateProfileData(ProfileDataDocument newProfile, string userUID)
        {
            await _fireStoreService.UpdateProfileData(newProfile, userUID);
        }

        [HttpDelete("/DeleteProfileData/{userUID}")]
        public async Task RemoveProfileData(string userUID)
        {
            await _fireStoreService.DeleteProfileData(userUID);
        }

        [HttpPatch("/UpdateFollow/{userUID}&{userToFollowUserUID}")]
        public async Task UpdateFollow(string userUID, string userToFollowUserUID)
        {
            await _fireStoreService.UpdateFollow(userUID, userToFollowUserUID);
        }

        [HttpDelete("/RemoveFollow/{userUID}&{userToFollowUserUID}")]
        public async Task RemoveFollow(string userUID, string userToFollowUserUID)
        {
            await _fireStoreService.RemoveFollow(userUID, userToFollowUserUID);
        }

        [HttpGet("/GetFollowList/{userUID}")]
        public async Task<List<string>> GetFollowList(string userUID)
        {
            return await _fireStoreService.GetFollowList(userUID);
        }

        [HttpGet("/GetClimbingScore/{climbingCenter}")]
        public async Task<List<ClimbingScoreDocument>> GetClimbingScores(string climbingCenter)
        {
            climbingCenter = climbingCenter.Replace(" ", "");
            return await _fireStoreService.GetClimbingScores(climbingCenter);
        }

        [HttpGet("/GetSelectedClimbingCenter/{climbingCenterName}")]
        public async Task<ClimbingCenterDocument> GetSelectedClimbingCenter(string climbingCenterName)
        {
            return await _fireStoreService.GetSelectedClimbingCenter(climbingCenterName);
        }

        [HttpPost("/SubmitUserClimb/{userUID}&{climbingCenterName}")]
        public async Task SubmitUserClimb(List<AreaRoutes> routes, string userUID, string climbingCenterName)
        {
            climbingCenterName = climbingCenterName.Replace(" ", "");
            await _fireStoreService.SubmitUserClimb(routes, userUID, climbingCenterName);
        }

        [HttpPatch("/UpdateSelectedGym/{userUID}&{newSelectedGym}")]
        public async Task UpdateSelectedGym(string userUID, string newSelectedGym)
        {
            newSelectedGym = newSelectedGym.Replace(" ", "");
            await _fireStoreService.UpdateSelectedGym(userUID, newSelectedGym);
        }

        [HttpGet("/CheckIfUserModerator/{userUID}&{climbingCenterName}")]
        public async Task<bool> CheckIfUserModerator(string userUID)
        {
            return await _fireStoreService.CheckIfUserModerator(userUID);
        }
    }
}
