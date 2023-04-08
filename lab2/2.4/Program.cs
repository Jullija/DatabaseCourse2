namespace JuliaSmerdelEFProducts
{
    class Program
    {
        static void Main(string[] args)
        {
            bool goodDecision = false;
            ProductContext productContext = new ProductContext();

            Console.WriteLine("Tworzenie nowego produktu:");
            Product product = createNewProduct();



            do
            {
                Console.WriteLine("Czy stworzyć nowego dostawcę i przypisać produkt do tego dostawcy" +
                                    " oraz dostawcę do produktu? (tak/nie)");
                string decision = Console.ReadLine();

                switch (decision)
                {
                    case "tak":
                        goodDecision = true;
                        Console.WriteLine("Tworzenie nowego dostawcy:");
                        Supplier supplier = createNewSupplier();
                        productContext.Suppliers.Add(supplier);
                        Console.WriteLine("Przypisanie podanego produktu do podanego dostawcy oraz dostawcy do produktu");
                        supplier.Products.Add(product);
                        product.Supplier = supplier;
                        break;

                    case "nie":
                        goodDecision = true;
                        displaySuppliers(productContext);
                        supplier = findSupplier(productContext);
                        Console.WriteLine("Przypisanie podanego produktu do podanego dostawcy oraz dostawcy do produktu");
                        supplier.Products.Add(product);
                        product.Supplier = supplier;
                        break;
                }

            } while (!goodDecision);

            productContext.Products.Add(product);
            productContext.SaveChanges();



        }


        private static Supplier createNewSupplier()
        {
            Console.WriteLine("Podaj nazwę dostawcy");
            string suppName = Console.ReadLine();

            Console.WriteLine("Podaj miasto dostawcy");
            string suppCity = Console.ReadLine();

            Console.WriteLine("Podaj ulicę dostawcy");
            string suppStreet = Console.ReadLine();

            Supplier supplier = new Supplier
            {
                CompanyName = suppName,
                Street = suppStreet,
                City = suppCity
            };

            return supplier;

        }


        private static Product createNewProduct()
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

            return product;

        }


        private static Supplier findSupplier(ProductContext productContext)
        {
            Console.WriteLine("Podaj id dostawcy, który ma być przypisany do nowego produktu.");
            int id = Int32.Parse(Console.ReadLine());

            var query = from supp in productContext.Suppliers where supp.SupplierID == id select supp;

            return query.FirstOrDefault();
        }

        private static void displaySuppliers(ProductContext productContext)
        {
            Console.WriteLine("Oto wszyscy dostawcy:");
            foreach(Supplier supp in productContext.Suppliers)
            {
                Console.WriteLine($"{ supp.SupplierID} { supp.CompanyName}");
            }
        }
    }
}


