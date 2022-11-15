library verilog;
use verilog.vl_types.all;
entity Jiaotong_lights_vlg_sample_tst is
    port(
        clk             : in     vl_logic;
        ctr             : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end Jiaotong_lights_vlg_sample_tst;
