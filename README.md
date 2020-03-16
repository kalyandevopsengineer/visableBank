## Introduction

REST API end points implementation for banking/financial services is a challenging task in which the application design, database design and code optimization for fast execution of code is the primary objective. Ruby on rails provides a very rich set of model, view, controller web/api framework class design for implementing the code in a simplified way.

### Platform and Software

###### Operating system:

```ruby
ruby@ruby:~/visableBank$ lsb_release -a
Distributor ID: Ubuntu
Description:    Ubuntu 16.04.6 LTS
Release:        16.04
Codename:       xenial
ruby@ruby:~/visableBank$
```
###### Ruby environment version:
```
ruby@ruby:~/visableBank$ rbenv --version
rbenv 1.1.2-26-gc6324ff
ruby@ruby:~/visableBank$
```
###### Ruby version:
```
ruby@ruby:~/visableBank$ ruby --version
ruby 2.7.0p0 (2019-12-25 revision 647ee6f091) [x86_64-linux]
ruby@ruby:~/visableBank$
```
###### Rails version:
```
ruby@ruby:~/visableBank$ rails --version
Rails 5.0.7.2
ruby@ruby:~/visableBank$
```
###### Gem version:
```
ruby@ruby:~/visableBank$ gem --version
3.1.2
ruby@ruby:~/visableBank$
```
###### MySQL version:
```
ruby@ruby:~/visableBank$ gem list --local | grep mysql
mysql2 (0.5.3)
ruby@ruby:~/visableBank$
```
###### Puma version:
```
ruby@ruby:~/visableBank$ gem list --local | grep puma
puma (3.12.4)
ruby@ruby:~/visableBank$
```
###### Client calls:

httpie is used to make the REST API CRUD calls.

###### Application design:

The application design consists of four controller classes namely:

- 1.accounts_controller.
- 2.beneficiaries_controller.
- 3.account_beneficiaries_controller.
- 4.transactions_controller.

Markup : 1. The transactions_controller class serves as a service class to perform transfer of money between accounts. 
	 2. Verify the account/beneficiary accounts are active.
	 3. Add money to the beneficiary account.
	 4. Deduct money from the account holder account.

###### Database & Dump file:

MySQL database is used for backend REST API connectivity to store the records. Database dump file can be found in the repository with name "visablebank_development.sql" to understand the database schema and structure of tables and their associations. 


###### Database Design:

Database design consists of four tables namely:

Markup : 1.accounts
         2.beneficiaries
         3.account_beneficiaries
         4.transactions

###### Database tables design:

Markup : 1.Accounts table stores the bank account holder's details.
         2.Beneficiaries table stores the beneficiaries of account holder's.
         3.Account_beneficiaries table stores the primary keys of accounts and beneficiaries tables as foreign keys.
         4.Transactions table stores the transfer transactions of accounts to beneficiaries.
         5.Account name, account number, beneficiary name, beneficairy number, account_id, beneficiary_id table columns are indexed for better performance of code.

###### Application code functionality:

Markup : 1.Accounts table has account holder's records with account name, account number and account balance with account status.
         2.Account holder with active status can be mapped with a beneficiary and can transfer amount to beneficiary. 
         3.Account and Beneficiary records are unique and cannot be added multiple times in the same tables.
         4.Beneficiary table has records with beneficiary name, beneficiary account number and status.
         5.Beneficiary record can be delete if and only if the beneficiary is not mapped with any account holder.
         6.Beneficiary record cannot be edited after adding into the database.
         7.Account_Beneficiaries table has records with foreign keys of both accounts and beneficaries tables which are primary keys of accounts and beneficiaries taables.
         8.Many-to-Many rich association is established between accounts table and beneficiary tables using acccont_beneficiaries table because an account holder can have many beneficiaries and a beneficiary can be an account holder in the same bank.
         9.Account_beneficiaries table stores the association of accounts and beneficiaries tables.
         10. Default value for accounts and beneficiaries status column is "active".
         11.Transactions table stores the transfer of amount between accounts and beneficiaries tables. Account id and Beneficiary id are passed as primary parameters to verify the account and beneficiary association from account_beneficiaries table and the status of account holder and beneficiary as active.
         12.Account holder information is verified before transfer to check the account balance from accounts table, status of account holder and updating the account holder account balance after the transaction is stored in the transactions table.
         13.Transactions table provides the last ten transactions of an account and benificiary.
         14.Transactions records cannot be edited or deleted and are required for legal retention purpose.

