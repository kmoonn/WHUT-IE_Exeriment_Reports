library verilog;
use verilog.vl_types.all;
entity subway_vlg_check_tst is
    port(
        change_gate     : in     vl_logic;
        change_num      : in     vl_logic_vector(4 downto 0);
        ticket_gate     : in     vl_logic;
        ticket_num      : in     vl_logic_vector(2 downto 0);
        sampler_rx      : in     vl_logic
    );
end subway_vlg_check_tst;
