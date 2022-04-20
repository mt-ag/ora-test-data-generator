create or replace package ora_test_data_generator_api as

  subtype t_category is lct_fake_data.otdg_category%type;
  subtype t_value    is lct_fake_data.fake_value%type;

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

end ora_test_data_generator_api;
/
