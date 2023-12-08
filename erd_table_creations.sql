-- Create the loan_table
CREATE TABLE staging.loan_table (
  "loan_id" VARCHAR(50) PRIMARY KEY,
  "borrower_id" VARCHAR(50),
  "date_of_release" DATE,
  "term" INT,
  "interest_rate" DECIMAL(10, 2),
  "loan_amount" DECIMAL(15, 2),
  "payment_frequency" VARCHAR(255),
  "maturity_date" DATE,
  FOREIGN KEY ("borrower_id") REFERENCES staging.borrower_table("borrower_id")
);

-- Create the borrower_table
CREATE TABLE staging.borrower_table (
  "borrower_id" VARCHAR(50) PRIMARY KEY,
  "state" VARCHAR(255),
  "city" VARCHAR(255),
  "zip_code" VARCHAR(10)
);

-- Create the payment_schedule
CREATE TABLE staging.payment_schedule (
  "schedule_id" VARCHAR(50) PRIMARY KEY,
  "loan_id" VARCHAR(50),
  "expected_payment_date" DATE,
  "expected_payment_amount" DECIMAL(15, 2),
  FOREIGN KEY ("loan_id") REFERENCES staging.loan_table("loan_id")
);

-- Create the loan_payment
CREATE TABLE staging.loan_payment (
  "payment_id" VARCHAR(50) PRIMARY KEY,
  "loan_id" VARCHAR(50),
  "amount_paid" DECIMAL(15, 2),
  "date_paid" DATE,
  FOREIGN KEY ("loan_id") REFERENCES staging.loan_table("loan_id")
);
