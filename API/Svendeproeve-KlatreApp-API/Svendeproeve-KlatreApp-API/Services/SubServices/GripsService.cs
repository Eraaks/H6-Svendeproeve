using Google.Cloud.Firestore;
using Svendeproeve_KlatreApp_API.FirebaseDocuments;

namespace Svendeproeve_KlatreApp_API.Services.SubServices
{
    public class GripsService
    {
        private readonly FirestoreDb _firestoreDb;
        public GripsService(FirestoreDb firestoreDb)
        {
            _firestoreDb = firestoreDb;
        }

        public async Task CreateNewGripsCollection(GripsDocument grip)
        {
            await _firestoreDb.Collection("Grips").AddAsync(grip);
        }

        public async Task<List<GripsDocument>> GetGrips()
        {
            var gripsDocuments = await _firestoreDb.Collection("Grips").GetSnapshotAsync();
            var gripsData = gripsDocuments.Documents.Select(s => s.ConvertTo<GripsDocument>()).ToList();
            return gripsData;
        }
    }
}
