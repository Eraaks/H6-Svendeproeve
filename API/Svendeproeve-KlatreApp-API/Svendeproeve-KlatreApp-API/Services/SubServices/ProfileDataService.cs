using Google.Cloud.Firestore;
using Google.Rpc;
using Grpc.Core;
using Microsoft.AspNetCore.Mvc;
using Svendeproeve_KlatreApp_API.FirebaseDocuments;
using System;
using System.Text.RegularExpressions;

namespace Svendeproeve_KlatreApp_API.Services.SubServices
{
    public class ProfileDataService
    {
        private readonly FirestoreDb _firestoreDb;
        public ProfileDataService(FirestoreDb firestoreDb)
        {
            _firestoreDb = firestoreDb;
        }

        public async Task<StatusCode> AddProfileData(ProfileDataDocument profileData)
        {
            try
            {
                var collection = _firestoreDb.Collection("Profile_data").Document(profileData.ID);
                await collection.SetAsync(profileData);
                await AddClimbingHistory(profileData.ID, profileData.Climbing_History);
                return StatusCode.OK;
            }
            catch (Exception)
            {
                return StatusCode.Aborted;
                throw;
            }

        }

        private async Task AddClimbingHistory(string profileID, List<Climbing_History> climbing_History)
        {
            var klatreCentre = await _firestoreDb.Collection("Klatrecentre").GetSnapshotAsync();
            var klatreData = klatreCentre.Documents.Select(k => k.ConvertTo<ClimbingCenterDocument>()).ToList();
            foreach (var document in klatreData)
            {
                var collection = _firestoreDb.Collection("Profile_data").Document(profileID).Collection("Climbing_History").Document(document.CenterName);
                foreach(var history in climbing_History)
                {
                    history.Location = document.CenterName;
                    await collection.SetAsync(history);
                    if (history.Send_Collections != null) await AddSendCollections(profileID, document.CenterName, history.Send_Collections);
                }
            }
        }

        private async Task AddSendCollections(string profileID, string historyID, List<Send_Collection> send_Collections)
        {
            foreach(var sendCollection in send_Collections)
            {
                var collection = _firestoreDb.Collection("Profile_data").Document(profileID).Collection("Climbing_History").Document(historyID).Collection("Send_Collections").Document(sendCollection.ID);
                await collection.SetAsync(sendCollection);
            }
        }

        public async Task<ProfileDataDocument?> GetProfileData(string userUID)
        {
            var document = await _firestoreDb.Collection("Profile_data").Document(userUID).GetSnapshotAsync();
            if(document.Exists == false) return null;

            var profileData = document.ConvertTo<ProfileDataDocument>();
            List<Climbing_History> climbing_History = new List<Climbing_History>();
            var climbingHistoryDocument = await _firestoreDb.Collection("Profile_data").Document(userUID).Collection("Climbing_History").GetSnapshotAsync();
            var climbingHistoryData = climbingHistoryDocument.Documents.Select(h => h.ConvertTo<Climbing_History>()).ToList();
            foreach(var data in climbingHistoryData)
            {
                List<Send_Collection> send_Collections = new List<Send_Collection>();
                var sendDocument = await _firestoreDb.Collection("Profile_data").Document(userUID).Collection("Climbing_History").Document(data.Location).Collection("Send_Collections").GetSnapshotAsync();
                var sendData = sendDocument.Documents.Select(s => s.ConvertTo<Send_Collection>()).ToList();
                send_Collections.AddRange(sendData);
                data.Send_Collections = send_Collections;
            }

            climbing_History.AddRange(climbingHistoryData);
            profileData.Climbing_History = climbing_History;
            return profileData;
        }

        public async Task<StatusCode> UpdateProfileData(ProfileDataDocument newProfile, string userUID)
        {
            try
            {
                await DeleteProfileData(userUID);
                await AddProfileData(newProfile);
                return StatusCode.OK;
            }
            catch (Exception)
            {
                return StatusCode.Aborted;
                throw;
            }
        }

        public async Task<StatusCode> DeleteProfileData(string userUID)
        {
            try
            {
                var climbingHistoryDocuments = await _firestoreDb.Collection("Profile_data").Document(userUID).Collection("Climbing_History").GetSnapshotAsync();
                var climbingHistoryData = climbingHistoryDocuments.Documents.Select(c => c.ConvertTo<Climbing_History>()).ToList();
                foreach(var history in climbingHistoryData)
                {
                    var sendCollections = await _firestoreDb.Collection("Profile_data").Document(userUID).Collection("Climbing_History").Document(history.Location).Collection("Send_Collections").GetSnapshotAsync();
                    var sendCollectionsData = sendCollections.Documents.Select(s => s.ConvertTo<Send_Collection>()).ToList();
                    foreach (var item in sendCollectionsData)
                    {
                        await _firestoreDb.Collection("Profile_data").Document(userUID).Collection("Climbing_History").Document(history.Location).Collection("Send_Collections").Document(item.ID).DeleteAsync();
                    }
                    await _firestoreDb.Collection("Profile_data").Document(userUID).Collection("Climbing_History").Document(history.Location).DeleteAsync();
                }

                await _firestoreDb.Collection("Profile_data").Document(userUID).DeleteAsync();
                return StatusCode.OK;
            }
            catch (Exception)
            {
                return StatusCode.Aborted;
                throw;
            }
        }

