# Data

The project uses the public Instacart Market Basket Analysis dataset.

The original Instacart CSV files were first loaded into MySQL. The SQL script in `sql/instacart.sql` creates the following tables:

* `table_prior` — `orders` filtered to `eval_set = 'prior'`, joined with `order_products_prior`
* `table_train` — `orders` filtered to `eval_set = 'train'`, joined with `order_products_train`
* `table_test` — `orders` filtered to `eval_set = 'test'`

For the Python analysis:

* `table_prior` was imported into Pandas and reduced to the columns `user_id`, `order_number`, `product_id`, and `reordered`. The resulting DataFrame was saved as `prior.parquet`.
* `table_train` was imported into Pandas and saved as `df_train.parquet` without further column selection.

## Files

* `prior.parquet` — order history used for feature engineering and modelling.
* `df_train.parquet` — held-out train-order data used to construct the final evaluation target.

`df_train.parquet` is included in the repository.

`prior.parquet` is not included because of its file size. It can be recreated by running the SQL preparation in `sql/instacart.sql`, importing `table_prior` into Pandas, selecting the four required columns, and saving the result as Parquet.

The SQL used to prepare the MySQL tables is available in `sql/instacart.sql`.


## Original dataset

The original Instacart dataset is publicly available from Kaggle:

https://www.kaggle.com/datasets/psparks/instacart-market-basket-analysis
