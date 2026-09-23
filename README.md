# Instacart Market Basket Prediction

## Project Overview

The goal of this project is to predict whether a product a customer has purchased before will appear in their next order.

The main question I wanted to explore was:

> **How much can we predict about a customer's next basket using only their previous relationship with each product?**

The project combines **MySQL for data preparation** with **Python for feature engineering and machine learning**.

Rather than focusing on overall product popularity, the model focuses on the individual customer-product relationship: how frequently a customer buys a product, how regularly they reorder it, and how recently they purchased it.

## Approach

The original Instacart data was first prepared in MySQL using SQL joins between the order and product-level tables. The prepared data was then imported into Pandas for feature engineering and modelling.

The prediction problem was structured temporally:

```text
Customer history through order N-1
              ↓
        Create features
              ↓
       Predict order N
              ↓
       Compare with actual order N
```

The final model uses four customer-product features:

* `reorder_rate`
* `avg_reorder_interval`
* `interval_missing`
* `recency`

An important part of the project was defining the target correctly. The `reordered` column was **not** used as the final target. Instead, the target represents whether a previously purchased product appeared in the customer's next order.

I compared a frequency-based baseline with Logistic Regression, Random Forest, and XGBoost.

## Results

The final model was an XGBoost classifier. After testing different prediction thresholds, I selected **0.25** for the final predictions.

| Model                              | Precision |    Recall |        F1 |
| ---------------------------------- | --------: | --------: | --------: |
| Frequency baseline                 |     0.174 |     0.253 |     0.206 |
| Logistic Regression                |     0.278 |     0.338 |     0.305 |
| Random Forest                      |     0.283 |     0.377 |     0.324 |
| XGBoost                            |     0.282 |     0.379 |     0.324 |
| **Final XGBoost (threshold 0.25)** | **0.262** | **0.430** | **0.326** |

The final model identifies about **43% of the products that actually appear in the next order**, with a precision of about **26%**.

The full modelling process, feature engineering, threshold testing, and evaluation are documented in the notebook.

## Key Takeaways

The main takeaway from the project was that a customer's previous relationship with a product contains useful information about whether they will purchase it again.

Recency and reorder behaviour were particularly useful signals. I also tested additional recent-purchase and customer-level features, but the improvement was small enough that I decided to keep the final model simpler.

I also found that the prediction threshold had a noticeable effect on the precision-recall trade-off. Rather than relying on the default 0.5 threshold, I selected the threshold based on the F1-score of the tested thresholds.

## Limitations

The model only uses the customer's previous purchasing behaviour at the customer-product level.

It does not include external factors such as price, promotions, product availability, or changes in the wider shopping environment.

The candidate set is also limited to products the customer has purchased previously, so the model does not attempt to predict completely new products that a customer has never bought before.

## Repository Structure

```text
instacart-market-basket/
├── data/
│   ├── df_train.parquet
│   └── README.md
├── sql/
│   └── instacart.sql
├── instacart_market_basket.ipynb
└── README.md
```

### Files

* `instacart_market_basket.ipynb` — full feature engineering, modelling, evaluation, and analysis.
* `sql/instacart.sql` — SQL used to prepare the MySQL tables.
* `data/df_train.parquet` — prepared data used to construct the final evaluation target.
* `data/README.md` — information about the data preparation and Parquet files.

The larger `prior.parquet` file is not included in the repository. Instructions for recreating it are provided in `data/README.md`.
