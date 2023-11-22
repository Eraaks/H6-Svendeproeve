using Google.Cloud.Firestore;
using Grpc.Core;
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
            try
            {
                var centerDocument = await _firestoreDb.Collection("Klatrecentre").GetSnapshotAsync();
                var centerData = centerDocument.Documents.Select(s => s.ConvertTo<ClimbingCenterDocument>()).ToList();
                foreach (var area in centerData)
                {
                    if (area.Moderators.Contains(userUID)) return true;
                }

                return false;
            }
            catch (Exception)
            {
                return false;
                throw;
            }

        }

        public async Task<string> RequestModeratorCode(string climbingCenterName, string userUID)
        {
            try
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
            catch (Exception)
            {
                return "";
                throw;
            }

        }

        public async Task<StatusCode> CheckModeratorCodeAndAddToCenter(string moderatorCode, string userUID)
        {
            try
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
                return StatusCode.OK;
            }
            catch (Exception)
            {
                return StatusCode.Aborted;
                throw;
            }
        }

        public async Task<StatusCode> RemoveModerator(string userUID, string moderatorToRemoveUID, string climbingCenterName)
        {
            try
            {
                var centerDocument = await _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).GetSnapshotAsync();
                var centerData = centerDocument.ConvertTo<ClimbingCenterDocument>();
                if (centerData.Moderators.Contains(userUID))
                {
                    centerData.Moderators.Remove(moderatorToRemoveUID);
                    await _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).UpdateAsync("Moderators", centerData.Moderators);
                }
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
