# 全自动洗衣机控制器的设计与仿真



## 设计思路

​		设计一个简易的全自动洗衣机控制器，该控制器可以实现全自动洗衣机的定时启动，自动控制及定时设置等功能。其工作流程为：定时启动→正转20s→暂停10s→反转20s→暂停10s→定时不到，重复上述过程，若定时已到，停止发出音响。控制器的设计主要是定时器的设计，利用减法计数器，时序控制电路和工作状态控制电路等组成，可以实现正转、反转和暂停等洗衣机的工作过程，并且用四个数码管可以显示预置洗涤时间，按倒计时方式对洗涤过程进行计数显示，直到时间到停机。



## 代码清单

```vhdl
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;
entity EX01 is
port(
	clk:in std_logic;	
	start:in std_logic;	
	reset:in std_logic;
	input:out std_logic;
	output:out std_logic;	
	forward:out std_logic;
	reversal:out std_logic;
	wash,rinse,drying,stop:out std_logic
);
end EX01;
architecture washer of EX01 is
	type state_type is (open_state,wash_state,cycle_state,rinse_state,drying_state,end_state);
	signal state: state_type;
begin
	process(clk)
		VARIABLE flag: std_logic_vector(1 downto 0);
		VARIABLE rinse_num: std_logic_vector(1 downto 0);
		VARIABLE cent: std_logic_vector(4 downto 0);
		VARIABLE count: std_logic_vector(4 downto 0);
		VARIABLE cycle_num: std_logic_vector(2 downto 0);
	begin
		IF(clk'event and clk='1')THEN
			IF(reset='1') THEN
				state<=open_state;
			END IF;
			CASE state IS
				WHEN open_state=>
					input<='0';
					output<='0';
					forward<='0';
					reversal<='0';
					wash<='0';
					rinse<='0';
					drying<='0';
					stop<='0';
					flag:="00";
					rinse_num:="00";
					cent:="00000";
					count:="00000";
					cycle_num:="000";
					IF(start='1')THEN
						state<=wash_state;
					END IF;
				WHEN wash_state=>
					wash<='1';
					IF(flag="00")THEN
						IF(cent<"01010")THEN
							input<='1';
							cent:=cent+"00001";
						ELSIF(cent<"01111")THEN
								input<='0';
								cent:=cent+"00001";
						ELSE
							state<=cycle_state;
							cent:="00000";
						END IF;
					ELSIF(flag="01")THEN
							IF(cent<"01010")THEN
								output<='1';
								cent:=cent+"00001";
							ELSE
								output<='0';
								cent:="00000";
								wash<='0';
								state<=rinse_state;
							END IF;
					END IF;			
				WHEN cycle_state=>
					IF(cent<"00010")THEN
						forward<='1';
						cent:=cent+"00001";
					ELSIF(cent<"00011")THEN
						forward<='0';
						cent:=cent+"00001";
					ELSIF(cent<"00101")THEN
						reversal<='1';
						cent:=cent+"00001";
					ELSE
						reversal<='0';
						cycle_num:=cycle_num+"001";
						cent:="00000";
					END IF;
					IF((cycle_num>="101")AND(flag="00"))THEN
						flag:="01";
						state<=wash_state;
						cycle_num:="000";
						cent:="00000";
					ELSIF((cycle_num>="101")AND(flag="01"))THEN
							flag:="10";
							state<=rinse_state;
							cycle_num:="000";
							cent:="00000";
					END IF;
				WHEN rinse_state=>
					rinse<='1';
					IF(flag="01")THEN
						IF(cent<"01010")THEN
							input<='1';
							cent:=cent+"00001";
						ELSIF(cent<"01111")THEN
								input<='0';
								cent:=cent+"00001";
						ELSE
							state<=cycle_state;
							cent:="00000";
						END IF;
					ELSIF(flag="10")THEN
							IF(cent<"01010")THEN
								output<='1';
								cent:=cent+"00001";
							ELSE
								output<='0';
								cent:="00000";
								rinse_num:=rinse_num+"01";
								IF(rinse_num<"11")THEN
									flag:="01";
								ELSE
									rinse<='0';
									output<='1';
									state<=drying_state;
								END IF;
							END IF;
					END IF;	
				WHEN drying_state=>
					drying<='1';
					IF(cent<"10100")THEN
						forward<='1';
						cent:=cent+"00001";
					ELSE
						forward<='0';
						drying<='0';
						state<=end_state;
					END IF;
				WHEN end_state=>
					if(count<"11111") THEN
						count:=count+"00001";
						stop<='1';
					else
						stop<='0';
					end if;
					input<='0';
					output<='0';
					forward<='0';
					reversal<='0';
					wash<='0';
					rinse<='0';
					drying<='0';
					flag:="00";
					rinse_num:="00";
					cent:="00000";
					cycle_num:="000";
			END CASE;
		END IF;
end process;
end architecture washer;
```

## 原理图

<img src="../../../AppData/Roaming/Typora/typora-user-images/image-20230310140435631.png" alt="image-20230310140435631" style="zoom:50%;" />

## 仿真波形

![image-20230303143100273](../../../AppData/Roaming/Typora/typora-user-images/image-20230303143100273.png)

仿真波形说明

## 实验小结



