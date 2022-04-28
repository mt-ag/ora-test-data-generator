# ora-test-data-generator

Oracle PL/SQL package to generate authentic test data.

The majority of the example values are copied from [falso](https://github.com/ngneat/falso).

## Installation

- Download the zip file from the [latest release](https://github.com/mt-ag/ora-test-data-generator/releases).
- Run `install.sql` in your database

To uninstall run `uninstall.sql`

## Usage

Query random values:

```sql
select rownum
     , ora_test_data_generator_api.get_first_name(p_accent_chance => 0.4)
     , ora_test_data_generator_api.get_last_name(p_accent_chance => 0.4)
  from dual
  connect by rownum <= 100
```
... or create a table:

```sql
create table users as
  select rownum as id
      , ora_test_data_generator_api.get_first_name(p_accent_chance => 0.05) as first_name
      , ora_test_data_generator_api.get_last_name(p_accent_chance => 0.05) as last_name
      , ora_test_data_generator_api.get_country() as country
      , ora_test_data_generator_api.get_credit_card_number () as credit_card_no
      , ora_test_data_generator_api.get_phone_number() as phone_no
  from dual
  connect by rownum <= 20
```
For a full list and the exact function names check out the [package spec](https://github.com/mt-ag/ora-test-data-generator/blob/main/src/ora_test_data_generator_api.pks). If you need more domains feel free to open an issue or even create a pull request.
