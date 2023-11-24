using Google.Cloud.Firestore;
using Grpc.Core;
using Microsoft.AspNetCore.Hosting;
using Moq;
using Svendeproeve_KlatreApp_API.Controllers;
using Svendeproeve_KlatreApp_API.FirebaseDocuments;
using Svendeproeve_KlatreApp_API.Services.SubServices;
using Xunit;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace Svendeproeve_KlatreApp_API_Test
{
    public class ProfileDataTest
    {
        private FirestoreDb _firestoreDB;
        private readonly ProfileDataService _profileDataService;

        public ProfileDataTest()
        {
            Environment.SetEnvironmentVariable("GOOGLE_APPLICATION_CREDENTIALS", @"C:\Users\Eraaks\Downloads\h6-svendeproeve-klatreapp-firebase-adminsdk-q7f96-1575848134.json");
            _firestoreDB = FirestoreDb.Create("h6-svendeproeve-klatreapp");
            _profileDataService = new ProfileDataService(_firestoreDB);
        }

        [Fact]
        public async void CreateNewProfile_Called_With_NewProfileDocument()
        {
            // Arrange
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
                ID = Guid.NewGuid().ToString(),
                Estimated_Grade = "2",
                Location = "",
                Total_Points = 200,
                Send_Collections = new List<Send_Collection>() { send_CollectionSouth }
            };
            var profile = new ProfileDataDocument()
            {
                ID = "TestUser",
                Follows_Me = new List<string>() { "" },
                Friend_Ids = new List<string>() { "" },
                Saved_Exercises = new List<string>() { },
                Saved_Workouts = new List<string>() { },
                Username = Guid.NewGuid().ToString(),
                Selected_Gym = "BetaBouldersSouth",
                Climbing_History = new List<Climbing_History>() { historySouth }
            };

            // Act
            var result = await _profileDataService.AddProfileData(profile);
            await _profileDataService.DeleteProfileData(profile.ID);

            // Assert
            Assert.Equal(StatusCode.OK, result);
        }

        [Fact]
        public async Task GetProfileData()
        {
            // Arrange
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
                ID = Guid.NewGuid().ToString(),
                Estimated_Grade = "2",
                Location = "",
                Total_Points = 200,
                Send_Collections = new List<Send_Collection>() { send_CollectionSouth }
            };
            var profile = new ProfileDataDocument()
            {
                ID = "TestUser",
                Follows_Me = new List<string>() { "" },
                Friend_Ids = new List<string>() { "" },
                Saved_Exercises = new List<string>() { },
                Saved_Workouts = new List<string>() { },
                Username = Guid.NewGuid().ToString(),
                Selected_Gym = "BetaBouldersSouth",
                Climbing_History = new List<Climbing_History>() { historySouth }
            };

            // Act
            await _profileDataService.AddProfileData(profile);
            var result = await _profileDataService.GetProfileData(profile.ID);

            // Assert
            Assert.Equal(result.ID, profile.ID);
        }

        [Fact]
        public async Task UpdateProfileData()
        {
            // Arrange
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
                ID = Guid.NewGuid().ToString(),
                Estimated_Grade = "2",
                Location = "",
                Total_Points = 200,
                Send_Collections = new List<Send_Collection>() { send_CollectionSouth }
            };
            var profile = new ProfileDataDocument()
            {
                ID = "TestUserUpdate",
                Follows_Me = new List<string>() { "" },
                Friend_Ids = new List<string>() { "" },
                Saved_Exercises = new List<string>() { },
                Saved_Workouts = new List<string>() { },
                Username = Guid.NewGuid().ToString(),
                Selected_Gym = "BetaBouldersSouth",
                Climbing_History = new List<Climbing_History>() { historySouth }
            };

            // Act
            await _profileDataService.AddProfileData(profile);
            profile.ID = "TestUser2";
            var result = await _profileDataService.UpdateProfileData(profile, "TestUserUpdate");
            await _profileDataService.DeleteProfileData(profile.ID);

            // Assert
            Assert.Equal(StatusCode.OK, result);
        }

        [Fact]
        public async Task DeleteProfileData()
        {
            // Arrange
            string userUIDToDelete = "TestUser3";
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
                ID = Guid.NewGuid().ToString(),
                Estimated_Grade = "2",
                Location = "",
                Total_Points = 200,
                Send_Collections = new List<Send_Collection>() { send_CollectionSouth }
            };
            var profile = new ProfileDataDocument()
            {
                ID = "TestUser3",
                Follows_Me = new List<string>() { "" },
                Friend_Ids = new List<string>() { "" },
                Saved_Exercises = new List<string>() { },
                Saved_Workouts = new List<string>() { },
                Username = Guid.NewGuid().ToString(),
                Selected_Gym = "BetaBouldersSouth",
                Climbing_History = new List<Climbing_History>() { historySouth }
            };

            // Act
            await _profileDataService.AddProfileData(profile);
            var result = await _profileDataService.DeleteProfileData(userUIDToDelete);

            // Assert
            Assert.Equal(StatusCode.OK, result);
        }

        [Fact]
        public async Task UpdateFollow()
        {
            // Arrange
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
                ID = Guid.NewGuid().ToString(),
                Estimated_Grade = "2",
                Location = "",
                Total_Points = 200,
                Send_Collections = new List<Send_Collection>() { send_CollectionSouth }
            };
            var profile1 = new ProfileDataDocument()
            {
                ID = "TestUser3",
                Follows_Me = new List<string>() { "" },
                Friend_Ids = new List<string>() { "" },
                Saved_Exercises = new List<string>() { },
                Saved_Workouts = new List<string>() { },
                Username = Guid.NewGuid().ToString(),
                Selected_Gym = "BetaBouldersSouth",
                Climbing_History = new List<Climbing_History>() { historySouth }
            };
            var profile2 = new ProfileDataDocument()
            {
                ID = "TestUser4",
                Follows_Me = new List<string>() { "" },
                Friend_Ids = new List<string>() { "" },
                Saved_Exercises = new List<string>() { },
                Saved_Workouts = new List<string>() { },
                Username = Guid.NewGuid().ToString(),
                Selected_Gym = "BetaBouldersSouth",
                Climbing_History = new List<Climbing_History>() { historySouth }
            };

            // Act
            await _profileDataService.AddProfileData(profile1);
            await _profileDataService.AddProfileData(profile2);
            var result = await _profileDataService.UpdateFollow(profile1.ID, profile2.ID);
            await _profileDataService.DeleteProfileData(profile1.ID);
            await _profileDataService.DeleteProfileData(profile2.ID);

            // Assert
            Assert.Equal(StatusCode.OK, result);
        }

        [Fact]
        public async Task RemoveFollow()
        {
            // Arrange
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
                ID = Guid.NewGuid().ToString(),
                Estimated_Grade = "2",
                Location = "",
                Total_Points = 200,
                Send_Collections = new List<Send_Collection>() { send_CollectionSouth }
            };
            var profile1 = new ProfileDataDocument()
            {
                ID = "TestUser3",
                Follows_Me = new List<string>() { "" },
                Friend_Ids = new List<string>() { "" },
                Saved_Exercises = new List<string>() { },
                Saved_Workouts = new List<string>() { },
                Username = Guid.NewGuid().ToString(),
                Selected_Gym = "BetaBouldersSouth",
                Climbing_History = new List<Climbing_History>() { historySouth }
            };
            var profile2 = new ProfileDataDocument()
            {
                ID = "TestUser4",
                Follows_Me = new List<string>() { "" },
                Friend_Ids = new List<string>() { "" },
                Saved_Exercises = new List<string>() { },
                Saved_Workouts = new List<string>() { },
                Username = Guid.NewGuid().ToString(),
                Selected_Gym = "BetaBouldersSouth",
                Climbing_History = new List<Climbing_History>() { historySouth }
            };

            // Act
            await _profileDataService.AddProfileData(profile1);
            await _profileDataService.AddProfileData(profile2);
            var result = await _profileDataService.RemoveFollow(profile1.ID, profile2.ID);
            await _profileDataService.DeleteProfileData(profile1.ID);
            await _profileDataService.DeleteProfileData(profile2.ID);

            // Assert
            Assert.Equal(StatusCode.OK, result);
        }

        [Fact]
        public async Task GetFollowList()
        {
            // Arrange
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
                ID = Guid.NewGuid().ToString(),
                Estimated_Grade = "2",
                Location = "",
                Total_Points = 200,
                Send_Collections = new List<Send_Collection>() { send_CollectionSouth }
            };
            var profile = new ProfileDataDocument()
            {
                ID = "TestUser",
                Follows_Me = new List<string>() { "" },
                Friend_Ids = new List<string>() { "TestUser2", "TestUser3", "TestUser4" },
                Saved_Exercises = new List<string>() { },
                Saved_Workouts = new List<string>() { },
                Username = Guid.NewGuid().ToString(),
                Selected_Gym = "BetaBouldersSouth",
                Climbing_History = new List<Climbing_History>() { historySouth }
            };

            // Act
            await _profileDataService.AddProfileData(profile);
            var result = await _profileDataService.GetFollowList(profile.ID);
            await _profileDataService.DeleteProfileData(profile.ID);

            // Assert
            Assert.Equal(3, result.Count);
        }

        [Fact]
        public async Task GetClimbingScores()
        {
            // Arrange
            var centerName = "BetaBouldersSouth";

            // Act
            var result = await _profileDataService.GetClimbingScores(centerName);

            // Assert
            Assert.InRange(result.Count, 1, 99);
        }

        [Fact]
        public async Task SubmitUserClimb()
        {
            // Arrange
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
                ID = Guid.NewGuid().ToString(),
                Estimated_Grade = "2",
                Location = "",
                Total_Points = 200,
                Send_Collections = new List<Send_Collection>() { send_CollectionSouth }
            };
            var profile = new ProfileDataDocument()
            {
                ID = "TestUserUpdate",
                Follows_Me = new List<string>() { "" },
                Friend_Ids = new List<string>() { "" },
                Saved_Exercises = new List<string>() { },
                Saved_Workouts = new List<string>() { },
                Username = Guid.NewGuid().ToString(),
                Selected_Gym = "BetaBouldersSouth",
                Climbing_History = new List<Climbing_History>() { historySouth }
            };

            var routes = new List<AreaRoutes>()
            {
                new AreaRoutes()
                {
                    ID = "023663a2-d79a-4c6f-aaaa-6477564d2d01",
                    Color = "255, 0, 255, 0",
                    Grade = "4",
                    UsersWhoCompleted = new List<string>(){ "" },
                    UsersWhoFlashed = new List<string>(){"TestUserUpdate"},
                    Number  = 17,
                    AssignedArea = "Gorilla Right"
                },
                new AreaRoutes()
                {
                    ID = "07685535-9800-4967-b2f9-22c295bc2120",
                    Color = "255, 0, 0, 0",
                    Grade = "6C",
                    UsersWhoCompleted = new List<string>(){ "TestUserUpdate" },
                    UsersWhoFlashed = new List<string>(){""},
                    Number  = 0,
                    AssignedArea = "Gorilla Right"
                }
            };

            var climbingCenterName = "BetaBouldersSouth";

            // Act
            await _profileDataService.AddProfileData(profile);
            var result = await _profileDataService.SubmitUserClimb(routes, profile.ID, climbingCenterName);
            await _profileDataService.DeleteProfileData(profile.ID);

            // Assert
            Assert.Equal(StatusCode.OK, result);
        }

        [Fact]
        public async Task UpdateSelectedGym()
        {
            // Arrange
            var newClimbingGym = "BetaBouldersWest";
            var profile = new ProfileDataDocument()
            {
                ID = "TestUserUpdate",
                Follows_Me = new List<string>() { "" },
                Friend_Ids = new List<string>() { "" },
                Saved_Exercises = new List<string>() { },
                Saved_Workouts = new List<string>() { },
                Username = Guid.NewGuid().ToString(),
                Selected_Gym = "BetaBouldersSouth",
                Climbing_History = new List<Climbing_History>() { }
            };

            // Act
            await _profileDataService.AddProfileData(profile);
            var result = await _profileDataService.UpdateSelectedGym(profile.ID, newClimbingGym);

            // Assert
            Assert.Equal(StatusCode.OK, result);
        }
    }
}