library verilog;
use verilog.vl_types.all;
entity Jiaotong_Lights_vlg_check_tst is
    port(
        branchroad_lights: in     vl_logic_vector(2 downto 0);
        branchroad_time_BCD: in     vl_logic_vector(7 downto 0);
        cnt             : in     vl_logic_vector(6 downto 0);
        mainroad_lights : in     vl_logic_vector(2 downto 0);
        mainroad_time_BCD: in     vl_logic_vector(7 downto 0);
        sampler_rx      : in     vl_logic
    );
end Jiaotong_Lights_vlg_check_tst;
