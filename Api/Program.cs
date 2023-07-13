using Microsoft.OpenApi.Models;
using Swashbuckle.AspNetCore.Filters;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using Api.Data;
using Microsoft.EntityFrameworkCore;
using Api.Services.CuentaService;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

// Adding DB
builder.Services.AddDbContext<DataContext>(
options =>
{
    options.UseMySql(builder.Configuration.GetConnectionString("DefaultConnection"),
    Microsoft.EntityFrameworkCore.ServerVersion.Parse("8.0.29-mysql"));
});

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c => {

    c.AddSecurityDefinition("oauth2", new OpenApiSecurityScheme{
        Description = """Standard Authorization header using the Bearer scheme. Example: "bearer {token}" """,
        In = ParameterLocation.Header,
        Name = "Authorization",
        Type = SecuritySchemeType.ApiKey
    });


    c.OperationFilter<SecurityRequirementsOperationFilter>();
});

// Se inyecta el servicio de HttpContextAccesor para mover el uso de ids a partir del token al servicio en vez del controller
// esto porque vamos a necesitar siempre el id del current user para cada operacion del crud
builder.Services.AddHttpContextAccessor();

// Registro del servicio automapper
builder.Services.AddAutoMapper(typeof(Program).Assembly);

// Inyeccion de servicios
builder.Services.AddScoped<ICuentaService, CuentaService>();
builder.Services.AddScoped<IAuthRepository, AuthRepository>();

// Se agrega el servicio para implementar authentication middleware
builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options => {
        options.TokenValidationParameters = new TokenValidationParameters
            {
                ValidateIssuerSigningKey = true,
                IssuerSigningKey = new SymmetricSecurityKey(System.Text.Encoding.UTF8
                    .GetBytes(builder.Configuration.GetSection("AppSettings:Token").Value!)),
                ValidateIssuer = false,
                ValidateAudience = false
            };
    });
    
var app = builder.Build();

// Configure the HTTP request pipeline.
//if (app.Environment.IsDevelopment())
//{
    app.UseSwagger();
    app.UseSwaggerUI();
//}

//app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
