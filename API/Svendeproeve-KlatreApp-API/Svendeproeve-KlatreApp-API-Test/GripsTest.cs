using Google.Cloud.Firestore;
using Grpc.Core;
using Svendeproeve_KlatreApp_API.FirebaseDocuments;
using Svendeproeve_KlatreApp_API.Services.SubServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Svendeproeve_KlatreApp_API_Test
{
    public class GripsTest
    {
        private FirestoreDb _firestoreDB;
        private readonly GripsService _gripsService;

        public GripsTest()
        {
            Environment.SetEnvironmentVariable("GOOGLE_APPLICATION_CREDENTIALS", @"C:\Users\Eraaks\Downloads\h6-svendeproeve-klatreapp-firebase-adminsdk-q7f96-1575848134.json");
            _firestoreDB = FirestoreDb.Create("h6-svendeproeve-klatreapp");
            _gripsService = new GripsService(_firestoreDB);
        }

        [Fact]
        public async Task CreateNewGripsCollection()
        {
            // Arrange
            var grip = new GripsDocument()
            {
                Name = "Tester",
                Description = "Testing",
                Image_Location = "Test"
            };
            StatusCode result;

            // Act
            result = await _gripsService.CreateNewGripsCollection(grip);
            await _gripsService.DeleteGrip(grip.Name);

            // Assert
            Assert.Equal(StatusCode.OK, result);
        }

        [Fact]
        public async Task GetGrip()
        {
            // Arrange
            var grip = new GripsDocument()
            {
                Name = "Tester",
                Description = "Testing",
                Image_Location = "Test"
            };

            // Act
            await _gripsService.CreateNewGripsCollection(grip);
            var result = await _gripsService.GetGrip(grip.Name);
            await _gripsService.DeleteGrip(grip.Name);

            // Assert
            Assert.Equal(grip.Name, result.Name);
        }

        [Fact]
        public async Task GetGrips()
        {
            // Arrange
            List<GripsDocument> result = new List<GripsDocument>();

            // Act
            result.AddRange(await _gripsService.GetGrips());

            // Assert
            Assert.Equal(6, result.Count);
        }

        [Fact]
        public async Task UpdateGrip()
        {
            // Arrange
            var grip = new GripsDocument()
            {
                Name = "Tester",
                Description = "Testing",
                Image_Location = "Test"
            };

            // Act
            await _gripsService.CreateNewGripsCollection(grip);
            await _gripsService.UpdateGrip(grip.Name, "Description", "Testing2");
            var result = await _gripsService.GetGrip(grip.Name);
            await _gripsService.DeleteGrip(grip.Name);

            // Assert
            Assert.NotEqual(grip.Description, result.Description);
        }

        [Fact]
        public async Task DeleteGrip()
        {
            // Arrange
            var grip = new GripsDocument()
            {
                Name = "Tester",
                Description = "Testing",
                Image_Location = "Test"
            };

            // Act
            await _gripsService.CreateNewGripsCollection(grip);
            var result = await _gripsService.DeleteGrip(grip.Name);

            // Assert
            Assert.Equal(StatusCode.OK, result);
        }
    }
}
