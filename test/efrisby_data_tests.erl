-module(efrisby_data_tests).
-include_lib("eunit/include/eunit.hrl").

get_root_data_test() ->
    Json = [
        {
            <<"args">>, {
                [{<<"foo">>,<<"bar">>}]
            }
        }
    ],

    ?assertEqual(Json, efrisby_data:get(".", Json)),
    ?assertEqual(Json, efrisby_data:get(<<".">>, Json)).

get_data_from_path_test() ->
    Args = [
        {<<"foo">>,<<"bar">>}
    ],
    Json = [
        {<<"args">>, Args}
    ],

    ?assertEqual(Args, efrisby_data:get(".args", Json)).

get_element_from_list_path_test() ->
    List = [<<"first">>, <<"second">>, <<"third">>],
    Json = [
        {<<"list">>, List}
    ],

    ?assertEqual(List, efrisby_data:get(".list", Json)),
    ?assertEqual(<<"second">>, efrisby_data:get(".list.2", Json)).

get_data_from_complex_path_test() ->
    Json = [
        {<<"headers">>, [
            {<<"Host">>, <<"httpbin.org">>}
        ]}
    ],

    ?assertEqual(<<"httpbin.org">>, efrisby_data:get(".headers.Host", Json)),
    ?assertEqual(<<"httpbin.org">>, efrisby_data:get(<<".headers.Host">>, Json)).

get_data_from_json_binary_test() ->
    Body     = <<"{\"args\":{\"foo\":\"bar\"}}">>,
    Actual   = efrisby_data:get(".args", Body),
    Expected = [
        {<<"foo">>,<<"bar">>}
    ],

    ?assertEqual(Expected, Actual).

get_data_from_json_string_test() ->
    Body     = "{\"args\":{\"foo\":\"bar\"}}",
    Actual   = efrisby_data:get(".args", Body),
    Expected = [
        {<<"foo">>,<<"bar">>}
    ],

    ?assertEqual(Expected, Actual).