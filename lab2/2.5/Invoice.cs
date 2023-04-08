using System;
using System.ComponentModel.DataAnnotations;


namespace JuliaSmerdelEFProducts
{
	public class Invoice
	{
		[Key]
		public int InvoiceNumber { get; set; }
		public virtual ICollection<InvoiceInfo> InvoiceInfos { get; set; }
	}
}

