﻿// <auto-generated />
using JuliaSmerdelEFCompanies;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Migrations;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;

#nullable disable

namespace JuliaSmerdelEFCompanies.Migrations
{
    [DbContext(typeof(CompanyContext))]
    [Migration("20230408113512_CompaniesInit")]
    partial class CompaniesInit
    {
        /// <inheritdoc />
        protected override void BuildTargetModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder.HasAnnotation("ProductVersion", "7.0.4");

            modelBuilder.Entity("JuliaSmerdelEFCompanies.Company", b =>
                {
                    b.Property<int>("CompanyID")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("INTEGER");

                    b.Property<string>("City")
                        .IsRequired()
                        .HasColumnType("TEXT");

                    b.Property<string>("CompanyName")
                        .IsRequired()
                        .HasColumnType("TEXT");

                    b.Property<string>("Discriminator")
                        .IsRequired()
                        .HasColumnType("TEXT");

                    b.Property<string>("Street")
                        .IsRequired()
                        .HasColumnType("TEXT");

                    b.Property<string>("ZipCode")
                        .IsRequired()
                        .HasColumnType("TEXT");

                    b.HasKey("CompanyID");

                    b.ToTable("Companies");

                    b.HasDiscriminator<string>("Discriminator").HasValue("Company");

                    b.UseTphMappingStrategy();
                });

            modelBuilder.Entity("JuliaSmerdelEFCompanies.Customer", b =>
                {
                    b.HasBaseType("JuliaSmerdelEFCompanies.Company");

                    b.Property<int>("CustomerID")
                        .HasColumnType("INTEGER");

                    b.Property<int>("Discount")
                        .HasColumnType("INTEGER");

                    b.HasDiscriminator().HasValue("Customer");
                });

            modelBuilder.Entity("JuliaSmerdelEFCompanies.Supplier", b =>
                {
                    b.HasBaseType("JuliaSmerdelEFCompanies.Company");

                    b.Property<int>("SupplierID")
                        .HasColumnType("INTEGER");

                    b.Property<string>("bankAccountNumber")
                        .IsRequired()
                        .HasColumnType("TEXT");

                    b.HasDiscriminator().HasValue("Supplier");
                });
#pragma warning restore 612, 618
        }
    }
}
