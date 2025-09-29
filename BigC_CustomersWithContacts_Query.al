
// page 60503 BigC_CustomersWithContacts_API // PageType = API
// {
//     PageType = API;
//     Caption = 'BigC Customers with Contacts (Minimal API Page)'; // Updated caption
//     APIPublisher = 'iteminc';
//     APIGroup = 'big_c';
//     APIVersion = 'v1.0';
//     EntityName = 'BigCCustomer';
//     EntitySetName = 'BigCCustomers';
//     SourceTable = Customer; // Primary table: ensures all customers are returned
//     DelayedInsert = true; // Typically set to true for API pages

//     layout
//     {
//         area(Content)
//         {
//             repeater(Customers) // 'Customers' is the name of the repeater section for the API output
//             {
//                 // -- Customer Fields (directly from the Customer SourceTable) --
//                 field(BCCustomerNo; Rec."No.") { } // Customer ID
//                 field(BCDisplayName; Rec.Name) { } // Customer's main name

//                 // -- Contact Information (Temporary fields populated by OnAfterGetRecord) --
//                 field(ContactNo; TempContactNo) { Caption = 'Contact No.'; Editable = false; } // Contact ID
//                 field(ContactFullName; TempContactFullName) { Caption = 'Contact Full Name'; Editable = false; } // Contact Full Name
//             }
//         }
//     }

//     // --- Global Variables for handling Contact data within the API page ---
//     var
//         ContactRec: Record Contact; // Record variable to search the Contact table
//         TempContactNo: Code[20];       // Temporary variable for Contact No.
//         TempContactFullName: Text[100]; // Temporary variable for Contact Full Name

//     // --- OnAfterGetRecord Trigger: Executes for each customer record retrieved by the API ---
//     trigger OnAfterGetRecord()
//     begin
//         // 1. Clear out any previously held contact data from the temporary variables
//         Clear(TempContactNo);
//         Clear(TempContactFullName);
//         Clear(ContactRec); // Also clear the Contact record variable itself

//         // 2. Attempt to find a matching Contact record
//         //    Using the custom field 'CustomerNo' (field ID 50173) on the Contact table
//         //    and filtering it to match the current Customer's 'No.' (primary key).
//         //    This uses standard AL record filtering, which reliably recognizes 'Contact.CustomerNo'.
//         ContactRec.SetRange(CustomerNo, Rec."No.");

//         // 3. If a matching contact is found, populate the temporary fields
//         if ContactRec.FindFirst() then begin
//             TempContactNo := ContactRec."No.";             // Get the contact's ID
//             TempContactFullName := ContactRec.Name;        // Get the contact's full name
//         end;
//         // If no contact is found, the temporary fields will remain blank, which is the desired behavior.
//     end;
// }

