create or replace package body ora_test_data_generator_api as

  c_first_name_accent    constant t_category := 'first_name_accent';
  c_first_name_no_accent constant t_category := 'first_name_no_accent';
  c_last_name_accent     constant t_category := 'last_name_accent';
  c_last_name_no_accent  constant t_category := 'last_name_no_accent';
  c_job_title            constant t_category := 'job_title';
  c_company_name         constant t_category := 'company_name';
  c_email_provider       constant t_category := 'email_provider';
  c_domain_suffix        constant t_category := 'domain_suffix';
  c_phone_number         constant t_category := 'phone_number';
  c_credit_card_number   constant t_category := 'credit_card_number';
  c_street_name          constant t_category := 'street_name';
  c_currency_name        constant t_category := 'currency_name';
  c_currency_symbol      constant t_category := 'currency_symbol';
  c_quote                constant t_category := 'quote';

  /*
    Private
  */

  function get_rowcount (
    p_category in t_category
  ) return pls_integer result_cache
  as
    l_count pls_integer;
  begin
    select count(*)
      into l_count
      from ora_test_data_generator_values
     where otdg_category = p_category
    ;

    return l_count;
  end get_rowcount;

  function get_random_value (
    p_category in t_category
  ) return t_value
  as
    l_value_count  pls_integer;
    l_random_index pls_integer;
    l_value        t_value;
  begin
    l_value_count  := get_rowcount(p_category);
    l_random_index := round(dbms_random.value() * l_value_count - 1); -- starting from 0 for offset

    select otdg_value
      into l_value
      from ora_test_data_generator_values
     where otdg_category = p_category
     order by otdg_value
    offset l_random_index rows fetch next 1 rows only
    ;

    return l_value;
  end get_random_value;

  function replace_hashes_with_random_numbers (
    pi_value in t_value
  ) return t_value
  as
    l_value   t_value := pi_value;
    l_numbers varchar2(40) := regexp_replace(to_char(dbms_random.value()), ',((0)+)?', '');
  begin
    for i in 1..length(l_value) 
    loop
      if substr(l_value, i, 1) = '#' then
        case 
            when i > 1 and i < length(l_value) then
              l_value := substr(l_value, 1, i - 1) || substr(l_numbers, i, 1) || substr(l_value, i + 1, length(l_value) - i);
            when i = 1 then
              l_value := substr(l_numbers, i, 1) || substr(l_value, i + 1, length(l_value) - i);
            when i = length(l_value) then
              l_value := substr(l_value, 1, i - 1) || substr(l_numbers, i, 1);
        end case;
      end if;
    end loop;

    return l_value;
  end replace_hashes_with_random_numbers;

  /*
    Public
  */


  -- name functions
  function get_first_name_accent
    return t_value
  as
  begin
    return get_random_value(c_first_name_accent);
  end get_first_name_accent;

  function get_first_name_no_accent
    return t_value
  as
  begin
    return get_random_value(c_first_name_no_accent);
  end get_first_name_no_accent;

  function get_first_name (
    p_accent_chance number default 0.2
  ) return t_value
  as
  begin
    if dbms_random.value() <= p_accent_chance then
      return get_first_name_accent();
    else
      return get_first_name_no_accent();
    end if;
  end get_first_name;

  function get_last_name_accent
    return t_value
  as
  begin
    return get_random_value(c_last_name_accent);
  end get_last_name_accent;

  function get_last_name_no_accent
    return t_value
  as
  begin
    return get_random_value(c_last_name_no_accent);
  end get_last_name_no_accent;

  function get_last_name (
    p_accent_chance number default 0.2
  ) return t_value
  as
  begin
    if dbms_random.value() <= p_accent_chance then
      return get_last_name_accent();
    else
      return get_last_name_no_accent();
    end if;
  end get_last_name;

  function get_full_name(
    p_accent_chance      number default 0.1
  , p_middle_name_chance number default 0.2
  ) return t_value
  as
    l_name t_value;
  begin
    l_name := get_first_name(p_accent_chance);

    if dbms_random.value() <= p_middle_name_chance then
      l_name := l_name || ' ' || get_first_name(p_accent_chance);
    end if;

    l_name := l_name || ' ' || get_last_name(p_accent_chance);

    return l_name;
  end get_full_name;

  function get_job_title
    return t_value
  as
  begin
    return get_random_value(c_job_title);
  end get_job_title;

  function get_company_name
    return t_value
  as
  begin
    return get_random_value(c_company_name);
  end get_company_name;

  function get_email_provider
    return t_value
  as
  begin
    return get_random_value(c_email_provider);
  end get_email_provider;

  function get_domain_suffix
    return t_value
  as
  begin
    return get_random_value(c_domain_suffix);
  end get_domain_suffix;

  function get_phone_number
    return t_value
  as
  begin
    return replace_hashes_with_random_numbers(get_random_value(c_phone_number));
  end get_phone_number;

  function get_credit_card_number
    return t_value
  as
  begin
    return replace_hashes_with_random_numbers(get_random_value(c_credit_card_number));
  end get_credit_card_number;

  function get_street_name
    return t_value
  as
  begin
    return get_random_value(c_street_name);
  end get_street_name;

  function get_currency_name
    return t_value
  as
  begin
    return get_random_value(c_currency_name);
  end get_currency_name;

  function get_currency_symbol
    return t_value
  as
  begin
    return get_random_value(c_currency_symbol);
  end get_currency_symbol;

  function get_quote
    return t_value
  as
  begin
    return get_random_value(c_quote);
  end get_quote;

  function get_email_address
    return t_value
  as
  begin
    return get_first_name_no_accent() || '.' || get_last_name_no_accent() || '@' || get_email_provider() || '.' || get_domain_suffix();
  end get_email_address;



  

end ora_test_data_generator_api;
/
