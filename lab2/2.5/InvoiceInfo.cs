using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace JuliaSmerdelEFProducts
{
	public class InvoiceInfo
	{
		[Key, Column(Order = 0)]
		public int InvoiceNumber { get; set; }
        [Key, Column(Order = 1)]
        public int ProductID { get; set; }

        public virtual Invoice Invoice { get; set; }
        public virtual Product Product { get; set; }

        public int Quantity { get; set; }

		
	}
}