        public async Task<StatusCode> UpdateFollow(string userUID, string userToFollowUserUID)
        {
            try
            {
                var profileDocument = await _firestoreDb.Collection("Profile_data").Document(userUID).GetSnapshotAsync();
                var profileData = profileDocument.ConvertTo<ProfileDataDocument>();
                profileData.Friend_Ids.Add(userToFollowUserUID);
                await _firestoreDb.Collection("Profile_data").Document(userUID).UpdateAsync("Friend_Ids", profileData.Friend_Ids);

                var userToFollowDocument = await _firestoreDb.Collection("Profile_data").Document(userToFollowUserUID).GetSnapshotAsync();
                var userToFollowData = userToFollowDocument.ConvertTo<ProfileDataDocument>();
                userToFollowData.Follows_Me.Add(userUID);
                await _firestoreDb.Collection("Profile_data").Document(userToFollowUserUID).UpdateAsync("Follows_Me", userToFollowData.Follows_Me);

                return StatusCode.OK;
            }
            catch (Exception)
            {
                return StatusCode.Aborted;
                throw;
            }
        }

        public async Task<StatusCode> RemoveFollow(string userUID, string userToFollowUserUID)
        {
            try
            {
                var profileDocument = await _firestoreDb.Collection("Profile_data").Document(userUID).GetSnapshotAsync();
                var profileData = profileDocument.ConvertTo<ProfileDataDocument>();
                profileData.Friend_Ids.Remove(userToFollowUserUID);
                await _firestoreDb.Collection("Profile_data").Document(userUID).UpdateAsync("Friend_Ids", profileData.Friend_Ids);

                var userToFollowDocument = await _firestoreDb.Collection("Profile_data").Document(userToFollowUserUID).GetSnapshotAsync();
                var userToFollowData = userToFollowDocument.ConvertTo<ProfileDataDocument>();
                userToFollowData.Follows_Me.Remove(userUID);
                await _firestoreDb.Collection("Profile_data").Document(userToFollowUserUID).UpdateAsync("Follows_Me", userToFollowData.Follows_Me);

                return StatusCode.OK;
            }
            catch (Exception)
            {
                return StatusCode.Aborted;
                throw;
            }
        }

        public async Task<List<string>> GetFollowList(string userUID)
        {
            var profileDocument = await _firestoreDb.Collection("Profile_data").Document(userUID).GetSnapshotAsync();
            var profileData = profileDocument.ConvertTo<ProfileDataDocument>();
            return profileData.Friend_Ids;
        }

        public async Task<List<ClimbingScoreDocument>> GetClimbingScores(string climbingCenter)
        {
            List<ClimbingScoreDocument> climbingScores = new List<ClimbingScoreDocument>();
            var profileDocuments = await _firestoreDb.Collection("Profile_data").GetSnapshotAsync();
            var profileData = profileDocuments.Documents.Select(p => p.ConvertTo<ProfileDataDocument>()).ToList();
            foreach(var profile in profileData)
            {
                var historyDocuments = await _firestoreDb.Collection("Profile_data").Document(profile.ID).Collection("Climbing_History").Document(climbingCenter).GetSnapshotAsync();
                var historyData = historyDocuments.ConvertTo<Climbing_History>();
                climbingScores.Add(new ClimbingScoreDocument
                {
                    UserUID = profile.ID,
                    Rank = 0,
                    Name = profile.User_Email,
                    Center_Name = Regex.Replace(climbingCenter, "([a-z])([A-Z])", "$1 $2"),
                    Grade = historyData.Estimated_Grade,
                    Score = historyData.Total_Points
                });
            }

            climbingScores = climbingScores.OrderByDescending(p => p.Score).ToList();

            for (int i = 0; i < climbingScores.Count; i++)
            {
                climbingScores[i].Rank = i + 1;
            }

            return climbingScores;
        }
        public async Task<StatusCode> SubmitUserClimb(List<AreaRoutes> routes, string userUID, string climbingCenterName)
        {
            try
            {
                foreach (var route in routes)
                {
                    var newSendCollection = new Send_Collection()
                    {
                        ID = route.ID,
                        Area = route.AssignedArea,
                        Grade = route.Grade.Replace("Plus", "+"),
                        Points = CalculatePoints(route.Grade) + (route.UsersWhoFlashed.Contains(userUID) ? 17 : 0),
                        Tries = route.UsersWhoFlashed.Contains(userUID) ? 1 : 2,
                        SendDate = DateTime.Today.Ticks
                    };

                    await _firestoreDb.Collection("Profile_data").Document(userUID).Collection("Climbing_History").Document(climbingCenterName).Collection("Send_Collections").Document(route.ID).SetAsync(newSendCollection);
                }

                await UpdateTotalPointsAndEstimatedGrade(userUID, climbingCenterName);
                return StatusCode.OK;
            }
            catch (Exception)
            {
                return StatusCode.Aborted;
                throw;
            }
        }

