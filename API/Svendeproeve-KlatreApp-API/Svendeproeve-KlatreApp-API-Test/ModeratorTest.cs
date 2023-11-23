using Google.Cloud.Firestore;
using Grpc.Core;
using Svendeproeve_KlatreApp_API.Services.SubServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Svendeproeve_KlatreApp_API_Test
{
    public class ModeratorTest
    {
        private FirestoreDb _firestoreDB;
        private readonly ModeratorService _moderatorService;

        public ModeratorTest()
        {
            Environment.SetEnvironmentVariable("GOOGLE_APPLICATION_CREDENTIALS", @"C:\Users\Eraaks\Downloads\h6-svendeproeve-klatreapp-firebase-adminsdk-q7f96-1575848134.json");
            _firestoreDB = FirestoreDb.Create("h6-svendeproeve-klatreapp");
            _moderatorService = new ModeratorService(_firestoreDB);
        }

        [Fact]
        public async Task CheckIfUserModerator()
        {
            // Arrange
            var nonModeratorUID = "TestUID";
            var moderatorUID = "KRYhQhBVh0a1myYi8kkekREE9Y03";

            // Act
            var result1 = await _moderatorService.CheckIfUserModerator(nonModeratorUID);
            var result2 = await _moderatorService.CheckIfUserModerator(moderatorUID);

            // Assert
            Assert.False(result1);
            Assert.True(result2);
        }

        [Fact]
        public async Task RequestModeratorCode()
        {
            // Arrange
            var moderatorUID = "KRYhQhBVh0a1myYi8kkekREE9Y03";
            var climbingCenterName = "BetaBouldersSouth";

            // Act
            var result = await _moderatorService.RequestModeratorCode(climbingCenterName, moderatorUID);

            // Assert
            Assert.NotNull(result);
        }

        [Fact]
        public async Task CheckModeratorCodeAndAddToCenter()
        {
            // Arrange
            var moderatorCode = "89d6f337-67fd-43d4-ba7f-b62e0285782b";
            var moderatorUID = "KRYhQhBVh0a1myYi8kkekREE9Y03";
            var userUID = "TesterMod";
            var climbingCenterName = "BetaBouldersSouth";

            // Act
            var result = await _moderatorService.CheckModeratorCodeAndAddToCenter(moderatorCode, userUID);
            await _moderatorService.RemoveModerator(moderatorUID, userUID, climbingCenterName);

            // Assert
            Assert.Equal(StatusCode.OK, result);
        }

        [Fact]
        public async Task RemoveModerator()
        {
            // Arrange
            var moderatorCode = "89d6f337-67fd-43d4-ba7f-b62e0285782b";
            var moderatorUID = "KRYhQhBVh0a1myYi8kkekREE9Y03";
            var moderatorToRemoveUID = "Tester";
            var climbingCenterName = "BetaBouldersSouth";

            // Act
            await _moderatorService.CheckModeratorCodeAndAddToCenter(moderatorCode, moderatorToRemoveUID);
            var result = await _moderatorService.RemoveModerator(moderatorUID, moderatorToRemoveUID, climbingCenterName);

            // Assert
            Assert.Equal(StatusCode.OK, result);
        }
    }
}
