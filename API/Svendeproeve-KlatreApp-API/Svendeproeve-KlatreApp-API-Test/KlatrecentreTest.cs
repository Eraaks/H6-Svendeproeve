using Google.Cloud.Firestore;
using Grpc.Core;
using Svendeproeve_KlatreApp_API.FirebaseDocuments;
using Svendeproeve_KlatreApp_API.Services.SubServices;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Svendeproeve_KlatreApp_API_Test
{
    public class KlatrecentreTest
    {
        private FirestoreDb _firestoreDB;
        private readonly KlatrecentreService _klatreCenterService;

        public KlatrecentreTest()
        {
            Environment.SetEnvironmentVariable("GOOGLE_APPLICATION_CREDENTIALS", @"C:\Users\Eraaks\Downloads\h6-svendeproeve-klatreapp-firebase-adminsdk-q7f96-1575848134.json");
            _firestoreDB = FirestoreDb.Create("h6-svendeproeve-klatreapp");
            _klatreCenterService = new KlatrecentreService(_firestoreDB);
        }

        [Fact]
        public async Task AddClimbingCenter()
        {
            // Arrange
            var changerUserUID = "QjjHBUwHqqOH1atLiuM7wi63SlO2";
            var climbingCenterName = "TestingCenter";
            var center = new ClimbingCenterDocument
            {
                CenterName = climbingCenterName,
                Description = "This is a test",
                Location = "A Magical Place",
                Moderator_Code = Guid.NewGuid().ToString(),
              Moderators = new List<string> { changerUserUID },
                AreaNames = new List<string> { "Test" },
                Areas = new List<Areas>()
                {
                    new Areas()
                    {
                        Name = "Test",
                        Description = "Test",
                        AreaRoutes = new List<AreaRoutes>()
                        {
                            new AreaRoutes()
                            {
                                ID = "",
                                Color = "Black",
                                Grade = "6C",
                                UsersWhoCompleted = new List<string>() { "string" },
                                UsersWhoFlashed = new List<string>() { "string" },
                                Number = 0,
                                AssignedArea = "",
                            }
                        }
                    }
                }
            };

            // Act
            var result = await _klatreCenterService.AddClimbingCenter(center, changerUserUID, climbingCenterName);
            await _klatreCenterService.DeleteClimbingCenter(climbingCenterName);

            // Assert
            Assert.Equal(StatusCode.OK, result);
        }

        [Fact]
        public async Task DeleteClimbingCenter()
        {
            // ArrangeUsername = Guid.NewGuid().ToString()
            var changerUserUID = "QjjHBUwHqqOH1atLiuM7wi63SlO2";
            var climbingCenterName = "TestingCenter";
            var center = new ClimbingCenterDocument
            {
                CenterName = climbingCenterName,
                Description = "This is a test",
                Location = "A Magical Place",
                Moderator_Code = Guid.NewGuid().ToString(),
                Moderators = new List<string> { changerUserUID },
                AreaNames = new List<string> { "Test" },
                Areas = new List<Areas>()
                {
                    new Areas()
                    {
                        Name = "Test",
                        Description = "Test",
                        AreaRoutes = new List<AreaRoutes>()
                        {
                            new AreaRoutes()
                            {
                                ID = "",
                                Color = "Black",
                                Grade = "6C",
                                UsersWhoCompleted = new List<string>() { "string" },
                                UsersWhoFlashed = new List<string>() { "string" },
                                Number = 0,
                                AssignedArea = "",
                            }
                        }
                    }
                }
            };

            // Act
            await _klatreCenterService.AddClimbingCenter(center, changerUserUID, climbingCenterName);
            var result = await _klatreCenterService.DeleteClimbingCenter(climbingCenterName);

            // Assert
            Assert.Equal(StatusCode.OK, result);
        }

        [Fact]
        public async Task AddAreaToClimbingCenter()
        {
            // Arrange
            var changerUserUID = "QjjHBUwHqqOH1atLiuM7wi63SlO2";
            var climbingCenterName = "TestingCenter";
            var center = new ClimbingCenterDocument
            {
                CenterName = climbingCenterName,
                Description = "This is a test",
                Location = "A Magical Place",
                Moderator_Code = Guid.NewGuid().ToString(),
                Moderators = new List<string> { "QjjHBUwHqqOH1atLiuM7wi63SlO2" },
                AreaNames = new List<string> { "Test" },
                Areas = new List<Areas>()
                {
                    new Areas()
                    {
                        Name = "Test",
                        Description = "Test",
                        AreaRoutes = new List<AreaRoutes>()
                        {
                            new AreaRoutes()
                            {
                                ID = "",
                                Color = "Black",
                                Grade = "6C",
                                UsersWhoCompleted = new List<string>() { "string" },
                                UsersWhoFlashed = new List<string>() { "string" },
                                Number = 0,
                                AssignedArea = "",
                            }
                        }
                    }
                }
            };

            var newArea = new List<Areas>()
            {
                new Areas()
                {
                    Name = "New Area2",
                    Description = "New Area2",
                    AreaRoutes = new List<AreaRoutes>()
                            {
                                new AreaRoutes()
                                {
                                    ID = "",
                                    Color = "Black",
                                    Grade = "6C",
                                    UsersWhoCompleted = new List<string>() { "string" },
                                    UsersWhoFlashed = new List<string>() { "string" },
                                    Number = 0,
                                    AssignedArea = "",
                                }
                            }
                }

            };

            // Act
            await _klatreCenterService.AddClimbingCenter(center, changerUserUID, climbingCenterName);
            var result = await _klatreCenterService.AddClimbingAreas(climbingCenterName, changerUserUID, newArea);
            await _klatreCenterService.DeleteClimbingCenter(climbingCenterName);

            // Assert
            Assert.Equal(StatusCode.OK, result);
        }

        [Fact]
        public async Task AddClimbingRoutes()
        {
            // Arrange
            var changerUserUID = "QjjHBUwHqqOH1atLiuM7wi63SlO2";
            var climbingCenterName = "TestingCenter";
            var center = new ClimbingCenterDocument
            {
                CenterName = climbingCenterName,
                Description = "This is a test",
                Location = "A Magical Place",
                Moderator_Code = Guid.NewGuid().ToString(),
                Moderators = new List<string> { "QjjHBUwHqqOH1atLiuM7wi63SlO2" },
                AreaNames = new List<string> { "Test" },
                Areas = new List<Areas>()
                {
                    new Areas()
                    {
                        Name = "Test",
                        Description = "Test",
                        AreaRoutes = new List<AreaRoutes>()
                        {
                            new AreaRoutes()
                            {
                                ID = "",
                                Color = "Black",
                                Grade = "6C",
                                UsersWhoCompleted = new List<string>() { "string" },
                                UsersWhoFlashed = new List<string>() { "string" },
                                Number = 0,
                                AssignedArea = "",
                            }
                        }
                    }
                }
            };

            var areaRoutes = new List<AreaRoutes>()
            {
                  new AreaRoutes()
                  {
                      ID = "",
                      Color = "Blue",
                      Grade = "6B",
                      UsersWhoCompleted = new List<string>() { "string" },
                      UsersWhoFlashed = new List<string>() { "string" },
                      Number = 0,
                      AssignedArea = "",
                  },
                  new AreaRoutes()
                  {
                      ID = "",
                      Color = "Red",
                      Grade = "6C+",
                      UsersWhoCompleted = new List<string>() { "string" },
                      UsersWhoFlashed = new List<string>() { "string" },
                      Number = 0,
                      AssignedArea = "",
                  },
            };

            // Act
            await _klatreCenterService.AddClimbingCenter(center, changerUserUID, climbingCenterName);
            var result = await _klatreCenterService.AddClimbingRoutes(climbingCenterName, "Test", areaRoutes, "", true, true);
            await _klatreCenterService.DeleteClimbingCenter(climbingCenterName);

            // Assert
            Assert.Equal(StatusCode.OK, result);
        }

        [Fact]
        public async Task GetClimbingCentre()
        {
            // Arrange
            var result = new List<ClimbingCenterDocument>();

            // Act
            result.AddRange(await _klatreCenterService.GetClimbingCentre());

            // Assert
            Assert.Equal(3, result.Count);
        }

        [Fact]
        public async Task GetClimbingCentreNames()
        {
            // Arrange
            var result = new List<string>();

            // Act
            result.AddRange(await _klatreCenterService.GetClimbingCentreNames());

            // Assert
            Assert.Equal(3, result.Count);
        }

        [Fact]
        public async Task DeleteClimbingRoute()
        {
            // Arrange
            var changerUserUID = "QjjHBUwHqqOH1atLiuM7wi63SlO2";
            StatusCode result;
            var climbingCenterName = "TestingCenter";
            var center = new ClimbingCenterDocument
            {
                CenterName = climbingCenterName,
                Description = "This is a test",
                Location = "A Magical Place",
                Moderator_Code = Guid.NewGuid().ToString(),
                Moderators = new List<string> { "QjjHBUwHqqOH1atLiuM7wi63SlO2" },
                AreaNames = new List<string> { "Test" },
                Areas = new List<Areas>()
                {
                    new Areas()
                    {
                        Name = "Test",
                        Description = "Test",
                        AreaRoutes = new List<AreaRoutes>()
                        {
                            new AreaRoutes()
                            {
                                ID = "",
                                Color = "Black",
                                Grade = "6C",
                                UsersWhoCompleted = new List<string>() { "string" },
                                UsersWhoFlashed = new List<string>() { "string" },
                                Number = 0,
                                AssignedArea = "",
                            }
                        }
                    }
                }
            };

            // Act
            await _klatreCenterService.AddClimbingCenter(center, changerUserUID, climbingCenterName);
            var centerData = await _klatreCenterService.GetSelectedClimbingCenter(climbingCenterName);
            var problemID = centerData.Areas.FirstOrDefault(a => a.Name == "Test").AreaRoutes.First().ID;
            result = await _klatreCenterService.DeleteClimbingRoute(climbingCenterName, "Test", problemID, "", true);

            // Assert
            Assert.Equal(StatusCode.OK, result);
        }

        [Fact]
        public async Task DeleteClimbingArea()
        {
            // Arrange
            var changerUserUID = "QjjHBUwHqqOH1atLiuM7wi63SlO2";
            StatusCode result;
            var climbingCenterName = "TestingCenter";
            var center = new ClimbingCenterDocument
            {
                CenterName = climbingCenterName,
                Description = "This is a test",
                Location = "A Magical Place",
                Moderator_Code = Guid.NewGuid().ToString(),
                Moderators = new List<string> { "QjjHBUwHqqOH1atLiuM7wi63SlO2" },
                AreaNames = new List<string> { "Test" },
                Areas = new List<Areas>()
                {
                    new Areas()
                    {
                        Name = "Test",
                        Description = "Test",
                        AreaRoutes = new List<AreaRoutes>()
                        {
                            new AreaRoutes()
                            {
                                ID = "",
                                Color = "Black",
                                Grade = "6C",
                                UsersWhoCompleted = new List<string>() { "string" },
                                UsersWhoFlashed = new List<string>() { "string" },
                                Number = 0,
                                AssignedArea = "",
                            }
                        }
                    },
                    new Areas()
                    {
                        Name = "Test2",
                        Description = "Test2",
                        AreaRoutes = new List<AreaRoutes>()
                        {
                            new AreaRoutes()
                            {
                                ID = "",
                                Color = "Black",
                                Grade = "6C",
                                UsersWhoCompleted = new List<string>() { "string" },
                                UsersWhoFlashed = new List<string>() { "string" },
                                Number = 0,
                                AssignedArea = "",
                            }
                        }
                    }
                }
            };

            // Act
            await _klatreCenterService.AddClimbingCenter(center, changerUserUID, climbingCenterName);
            result = await _klatreCenterService.DeleteClimbingArea(climbingCenterName, "Test2", "", true);
            await _klatreCenterService.DeleteClimbingCenter(climbingCenterName);

            // Assert
            Assert.Equal(StatusCode.OK, result);
        }

        [Fact]
        public async Task UpdateClimbingRoutes()
        {
            // Arrange
            var changerUserUID = "QjjHBUwHqqOH1atLiuM7wi63SlO2";
            StatusCode result;
            var climbingCenterName = "TestingCenter";
            var center = new ClimbingCenterDocument
            {
                CenterName = climbingCenterName,
                Description = "This is a test",
                Location = "A Magical Place",
                Moderator_Code = Guid.NewGuid().ToString(),
                Moderators = new List<string> { "QjjHBUwHqqOH1atLiuM7wi63SlO2" },
                AreaNames = new List<string> { "Test" },
                Areas = new List<Areas>()
                {
                    new Areas()
                    {
                        Name = "Test",
                        Description = "Test",
                        AreaRoutes = new List<AreaRoutes>()
                        {
                            new AreaRoutes()
                            {
                                ID = "",
                                Color = "Black",
                                Grade = "6C",
                                UsersWhoCompleted = new List<string>() { "string" },
                                UsersWhoFlashed = new List<string>() { "string" },
                                Number = 0,
                                AssignedArea = "",
                            }
                        }
                    }
                }
            };
            var newAreaRoute = new AreaRoutes()
            {
                ID = "",
                Color = "Yellow",
                Grade = "6A",
                UsersWhoCompleted = new List<string>() { "string" },
                UsersWhoFlashed = new List<string>() { "string" },
                Number = 0,
                AssignedArea = "",
            };

            // Act
            await _klatreCenterService.AddClimbingCenter(center, changerUserUID, climbingCenterName);
            var centerData = await _klatreCenterService.GetSelectedClimbingCenter(climbingCenterName);
            var problem = centerData.Areas.FirstOrDefault(a => a.Name == "Test").AreaRoutes.First();
            newAreaRoute.ID = problem.ID;
            newAreaRoute.Number = problem.Number;
            newAreaRoute.AssignedArea = problem.AssignedArea;
            result = await _klatreCenterService.UpdateClimbingRoutes(newAreaRoute, climbingCenterName, newAreaRoute.AssignedArea, "", true);
            await _klatreCenterService.DeleteClimbingCenter(climbingCenterName);

            // Assert
            Assert.Equal(StatusCode.OK, result);
        }

        [Fact]
        public async Task UpdateClimbingArea()
        {
            // Arrange
            var changerUserUID = "QjjHBUwHqqOH1atLiuM7wi63SlO2";
            StatusCode result;
            var climbingCenterName = "TestingCenter";
            var center = new ClimbingCenterDocument
            {
                CenterName = climbingCenterName,
                Description = "This is a test",
                Location = "A Magical Place",
                Moderator_Code = Guid.NewGuid().ToString(),
                Moderators = new List<string> { "QjjHBUwHqqOH1atLiuM7wi63SlO2" },
                AreaNames = new List<string> { "Test" },
                Areas = new List<Areas>()
                {
                    new Areas()
                    {
                        Name = "Test",
                        Description = "Test",
                        AreaRoutes = new List<AreaRoutes>()
                        {
                            new AreaRoutes()
                            {
                                ID = "",
                                Color = "Black",
                                Grade = "6C",
                                UsersWhoCompleted = new List<string>() { "string" },
                                UsersWhoFlashed = new List<string>() { "string" },
                                Number = 0,
                                AssignedArea = "",
                            }
                        }
                    }
                }
            };

            // Act
            await _klatreCenterService.AddClimbingCenter(center, changerUserUID, climbingCenterName);
            result = await _klatreCenterService.UpdateClimbingArea(climbingCenterName, "Test", "Test2", "", true);
            await _klatreCenterService.DeleteClimbingCenter(climbingCenterName);

            // Assert
            Assert.Equal(StatusCode.OK, result);
        }

        [Fact]
        public async Task GetSelectedClimbingCenter()
        {
            // Arrange
            var changerUserUID = "QjjHBUwHqqOH1atLiuM7wi63SlO2";
            var climbingCenterName = "TestingCenter";
            var center = new ClimbingCenterDocument
            {
                CenterName = climbingCenterName,
                Description = "This is a test",
                Location = "A Magical Place",
                Moderator_Code = Guid.NewGuid().ToString(),
                Moderators = new List<string> {  },
                AreaNames = new List<string> { "Test" },
                Areas = new List<Areas>()
                {
                    new Areas()
                    {
                        Name = "Test",
                        Description = "Test",
                        AreaRoutes = new List<AreaRoutes>()
                        {
                            new AreaRoutes()
                            {
                                ID = "",
                                Color = "Black",
                                Grade = "6C",
                                UsersWhoCompleted = new List<string>() { "string" },
                                UsersWhoFlashed = new List<string>() { "string" },
                                Number = 0,
                                AssignedArea = "",
                            }
                        }
                    }
                }
            };

            // Act
            await _klatreCenterService.AddClimbingCenter(center, changerUserUID, climbingCenterName);
            var result = await _klatreCenterService.GetSelectedClimbingCenter(climbingCenterName);
            await _klatreCenterService.DeleteClimbingCenter(climbingCenterName);

            // Assert
            Assert.Equal(climbingCenterName, result.CenterName.Replace(" ", ""));
        }

        [Fact]
        public async Task GetCenterRoutes()
        {
            // Arrange
            var changerUserUID = "QjjHBUwHqqOH1atLiuM7wi63SlO2";
            List<Areas> areas = new List<Areas>();
            var climbingCenterName = "TestingCenter";
            var center = new ClimbingCenterDocument
            {
                CenterName = climbingCenterName,
                Description = "This is a test",
                Location = "A Magical Place",
                Moderator_Code = Guid.NewGuid().ToString(),
                Moderators = new List<string> { changerUserUID },
                AreaNames = new List<string> { "Test" },
                Areas = new List<Areas>()
                {
                    new Areas()
                    {
                        Name = "Test",
                        Description = "Test",
                        AreaRoutes = new List<AreaRoutes>()
                        {
                            new AreaRoutes()
                            {
                                ID = "string",
                                Color = "Black",
                                Grade = "6C",
                                UsersWhoCompleted = new List<string>() { "string" },
                                UsersWhoFlashed = new List<string>() { "string" },
                                Number = 0,
                                AssignedArea = "string",
                            }
                        }
                    }
                }
            };

            // Act
            await _klatreCenterService.AddClimbingCenter(center, changerUserUID, climbingCenterName);
            var result = await _klatreCenterService.GetCenterRoutes(climbingCenterName);
            areas.AddRange(result);
            await _klatreCenterService.DeleteClimbingCenter(climbingCenterName);

            // Assert
            Assert.NotNull(areas);
        }

        [Fact]
        public async Task UpdateRouteCompleters()
        {
            // Arrange
            var changerUserUID = "QjjHBUwHqqOH1atLiuM7wi63SlO2";
            var climbingCenterName = "TestingCenter";
            var center = new ClimbingCenterDocument
            {
                CenterName = climbingCenterName,
                Description = "This is a test",
                Location = "A Magical Place",
                Moderator_Code = Guid.NewGuid().ToString(),
              Moderators = new List<string> { changerUserUID },
                AreaNames = new List<string> { "Test" },
                Areas = new List<Areas>()
                {
                    new Areas()
                    {
                        Name = "Test",
                        Description = "Test",
                        AreaRoutes = new List<AreaRoutes>()
                        {
                            new AreaRoutes()
                            {
                                ID = "",
                                Color = "Black",
                                Grade = "6C",
                                UsersWhoCompleted = new List<string>() { "string" },
                                UsersWhoFlashed = new List<string>() { "string" },
                                Number = 0,
                                AssignedArea = "",
                            },
                            new AreaRoutes()
                            {
                                ID = "",
                                Color = "Blue",
                                Grade = "6B+",
                                UsersWhoCompleted = new List<string>() { "string" },
                                UsersWhoFlashed = new List<string>() { "string" },
                                Number = 0,
                                AssignedArea = "",
                            }
                        }
                    }
                }
            };

            // Act
            await _klatreCenterService.AddClimbingCenter(center, changerUserUID, climbingCenterName);
            var routes = await _klatreCenterService.GetSelectedClimbingCenter(climbingCenterName);
            var route = routes.Areas.FirstOrDefault().AreaRoutes.FirstOrDefault();
            route.UsersWhoCompleted.Add("Tester");
            List<AreaRoutes> areaRoutes = new List<AreaRoutes>
            {
                route
            };
            var result = await _klatreCenterService.UpdateRouteCompleters(areaRoutes, climbingCenterName, "Tester");
            await _klatreCenterService.DeleteClimbingCenter(climbingCenterName);

            // Assert
            Assert.Equal(StatusCode.OK, result);
        }
    }
}
