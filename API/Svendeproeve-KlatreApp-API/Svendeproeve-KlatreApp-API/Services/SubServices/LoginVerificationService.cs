using Google.Cloud.Firestore;

namespace Svendeproeve_KlatreApp_API.Services.SubServices
{
    public class LoginVerificationService
    {
        private readonly FirestoreDb _firestoreDb;
        public LoginVerificationService(FirestoreDb firestoreDb)
        {
            _firestoreDb = firestoreDb;
        }

        public async Task<bool> CompareSecretValues(string fireBaseSecret)
        {
            var data = await _firestoreDb.Collection("Login Verification").GetSnapshotAsync();
            var snapshotDocumentID = data.Documents[0].Id;
            DocumentSnapshot snapshotDocument = await _firestoreDb.Collection("Login Verification").Document(snapshotDocumentID).GetSnapshotAsync();
            if (snapshotDocument.Exists)
            {
                Dictionary<string, object> keys = snapshotDocument.ToDictionary();
                foreach (KeyValuePair<string, object> k in keys)
                {
                    if ((string)k.Value == fireBaseSecret) return true;
                }
            }

            return false;
        }
    }
}
