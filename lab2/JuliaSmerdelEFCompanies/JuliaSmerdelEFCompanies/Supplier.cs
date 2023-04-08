using System;
using System.ComponentModel.DataAnnotations.Schema;

namespace JuliaSmerdelEFCompanies
{
    [Table("Suppliers")]
    public class Supplier : Company
    {
        public int SupplierID { get; set; }
        public string bankAccountNumber { get; set; }
    }
}

