-module(pkt_lldp_tests).

-include_lib("pkt/include/pkt.hrl").
-include_lib("eunit/include/eunit.hrl").

codec_test_() ->
    [
        decode(),
        encode(),
        pkt_decode(),
        unknown_tlv_decode(),
        unknown_tlv_eecode()
    ].

packet() ->
    <<16#02, 16#07, 16#04, 16#00, 16#01, 16#30, 16#f9, 16#ad,
      16#a0, 16#04, 16#04, 16#05, 16#31, 16#2f, 16#31, 16#06,
      16#02, 16#00, 16#78, 16#08, 16#17, 16#53, 16#75, 16#6d,
      16#6d, 16#69, 16#74, 16#33, 16#30, 16#30, 16#2d, 16#34,
      16#38, 16#2d, 16#50, 16#6f, 16#72, 16#74, 16#20, 16#31,
      16#30, 16#30, 16#31, 16#00, 16#0a, 16#0d, 16#53, 16#75,
      16#6d, 16#6d, 16#69, 16#74, 16#33, 16#30, 16#30, 16#2d,
      16#34, 16#38, 16#00, 16#0c, 16#4c, 16#53, 16#75, 16#6d,
      16#6d, 16#69, 16#74, 16#33, 16#30, 16#30, 16#2d, 16#34,
      16#38, 16#20, 16#2d, 16#20, 16#56, 16#65, 16#72, 16#73,
      16#69, 16#6f, 16#6e, 16#20, 16#37, 16#2e, 16#34, 16#65,
      16#2e, 16#31, 16#20, 16#28, 16#42, 16#75, 16#69, 16#6c,
      16#64, 16#20, 16#35, 16#29, 16#20, 16#62, 16#79, 16#20,
      16#52, 16#65, 16#6c, 16#65, 16#61, 16#73, 16#65, 16#5f,
      16#4d, 16#61, 16#73, 16#74, 16#65, 16#72, 16#20, 16#30,
      16#35, 16#2f, 16#32, 16#37, 16#2f, 16#30, 16#35, 16#20,
      16#30, 16#34, 16#3a, 16#35, 16#33, 16#3a, 16#31, 16#31,
      16#00, 16#0e, 16#04, 16#00, 16#14, 16#00, 16#14, 16#10,
      16#0e, 16#07, 16#06, 16#00, 16#01, 16#30, 16#f9, 16#ad,
      16#a0, 16#02, 16#00, 16#00, 16#03, 16#e9, 16#00, 16#fe,
      16#07, 16#00, 16#12, 16#0f, 16#02, 16#07, 16#01, 16#00,
      16#fe, 16#09, 16#00, 16#12, 16#0f, 16#01, 16#03, 16#6c,
      16#00, 16#00, 16#10, 16#fe, 16#09, 16#00, 16#12, 16#0f,
      16#03, 16#01, 16#00, 16#00, 16#00, 16#00, 16#fe, 16#06,
      16#00, 16#12, 16#0f, 16#04, 16#05, 16#f2, 16#fe, 16#06,
      16#00, 16#80, 16#c2, 16#01, 16#01, 16#e8, 16#fe, 16#07,
      16#00, 16#80, 16#c2, 16#02, 16#01, 16#00, 16#00, 16#fe,
      16#17, 16#00, 16#80, 16#c2, 16#03, 16#01, 16#e8, 16#10,
      16#76, 16#32, 16#2d, 16#30, 16#34, 16#38, 16#38, 16#2d,
      16#30, 16#33, 16#2d, 16#30, 16#35, 16#30, 16#35, 16#00,
      16#fe, 16#05, 16#00, 16#80, 16#c2, 16#04, 16#00, 16#00,
      16#00>>.
packet(entire_pkt) ->
    <<
        16#01, 16#80, 16#c2, 16#00, 16#00, 16#0e, 16#00, 16#04,
        16#96, 16#1f, 16#a7, 16#26, 16#88, 16#cc, 16#02, 16#07,
        16#04, 16#00, 16#04, 16#96, 16#1f, 16#a7, 16#26, 16#04,
        16#04, 16#05, 16#31, 16#2f, 16#33, 16#06, 16#02, 16#00,
        16#78, 16#06, 16#02, 16#00, 16#01, 16#06, 16#02, 16#00,
        16#02, 16#06, 16#02, 16#00, 16#03, 16#00, 16#00, 16#ff,
        16#ff, 16#ff, 16#ff, 16#ff, 16#ff, 16#ff, 16#ff, 16#ff,
        16#ff, 16#ff, 16#ff, 16#ff, 16#ff, 16#ff, 16#aa, 16#bb
    >>;
