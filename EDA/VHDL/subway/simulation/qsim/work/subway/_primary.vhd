library verilog;
use verilog.vl_types.all;
entity subway is
    port(
        clk             : in     vl_logic;
        select_start    : in     vl_logic;
        insert_start    : in     vl_logic;
        money           : in     vl_logic_vector(3 downto 0);
        cancel          : in     vl_logic;
        station         : in     vl_logic_vector(4 downto 0);
        numbers         : in     vl_logic_vector(2 downto 0);
        ticket_num      : out    vl_logic_vector(2 downto 0);
        change_num      : out    vl_logic_vector(4 downto 0);
        ticket_gate     : out    vl_logic;
        change_gate     : out    vl_logic
    );
end subway;
