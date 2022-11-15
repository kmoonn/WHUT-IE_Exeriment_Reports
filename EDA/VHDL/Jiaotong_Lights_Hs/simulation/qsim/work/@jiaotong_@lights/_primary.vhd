library verilog;
use verilog.vl_types.all;
entity Jiaotong_Lights is
    port(
        mainroad_lights : out    vl_logic_vector(2 downto 0);
        branchroad_lights: out    vl_logic_vector(2 downto 0);
        mainroad_time_BCD: out    vl_logic_vector(7 downto 0);
        branchroad_time_BCD: out    vl_logic_vector(7 downto 0);
        clk             : in     vl_logic;
        ctr             : in     vl_logic;
        cnt             : out    vl_logic_vector(6 downto 0)
    );
end Jiaotong_Lights;
