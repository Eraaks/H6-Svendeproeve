using Google.Cloud.Firestore;
using Grpc.Core;
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

        public async Task<StatusCode> CreateNewGripsCollection(GripsDocument grip)
        {
            try
            {
                await _firestoreDb.Collection("Grips").Document(grip.Name).SetAsync(grip);
                return StatusCode.OK;
            }
            catch (Exception)
            {
                return StatusCode.Aborted;
                throw;
            }
        }

        public async Task<GripsDocument> GetGrip(string gripName)
        {
            try
            {
                var gripDocument = await _firestoreDb.Collection("Grips").Document(gripName).GetSnapshotAsync();
                var gripData = gripDocument.ConvertTo<GripsDocument>();
                return gripData;
            }
            catch (Exception)
            {
                return new GripsDocument();
                throw;
            }
        }

        public async Task<List<GripsDocument>> GetGrips()
        {
            var gripsDocuments = await _firestoreDb.Collection("Grips").GetSnapshotAsync();
            var gripsData = gripsDocuments.Documents.Select(s => s.ConvertTo<GripsDocument>()).ToList();
            return gripsData;
        }

        public async Task UpdateGrip(string gripName, string fieldToChange, string newValue)
        {
            try
            {
                await _firestoreDb.Collection("Grips").Document(gripName).UpdateAsync(fieldToChange, newValue);
            }
            catch (Exception)
            {
                throw;
            }

        }

        public async Task<StatusCode> DeleteGrip(string gripName)
        {
            try
            {
                await _firestoreDb.Collection("Grips").Document(gripName).DeleteAsync();
                return StatusCode.OK;
            }
            catch (Exception)
            {
                return StatusCode.Aborted;
                throw;
            }
        }
    }
}
