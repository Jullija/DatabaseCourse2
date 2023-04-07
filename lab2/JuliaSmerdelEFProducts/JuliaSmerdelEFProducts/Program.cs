namespace JuliaSmerdelEFProducts
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Tworzenie nowego produktu:");
            Product product = createNewProduct();
            Console.WriteLine("Tworzenie nowego dostawcy:");
            Supplier supplier = createNewSupplier();

            Console.WriteLine("Przypisanie podanego dostawcy do podanego produktu");
            product.Supplier = supplier;

            Console.WriteLine("Dodanie danych do bazy");
            ProductContext productContext = new ProductContext();
            productContext.Suppliers.Add(supplier);
            productContext.Products.Add(product);
            productContext.SaveChanges();

            //Console.WriteLine("Podaj nazwę produktu");
            //string prodName = Console.ReadLine();

            //Console.WriteLine("Poniżej lista produktów zarejestrowanych w naszej bazie danych");
            //ProductContext productContext = new ProductContext();
            //Product product = new Product { ProductName = prodName };
            //productContext.Products.Add(product);
            //productContext.SaveChanges();

            //var query = from prod in productContext.Products select prod.ProductName;

            //foreach(var pName in query)
            //{
            //    Console.WriteLine(pName);
            //}


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
    }
}


