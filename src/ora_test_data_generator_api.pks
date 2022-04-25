create or replace package ora_test_data_generator_api as

  subtype t_category is ora_test_data_generator_values.otdg_category%type;
  subtype t_value    is ora_test_data_generator_values.otdg_value%type;

  function get_first_name_accent
    return t_value
  ;

  function get_first_name_no_accent
    return t_value
  ;

  function get_first_name(
    p_accent_chance number default 0.2
  ) return t_value;

  function get_last_name_accent
    return t_value
  ;

  function get_last_name_no_accent
    return t_value
  ;

  function get_last_name(
    p_accent_chance number default 0.2
  ) return t_value;

  function get_full_name(
    p_accent_chance      number default 0.1
  , p_middle_name_chance number default 0.2
  ) return t_value;

  function get_job_title
    return t_value
  ;
  
  function get_company_name
    return t_value
  ;
  
  function get_email_provider
    return t_value
  ;
  
  function get_domain_suffix
    return t_value
  ;
  
  function get_phone_number
    return t_value
  ;
  
  function get_credit_card_number
    return t_value
  ;
  
  function get_street_name
    return t_value
  ;
  
  function get_currency_code
    return t_value
  ;

  function get_currency_name
    return t_value
  ;
  
  function get_currency_symbol
    return t_value
  ;

  function get_country
    return t_value
  ;

  function get_country_code
    return t_value
  ;
  
  function get_quote
    return t_value
  ;

  function get_email_address
    return t_value
  ;
  

end ora_test_data_generator_api;
/
