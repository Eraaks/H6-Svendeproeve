using Google.Cloud.Firestore;
using Svendeproeve_KlatreApp_API.FirebaseDocuments;

namespace Svendeproeve_KlatreApp_API.Services.SubServices
{
    public class ModeratorService
    {
        private readonly FirestoreDb _firestoreDb;
        public ModeratorService(FirestoreDb firestoreDb)
        {
            _firestoreDb = firestoreDb;
        }

        public async Task<bool> CheckIfUserModerator(string userUID)
        {
            var centerDocument = await _firestoreDb.Collection("Klatrecentre").GetSnapshotAsync();
            var centerData = centerDocument.Documents.Select(s => s.ConvertTo<ClimbingCenterDocument>()).ToList();
            foreach (var area in centerData)
            {
                if (area.Moderators.Contains(userUID)) return true;
            }

            return false;
        }

        public async Task<string> RequestModeratorCode(string climbingCenterName, string userUID)
        {
            var centerDocument = await _firestoreDb.Collection("Klatrecentre").GetSnapshotAsync();
            var centerData = centerDocument.Documents.Select(s => s.ConvertTo<ClimbingCenterDocument>()).ToList();
            foreach (var area in centerData)
            {
                if (area.CenterName == climbingCenterName)
                {
                    if (area.Moderators.Contains(userUID)) return area.Moderator_Code;
                }
            }
            return "";
        }

        public async Task CheckModeratorCodeAndAddToCenter(string moderatorCode, string userUID)
        {
            var centerData = await _firestoreDb.Collection("Klatrecentre").GetSnapshotAsync();
            var centerDocuments = centerData.Documents.Select(s => s.ConvertTo<ClimbingCenterDocument>()).ToList();
            foreach (var document in centerDocuments)
            {
                if (moderatorCode == document.Moderator_Code)
                {
                    var centerDocument = _firestoreDb.Collection("Klatrecentre").Document(document.CenterName);
                    var moderators = document.Moderators;
                    moderators.Add(userUID);
                    await centerDocument.UpdateAsync("Moderators", moderators);
                }
            }
        }
    }
}
