library verilog;
use verilog.vl_types.all;
entity subway_vlg_sample_tst is
    port(
        cancel          : in     vl_logic;
        clk             : in     vl_logic;
        insert_start    : in     vl_logic;
        money           : in     vl_logic_vector(3 downto 0);
        numbers         : in     vl_logic_vector(2 downto 0);
        select_start    : in     vl_logic;
        station         : in     vl_logic_vector(4 downto 0);
        sampler_tx      : out    vl_logic
    );
end subway_vlg_sample_tst;
