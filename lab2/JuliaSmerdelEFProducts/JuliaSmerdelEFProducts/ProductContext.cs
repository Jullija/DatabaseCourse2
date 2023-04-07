using System;
using Microsoft.EntityFrameworkCore;
namespace JuliaSmerdelEFProducts
{
	public class ProductContext : DbContext
	{
		public DbSet<Product> Products { get; set; }
        public DbSet<Supplier> Suppliers { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            base.OnConfiguring(optionsBuilder);
            optionsBuilder.UseSqlite("Datasource=ProductsDatabase");
        }
    }
}

