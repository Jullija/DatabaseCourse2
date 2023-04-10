using JuliaSmerdelEFCompanies;

namespace JuliaSmerdelEFProducts
{
    class Program
    {
        static void Main(string[] args)
        {
            CompanyContext companyContext = new CompanyContext();

            bool stop = false;
            

            while (!stop)
            {
                Console.WriteLine("add - dodanie danych do bazy, show - pokazanie danych, exit - wyjście");
                string input = Console.ReadLine();
                switch (input)
                {
                    case "add":
                        addFun(companyContext);
                        break;
                    case "show":
                        show(companyContext);
                        break;
                    case "exit":
                        stop = true;
                        break;
                    default:
                        Console.WriteLine("Zła komenda.");
                        break;
                }
            }


        }


        private static void addFun(CompanyContext companyContext)
        {
            Console.WriteLine("Aby wyjść, kliknij Enter");
            while (true)
            {
                Console.WriteLine("Podaj nazwę firmy");
                string comName = Console.ReadLine();

                if (comName == String.Empty)
                {
                    Console.WriteLine("Zakończono dodawanie klienta");
                    break;
                }

                Console.WriteLine("Podaj miasto firmy");
                string comCity = Console.ReadLine();

                if (comCity == String.Empty)
                {
                    Console.WriteLine("Zakończono dodawanie klienta");
                    break;
                }

                Console.WriteLine("Podaj ulicę firmy");
                string comStreet = Console.ReadLine();

                if (comStreet == String.Empty)
                {
                    Console.WriteLine("Zakończono dodawanie klienta");
                    break;
                }

                Console.WriteLine("Podaj kod pocztowy firmy");
                string comCode = Console.ReadLine();

                if (comCode == String.Empty)
                {
                    Console.WriteLine("Zakończono dodawanie klienta");
                    break;
                }

                Console.WriteLine("supplier - dodanie dostawcy, customer - dodanie klienta");
                string input = Console.ReadLine();

                if (input == String.Empty)
                {
                    Console.WriteLine("Zakończono dodawanie klienta");
                    break;
                }

                switch (input)
                {
                    case "supplier":
                        Supplier supp = addSupplier(comName, comCity, comStreet, comCode);
                        companyContext.Suppliers.Add(supp);
                        companyContext.SaveChanges();
                        return;

                    case "customer":
                        Customer cus =  addCustomer(comName, comCity, comStreet, comCode);
                        companyContext.Customers.Add(cus);
                        companyContext.SaveChanges();
                        return;

                    default:
                        Console.WriteLine("Wrong command");
                        return;

                }
            }
            
            
        }

        private static Supplier addSupplier(string comName, string comCity, string comStreet, string comCode)
        {
            Console.WriteLine("Podaj numer konta bankowego:");
            string bank = Console.ReadLine();

            Supplier supplier = new Supplier
            {
                CompanyName = comName,
                Street = comStreet,
                City = comCity,
                ZipCode = comCode,
                bankAccountNumber = bank
            };

            return supplier;

        }

        private static Customer addCustomer(string comName, string comCity, string comStreet, string comCode)
        {
            Console.WriteLine("Podaj wartość zniżki w %:");
            int discount = int.Parse(Console.ReadLine());

            Customer customer = new Customer
            {
                CompanyName = comName,
                Street = comStreet,
                City = comCity,
                ZipCode = comCode,
                Discount = discount
            };

            return customer;

        }


        private static void show(CompanyContext companyContext)
        {
            while (true)
            {
                Console.WriteLine("supplier - zobaczenie dostawców, customer - zobaczenie klientów");
                string decision = Console.ReadLine();
                if (decision == String.Empty)
                {
                    Console.WriteLine("Zakończono przeglądanie klientów");
                    break;
                }

                switch (decision)
                {
                    case "supplier":
                        showSupp(companyContext);
                        return;
                    case "customer":
                        showCus(companyContext);
                        return;
                    default:
                        Console.WriteLine("Podano złą komendę.");
                        return;
                }
            }
            
        }

        private static void showSupp(CompanyContext companyContext)
        {
            foreach(Supplier supp in companyContext.Suppliers)
            {
                Console.WriteLine($" {supp.CompanyID} {supp.CompanyName} {supp.City} {supp.bankAccountNumber}");
            }
        }

        private static void showCus(CompanyContext companyContext)
        {
            foreach (Customer cus in companyContext.Customers)
            {
                Console.WriteLine($" {cus.CompanyID} {cus.CompanyName} {cus.City} {cus.Discount}");
            }
        }

    }
}


