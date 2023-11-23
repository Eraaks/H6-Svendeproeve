using Google.Cloud.Firestore;
using Grpc.Core;
using Svendeproeve_KlatreApp_API.FirebaseDocuments;
using System.Text.RegularExpressions;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace Svendeproeve_KlatreApp_API.Services.SubServices
{
    public class KlatrecentreService
    {
        private readonly FirestoreDb _firestoreDb;
        public KlatrecentreService(FirestoreDb firestoreDb)
        {
            _firestoreDb = firestoreDb;
        }

        public async Task<StatusCode> AddClimbingCenter(ClimbingCenterDocument climbingCenter,string changerUserUID, string climbingCenterName)
        {
            try
            {
                var profileDocuments = await _firestoreDb.Collection("Profile_data").GetSnapshotAsync();
                var profileData = profileDocuments.Documents.Select(p => p.ConvertTo<ProfileDataDocument>()).ToList();
                foreach (var profile in profileData)
                {
                    Send_Collection newSend_Collection = new Send_Collection()
                    {
                        ID = Guid.NewGuid().ToString(),
                        Area = "",
                        Grade = "2",
                        Points = 200,
                        Tries = 2,
                        SendDate = DateTime.Today.Ticks,
                    };
                    Climbing_History newHistory = new Climbing_History()
                    {
                        ID = profile.ID,
                        Estimated_Grade = "2",
                        Location = "",
                        Total_Points = 200,
                        Send_Collections = new List<Send_Collection>() { newSend_Collection }
                    };

                    var newCollection = _firestoreDb.Collection("Profile_data").Document(profile.ID).Collection("Climbing_History").Document(climbingCenterName);
                    newHistory.Location = climbingCenterName;
                    await newCollection.SetAsync(newHistory);
                    if (newHistory.Send_Collections != null)
                    {
                        foreach (var sendCollection in newHistory.Send_Collections)
                        {
                            var registerSend = _firestoreDb.Collection("Profile_data").Document(profile.ID).Collection("Climbing_History").Document(climbingCenterName).Collection("Send_Collections").Document(sendCollection.ID);
                            await registerSend.SetAsync(sendCollection);
                        }
                    }
                }
                var collection = _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName);
                await collection.SetAsync(climbingCenter);
                await AddClimbingAreas(climbingCenterName, changerUserUID, climbingCenter.Areas);
                return StatusCode.OK;
            }
            catch (Exception)
            {
                return StatusCode.Aborted;
                throw;
            }

        }

        public async Task<StatusCode> DeleteClimbingCenter(string climbingCenterName)
        {
            try
            {
                var centerDocument = await _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).GetSnapshotAsync();
                var centerData = centerDocument.ConvertTo<ClimbingCenterDocument>();
                foreach (var area in centerData.AreaNames)
                {
                    var routeDocuments = await _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).Collection(area).Document(area).Collection("Routes").GetSnapshotAsync();
                    var routeData = routeDocuments.Documents.Select(r => r.ConvertTo<AreaRoutes>()).ToList();
                    foreach (var route in routeData)
                    {
                        await _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).Collection(area).Document(area).Collection("Routes").Document(route.ID).DeleteAsync();
                    }

                    await _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).Collection(area).Document(area).DeleteAsync();
                }

                await _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).DeleteAsync();
                return StatusCode.OK;
            }
            catch (Exception)
            {
                return StatusCode.Aborted;
                throw;
            }
        }

        public async Task<StatusCode> AddClimbingAreas(string climbingCenterName, string changerUserUID, List<Areas> areas)
        {
            try
            {
                var centerDocument = await _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).GetSnapshotAsync();
                var centerData = centerDocument.ConvertTo<ClimbingCenterDocument>();

                if (centerData.Moderators.Contains(changerUserUID))
                {
                    int number = 0;
                    var routeCount = await GetCenterRoutes(climbingCenterName);
                    foreach (var area in routeCount)
                    {
                        foreach (var route in area.AreaRoutes)
                        {
                            number++;
                        }
                    }

                    foreach (var area in areas)
                    {
                       
                        foreach (var route in area.AreaRoutes)
                        {
                            route.ID = Guid.NewGuid().ToString();
                            route.Number = number++;
                            route.AssignedArea = area.Name;
                        }
                    }

                    List<string> areaNames = new List<string>();
                    areaNames.AddRange(centerData.AreaNames);
                    foreach (var area in areas)
                    {
                        areaNames.Add(area.Name);
                        var collection = _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).Collection(area.Name).Document(area.Name);
                        await collection.SetAsync(area);
                        await AddClimbingRoutes(climbingCenterName, area.Name, area.AreaRoutes, "", true, false);
                    }

                    await _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).UpdateAsync("AreaNames", areaNames);
                    return StatusCode.OK;
                }
                else
                {
                    return StatusCode.Aborted;
                }
            }
            catch (Exception)
            {
                return StatusCode.Aborted;
                throw;
            }
        }

        public async Task<StatusCode> AddClimbingRoutes(string climbingCenterName, string climbingArea, List<AreaRoutes> areaRoutes, string changerUserUID, bool systemChanger, bool routesDirectly)
        {
            try
            {
                if (routesDirectly == true)
                {
                    int number = 0;
                    var routeCount = await GetCenterRoutes(climbingCenterName);
                    foreach (var area in routeCount)
                    {
                        foreach (var route in area.AreaRoutes)
                        {
                            number++;
                        }
                    }
                    foreach (var route in areaRoutes)
                    {
                        route.ID = Guid.NewGuid().ToString();
                        route.Number = number++;
                        route.AssignedArea = climbingArea;
                    }
                }
                var centerDocument = await _firestoreDb.Collection("Klatrecentre").GetSnapshotAsync();
                var centerData = centerDocument.Documents.Select(s => s.ConvertTo<ClimbingCenterDocument>()).ToList();
                foreach (var center in centerData)
                {
                    if (center.CenterName == climbingCenterName)
                    {
                        if (center.Moderators.Contains(changerUserUID) || systemChanger)
                        {
                            foreach (var area in areaRoutes)
                            {
                                var routesCollection = _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).Collection(climbingArea).Document(climbingArea).Collection("Routes").Document(area.ID);
                                await routesCollection.SetAsync(area);
                            }
                        }
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

        public async Task<List<ClimbingCenterDocument>> GetClimbingCentre()
        {
            var centerDocument = await _firestoreDb.Collection("Klatrecentre").GetSnapshotAsync();
            var centerData = centerDocument.Documents.Select(s => s.ConvertTo<ClimbingCenterDocument>()).ToList();
            foreach (var center in centerData)
            {
                List<Areas> area = new List<Areas>();
                if (center.AreaNames != null)
                {
                    foreach (var areaName in center.AreaNames)
                    {
                        List<AreaRoutes> areaRoutes = new List<AreaRoutes>();
                        var areaDocument = await _firestoreDb.Collection("Klatrecentre").Document(center.CenterName).Collection(areaName).GetSnapshotAsync();
                        var areaData = areaDocument.Select(a => a.ConvertTo<Areas>()).ToList();

                        foreach (var areas in areaData)
                        {
                            var routesDocument = await _firestoreDb.Collection("Klatrecentre").Document(center.CenterName).Collection(areaName).Document(areaName).Collection("Routes").GetSnapshotAsync();
                            var routesData = routesDocument.Select(r => r.ConvertTo<AreaRoutes>()).ToList();
                            if (routesData.Count != 0)
                            {
                                areaRoutes.AddRange(routesData);
                                areas.AreaRoutes = areaRoutes;
                            }
                        }

                        area.AddRange(areaData);
                    }
                }

                center.Areas = area;
                center.CenterName = Regex.Replace(center.CenterName, "([a-z])([A-Z])", "$1 $2");
            }

            return centerData;
        }

        public async Task<List<string>> GetClimbingCentreNames()
        {
            try
            {
                var centerDocuments = await _firestoreDb.Collection("Klatrecentre").GetSnapshotAsync();
                var centerData = centerDocuments.Documents.Select(c => c.ConvertTo<ClimbingCenterDocument>()).ToList();
                List<string> names = new List<string>();
                foreach (var c in centerData)
                {
                    names.Add(c.CenterName);
                }

                return names;
            }
            catch (Exception)
            {
                return new List<string>() { };
                throw;
            }

        }

        public async Task<StatusCode> DeleteClimbingRoute(string climbingCenterName, string climbingArea, string problemId, string changerUserUID, bool systemChanger)
        {
            try
            {
                var centerDocument = await _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).GetSnapshotAsync();
                var centerData = centerDocument.ConvertTo<ClimbingCenterDocument>();

                if (centerData.Moderators.Contains(changerUserUID) || systemChanger)
                {
                    var routeData = _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).Collection(climbingArea).Document(climbingArea).Collection("Routes").Document(problemId);
                    await routeData.DeleteAsync();
                }
                return StatusCode.OK;
            }
            catch (Exception)
            {
                return StatusCode.Aborted;
                throw;
            }
        }

        public async Task<StatusCode> DeleteClimbingArea(string climbingCenterName, string climbingArea, string changerUserUID, bool systemChanger)
        {
            try
            {
                var centerDocument = await _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).GetSnapshotAsync();
                var centerData = centerDocument.ConvertTo<ClimbingCenterDocument>();

                if (centerData.Moderators.Contains(changerUserUID) || systemChanger)
                {
                    var routeData = await _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).Collection(climbingArea).Document(climbingArea).Collection("Routes").GetSnapshotAsync();

                    foreach (var routes in routeData.Documents)
                    {
                        await _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).Collection(climbingArea).Document(climbingArea).Collection("Routes").Document(routes.Id).DeleteAsync();
                    }

                    await _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).Collection(climbingArea).Document(climbingArea).DeleteAsync();

                    centerData.AreaNames.Remove(climbingArea);
                    await _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).UpdateAsync("AreaNames", centerData.AreaNames);
                }
                return StatusCode.OK;
            }
            catch (Exception)
            {
                return StatusCode.Aborted;
                throw;
            }
        }


        public async Task<StatusCode> UpdateClimbingRoutes(AreaRoutes areaRoutes, string climbingCenterName, string climbingArea, string changerUserUID, bool systemChanger)
        {
            try
            {
                var centerDocument = await _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).GetSnapshotAsync();
                var centerData = centerDocument.ConvertTo<ClimbingCenterDocument>();

                if (centerData.Moderators.Contains(changerUserUID) || systemChanger)
                {
                    var routeData = _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).Collection(climbingArea).Document(climbingArea).Collection("Routes").Document(areaRoutes.ID);
                    await routeData.DeleteAsync();
                    routeData = _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).Collection(climbingArea).Document(climbingArea).Collection("Routes").Document(areaRoutes.ID);
                    await routeData.CreateAsync(areaRoutes);
                }
                return StatusCode.OK;
            }
            catch (Exception)
            {
                return StatusCode.Aborted;
                throw;
            }
        }

        public async Task<StatusCode> UpdateClimbingArea(string climbingCenterName, string climbingArea, string newValue, string changerUserUID, bool systemChanger)
        {
            try
            {
                var centerDocument = await _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).GetSnapshotAsync();
                var centerData = centerDocument.ConvertTo<ClimbingCenterDocument>();

                if (centerData.Moderators.Contains(changerUserUID) || systemChanger)
                {
                    var areaRoutes = new List<AreaRoutes>();
                    var areaRoutesDocuments = await _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).Collection(climbingArea).Document(climbingArea).Collection("Routes").GetSnapshotAsync();
                    var areaRoutesData = areaRoutesDocuments.Documents.Select(a => a.ConvertTo<AreaRoutes>()).ToList();
                    foreach (var route in areaRoutesData)
                    {
                        route.AssignedArea = newValue;
                        areaRoutes.Add(route);
                        await _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).Collection(climbingArea).Document(climbingArea).Collection("Routes").Document(route.ID).DeleteAsync();
                    }
                    centerData.AreaNames.Remove(climbingArea);
                    centerData.AreaNames.Add(newValue);

                    var newArea = new Areas()
                    {
                        Name = newValue,
                        Description = "",
                        AreaRoutes = areaRoutes,
                    };

                    await _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).UpdateAsync("AreaNames", centerData.AreaNames);
                    await _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).Collection(climbingArea).Document(climbingArea).DeleteAsync();
                    await _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).Collection(newValue).Document(newValue).SetAsync(newArea);
                    foreach (var route in areaRoutes)
                    {
                        await _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).Collection(newValue).Document(newValue).Collection("Routes").Document(route.ID).SetAsync(route);
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

        public async Task<ClimbingCenterDocument> GetSelectedClimbingCenter(string climbingCenterName)
        {
            try
            {
                var centerDocument = await _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).GetSnapshotAsync();
                var centerData = centerDocument.ConvertTo<ClimbingCenterDocument>();


                List<Areas> area = new List<Areas>();

                if (centerData.AreaNames != null)
                {
                    foreach (var areaName in centerData.AreaNames)
                    {
                        List<AreaRoutes> areaRoutes = new List<AreaRoutes>();
                        var areaDocument = await _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).Collection(areaName).GetSnapshotAsync();
                        var areaData = areaDocument.Select(a => a.ConvertTo<Areas>()).ToList();

                        foreach (var areas in areaData)
                        {
                            var routesDocument = await _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).Collection(areaName).Document(areaName).Collection("Routes").GetSnapshotAsync();
                            var routesData = routesDocument.Select(r => r.ConvertTo<AreaRoutes>()).ToList();
                            if (routesData.Count != 0)
                            {
                                areaRoutes.AddRange(routesData);
                                areas.AreaRoutes = areaRoutes;
                            }
                        }

                        area.AddRange(areaData);
                    }
                }

                centerData.Areas = area;
                centerData.CenterName = Regex.Replace(centerData.CenterName, "([a-z])([A-Z])", "$1 $2");

                return centerData;
            }
            catch (Exception)
            {
                return new ClimbingCenterDocument() { };
                throw;
            }

        }

        public async Task<List<Areas>> GetCenterRoutes(string centerName)
        {
            try
            {
                var centerDocument = await _firestoreDb.Collection("Klatrecentre").Document(centerName).GetSnapshotAsync();
                var centerData = centerDocument.ConvertTo<ClimbingCenterDocument>();
                List<Areas> area = new List<Areas>();
                if (centerData.AreaNames != null)
                {
                    foreach (var areaName in centerData.AreaNames)
                    {
                        List<AreaRoutes> areaRoutes = new List<AreaRoutes>();
                        var areaDocument = await _firestoreDb.Collection("Klatrecentre").Document(centerData.CenterName).Collection(areaName).GetSnapshotAsync();
                        var areaData = areaDocument.Select(a => a.ConvertTo<Areas>()).ToList();

                        foreach (var areas in areaData)
                        {
                            var routesDocument = await _firestoreDb.Collection("Klatrecentre").Document(centerData.CenterName).Collection(areaName).Document(areaName).Collection("Routes").GetSnapshotAsync();
                            var routesData = routesDocument.Select(r => r.ConvertTo<AreaRoutes>()).ToList();
                            if (routesData.Count != 0)
                            {
                                areaRoutes.AddRange(routesData);
                                foreach (var route in areaRoutes)
                                {
                                    switch (route.Color)
                                    {
                                        case "Black":
                                            route.Color = "255, 0, 0, 0";
                                            break;

                                        case "Red":
                                            route.Color = "255, 255, 0, 0";
                                            break;

                                        case "Orange":
                                            route.Color = "255, 255, 145, 0";
                                            break;

                                        case "Blue":
                                            route.Color = "255, 0, 68, 255";
                                            break;

                                        case "Yellow":
                                            route.Color = "255, 255, 251, 0";
                                            break;

                                        case "Green":
                                            route.Color = "255, 0, 255, 0";
                                            break;

                                        case "Light Blue":
                                            route.Color = "255, 0, 225, 255";
                                            break;
                                    }
                                }
                                areas.AreaRoutes = areaRoutes;
                            }
                        }

                        area.AddRange(areaData);
                    }
                }

                return area;
            }
            catch (Exception)
            {
                return new List<Areas>() { };
                throw;
            }

        }

        public async Task<StatusCode> UpdateRouteCompleters(List<AreaRoutes> routes, string climbingCenterName, string userUID)
        {
            try
            {
                foreach (var route in routes)
                {
                    var routeDocument = await _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).Collection(route.AssignedArea).Document(route.AssignedArea).Collection("Routes").Document(route.ID).GetSnapshotAsync();
                    var routeData = routeDocument.ConvertTo<AreaRoutes>();

                    if (route.UsersWhoFlashed.Contains(userUID))
                    {
                        if (!routeData.UsersWhoFlashed.Contains(userUID)) routeData.UsersWhoFlashed.Add(userUID);
                        if (routeData.UsersWhoFlashed.Contains("string")) routeData.UsersWhoFlashed.Remove("string");
                        await _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).Collection(route.AssignedArea).Document(route.AssignedArea).Collection("Routes").Document(route.ID).UpdateAsync("UsersWhoFlashed", routeData.UsersWhoFlashed);
                    }
                    else
                    {
                        if (!routeData.UsersWhoCompleted.Contains(userUID)) routeData.UsersWhoCompleted.Add(userUID);
                        if (routeData.UsersWhoCompleted.Contains("string")) routeData.UsersWhoCompleted.Remove("string");
                        await _firestoreDb.Collection("Klatrecentre").Document(climbingCenterName).Collection(route.AssignedArea).Document(route.AssignedArea).Collection("Routes").Document(route.ID).UpdateAsync("UsersWhoCompleted", routeData.UsersWhoCompleted);
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
    }
}
