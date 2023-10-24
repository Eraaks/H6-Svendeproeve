using Google.Cloud.Firestore;

namespace Svendeproeve_KlatreApp_API.FirebaseDocuments
{
    [FirestoreData]
    public class ShoeDocument
    {
        [FirestoreDocumentId]
        public string Id { get; set; }
        [FirestoreProperty]
        public required string Name { get; set; }
        [FirestoreProperty]
        public required string Brand { get; set; }
        [FirestoreProperty]
        public required string Price { get; set; }
    }
}
