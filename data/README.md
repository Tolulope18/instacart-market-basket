# Data

The project uses the public Instacart Market Basket Analysis dataset.

The original Instacart CSV files were first loaded into MySQL. The SQL script in `sql/instacart.sql` prepares three joined tables:

* `table_prior` — `orders` filtered to `eval_set = 'prior'`, joined with `order_products_prior`
* `table_train` — `orders` filtered to `eval_set = 'train'`, joined with `order_products_train`
* `table_test` — `orders` filtered to `eval_set = 'test'`

For this project, `table_prior` and `table_train` were then imported into Pandas, reduced to the columns needed for the analysis and modelling, and saved as Parquet files.

## Files

* `df_train.parquet` — prepared data from `table_train`, used to construct the final evaluation target.
* `prior.parquet` — prepared data from `table_prior`, used as the order history for feature engineering and modelling.

`df_train.parquet` is included in the repository.

`prior.parquet` is not included because of its file size. It can be recreated from the original Instacart data by running the SQL preparation and then performing the same Pandas preparation used in the project.

The SQL used to create the MySQL tables is available in `sql/instacart.sql`.

## Original dataset

The original Instacart dataset is publicly available from Kaggle:

https://www.kaggle.com/c/instacart-market-basket-analysis/data
