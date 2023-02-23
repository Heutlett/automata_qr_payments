using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

#pragma warning disable CA1814 // Prefer jagged arrays over multidimensional

namespace Api.Migrations
{
    /// <inheritdoc />
    public partial class Ubicacion : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Ubicaciones",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    Provincia = table.Column<int>(type: "int", nullable: false),
                    NombreProvincia = table.Column<string>(type: "longtext", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    Canton = table.Column<int>(type: "int", nullable: false),
                    NombreCanton = table.Column<string>(type: "longtext", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    Distrito = table.Column<int>(type: "int", nullable: false),
                    NombreDistrito = table.Column<string>(type: "longtext", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4"),
                    Barrio = table.Column<int>(type: "int", nullable: false),
                    NombreBarrio = table.Column<string>(type: "longtext", nullable: false)
                        .Annotation("MySql:CharSet", "utf8mb4")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Ubicaciones", x => x.Id);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.InsertData(
                table: "Ubicaciones",
                columns: new[] { "Id", "Barrio", "Canton", "Distrito", "NombreBarrio", "NombreCanton", "NombreDistrito", "NombreProvincia", "Provincia" },
                values: new object[,]
                {
                    { 1, 1, 1, 1, "Amón", "San José", "CARMEN", "San José", 1 },
                    { 2, 2, 1, 1, "Aranjuez", "San José", "CARMEN", "San José", 1 },
                    { 3, 3, 1, 1, "California (parte)", "San José", "CARMEN", "San José", 1 },
                    { 4, 1, 8, 1, "Danto", "Coto Brus", "SAN VITO", "Puntarenas", 6 },
                    { 5, 11, 8, 1, "Danto", "Coto Brus", "SAN VITO", "Puntarenas", 6 }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Ubicaciones");
        }
    }
}