packet(unknown_tlv_packet) ->
    <<
        16#01, 16#80, 16#c2, 16#00, 16#00, 16#0e, 16#ca, 16#e1,
        16#f8, 16#79, 16#9b, 16#82, 16#88, 16#cc, 16#02, 16#07,
        16#04, 16#72, 16#71, 16#fe, 16#9b, 16#8e, 16#4d, 16#04,
        16#03, 16#02, 16#00, 16#02, 16#06, 16#02, 16#00, 16#78,
        16#fe, 16#0c, 16#00, 16#26, 16#e1, 16#00, 16#00, 16#00,
        16#72, 16#71, 16#fe, 16#9b, 16#8e, 16#4d, 16#18, 16#08,
        16#06, 16#8f, 16#10, 16#aa, 16#74, 16#d7, 16#9a, 16#16,
        16#e6, 16#01, 16#01, 16#fe, 16#0c, 16#00, 16#26, 16#e1,
        16#01, 16#00, 16#00, 16#00, 16#00, 16#15, 16#11, 16#34,
        16#97, 16#00, 16#00
    >>.

decode() ->
    ?_assertEqual({{lldp, [{chassis_id,mac_address,<<0,1,48,249,173,160>>},
                           {port_id,interface_name,<<"1/1">>},
                           {ttl,120},
                           {port_desc,<<"Summit300-48-Port 1001">>},
                           {system_name,<<"Summit300-48">>},
                           {system_desc,<<"Summit300-48 - Version 7.4e.1 (Build 5) by Release_Master 05/27/05 04:53:11">>},
                           {system_capability,[router,bridge],[router,bridge]},
                           {management_address,<<7,6,0,1,48,249,173,160,2,0,0,3,233,0>>},
                           {organizationally_specific,<<0,18,15,2,7,1,0>>},
                           {organizationally_specific,<<0,18,15,1,3,108,0,0,16>>},
                           {organizationally_specific,<<0,18,15,3,1,0,0,0,0>>},
                           {organizationally_specific,<<0,18,15,4,5,242>>},
                           {organizationally_specific,<<0,128,194,1,1,232>>},
                           {organizationally_specific,<<0,128,194,2,1,0,0>>},
                           {organizationally_specific,<<0,128,194,3,1,232,16,118,
                                                        50,45,48,52,56,56,45,48,51,45,48, 53,48,53,0>>},
                           {organizationally_specific,<<0,128,194,4,0>>},
                           end_of_lldpdu]}, <<>>},
                  pkt:lldp(packet())).

encode() ->
    {Header, _Payload} = pkt:lldp(packet()),
    ?_assertEqual(pkt:lldp(Header), packet()).

pkt_decode() ->
    ?_assertEqual(
        {ok,{[{ether,<<1,128,194,0,0,14>>,
            <<0,4,150,31,167,38>>,
            35020,0},
            {lldp,[{chassis_id,mac_address,<<0,4,150,31,167,38>>},
                {port_id,interface_name,<<"1/3">>},
                {ttl,120},
                {ttl,1},
                {ttl,2},
                {ttl,3},
                end_of_lldpdu]}],
            <<>>}},
        pkt:codec(packet(entire_pkt))
    ).

unknown_tlv_decode() ->
    ?_assertEqual(
        {ok,{[
            {ether,<<1,128,194,0,0,14>>, <<202,225,248,121,155,130>>,35020,0},
            {lldp,[
                {chassis_id,mac_address,<<114,113,254,155,142,77>>},
                {port_id,port_component,<<0,2>>},
                {ttl,120},
                {organizationally_specific,<<0,38,225,0,0,0,114,113,254,155,142,77>>},
                {unknown_lldp_tlv,12,<<6,143,16,170,116,215,154,22>>},
                {unknown_lldp_tlv,115,<<1>>},
                {organizationally_specific,<<0,38,225,1,0,0,0,0,21,17,52,151>>},
                end_of_lldpdu
            ]}],
            <<>>
        }},
        pkt:codec(packet(unknown_tlv_packet))
    ).

unknown_tlv_eecode() ->
    {ok, DecodedTuple} = pkt:codec(packet(unknown_tlv_packet)),
    ?_assertEqual(
        packet(unknown_tlv_packet),
        pkt:codec(DecodedTuple)
    ).