        private int CalculatePoints(string grade)
        {
            switch(grade)
            {
                case "2":
                    return 200;

                case "2Plus":
                    return 250;

                case "3":
                    return 300;

                case "3Plus":
                    return 333;

                case "4":
                    return 400;

                case "4Plus":
                    return 433;

                case "5":
                    return 500;

                case "5Plus":
                    return 550;

                case "6A":
                    return 600;

                case "6APlus":
                    return 617;

                case "6B":
                    return 633;

                case "6BPlus":
                    return 650;

                case "6C":
                    return 667;

                case "6CPlus":
                    return 683;

                case "7A":
                    return 700;

                case "7APlus":
                    return 717;

                case "7B":
                    return 733;

                case "7BPlus":
                    return 750;

                case "7C":
                    return 767;

                case "7CPlus":
                    return 783;

                case "8A":
                    return 800;

                case "8APlus":
                    return 817;

                case "8B":
                    return 833;

                case "8BPlus":
                    return 850;

                case "8C":
                    return 867;

                case "8CPlus":
                    return 883;

                case "9A":
                    return 900;

                case "9APlus":
                    return 917;

                case "9B":
                    return 933;

                case "9BPlus":
                    return 950;

                default:
                    return 0;
            }
        }

        private async Task UpdateTotalPointsAndEstimatedGrade(string userUID, string climbingCenterName)
        {
            var sendCollectionDocuments = await _firestoreDb.Collection("Profile_data").Document(userUID).Collection("Climbing_History").Document(climbingCenterName).Collection("Send_Collections").GetSnapshotAsync();
            var sendCollectionData = sendCollectionDocuments.Documents.Select(s => s.ConvertTo<Send_Collection>()).ToList();
            int totalNumberOfCollections = sendCollectionData.Count;
            int totalPoints = 0;

            foreach(var send in sendCollectionData)
            {
                totalPoints += send.Points;
            }

            totalPoints = totalPoints / totalNumberOfCollections;
            string estimatedGrade = CalculateGrade(totalPoints);
            await _firestoreDb.Collection("Profile_data").Document(userUID).Collection("Climbing_History").Document(climbingCenterName).UpdateAsync("Total_Points", totalPoints);
            await _firestoreDb.Collection("Profile_data").Document(userUID).Collection("Climbing_History").Document(climbingCenterName).UpdateAsync("Estimated_Grade", estimatedGrade);
        }

        private string CalculateGrade(int points)
        {
            switch (points)
            {
                case int i when i < 300:
                    return "2";

                case int i when i >= 300 && i < 400:
                    return "3";

                case int i when i >= 400 && i < 433:
                    return "4";

                case int i when i >= 433 && i < 500:
                    return "4+";

                case int i when i >= 500 && i < 550:
                    return "5";

                case int i when i >= 550 && i < 600:
                    return "5+";

                case int i when i >= 600 && i < 617:
                    return "6A";

                case int i when i >= 617 && i < 633:
                    return "6A+";

                case int i when i >= 633 && i < 650:
                    return "6B";

                case int i when i >= 650 && i < 667:
                    return "6B+";

                case int i when i >= 667 && i < 683:
                    return "6C";

                case int i when i >= 683 && i < 700:
                    return "6C+";

                case int i when i >= 700 && i < 717:
                    return "7A";

                case int i when i >= 717 && i < 733:
                    return "7A+";

                case int i when i >= 733 && i < 750:
                    return "7B";

                case int i when i >= 750 && i < 767:
                    return "7B+";

                case int i when i >= 767 && i < 783:
                    return "7C";

                case int i when i >= 783 && i < 800:
                    return "7C+";

                case int i when i >= 800 && i < 817:
                    return "8A";

                case int i when i >= 817 && i < 833:
                    return "8A+";

                case int i when i >= 833 && i < 850:
                    return "8B";

                case int i when i >= 850 && i < 867:
                    return "8B+";

                case int i when i >= 867 && i < 883:
                    return "8C";

                case int i when i >= 883 && i < 900:
                    return "8C+";

                case int i when i >= 900 && i < 917:
                    return "9A";

                case int i when i >= 917 && i < 933:
                    return "9A+";

                case int i when i >= 933 && i < 950:
                    return "9B";

                case int i when i >= 950:
                    return "9B+";

                default:
                    return "Ungrated";
            }
        }

        public async Task<StatusCode> UpdateSelectedGym(string userUID, string newSelectedGym)
        {
            try
            {
                await _firestoreDb.Collection("Profile_data").Document(userUID).UpdateAsync("Selected_Gym", newSelectedGym);
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
