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
                // DataItemLink = "CustomerNo" = Customer."No.";
                // DataItemLink = "No." = Customer."Primary Contact No.";
                // SqlJoinType = LeftOuterJoin;
                DataItemLink = "CustomerNo" = Customer."No.";

                column(ContactFullName; Name) { } // Full name from Contact table
                column(ContactFirstName; "First Name") { } // If Contact table has it
                column(ContactLastName; Surname) { }   // If Contact table has it
            }
        }
    }
}

// page 60503 BigC_CustomersWithContacts_API
// {
//     PageType = API;
//     Caption = 'BigC Customers with Contacts';
//     APIPublisher = 'iteminc';
//     APIGroup = 'big_c';
//     APIVersion = 'v1.0';
//     EntityName = 'BigCCustomer'; // Singular name for a record in the API output
//     EntitySetName = 'BigCCustomers'; // Plural name for the collection in the API output
//     SourceTable = Customer;
//     DelayedInsert = true;

//     layout
//     {
//         area(Content)
//         {
//             repeater(Customers)
//             {
//                 // -- Customer Fields (directly from the Customer SourceTable) --
//                 field(BCCustomerNo; Rec."No.") { }
//                 field(BCDisplayName; Rec.Name) { }
//                 field(CustomerPhone; Rec."Phone No.") { }
//                 field(CustomerEmail; Rec."E-Mail") { }
//                 field(PrimaryContactRefNo; Rec."Primary Contact No.") { }
//                 field(ContactRec; Rec.Contact) { }
//                 field("ContactID"; Rec."Contact ID") { }

//                 // -- Bill-To Address Fields (flat fields from Customer SourceTable, for Celigo to structure) --
//                 field(BillToAddress1; Rec.Address) { }
//                 field(BillToAddress2; Rec."Address 2") { }
//                 field(BillToCity; Rec.City) { }
//                 field(BillToState; Rec.County) { }
//                 field(BillToPostalCode; Rec."Post Code") { }
//                 field(BillToCountryCode; Rec."Country/Region Code") { }

//                 // -- Other Customer Details --
//                 field(CreditLimitLCY; Rec."Credit Limit (LCY)") { } // Customer's credit limit
//                 field(TaxExemptionNumber; Rec."Tax Exemption No.") { } // Customer's tax exemption number
//                 field(LastModifiedDateTime; Rec."Last Date Modified") { } // Last modification timestamp (for delta sync)

//                 // -- Contact Information (These are temporary fields, populated by OnAfterGetRecord) --
//                 field(ContactFullName; TempContactFullName) { Caption = 'Contact Full Name'; Editable = false; }
//                 field(ContactFirstName; TempContactFirstName) { Caption = 'Contact First Name'; Editable = false; }
//                 field(ContactLastName; TempContactLastName) { Caption = 'Contact Last Name'; Editable = false; }
//                 field(ContactEmail; TempContactEmail) { Caption = 'Contact Email'; Editable = false; } // Contact's email
//                 field(ContactMobilePhoneNo; TempContactMobilePhoneNo) { Caption = 'Contact Mobile Phone No.'; Editable = false; } // Contact's mobile phone number
//             }
//         }
//     }

//     // --- Global Variables for handling Contact data within the API page ---
//     var
//         ContactRec: Record Contact; // This record variable will be used to look up contact details
//         TempContactFullName: Text[100]; // Temporary variable to hold the full name from the Contact
//         TempContactFirstName: Text[30]; // Temporary variable for the first name
//         TempContactLastName: Text[30];  // Temporary variable for the last name
//         TempContactEmail: Text[80];     // Temporary variable for the contact's email
//         TempContactMobilePhoneNo: Text[30]; // Temporary variable for the contact's mobile phone number

//     // --- OnAfterGetRecord Trigger: Executes for each customer record retrieved by the API ---
//     trigger OnAfterGetRecord()
//     begin
//         // 1. Clear out any previously held contact data from the temporary variables
//         Clear(TempContactFullName);
//         Clear(TempContactFirstName);
//         Clear(TempContactLastName);
//         Clear(TempContactEmail);
//         Clear(TempContactMobilePhoneNo);
//         Clear(ContactRec); // Also clear the Contact record variable before reuse

//         // 2. Attempt to find a matching Contact record

//         ContactRec.SetRange("No.", Rec."Primary Contact No."); // Match by Primary Contact No.

//         // 3. If a matching contact is found, populate the temporary fields
//         if ContactRec.FindFirst() then begin
//             TempContactFullName := ContactRec.Name;          // Full name from Contact (e.g., "Judy Emerson")
//             TempContactFirstName := ContactRec."First Name"; // First name from Contact (e.g., "Judy")
//             TempContactLastName := ContactRec.Surname;       // Last name from Contact (e.g., "Emerson")
//             TempContactEmail := ContactRec."E-Mail";         // Email from Contact
//             TempContactMobilePhoneNo := ContactRec."Mobile Phone No."; // Mobile from Contact
//         end;
//         // If no contact is found, the temporary fields will remain blank, which is the desired behavior.
//     end;
// }

// page 60503 BigC_CustomersWithContacts_API
// {
//     PageType = API;
//     Caption = 'BigC Customers with Contacts';
//     APIPublisher = 'iteminc';
//     APIGroup = 'big_c';
//     APIVersion = 'v1.0';
//     EntityName = 'BigCCustomer'; // Singular name for a record in the API output
//     EntitySetName = 'BigCCustomers'; // Plural name for the collection in the API output
//     SourceTable = Customer;
//     DelayedInsert = true;

//     layout
//     {
//         area(Content)
//         {
//             repeater(GroupName)
//             {
//                 field(fieldName; NameSource)
//                 {
//                     Caption = 'fieldCaption';

//                 }
//             }
//         }
//     }
// }