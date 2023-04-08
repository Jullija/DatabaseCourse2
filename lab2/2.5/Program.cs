namespace JuliaSmerdelEFProducts
{
    class Program
    {
        static void Main(string[] args)
        {
            bool stillStanding = true;
            ProductContext productContext = new ProductContext();


            while(stillStanding)
            {
                Console.WriteLine("add - dodanie nowego produktu, buy - kupowanie produktów, invoice - przeglądanie faktury, exit - wyjście ");
                string decision = Console.ReadLine();

                switch (decision)
                {
                    case "add":
                        Console.WriteLine("Tworzenie nowego produktu:");
                        addProduct(productContext);
                        break;

                    case "buy":
                        displayProducts(productContext);
                        invoiceFun(productContext);
                        break;

                    case "invoice":
                        displayInvoice(productContext);
                        break;

                    case "exit":
                        stillStanding = false;
                        break;
                    default:
                        Console.WriteLine("Podana została zła komenda");
                        break;
                }

            } 

            
            



        }



        private static void displayInvoice(ProductContext productContext)
        {
            Console.WriteLine("Podaj ID faktury, którą chcesz zobaczyć.");
            int id = Int32.Parse(Console.ReadLine());
            Invoice invoice = productContext.Invoices.First(inv => inv.InvoiceNumber == id);

            foreach(InvoiceInfo stats in invoice.InvoiceInfos)
            {
                Console.WriteLine($"ID:{stats.ProductID} Liczba kupionych produktów:{stats.Quantity}");
            }

        }


        private static void invoiceFun(ProductContext productContext)
        {

            List<InvoiceInfo> invoiceInfo = new();
            Console.WriteLine("Aby zakończyć kupowanie produktów do faktury, kliknij Enter.");
            while (true)
            {
                Console.WriteLine("Podaj ID produktu, który chcesz kupić.");
                string input = Console.ReadLine();
                if (input == String.Empty)
                {
                    Console.WriteLine("Zakończono kupowanie produktów");
                    break;
                }
                int id = Int32.Parse(input);
                
                Console.WriteLine("Podaj, ile produktu chcesz kupić.");
                string input2 = Console.ReadLine();

                if (input2 == String.Empty)
                {
                    Console.WriteLine("Zakończono kupowanie produktów");
                    break;
                }
                int quantity = Int32.Parse(input2);


                Product product = productContext.Products.First(prod => prod.ProductID == id);
                if (quantity > product.UnitsOnStock)
                {
                    Console.WriteLine("Podana liczba jest większa niż liczba dostępnych sztuk.");
                }
                else
                {
                    product.UnitsOnStock = product.UnitsOnStock - quantity;

                    invoiceInfo.Add(new InvoiceInfo { ProductID = id, Quantity = quantity });
                }

                
            }

            Invoice invoice = new Invoice
            {
                InvoiceInfos = invoiceInfo
            };
            productContext.Add(invoice);
            productContext.SaveChanges();


        }





        //private static Supplier createNewSupplier()
        //{
        //    Console.WriteLine("Podaj nazwę dostawcy");
        //    string suppName = Console.ReadLine();

        //    Console.WriteLine("Podaj miasto dostawcy");
        //    string suppCity = Console.ReadLine();

        //    Console.WriteLine("Podaj ulicę dostawcy");
        //    string suppStreet = Console.ReadLine();

        //    Supplier supplier = new Supplier
        //    {
        //        CompanyName = suppName,
        //        Street = suppStreet,
        //        City = suppCity
        //    };

        //    return supplier;

        //}


        private static void addProduct(ProductContext productContext)
        {
            Console.WriteLine("Podaj nazwę produktu");
            string prodName = Console.ReadLine();

            Console.WriteLine("Podaj liczbę sztuk produktu");
            int quantity = Int32.Parse(Console.ReadLine());

            Product product = new Product
            {
                ProductName = prodName,
                UnitsOnStock = quantity
            };

            
            productContext.Products.Add(product);
            productContext.SaveChanges();

        }


        private static void displayProducts(ProductContext productContext)
        {
            Console.WriteLine("Oto wszystkie produkty:");
            foreach (Product prod in productContext.Products)
            {
                Console.WriteLine($"ID:{prod.ProductID} Nazwa:{prod.ProductName} Dostępnych:{prod.UnitsOnStock} ");
            }
        }



        //private static Supplier findSupplier(ProductContext productContext)
        //{
        //    Console.WriteLine("Podaj id dostawcy, który ma być przypisany do nowego produktu.");
        //    int id = Int32.Parse(Console.ReadLine());

        //    var query = from supp in productContext.Suppliers where supp.SupplierID == id select supp;

        //    return query.FirstOrDefault();
        //}

        //private static void displaySuppliers(ProductContext productContext)
        //{
        //    Console.WriteLine("Oto wszyscy dostawcy:");
        //    foreach(Supplier supp in productContext.Suppliers)
        //    {
        //        Console.WriteLine($"{ supp.SupplierID} { supp.CompanyName}");
        //    }
        //}
    }
}


