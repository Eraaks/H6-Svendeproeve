using FirebaseAdmin.Auth;
using Google.Cloud.Firestore;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Svendeproeve_KlatreApp_API.FirebaseDocuments;
using Svendeproeve_KlatreApp_API.Services;

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
            await _fireStoreService.AddProfileData(new ProfileDataDocument
            {
                ID = userUID,
                Follows_Me = new List<string>(){""},
                Friend_Ids = new List<string>(){""},
                Saved_Exercises = new List<string>() { },
                Saved_Workouts = new List<string>() { },
                Training_For = "",
                Training_Skill_Level = "",
                User_Email = email,
                Climbing_History = new Climbing_History
                {
                    ID = userUID,
                    Estimated_Grade = "2",
                    Location = "",
                    Total_Points = 200,
                    Send_Collections = new Send_Collection
                    {
                        ID = Guid.NewGuid().ToString(),
                        Area = "",
                        Grade = "",
                        Points = 0,
                        Tries = 0,
                    }
                },
            });

            if(moderatorCode != null && moderatorCode != "Empty") await _fireStoreService.CheckModeratorCodeAndAddToCenter(moderatorCode, userUID);
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
            await _fireStoreService.RemoveProfileData(userUID);
        }
    }
}
