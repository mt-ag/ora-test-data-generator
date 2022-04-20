create table ora_test_data_generator_values(
  otdg_category  varchar2(50 char) not null
, otdg_value     varchar2(4000 char) not null
);

create index otdg_category_idx on ora_test_data_generator_values (otdg_category);
