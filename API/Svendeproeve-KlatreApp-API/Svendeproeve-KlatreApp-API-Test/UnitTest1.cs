using Google.Cloud.Firestore;
using Microsoft.AspNetCore.Hosting;
using Svendeproeve_KlatreApp_API.Controllers;
using Svendeproeve_KlatreApp_API.FirebaseDocuments;
using Svendeproeve_KlatreApp_API.Services.SubServices;
using Xunit;

namespace Svendeproeve_KlatreApp_API_Test
{
    public class FakeFireStoreService
    {
        private readonly FirestoreDb _firestoreDb;
        public FakeFireStoreService(FirestoreDb firestoreDb)
        {
            _firestoreDb = firestoreDb;
        }
        public bool AddProfileDataCalled { get; private set; }
        public bool CheckModeratorCodeAndAddToCenterCalled { get; private set; }

        public async Task AddProfileData(ProfileDataDocument profileData)
        {
            // Implement the fake behavior or assert parameters if needed
            AddProfileDataCalled = true;
        }

        public async Task CheckModeratorCodeAndAddToCenter(string moderatorCode, string userUID)
        {
            // Implement the fake behavior or assert parameters if needed
            CheckModeratorCodeAndAddToCenterCalled = true;
        }
    }

    public class UnitTest1
    {
        private FirestoreDb _firestoreDB;

        public UnitTest1()
        {
            // Arrange
            Environment.SetEnvironmentVariable("GOOGLE_APPLICATION_CREDENTIALS", @".\API\Svendeproeve-KlatreApp-API\h6-svendeproeve-klatreapp-firebase-adminsdk-7l50x-662b9ddd66.json");
            _firestoreDB = FirestoreDb.Create("h6-svendeproeve-klatreapp");
        }

        [Fact]
        public async void Test1()
        {
            // Arrange
            var fakeProfileDataService = new FakeFireStoreService(_firestoreDB);
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
                ID = Guid.NewGuid().ToString(),
                Follows_Me = new List<string>() { "" },
                Friend_Ids = new List<string>() { "" },
                Saved_Exercises = new List<string>() { },
                Saved_Workouts = new List<string>() { },
                User_Email = Guid.NewGuid().ToString() + "@gmail.com",
                Selected_Gym = "BetaBouldersSouth",
                Climbing_History = new List<Climbing_History>() { historySouth }
            };

            //var profileController = new ProfileDataController();

            // Act
            await fakeProfileDataService.AddProfileData(profile);

            // Assert
            Assert.True(fakeProfileDataService.AddProfileDataCalled);
        }
    }
}