page 60503 BigC_CustomersWithContacts_API
{
    PageType = API;
    Caption = 'BigC Customer Export';
    APIPublisher = 'iteminc';
    APIGroup = 'big_c';
    APIVersion = 'v1.0';
    EntityName = 'BigCCustomer';
    EntitySetName = 'BigCCustomers';
    SourceTable = Customer;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(Customers)
            {
                // -- Customer Fields (from Customer SourceTable) --
                field(BCCustomerNo; Rec."No.") { }
                field(BCDisplayName; Rec.Name) { }
                field(BCAddress1; Rec.Address) { }
                field(BCAddress2; Rec."Address 2") { }
                field(BCCity; Rec.City) { }
                field(BCState; Rec.County) { } // Assuming County maps to BigCommerce state_or_province
                field(BCPostalCode; Rec."Post Code") { }
                field(BCCountryCode; Rec."Country/Region Code") { } // Ensure ISO 2-letter codes
                field(BCCreditLimitLCY; Rec."Credit Limit (LCY)") { }
                field(BCEmail; Rec."E-Mail") { }
                field(BCPhoneNumber; Rec."Phone No.") { }
                field(BCTaxExemptionNumber; Rec."Tax Exemption No.") { }
                field(BCNoOfOrders; Rec."No. of Orders") { } // FlowField - will be calculated by BC
                field(BCPrimaryContactCode; Rec."Primary Contact No.") { }
                field(BCContactNameText; Rec.Contact) { } // Text field from Customer card
                field(BCLastModifiedDateTime; Rec."Last Date Modified") { }
                field(BCB2C; Rec.B2C) { } // Assuming a custom B2C field on Customer table

                // -- BigCommerce ID Fields from Customer Table (Assuming these are custom fields) --
                // field(CustomerBigCID1; Rec."BigC ID") { } // Assuming first custom field name
                // field(CustomerBigCID2; Rec."BigC ID (Guid)") { } // Assuming second custom field name (e.g., GUID)

                // -- Contact Information (Temporary fields, populated by OnAfterGetRecord) --
                field(ContactNo; TempContactNo) { Caption = 'Contact No.'; Editable = false; }
                field(ContactCustomerNo; TempContactCustomerNo) { Caption = 'Contact Customer No.'; Editable = false; } // Link to Customer
                field(ContactFullName; TempContactFullName) { Caption = 'Contact Full Name'; Editable = false; }
                field(ContactFirstName; TempContactFirstName) { Caption = 'Contact First Name'; Editable = false; }
                field(ContactMiddleName; TempContactMiddleName) { Caption = 'Contact Middle Name'; Editable = false; }
                field(ContactLastName; TempContactLastName) { Caption = 'Contact Last Name'; Editable = false; }
                field(ContactEmail; TempContactEmail) { Caption = 'Contact Email'; Editable = false; }
                field(ContactPhoneNumber; TempContactPhoneNumber) { Caption = 'Contact Phone Number'; Editable = false; }
                field(ContactMobilePhoneNo; TempContactMobilePhoneNo) { Caption = 'Contact Mobile Phone No.'; Editable = false; }
                field(ContactAddress1; TempContactAddress1) { Caption = 'Contact Address 1'; Editable = false; }
                field(ContactAddress2; TempContactAddress2) { Caption = 'Contact Address 2'; Editable = false; }
                field(ContactCity; TempContactCity) { Caption = 'Contact City'; Editable = false; }
                field(ContactState; TempContactState) { Caption = 'Contact State'; Editable = false; }
                field(ContactPostalCode; TempContactPostalCode) { Caption = 'Contact Postal Code'; Editable = false; }
                field(ContactCountryCode; TempContactCountryCode) { Caption = 'Contact Country Code'; Editable = false; }
                field(ContactLastModifiedDateTime; TempContactLastModifiedDateTime) { Caption = 'Contact Last Modified Date Time'; Editable = false; }
            }
        }
    }

    // --- Global Variables for handling Contact data ---
    var
        ContactRec: Record Contact;
        TempContactNo: Code[20];
        TempContactCustomerNo: Code[20]; // For Contact.CustomerNo (custom 50173 field)
        TempContactFullName: Text[100];
        TempContactFirstName: Text[30];
        TempContactMiddleName: Text[30];
        TempContactLastName: Text[30];
        TempContactEmail: Text[80];
        TempContactPhoneNumber: Text[30];
        TempContactMobilePhoneNo: Text[30];
        TempContactAddress1: Text[100];
        TempContactAddress2: Text[50];
        TempContactCity: Text[30];
        TempContactState: Text[30];
        TempContactPostalCode: Code[20];
        TempContactCountryCode: Code[10];
        TempContactLastModifiedDateTime: DateTime; // Last modified date/time for the contact

    // --- OnAfterGetRecord Trigger: Executes for each customer record ---
    trigger OnAfterGetRecord()
    begin
        // Clear all temporary contact variables before populating for the current customer
        Clear(TempContactNo);
        Clear(TempContactCustomerNo);
        Clear(TempContactFullName);
        Clear(TempContactFirstName);
        Clear(TempContactMiddleName);
        Clear(TempContactLastName);
        Clear(TempContactEmail);
        Clear(TempContactPhoneNumber);
        Clear(TempContactMobilePhoneNo);
        Clear(TempContactAddress1);
        Clear(TempContactAddress2);
        Clear(TempContactCity);
        Clear(TempContactState);
        Clear(TempContactPostalCode);
        Clear(TempContactCountryCode);
        Clear(TempContactLastModifiedDateTime);
        Clear(ContactRec);

        // Attempt to find a matching Contact record using the custom Contact.CustomerNo field
        ContactRec.SetRange(CustomerNo, Rec."No.");

        if ContactRec.FindFirst() then begin
            // Populate temporary fields from the found Contact record
            TempContactNo := ContactRec."No.";
            TempContactCustomerNo := ContactRec.CustomerNo;
            TempContactFullName := ContactRec.Name;
            TempContactFirstName := ContactRec."First Name";
            TempContactMiddleName := ContactRec."Middle Name";
            TempContactLastName := ContactRec.Surname;
            TempContactEmail := ContactRec."E-Mail";
            TempContactPhoneNumber := ContactRec."Phone No."; // Using Contact's primary phone
            TempContactMobilePhoneNo := ContactRec."Mobile Phone No.";
            TempContactAddress1 := ContactRec.Address;
            TempContactAddress2 := ContactRec."Address 2";
            TempContactCity := ContactRec.City;
            TempContactState := ContactRec.County; // Assuming Contact.County maps to state/province
            TempContactPostalCode := ContactRec."Post Code";
            TempContactCountryCode := ContactRec."Country/Region Code";
            TempContactLastModifiedDateTime := ContactRec.GetLastDateTimeModified(); // Assuming this is available
        end;
    end;
}