using System;
using Microsoft.EntityFrameworkCore;
namespace JuliaSmerdelEFProducts
{
	public class ProductContext : DbContext
	{
		public DbSet<Product> Products { get; set; }
        public DbSet<Invoice> Invoices { get; set; }
        public DbSet<InvoiceInfo> InvoiceInfos { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            base.OnConfiguring(optionsBuilder);
            optionsBuilder.UseSqlite("Datasource=ProductsDatabase");
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<InvoiceInfo>().HasKey(t => new { t.InvoiceNumber, t.ProductID });

        }
    }
}

