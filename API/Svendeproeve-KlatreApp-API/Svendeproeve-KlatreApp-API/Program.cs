
using Google.Cloud.Firestore;
using Svendeproeve_KlatreApp_API.Services;

namespace Svendeproeve_KlatreApp_API
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            Environment.SetEnvironmentVariable("GOOGLE_APPLICATION_CREDENTIALS", @"C:\Users\Eraaks\Downloads\h6-svendeproeve-klatreapp-firebase-adminsdk-7l50x-662b9ddd66.json");

            builder.Services.AddSingleton(s => new FirestoreService(
            FirestoreDb.Create("h6-svendeproeve-klatreapp")
            ));

            // Add services to the container.

            builder.Services.AddControllers();
            // Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
            builder.Services.AddEndpointsApiExplorer();
            builder.Services.AddSwaggerGen();

            var app = builder.Build();

            // Configure the HTTP request pipeline.
            if (app.Environment.IsDevelopment())
            {
                app.UseSwagger();
                app.UseSwaggerUI();
            }

            app.UseHttpsRedirection();

            app.UseAuthorization();


            app.MapControllers();

            app.Run();
        }
    }
}