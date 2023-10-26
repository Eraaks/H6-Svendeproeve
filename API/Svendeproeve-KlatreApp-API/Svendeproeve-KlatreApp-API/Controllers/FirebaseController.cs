using FirebaseAdmin.Auth;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Svendeproeve_KlatreApp_API.FirebaseDocuments;
using Svendeproeve_KlatreApp_API.Services;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace Svendeproeve_KlatreApp_API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class FirebaseController : ControllerBase
    {
        private readonly FirestoreService _fireStoreService;

        public FirebaseController(FirestoreService firestoreService)
        {
            _fireStoreService = firestoreService;
        }

        [HttpGet("/Testing/{UID}")]
        public async Task<dynamic> Tester(string UID)
        {
            return await FirebaseAuth.DefaultInstance.CreateCustomTokenAsync(UID);
            //FirebaseAuth.DefaultInstance.
            //var test = await FirebaseAuth.DefaultInstance.CreateCustomTokenAsync(UID);
            //var test2 = test;
            // Console.WriteLine(FirebaseAuth.GetAuth());
        }

        [HttpPost("/NewProfileDataAsync/{userUID}&{email}")]
        [Authorize]
        public async Task NewProfileDataAsync(string userUID, string email, string moderatorCode = "Empty")
        {
            await _fireStoreService.AddAsync(new ProfileDataDocument
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
    }
}
