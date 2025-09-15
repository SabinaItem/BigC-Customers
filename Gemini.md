# Project: BigC Customers

This project is a Microsoft Dynamics 365 Business Central application that exposes customer and contact data through an API.

## Key Components:

*   **`app.json`**: This file defines the project's metadata, including its name, publisher, version, and dependencies.
*   **`BigC_CustomersWithContacts_Query.al`**: This file contains the core logic of the application. It defines a query object that retrieves and exposes customer and contact information.
*   **`.vscode/launch.json`**: This file configures the debugging and launching settings for the application within Visual Studio Code.

## API Endpoint:

The application exposes an API endpoint with the following characteristics:

*   **Query Object:** `BigC_CustomersWithContacts` (ID 60503)
*   **API Publisher:** `iteminc`
*   **API Group:** `big_c`
*   **API Version:** `v1.0`
*   **Entity Name:** `BigCCustomer`
*   **Entity Set Name:** `BigCCustomers`

## Data Model:

The API query joins two tables:

1.  **`Customer`**: The primary table, providing customer details like name, address, and credit limit.
2.  **`Contact`**: Joined to the `Customer` table to provide additional contact information.

## Development Environment:

The project is set up for development in a Sandbox environment named "BigC", as configured in the `launch.json` file.
