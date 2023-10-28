using Google.Cloud.Firestore;

namespace Svendeproeve_KlatreApp_API.FirebaseDocuments
{
    [FirestoreData]
    public class GripsDocument
    {
        [FirestoreProperty]
        public string Description { get; set; }

        [FirestoreProperty]
        public string Image_Location { get; set; }

        [FirestoreProperty]
        public string Name { get; set; }
    }
}
