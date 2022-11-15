```vhdl
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;

entity subway is
port(
	clk:in std_logic;	--系统时钟
	select_start:in std_logic;	--"开始选择"按钮
	insert_start:in std_logic; --"开始投币"按钮
	money:in std_logic_vector(3 downto 0);	--投币入口
	cancel:in std_logic;	--"取消购票"按钮
	station:in std_logic_vector(4 downto 0);	--出站口编号
	numbers:in std_logic_vector(2 downto 0);	--购买票数
	ticket_num:out std_logic_vector(2 downto 0);	--出票数
	change_num:out std_logic_vector(4 downto 0);	--找零数
	ticket_gate:out std_logic;	--出票口
	change_gate:out std_logic	--找零口
);
end subway;

architecture bhv of subway is
	type state_type is(init_state,select_state,insert_state,ticket_state,change_state);	--状态变量申明
	signal state:state_type; 	--状态信号申明
	begin
		process(clk)
			variable type_exit:std_logic;	--记录是否已选择出站口的变量
			variable type_num:std_logic;	--记录是否已选择购票张数的变量
			variable type_out:std_logic;	--记录是否已出票的变量
			variable price:std_logic_vector(4 downto 0);	--记录单张票价的变量
			variable temp_number:std_logic_vector(2 downto 0);	--记录票数的中间变量
			variable total_price:std_logic_vector(4 downto 0);	--记录总票价的变量
			variable total_insert:std_logic_vector(4 downto 0);	--记录投入钱币总额的变量
			variable change:std_logic_vector(4 downto 0);	--记录应找零金额的变量
			variable sign:std_logic;	--记录系统是否已经过初始化的变量
			variable temp_enough:std_logic;	--记录投入钱币金额达到总票价的变量
			variable x:std_logic;		--找零波形辅助变量
			variable y:std_logic;		--出票波形辅助变量
			variable distance:std_logic_vector(4 downto 0);	--记录出站口的中间变量
			variable num:std_logic_vector(2 downto 0);	--记录票数的中间变量

			begin
				if(clk'event and clk='1') then	--时钟信号上升沿触发
					case state is
						when init_state=>	--初始状态
							if(sign='0')	then	--表示系统未经过初始化
								ticket_num<="000";	--购票记录清零
								change_num<="00000";	--找零数清零
								ticket_gate<='0';	--出票口关闭
								change_gate<='0';	--找零口关闭
								type_exit:='0';
								type_out:='0';
								type_num:='0';
								price:="00000";	--单张票价记录清零
								temp_number:="000";	--购票张数记录清零
								total_price:="00000";	--票价总额记录清零
								total_insert:="00000";	--投入钱币总额记录清零
								change:="00000";	--应找零金额记录清零
								sign:='1';	--记录已完成系统初始化
								temp_enough:='0';	--投入达到总票价记录清零
								distance:="00000";
								x:='0';
								y:='0';
								num:="000";
							else	--表示系统已经过初始化
								if(select_start='1') then --按下“开始选择”按钮
									sign:='0';
									state<=select_state;	--系统进入选择状态
								end if;
							end if;
						when select_state=>	--选择状态
							if(type_exit='0')	then	--表示尚未选择出站口
								distance:=station;
								if((distance>="00001")and(distance<="00011"))then
									price:="00011";	--票价为3元
									type_exit:='1';	--记录已选择出站口
								elsif((distance>="00100")and(distance<="01001"))then
									price:="00010";	--票价为2元
									type_exit:='1';
								elsif((distance>="01010")and(distance<="01110"))then
									price:="00010";	--票价为2元
									type_exit:='1';	
								elsif((distance>="01111")and(distance<="10011"))then
									price:="00011";	--票价为3元
									type_exit:='1';	
								elsif((distance>="10100")and(distance<="11000"))then
									price:="00100";	--票价为4元
									type_exit:='1';	
								elsif((distance>="11001")and(distance<="11011"))then
									price:="00101";	--票价为5元
									type_exit:='1';
								end if;
							end if;
							if((type_num='0')and(type_exit='1'))	then	--表示已选择出站口但尚未选择购票张数
								case numbers is
									when "100"=>	--选择4张票
										temp_number:="100";--购票张数为4
										num:="100";
										total_price:=price+price+price+price;--计算总票价
										type_num:='1';--记录已选择购票张数
									when "011"=>	--选择3张票
										temp_number:="011";
										num:="011";
										total_price:=price+price+price;
										type_num:='1';
									when "010"=>	--选择2张票
										temp_number:="010";
										num:="010";
										total_price:=price+price;
										type_num:='1';
									when "001"=>	--选择1张票
										temp_number:="001";
										num:="001";
										total_price:=price;
										type_num:='1';
									when others=>
										null;
								end case;
							end if;
							if((type_exit='1')and(type_num='1'))	then	--表示已选择出站口且已选择购票张数
								if(insert_start='1') then	--按下“开始投币”按钮
									state<=insert_state;--系统进入投币状态
								end if;
							end if;
							if(cancel='1') then --按下“取消”按钮
								state<=init_state;	--回到初始状态
							end if;
						when insert_state=>	--投币状态
								case money is	--投币
									when "0001"=>	--1元币
										total_insert:=total_insert+"00001";	--重新计算投币总额
										if(cancel='1') then	--按下“取消”按钮
											change:=total_insert;
											state<=change_state;	--回到初始状态
										end if;
									when "1010"=>  --10元币
										total_insert:=total_insert+"01010";	
										if(cancel='1') then	--按下“取消”按钮
											change:=total_insert;
											state<=change_state;	--回到初始状态
										end if;
									when others=>
										null;
								end case;
							
							if(total_insert>=total_price)then	--判断投入总金额是否已达到票价总额
								temp_enough:='1';--记录投入钱币金额达到总票价
							end if;
							if(temp_enough='1' and cancel='0')then	--判断投入钱币金额达到总票价
								state<=ticket_state;--系统进入出票状态
							end if;
						when ticket_state=>	--出票状态 
							ticket_num<=temp_number;--计算输出车票
							if(temp_number>"000" and y='0') then
								ticket_gate<='1';	--出票口打开
								temp_number:=temp_number-"001";--计算剩余票数
								y:='1';
							elsif(temp_number="000") then
								ticket_gate<='0';
								type_out:='0';
								if((type_out<='0') and (change>"00000")) then	--判断是否还有找零
									state<=change_state;	--系统进入找零状态
								else
									state<=init_state;	--找零完成，回到初始状态
								end if;
							else
								ticket_gate<='0';	
								y:='0';				--出票口关闭
							end if;
							if(num="100")	then
								change:=total_insert-price-price-price-price;
							elsif(num="011") then
								change:=total_insert-price-price-price;
							elsif(num="010") then
								change:=total_insert-price-price;
							elsif(num="001") then
								change:=total_insert-price;
							end if;
						when change_state=>	--找零状态	--找零口打开时，可控制每个时钟上升沿推出一个1元的硬币
							change_num<=change;
							if(change>"00000" and x='0') then
								change_gate<='1';		--找零口打开
								change:=change-"00001";		--计算剩余应找零金额
								x:='1';
							elsif(change="00000") then
								change_gate<='0';
								state<=init_state;	--系统回到初始状态
							else
								change_gate<='0';	
								x:='0';--找零口关闭
							end if;
				end case;
			end if;
	end process;
end bhv;
                
                
                
                
                
                
```



<div STYLE="page-break-after: always;"></div>

![uTools_1668091676222](C:\Users\34538\Desktop\uTools_1668091676222.png)



![uTools_1668091800648](C:\Users\34538\Desktop\uTools_1668091800648.png)



![uTools_1668093102005](C:\Users\34538\Desktop\uTools_1668093102005.png)



![uTools_1668091571266](C:\Users\34538\Desktop\uTools_1668091571266.png)



