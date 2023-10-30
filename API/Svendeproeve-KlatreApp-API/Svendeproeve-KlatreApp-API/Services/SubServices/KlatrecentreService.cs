using Google.Cloud.Firestore;
using Svendeproeve_KlatreApp_API.FirebaseDocuments;

namespace Svendeproeve_KlatreApp_API.Services.SubServices
{
    public class KlatrecentreService
    {
        private readonly FirestoreDb _firestoreDb;
        public KlatrecentreService(FirestoreDb firestoreDb)
        {
            _firestoreDb = firestoreDb;
        }

        public async Task AddClimbingCenter(ClimbingCenterDocument climbingCenter, string climbingCenterName)
        {
            var collection = _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName);
            await collection.SetAsync(climbingCenter);
            await AddClimbingAreas(climbingCenterName, climbingCenter.Areas);
        }

        private async Task AddClimbingAreas(string climbingCenterName, List<Areas> areas)
        {
            foreach (var area in areas)
            {
                var collection = _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).Collection(area.Name);
                await collection.AddAsync(area);
            }
        }

        public async Task AddClimbingRoutes(string climbingArea, List<AreaRoutes> areaRoutes, string moderator)
        {

        }
    }
}
