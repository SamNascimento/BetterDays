var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// Adiciona política Cors para poder receber chamadas de qualquer fonte
builder.Services.AddCors(option =>
{
    option.AddDefaultPolicy(policy => 
    {
        policy
            .AllowAnyHeader()
            .AllowAnyMethod()
            .AllowAnyOrigin();
    });
});

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

// Pega os arquivos da pasta wwwroot como estáticos
app.UseStaticFiles();

app.UseAuthorization();

app.MapControllers();

app.Run();
