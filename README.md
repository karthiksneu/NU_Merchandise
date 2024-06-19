
# NU_Merchandise

## Overview

NU_Merchandise aims to develop a comprehensive retail management system for NU's retail merchandise store. The project focuses on building a robust database that facilitates both online and offline sales of high-quality products. By analyzing product sales, customer behavior, and employee performance, administrators can make informed decisions to enhance sales and customer satisfaction. The database design ensures efficient storage and analysis of business-critical information, enabling insights into top-rated products, revenue management, and quality control.

## Objectives

The key objectives of NU_Merchandise are:

- **Order Management:** Record and manage all incoming and outgoing orders. Analyze top-selling items, track newly added products, monitor stock levels, and optimize inventory management.

- **Customer Service:** Evaluate customer ratings to identify highly rated products and areas for improvement. Enhance customer satisfaction by focusing on product quality and customer preferences.

- **Revenue Management:** Monitor and analyze revenue generated from both online and offline channels. Gain insights into sales trends, peak periods, and revenue growth opportunities.

- **Quality Control:** Ensure product quality by tracking defects and maintaining high standards. Optimize product offerings to align with customer expectations and increase overall sales.

## Steps to Get Started

To set up and deploy NU_Merchandise, follow these steps:

### Prerequisites

- Ensure you have access to an Oracle Autonomous Database instance.
- Install SQL Developer or any preferred SQL client for executing scripts.

### Setup Instructions

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/yourusername/NU_Merchandise.git
   cd NU_Merchandise
   ```

2. **Execute SQL Scripts:**
   - Open SQL Developer or your SQL client.
   - Connect to your Oracle Autonomous Database instance using credentials for user `NU_MERCHANDISE_ADMIN`.
   - Execute the `Create_Table_Scripts.sql` script located in the repository.
     ```sql
     @Create_Table_Scripts.sql
     ```
   - Use the following credentials when prompted:
     - **Username:** `NU_MERCHANDISE_ADMIN`
     - **Password:** `Oracledb2023`

3. **Configure Database Connection:**
   - Update your application configuration files (`config.js`, `application.properties`, etc.) with the database connection details for `NU_MERCHANDISE_ADMIN`.

4. **Run the Application:**
   - Deploy and run the application using your preferred web server (Node.js, Tomcat, etc.).
   - Navigate to the application URL to access NU_Merchandise.

### Additional Notes

- Customize the database schema and application configuration to suit your specific environment and requirements.
- Ensure proper security measures are implemented for database access and application deployment.
- Refer to the project documentation for detailed API endpoints, database schema, and application functionalities.