###### Code Usage:

Markup : 1. Clone the code repository from github.



Markup : 2. Change directory to root of the application.



Markup : 3. Start the rails puma development server on port 3000 and ip address of your machine.

```ruby
ruby@ruby:~/visableBank$ rails server -b 0.0.0.0 -p 3000
=> Booting Puma
=> Rails 5.0.7.2 application starting in development on http://0.0.0.0:3000
=> Run `rails server -h` for more startup options
Puma starting in single mode...
* Version 3.12.4 (ruby 2.7.0-p0), codename: Llamas in Pajamas
* Min threads: 5, max threads: 5
* Environment: development
* Listening on tcp://0.0.0.0:3000
Use Ctrl-C to stop
```

## REST Operations:

###### 1. Add an account
```ruby
ruby@ruby:~/visableBank$ http POST 10.0.0.17:3000/accounts account_number=8686947001 account_name=Kalyan account_balance=70000
HTTP/1.1 200 OK
Cache-Control: max-age=0, private, must-revalidate
Content-Type: application/json; charset=utf-8
ETag: W/"9113a8c1cfe9ef143c98680d97e86986"
Transfer-Encoding: chunked
X-Request-Id: e89608f3-1ddd-4871-b583-61d4fb2ad380
X-Runtime: 0.080994

{
    "account_balance": "70000.0", 
    "account_name": "Kalyan", 
    "account_number": 8686947001, 
    "account_status": true, 
    "created_at": "2020-03-16T08:26:11.000Z", 
    "id": 1, 
    "updated_at": "2020-03-16T08:26:11.000Z"
}
```
###### 2. View an account
```ruby
ruby@ruby:~/visableBank$ http GET 10.0.0.17:3000/accounts/1
HTTP/1.1 200 OK
Cache-Control: max-age=0, private, must-revalidate
Content-Type: application/json; charset=utf-8
ETag: W/"686ea2e2fc8189046838f8a669c64508"
Transfer-Encoding: chunked
X-Request-Id: dab91046-3c4b-4d23-88c3-a9a5b9b0fcdd
X-Runtime: 0.005536

{
    "account_balance": "69000.0", 
    "account_name": "Kalyan", 
    "account_number": 8686947001, 
    "account_status": true, 
    "created_at": "2020-03-16T08:26:11.000Z", 
    "id": 1, 
    "updated_at": "2020-03-16T08:31:02.000Z"
}
```
###### 3.View all accounts
```ruby
ruby@ruby:~/visableBank$ http GET 10.0.0.17:3000/accounts
HTTP/1.1 200 OK
Cache-Control: max-age=0, private, must-revalidate
Content-Type: application/json; charset=utf-8
ETag: W/"c296780a311132ff0a5b857085ffcc91"
Transfer-Encoding: chunked
X-Request-Id: f74df00c-5592-433b-9370-1fbbb7830b2a
X-Runtime: 0.004601

[
    {
        "account_balance": "69000.0", 
        "account_name": "Kalyan", 
        "account_number": 8686947001, 
        "account_status": true, 
        "created_at": "2020-03-16T08:26:11.000Z", 
        "id": 1, 
        "updated_at": "2020-03-16T08:31:02.000Z"
    }, 
    {
        "account_balance": "81000.0", 
        "account_name": "Kiran", 
        "account_number": 8686947002, 
        "account_status": true, 
        "created_at": "2020-03-16T08:27:57.000Z", 
        "id": 2, 
        "updated_at": "2020-03-16T08:31:02.000Z"
    }
]
```
###### 4.Edit Account
```ruby
ruby@ruby:~/visableBank$ http PUT 10.0.0.17:3000/accounts/1
HTTP/1.1 200 OK
Cache-Control: max-age=0, private, must-revalidate
Content-Type: application/json; charset=utf-8
ETag: W/"eded21da84c48c69982297698eed7629"
Transfer-Encoding: chunked
X-Request-Id: e24ed952-52b9-450e-a936-ac5a7200da3f
X-Runtime: 0.036793

{
    "code": 200, 
    "message": "Account status updated.", 
    "status": "Success"
}
```
###### 5.Delete Account
```ruby
ruby@ruby:~/visableBank$ http DELETE 10.0.0.17:3000/accounts/4
HTTP/1.1 200 OK
Cache-Control: max-age=0, private, must-revalidate
Content-Type: application/json; charset=utf-8
ETag: W/"f9230d35e6fc6ad872db8eeb8bd821b8"
Transfer-Encoding: chunked
X-Request-Id: 8a53f724-71e7-4564-90f4-bb459ef559cf
X-Runtime: 0.015616

{
    "code": 200, 
    "message": "Account deleted.", 
    "status": "Success"
}
```
###### 6.Add a beneficiary
```ruby
ruby@ruby:~/visableBank$ http POST 10.0.0.17:3000/beneficiaries beneficiary_number=8686947002 beneficiary_name=Kiran account_balance=80000
HTTP/1.1 200 OK
Cache-Control: max-age=0, private, must-revalidate
Content-Type: application/json; charset=utf-8
ETag: W/"c6e63fadd92e24e31977b7e07e49a95c"
Transfer-Encoding: chunked
X-Request-Id: 8f76c2e7-9c89-4b10-9cc8-644a85e09880
X-Runtime: 0.012357

{
    "beneficiary_name": "Kiran", 
    "beneficiary_number": 8686947002, 
    "beneficiary_status": true, 
    "created_at": "2020-03-16T08:28:05.000Z", 
    "id": 1, 
    "updated_at": "2020-03-16T08:28:05.000Z"
}
```
###### 7.View a beneficiary
```ruby
ruby@ruby:~/visableBank$ http GET 10.0.0.17:3000/beneficiaries/1
HTTP/1.1 200 OK
Cache-Control: max-age=0, private, must-revalidate
Content-Type: application/json; charset=utf-8
ETag: W/"c6e63fadd92e24e31977b7e07e49a95c"
Transfer-Encoding: chunked
X-Request-Id: 7df7d129-13bd-42d9-abee-caec5e8f9671
X-Runtime: 0.004309

{
    "beneficiary_name": "Kiran", 
    "beneficiary_number": 8686947002, 
    "beneficiary_status": true, 
    "created_at": "2020-03-16T08:28:05.000Z", 
    "id": 1, 
    "updated_at": "2020-03-16T08:28:05.000Z"
}
```
###### 8.View all beneficiaries.
```ruby
ruby@ruby:~/visableBank$ http GET 10.0.0.17:3000/beneficiaries
HTTP/1.1 200 OK
Cache-Control: max-age=0, private, must-revalidate
Content-Type: application/json; charset=utf-8
ETag: W/"c500d1531099d8ba8e39d27a4d290e5e"
Transfer-Encoding: chunked
X-Request-Id: 9d4e4b32-abbb-4ded-84a7-c0afee6ac4ac
X-Runtime: 0.003910

[
    {
        "beneficiary_name": "Kiran", 
        "beneficiary_number": 8686947002, 
        "beneficiary_status": true, 
        "created_at": "2020-03-16T08:28:05.000Z", 
        "id": 1, 
        "updated_at": "2020-03-16T08:28:05.000Z"
    }
]
```
###### 9.Edit a beneficiary.
```ruby
ruby@ruby:~/visableBank$ http PUT 10.0.0.17:3000/beneficiaries/1
HTTP/1.1 200 OK
Cache-Control: max-age=0, private, must-revalidate
Content-Type: application/json; charset=utf-8
ETag: W/"36c83a3ca2e60ed2dd22d0c1cf0987dd"
Transfer-Encoding: chunked
X-Request-Id: b5e2446c-05dc-4245-97ba-762ebde9baf0
X-Runtime: 0.009698

{
    "code": 200, 
    "message": "Beneficiary account status updated.", 
    "status": "Success"
}
```
###### 10. Delete a beneficiary.
```ruby
ruby@ruby:~/visableBank$ http DELETE 10.0.0.17:3000/beneficiaries/1
HTTP/1.1 200 OK
Cache-Control: max-age=0, private, must-revalidate
Content-Type: application/json; charset=utf-8
ETag: W/"abc3cb2749d1f7864323723ff30b2a94"
Transfer-Encoding: chunked
X-Request-Id: 71d66647-2540-4d31-a793-2c479869c858
X-Runtime: 0.013605

{
    "code": 200, 
    "message": "Beneficiary deleted.", 
    "status": "Success"
}
```
###### 11. Add account beneficiaries association.
```ruby
ruby@ruby:~/visableBank$ http POST 10.0.0.17:3000/account_beneficiaries account_id=1 beneficiary_id=1
HTTP/1.1 200 OK
Cache-Control: max-age=0, private, must-revalidate
Content-Type: application/json; charset=utf-8
ETag: W/"fe2c48576d510c2bcda6e213ddbe4083"
Transfer-Encoding: chunked
X-Request-Id: d22fb44b-f8f8-49dc-98c1-f436a94cba96
X-Runtime: 0.022655

{
    "account_id": 1, 
    "beneficiary_id": 1, 
    "created_at": "2020-03-16T08:30:01.000Z", 
    "id": 1, 
    "updated_at": "2020-03-16T08:30:01.000Z"
}
```
###### 12. Edit acount beneficiaries association.
```ruby
ruby@ruby:~/visableBank$ http PUT 10.0.0.17:3000/account_beneficiaries/1
HTTP/1.1 200 OK
Cache-Control: max-age=0, private, must-revalidate
Content-Type: application/json; charset=utf-8
ETag: W/"32a05f529d3eba22e3064e9582fb89e6"
Transfer-Encoding: chunked
X-Request-Id: 4d8506db-72a7-473c-9bcc-c2735b374235
X-Runtime: 0.002883

{
    "code": 500, 
    "error": "Update operation not supported.", 
    "status": "Failed"
}
```
###### 13. Delete account beneficiaries association.
```ruby
ruby@ruby:~/visableBank$ http DELETE 10.0.0.17:3000/account_beneficiaries/1
HTTP/1.1 200 OK
Cache-Control: max-age=0, private, must-revalidate
Content-Type: application/json; charset=utf-8
ETag: W/"fe2c48576d510c2bcda6e213ddbe4083"
Transfer-Encoding: chunked
X-Request-Id: aacd818d-5907-41b8-b4b7-dec23a046370
X-Runtime: 0.013683

{
    "account_id": 1, 
    "beneficiary_id": 1, 
    "created_at": "2020-03-16T08:30:01.000Z", 
    "id": 1, 
    "updated_at": "2020-03-16T08:30:01.000Z"
}
```
###### 14. View all account beneficiaries.
```ruby
ruby@ruby:~/visableBank$ http GET 10.0.0.17:3000/beneficiaries
HTTP/1.1 200 OK
Cache-Control: max-age=0, private, must-revalidate
Content-Type: application/json; charset=utf-8
ETag: W/"c500d1531099d8ba8e39d27a4d290e5e"
Transfer-Encoding: chunked
X-Request-Id: 34431927-53dc-4c2a-987d-580ae0c8fc44
X-Runtime: 0.004049

[
    {
        "beneficiary_name": "Kiran", 
        "beneficiary_number": 8686947002, 
        "beneficiary_status": true, 
        "created_at": "2020-03-16T08:28:05.000Z", 
        "id": 1, 
        "updated_at": "2020-03-16T08:28:05.000Z"
    }
]
```
###### 15. View an account beneficiary.
```ruby
ruby@ruby:~/visableBank$ http GET 10.0.0.17:3000/beneficiaries/1
HTTP/1.1 200 OK
Cache-Control: max-age=0, private, must-revalidate
Content-Type: application/json; charset=utf-8
ETag: W/"c6e63fadd92e24e31977b7e07e49a95c"
Transfer-Encoding: chunked
X-Request-Id: 80aa33ee-b057-4781-bf68-cf00fe77f260
X-Runtime: 0.004084

{
    "beneficiary_name": "Kiran", 
    "beneficiary_number": 8686947002, 
    "beneficiary_status": true, 
    "created_at": "2020-03-16T08:28:05.000Z", 
    "id": 1, 
    "updated_at": "2020-03-16T08:28:05.000Z"
}
```
###### 16. Add transaction.
```ruby
ruby@ruby:~/visableBank$ http POST 10.0.0.17:3000/transactions account_id=1 beneficiary_id=1 account_number=8686947001 account_name=Kalyan beneficiary_number=8686947002 beneficiary_name=Kiran amount_debited=1000 amount_credited=1000
HTTP/1.1 200 OK
Cache-Control: max-age=0, private, must-revalidate
Content-Type: application/json; charset=utf-8
ETag: W/"0e153b5df4b30f28bf954bebb124a2d2"
Transfer-Encoding: chunked
X-Request-Id: 217ff0b9-7cd6-4bd2-a7d0-ea382dbc410e
X-Runtime: 0.033424

{
    "code": 200, 
    "message": "Transaction successful.", 
    "status": "Success"
}
```
###### 17. Edit transaction.
```ruby
ruby@ruby:~/visableBank$ http PUT 10.0.0.17:3000/transactions/1
HTTP/1.1 200 OK
Cache-Control: max-age=0, private, must-revalidate
Content-Type: application/json; charset=utf-8
ETag: W/"e4c898a476059cbb50dc586a5f63e458"
Transfer-Encoding: chunked
X-Request-Id: cb35230f-4e18-47dc-b095-dd70a197f5a0
X-Runtime: 0.002922

{
    "code": 500, 
    "error": "Transaction information cannot be updated.", 
    "status": "Failed"
}
```
###### 18. Delete transaction.
```ruby
ruby@ruby:~/visableBank$ http DELETE 10.0.0.17:3000/transactions/1
HTTP/1.1 200 OK
Cache-Control: max-age=0, private, must-revalidate
Content-Type: application/json; charset=utf-8
ETag: W/"4e8ddd327512b7cf6d5f1e41afa62b6c"
Transfer-Encoding: chunked
X-Request-Id: ec87fe81-76cc-4e0a-9e24-aa1087db1be0
X-Runtime: 0.003238

{
    "code": 500, 
    "error": "Beneficiary may be associated with another account, remove mapping in join table.", 
    "status": "Failed"
}
```
###### 19. View all transactions.
```ruby
ruby@ruby:~/visableBank$ http GET 10.0.0.17:3000/transactions
HTTP/1.1 200 OK
Cache-Control: max-age=0, private, must-revalidate
Content-Type: application/json; charset=utf-8
ETag: W/"585b33ffb3aa8ec744f28d3cd17af65b"
Transfer-Encoding: chunked
X-Request-Id: 1e239c33-8ed3-4063-906f-98cfd01b18f2
X-Runtime: 0.004483

[
    {
        "account_id": 1, 
        "account_name": "Kalyan", 
        "account_number": 8686947001, 
        "amount_credited": "1000.0", 
        "amount_debited": "1000.0", 
        "beneficiary_id": 1, 
        "beneficiary_name": "Kiran", 
        "beneficiary_number": 8686947002, 
        "created_at": "2020-03-16T08:31:02.000Z", 
        "id": 1, 
        "updated_at": "2020-03-16T08:31:02.000Z"
    }
]
```
###### 20. View a transaction.
```ruby
ruby@ruby:~/visableBank$ http GET 10.0.0.17:3000/transactions/1
HTTP/1.1 200 OK
Cache-Control: max-age=0, private, must-revalidate
Content-Type: application/json; charset=utf-8
ETag: W/"585b33ffb3aa8ec744f28d3cd17af65b"
Transfer-Encoding: chunked
X-Request-Id: 8c90e960-2eab-4294-ac4b-f905ba7d4fff
X-Runtime: 0.004615

[
    {
        "account_id": 1, 
        "account_name": "Kalyan", 
        "account_number": 8686947001, 
        "amount_credited": "1000.0", 
        "amount_debited": "1000.0", 
        "beneficiary_id": 1, 
        "beneficiary_name": "Kiran", 
        "beneficiary_number": 8686947002, 
        "created_at": "2020-03-16T08:31:02.000Z", 
        "id": 1, 
        "updated_at": "2020-03-16T08:31:02.000Z"
    }
]
```
