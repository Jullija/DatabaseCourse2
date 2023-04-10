using System;
using System.ComponentModel.DataAnnotations.Schema;

namespace JuliaSmerdelEFCompanies
{
    public class Customer : Company
    {
        public int CustomerID { get; set; }
        public int Discount { get; set; }
    }
}

