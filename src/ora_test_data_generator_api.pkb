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
      from lct_fake_data
     where fake_category = p_category
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

    select fake_value
      into l_value
      from lct_fake_data
     where fake_category = p_category
     order by fake_value
    offset l_random_index rows fetch next 1 rows only
    ;

    return l_value;
  end get_random_value;

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


  

end ora_test_data_generator_api;
/
