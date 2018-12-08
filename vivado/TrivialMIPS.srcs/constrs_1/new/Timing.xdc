create_clock -period 20.000 -name clk_50M -waveform {0.000 10.000} [get_ports clk_50M]
create_clock -period 90.422 -name clk_11M0592 -waveform {0.000 45.211} [get_ports clk_11M0592]

set all_mmcm_clk   [get_clocks -of_objects [get_pins clk_wiz_instance/inst/mmcm_adv_inst/CLKOUT*]]
set sram_clk       [get_clocks out_60M_shift_top_clk_wiz]
set vga_clk        [get_clocks clk_50M]
set main_clk       [get_clocks out_30M_top_clk_wiz]
set peripheral_clk [get_clocks out_60M_shift_top_clk_wiz]

set_false_path -from $vga_clk               -to $all_mmcm_clk
set_false_path -from $all_mmcm_clk          -to $vga_clk
set_false_path -from $peripheral_clk        -to $main_clk
set_false_path -from [get_pins rst_reg_*/*] -to *

set_input_delay  -clock $sram_clk -min -add_delay 8.000  [get_ports {base_ram\.data[*]}]
set_input_delay  -clock $sram_clk -max -add_delay 10.000 [get_ports {base_ram\.data[*]}]
set_input_delay  -clock $sram_clk -min -add_delay 8.000  [get_ports {ext_ram\.data[*]}]
set_input_delay  -clock $sram_clk -max -add_delay 10.000 [get_ports {ext_ram\.data[*]}]
set_output_delay -clock $sram_clk -min -add_delay 0.000 [get_ports {base_ram\.address[*]}]
set_output_delay -clock $sram_clk -max -add_delay 8.000 [get_ports {base_ram\.address[*]}]
set_output_delay -clock $sram_clk -min -add_delay 0.000 [get_ports {base_ram\.be_n[*]}]
set_output_delay -clock $sram_clk -max -add_delay 8.000 [get_ports {base_ram\.be_n[*]}]
set_output_delay -clock $sram_clk -min -add_delay 0.000 [get_ports {base_ram\.data[*]}]
set_output_delay -clock $sram_clk -max -add_delay 8.000 [get_ports {base_ram\.data[*]}]
set_output_delay -clock $sram_clk -min -add_delay 0.000 [get_ports {ext_ram\.address[*]}]
set_output_delay -clock $sram_clk -max -add_delay 8.000 [get_ports {ext_ram\.address[*]}]
set_output_delay -clock $sram_clk -min -add_delay 0.000 [get_ports {ext_ram\.be_n[*]}]
set_output_delay -clock $sram_clk -max -add_delay 8.000 [get_ports {ext_ram\.be_n[*]}]
set_output_delay -clock $sram_clk -min -add_delay 0.000 [get_ports {ext_ram\.data[*]}]
set_output_delay -clock $sram_clk -max -add_delay 8.000 [get_ports {ext_ram\.data[*]}]
set_output_delay -clock $sram_clk -min -add_delay 0.000 [get_ports {base_ram\.ce_n}]
set_output_delay -clock $sram_clk -max -add_delay 8.000 [get_ports {base_ram\.ce_n}]
set_output_delay -clock $sram_clk -min -add_delay 0.000 [get_ports {base_ram\.oe_n}]
set_output_delay -clock $sram_clk -max -add_delay 8.000 [get_ports {base_ram\.oe_n}]
set_output_delay -clock $sram_clk -min -add_delay 0.000 [get_ports {base_ram\.we_n}]
set_output_delay -clock $sram_clk -max -add_delay 8.000 [get_ports {base_ram\.we_n}]
set_output_delay -clock $sram_clk -min -add_delay 0.000 [get_ports {ext_ram\.ce_n}]
set_output_delay -clock $sram_clk -max -add_delay 8.000 [get_ports {ext_ram\.ce_n}]
set_output_delay -clock $sram_clk -min -add_delay 0.000 [get_ports {ext_ram\.oe_n}]
set_output_delay -clock $sram_clk -max -add_delay 8.000 [get_ports {ext_ram\.oe_n}]
set_output_delay -clock $sram_clk -min -add_delay 0.000 [get_ports {ext_ram\.we_n}]
set_output_delay -clock $sram_clk -max -add_delay 8.000 [get_ports {ext_ram\.we_n}]
