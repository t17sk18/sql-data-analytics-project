PRINT 'Executing scripts/execute.sql';

PRINT '----------------------------------------------------------------';
PRINT 'Loading the Bronze Tables';
PRINT '----------------------------------------------------------------';
EXEC bronze.load_bronze;

PRINT 'Data from the Bronze Layer';
SELECT * FROM bronze.crm_cust_info;
SELECT * FROM bronze.crm_prd_info;
SELECT * FROM bronze.crm_sales_details;
SELECT * FROM bronze.erp_cust_az12;
SELECT * FROM bronze.erp_loc_a101;
SELECT * FROM bronze.erp_px_cat_g1v2;


PRINT '----------------------------------------------------------------';
PRINT 'Loading the Silver Tables';
PRINT '----------------------------------------------------------------';
EXEC silver.load_silver;

PRINT 'Data from the Silver Layer';
SELECT * FROM silver.crm_cust_info; 
SELECT * FROM silver.crm_prd_info;
SELECT * FROM silver.crm_sales_details;
SELECT * FROM silver.erp_cust_az12;
SELECT * FROM silver.erp_loc_a101;
SELECT * FROM silver.erp_px_cat_g1v2;


PRINT '----------------------------------------------------------------';
PRINT 'Data from the Views - DWH Dimension and Fact Tables';
PRINT '----------------------------------------------------------------';

SELECT * FROM gold.dim_customers;
SELECT * FROM gold.dim_products;
SELECT * FROM gold.fact_sales;
