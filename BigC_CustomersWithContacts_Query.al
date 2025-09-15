query 60503 BigC_CustomersWithContacts
{
    QueryType = API; // Essential for exposing it as an API endpoint
    Caption = 'BigC Customers with Contacts Query';
    APIPublisher = 'iteminc';
    APIGroup = 'big_c';
    APIVersion = 'v1.0';
    EntityName = 'BigCCustomer';
    EntitySetName = 'BigCCustomers';

    elements
    {
        // 1. Primary Data Item: Customer Table
        dataitem(Customer; Customer)
        {
            column(BCCustomerNo; "No.") { }
            column(BCDisplayName; Name) { }
            column(CustomerPhone; "Phone No.") { }
            column(CustomerEmail; "E-Mail") { }
            column(PrimaryContactNumber; "Primary Contact No.") { }

            column(BillToAddress1; Address) { }
            column(BillToAddress2; "Address 2") { }
            column(BillToCity; City) { }
            column(BillToState; County) { }
            column(BillToPostalCode; "Post Code") { }
            column(BillToCountryCode; "Country/Region Code") { }

            // Additional fields as needed
            column(CreditLimit; "Credit Limit (LCY)") { }
            column(TaxExemptionID; "Tax Exemption No.") { }
            column(LastModifiedDate; "Last Date Modified") { }


            // 2. Second Data Item: Contact Table - Joined to Customer
            dataitem(Contact; Contact)
            {
                // Define the JOIN condition
                // DataItemLink = "Customer No." = Customer."No.";
                DataItemLink = "No." = Customer."Primary Contact No.";
                SqlJoinType = LeftOuterJoin;


                column(ContactFullName; Name) { } // Full name from Contact table
                column(ContactFirstName; "First Name") { } // If Contact table has it
                column(ContactLastName; Surname) { }   // If Contact table has it
            }
        }
    }
}