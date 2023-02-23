using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

namespace Api.Data
{
    public class DataContext: DbContext
    {
        public DataContext(DbContextOptions<DataContext> options) : base(options)
        {
            
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            // modelBuilder.Entity<Skill>().HasData(
            //     new Skill {Id = 1, Name = "Fireball", Damage = 30},
            //     new Skill {Id = 2, Name = "Freezy", Damage = 20},
            //     new Skill {Id = 3, Name = "Blizzard", Damage = 50}
            // );
        }

        public DbSet<Usuario> Usuarios => Set<Usuario>();
    }
}