/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @start_load_time DATETIME, @end_load_time DATETIME
	BEGIN TRY
		PRINT '================================================================';
		PRINT 'Loading the Bronze Layer';
		PRINT '================================================================';

		PRINT '----------------------------------------------------------------';
		PRINT 'Loading the CRM Tables';
		PRINT '----------------------------------------------------------------';
		
		SET @start_load_time = GETDATE();
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_cust_info;
		BULK INSERT bronze.crm_cust_info
		FROM 'D:\sql-data-warehouse-project\datasets\crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'
		PRINT '>> ......................'

		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_prd_info;
		BULK INSERT bronze.crm_prd_info
		FROM 'D:\sql-data-warehouse-project\datasets\crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'
		PRINT '>> ......................'

		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_sales_details;
		BULK INSERT bronze.crm_sales_details
		FROM 'D:\sql-data-warehouse-project\datasets\crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'
		PRINT '>> ......................'

		PRINT '----------------------------------------------------------------';
		PRINT 'Loading the ERP Tables';
		PRINT '----------------------------------------------------------------';

		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_cust_az12;
		BULK INSERT bronze.erp_cust_az12
		FROM 'D:\sql-data-warehouse-project\datasets\erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'
		PRINT '>> ......................'

		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_loc_a101;
		BULK INSERT bronze.erp_loc_a101
		FROM 'D:\sql-data-warehouse-project\datasets\erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'
		PRINT '>> ......................'

		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'D:\sql-data-warehouse-project\datasets\erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'
		PRINT '>> ......................'

		SET @end_load_time = GETDATE();
		PRINT'>> Entire Bronze Layer Load Time ' + CAST(DATEDIFF(second, @start_load_time, @end_load_time) AS NVARCHAR) + ' seconds'
		PRINT'>> .......................'

	END TRY
	BEGIN CATCH
		PRINT '==============================================================';
		PRINT 'Error occured during bronze layer loading';
		PRINT ('Error Message: ' + ERROR_MESSAGE());
		PRINT ('Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR));
		PRINT ('Error Line: '+ CAST(ERROR_LINE() AS NVARCHAR));
		PRINT ('Error Procedure: ' + ERROR_PROCEDURE());
	END CATCH
END