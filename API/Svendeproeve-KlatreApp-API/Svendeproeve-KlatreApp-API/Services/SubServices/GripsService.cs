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
            await _firestoreDb.Collection("Grips").Document(grip.Name).SetAsync(grip);
        }

        public async Task<GripsDocument> GetGrip(string gripName)
        {
            var gripDocument = await _firestoreDb.Collection("Grips").Document(gripName).GetSnapshotAsync();
            var gripData = gripDocument.ConvertTo<GripsDocument>();
            return gripData;
        }

        public async Task<List<GripsDocument>> GetGrips()
        {
            var gripsDocuments = await _firestoreDb.Collection("Grips").GetSnapshotAsync();
            var gripsData = gripsDocuments.Documents.Select(s => s.ConvertTo<GripsDocument>()).ToList();
            return gripsData;
        }

        public async Task UpdateGrip(string gripName, string fieldToChange, string newValue)
        {
            await _firestoreDb.Collection("Grips").Document(gripName).UpdateAsync(fieldToChange, newValue);
        }

        public async Task DeleteGrip(string gripName)
        {
            await _firestoreDb.Collection("Grips").Document(gripName).DeleteAsync();
        }
    }
}
