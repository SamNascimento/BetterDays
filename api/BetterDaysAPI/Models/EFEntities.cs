using Microsoft.EntityFrameworkCore;

namespace BetterDaysAPI.Models
{

    public class EFEntities : DbContext
    {
        private readonly string _conn;

        public EFEntities(string conn) 
        {
            _conn = conn;
        }

        public virtual DbSet<Usuario> Usuario { get; set; }
        public virtual DbSet<Diario> Diario { get; set; }
        public virtual DbSet<ListaMetas> ListaMeta { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            var connectionstring = _conn;

            if (!optionsBuilder.IsConfigured)
            {
                optionsBuilder
                    .UseMySQL(connectionstring)
                    .LogTo(Console.WriteLine)
                    .EnableDetailedErrors()
                    .EnableSensitiveDataLogging();
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Usuario>(entity =>
            {
                entity.Property(e => e.idUsuario)
                    .HasColumnType("BIGINT")
                    .ValueGeneratedOnAdd();
                
                entity.Property(e => e.nome)
                    .HasColumnType("VARCHAR(255)")
                    .IsRequired();

                entity.Property(e => e.loginUsuario)
                    .HasColumnType("VARCHAR(20)")
                    .IsRequired();

                entity.Property(e => e.senhaUsuario)
                    .HasColumnType("VARCHAR(30) ")
                    .IsRequired();

                entity.HasKey(e => e.idUsuario);
            });

            modelBuilder.Entity<Diario>(entity =>
            {
                entity.Property(e => e.idDiario)
                    .HasColumnType("BIGINT")
                    .ValueGeneratedOnAdd();

                entity.Property(e => e.idUsuario)
                    .HasColumnType("BIGINT")
                    .IsRequired();
                
                entity.Property(e => e.dataRegistro)
                    .HasColumnType("DATETIME")
                    .IsRequired();

                entity.Property(e => e.titulo)
                    .HasColumnType("VARCHAR(30)")
                    .IsRequired();

                entity.Property(e => e.nota)
                    .HasColumnType("TEXT")
                    .IsRequired();

                entity.HasOne(e => e.Usuario)
                    .WithMany(e => e.Diarios)
                    .HasForeignKey(e => e.idUsuario)
                    .HasConstraintName("fk_diario_usuario");

                entity.HasKey(e => e.idDiario);
            });

            modelBuilder.Entity<ListaMetas>(entity =>
            {
                entity.Property(e => e.idMetas)
                    .HasColumnType("BIGINT")
                    .ValueGeneratedOnAdd();

                entity.Property(e => e.idUsuario)
                    .HasColumnType("BIGINT")
                    .IsRequired();

                entity.Property(e => e.dataRegistro)
                    .HasColumnType("DATETIME")
                    .IsRequired();

                entity.Property(e => e.titulo)
                    .HasColumnType("VARCHAR(30)")
                    .IsRequired();

                entity.Property(e => e.descricao)
                    .HasColumnType("TEXT")
                    .IsRequired();

                entity.Property(e => e.isConcluido)
                    .HasColumnType("TINYINT")
                    .IsRequired()
                    .HasDefaultValue(0);

                entity.HasOne(e => e.Usuario)
                    .WithMany(e => e.ListaMetas)
                    .HasForeignKey(e => e.idUsuario)
                    .HasConstraintName("fk_listaMetas_usuario");

                entity.HasKey(e => e.idMetas);
            });
        }
    }
}