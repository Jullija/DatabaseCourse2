namespace JuliaSmerdelEFProducts
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Podaj nazwę produktu");
            string prodName = Console.ReadLine();

            Console.WriteLine("Poniżej lista produktów zarejestrowanych w naszej bazie danych");
            ProductContext productContext = new ProductContext();
            Product product = new Product { ProductName = prodName };
            productContext.Products.Add(product);
            productContext.SaveChanges();

            var query = from prod in productContext.Products select prod.ProductName;

            foreach(var pName in query)
            {
                Console.WriteLine(pName);
            }

        }
    }
}


