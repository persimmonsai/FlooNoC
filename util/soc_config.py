

NUM_X = 7

data_widths = {"wide": 512, "narrow": 64}

# New soc_type attribute to facilitate auto-testbench generation
# soc_type = {"cluster", "memory", "processor", "peripheral", "serial_link"}

AddrMap = [
	{"idx": {"x": 1, "y": 1}, "name": "cluster_l", "mgr_port": {"narrow": True, "wide": True}, "sbr_port": {"narrow": True, "wide": True}, "start_addr": int("0x000010000000",16), "end_addr": int("0x000010080000",16)},
	{"idx": {"x": 1, "y": 2}, "name": "cluster_l", "mgr_port": {"narrow": True, "wide": True}, "sbr_port": {"narrow": True, "wide": True}, "start_addr": int("0x000010080000",16), "end_addr": int("0x000010100000",16)},
	{"idx": {"x": 1, "y": 3}, "name": "cluster_l", "mgr_port": {"narrow": True, "wide": True}, "sbr_port": {"narrow": True, "wide": True}, "start_addr": int("0x000010100000",16), "end_addr": int("0x000010180000",16)},
	{"idx": {"x": 1, "y": 4}, "name": "cluster_l", "mgr_port": {"narrow": True, "wide": True}, "sbr_port": {"narrow": True, "wide": True}, "start_addr": int("0x000010180000",16), "end_addr": int("0x000010200000",16)},
	{"idx": {"x": 2, "y": 1}, "name": "cluster_l", "mgr_port": {"narrow": True, "wide": True}, "sbr_port": {"narrow": True, "wide": True}, "start_addr": int("0x000010200000",16), "end_addr": int("0x000010280000",16)},
	{"idx": {"x": 2, "y": 2}, "name": "cluster_l", "mgr_port": {"narrow": True, "wide": True}, "sbr_port": {"narrow": True, "wide": True}, "start_addr": int("0x000010280000",16), "end_addr": int("0x000010300000",16)},
	{"idx": {"x": 2, "y": 3}, "name": "cluster_l", "mgr_port": {"narrow": True, "wide": True}, "sbr_port": {"narrow": True, "wide": True}, "start_addr": int("0x000010300000",16), "end_addr": int("0x000010380000",16)},
	{"idx": {"x": 2, "y": 4}, "name": "cluster_l", "mgr_port": {"narrow": True, "wide": True}, "sbr_port": {"narrow": True, "wide": True}, "start_addr": int("0x000010380000",16), "end_addr": int("0x000010400000",16)},
	{"idx": {"x": 3, "y": 1}, "name": "cluster_l", "mgr_port": {"narrow": True, "wide": True}, "sbr_port": {"narrow": True, "wide": True}, "start_addr": int("0x000010400000",16), "end_addr": int("0x000010480000",16)},
	{"idx": {"x": 3, "y": 2}, "name": "cluster_l", "mgr_port": {"narrow": True, "wide": True}, "sbr_port": {"narrow": True, "wide": True}, "start_addr": int("0x000010480000",16), "end_addr": int("0x000010500000",16)},
	{"idx": {"x": 3, "y": 3}, "name": "cluster_l", "mgr_port": {"narrow": True, "wide": True}, "sbr_port": {"narrow": True, "wide": True}, "start_addr": int("0x000010500000",16), "end_addr": int("0x000010580000",16)},
	{"idx": {"x": 3, "y": 4}, "name": "cluster_l", "mgr_port": {"narrow": True, "wide": True}, "sbr_port": {"narrow": True, "wide": True}, "start_addr": int("0x000010580000",16), "end_addr": int("0x000010600000",16)},
	{"idx": {"x": 5, "y": 1}, "name": "cluster_r", "mgr_port": {"narrow": True, "wide": True}, "sbr_port": {"narrow": True, "wide": True}, "start_addr": int("0x000010600000",16), "end_addr": int("0x000010680000",16)},
	{"idx": {"x": 5, "y": 2}, "name": "cluster_r", "mgr_port": {"narrow": True, "wide": True}, "sbr_port": {"narrow": True, "wide": True}, "start_addr": int("0x000010680000",16), "end_addr": int("0x000010700000",16)},
	{"idx": {"x": 5, "y": 3}, "name": "cluster_r", "mgr_port": {"narrow": True, "wide": True}, "sbr_port": {"narrow": True, "wide": True}, "start_addr": int("0x000010700000",16), "end_addr": int("0x000010780000",16)},
	{"idx": {"x": 5, "y": 4}, "name": "cluster_r", "mgr_port": {"narrow": True, "wide": True}, "sbr_port": {"narrow": True, "wide": True}, "start_addr": int("0x000010780000",16), "end_addr": int("0x000010800000",16)},
	{"idx": {"x": 6, "y": 1}, "name": "cluster_r", "mgr_port": {"narrow": True, "wide": True}, "sbr_port": {"narrow": True, "wide": True}, "start_addr": int("0x000010800000",16), "end_addr": int("0x000010880000",16)},
	{"idx": {"x": 6, "y": 2}, "name": "cluster_r", "mgr_port": {"narrow": True, "wide": True}, "sbr_port": {"narrow": True, "wide": True}, "start_addr": int("0x000010880000",16), "end_addr": int("0x000010900000",16)},
	{"idx": {"x": 6, "y": 3}, "name": "cluster_r", "mgr_port": {"narrow": True, "wide": True}, "sbr_port": {"narrow": True, "wide": True}, "start_addr": int("0x000010900000",16), "end_addr": int("0x000010980000",16)},
	{"idx": {"x": 6, "y": 4}, "name": "cluster_r", "mgr_port": {"narrow": True, "wide": True}, "sbr_port": {"narrow": True, "wide": True}, "start_addr": int("0x000010980000",16), "end_addr": int("0x000010a00000",16)},
	{"idx": {"x": 7, "y": 1}, "name": "cluster_r", "mgr_port": {"narrow": True, "wide": True}, "sbr_port": {"narrow": True, "wide": True}, "start_addr": int("0x000010a00000",16), "end_addr": int("0x000010a80000",16)},
	{"idx": {"x": 7, "y": 2}, "name": "cluster_r", "mgr_port": {"narrow": True, "wide": True}, "sbr_port": {"narrow": True, "wide": True}, "start_addr": int("0x000010a80000",16), "end_addr": int("0x000010b00000",16)},
	{"idx": {"x": 7, "y": 3}, "name": "cluster_r", "mgr_port": {"narrow": True, "wide": True}, "sbr_port": {"narrow": True, "wide": True}, "start_addr": int("0x000010b00000",16), "end_addr": int("0x000010b80000",16)},
	{"idx": {"x": 7, "y": 4}, "name": "cluster_r", "mgr_port": {"narrow": True, "wide": True}, "sbr_port": {"narrow": True, "wide": True}, "start_addr": int("0x000010b80000",16), "end_addr": int("0x000010c00000",16)},
	{"idx": {"x": 3, "y": 5}, "name": "hbm_north_dram_0", "mgr_port": {"narrow": False, "wide": False}, "sbr_port": {"narrow": True, "wide": True}, "start_addr": int("0x000080000000",16), "end_addr": int("0x0000c0000000",16)},
	{"idx": {"x": 5, "y": 5}, "name": "hbm_north_dram_1", "mgr_port": {"narrow": False, "wide": False}, "sbr_port": {"narrow": True, "wide": True}, "start_addr": int("0x0000c0000000",16), "end_addr": int("0x000100000000",16)},
	{"idx": {"x": 2, "y": 5}, "name": "hbm_north_2", "mgr_port": {"narrow": False, "wide": False}, "sbr_port": {"narrow": True, "wide": True}, "start_addr": int("0x001000000000",16), "end_addr": int("0x001040000000",16)},
	{"idx": {"x": 6, "y": 5}, "name": "hbm_north_3", "mgr_port": {"narrow": False, "wide": False}, "sbr_port": {"narrow": True, "wide": True}, "start_addr": int("0x001040000000",16), "end_addr": int("0x001080000000",16)},
	{"idx": {"x": 2, "y": 0}, "name": "hbm_south_0", "mgr_port": {"narrow": False, "wide": False}, "sbr_port": {"narrow": True, "wide": True}, "start_addr": int("0x001080000000",16), "end_addr": int("0x0010c0000000",16)},
	{"idx": {"x": 3, "y": 0}, "name": "hbm_south_0", "mgr_port": {"narrow": False, "wide": False}, "sbr_port": {"narrow": True, "wide": True}, "start_addr": int("0x0010c0000000",16), "end_addr": int("0x001100000000",16)},
	{"idx": {"x": 5, "y": 0}, "name": "hbm_south_2", "mgr_port": {"narrow": False, "wide": False}, "sbr_port": {"narrow": True, "wide": True}, "start_addr": int("0x001100000000",16), "end_addr": int("0x001140000000",16)},
	{"idx": {"x": 6, "y": 0}, "name": "hbm_south_2", "mgr_port": {"narrow": False, "wide": False}, "sbr_port": {"narrow": True, "wide": True}, "start_addr": int("0x001140000000",16), "end_addr": int("0x001180000000",16)},
	{"idx": {"x": 0, "y": 1}, "name": "hbm_west", "mgr_port": {"narrow": False, "wide": False}, "sbr_port": {"narrow": True, "wide": True}, "start_addr": int("0x001180000000",16), "end_addr": int("0x0011c0000000",16)},
	{"idx": {"x": 0, "y": 2}, "name": "hbm_west", "mgr_port": {"narrow": False, "wide": False}, "sbr_port": {"narrow": True, "wide": True}, "start_addr": int("0x0011c0000000",16), "end_addr": int("0x001200000000",16)},
	{"idx": {"x": 0, "y": 3}, "name": "hbm_west", "mgr_port": {"narrow": False, "wide": False}, "sbr_port": {"narrow": True, "wide": True}, "start_addr": int("0x001200000000",16), "end_addr": int("0x001240000000",16)},
	{"idx": {"x": 0, "y": 4}, "name": "hbm_west", "mgr_port": {"narrow": False, "wide": False}, "sbr_port": {"narrow": True, "wide": True}, "start_addr": int("0x001240000000",16), "end_addr": int("0x001280000000",16)},
	{"idx": {"x": 8, "y": 1}, "name": "hbm_east", "mgr_port": {"narrow": False, "wide": False}, "sbr_port": {"narrow": True, "wide": True}, "start_addr": int("0x001280000000",16), "end_addr": int("0x0012c0000000",16)},
	{"idx": {"x": 8, "y": 2}, "name": "hbm_east", "mgr_port": {"narrow": False, "wide": False}, "sbr_port": {"narrow": True, "wide": True}, "start_addr": int("0x0012c0000000",16), "end_addr": int("0x001300000000",16)},
	{"idx": {"x": 8, "y": 3}, "name": "hbm_east", "mgr_port": {"narrow": False, "wide": False}, "sbr_port": {"narrow": True, "wide": True}, "start_addr": int("0x001300000000",16), "end_addr": int("0x001340000000",16)},
	{"idx": {"x": 8, "y": 4}, "name": "hbm_east", "mgr_port": {"narrow": False, "wide": False}, "sbr_port": {"narrow": True, "wide": True}, "start_addr": int("0x001340000000",16), "end_addr": int("0x001380000000",16)},
	{"idx": {"x": 4, "y": 5}, "name": "idma", "mgr_port": {"narrow": True, "wide": True}, "sbr_port": {"narrow": True, "wide": True}, "start_addr": int("0x000011000000",16), "end_addr": int("0x000011010000",16)},
	{"idx": {"x": 4, "y": 4}, "name": "spm", "mgr_port": {"narrow": False, "wide": False}, "sbr_port": {"narrow": True, "wide": True}, "start_addr": int("0x000070000000",16), "end_addr": int("0x000070100000",16)},
	{"idx": {"x": 4, "y": 3}, "name": "cva6", "mgr_port": {"narrow": True, "wide": False}, "sbr_port": {"narrow": True, "wide": False}, "start_addr": int("0x800000000000",16), "end_addr": int("0x800000100000",16)},
	{"idx": {"x": 4, "y": 2}, "name": "peripherals", "mgr_port": {"narrow": False, "wide": False}, "sbr_port": {"narrow": True, "wide": True}, "start_addr": int("0x000001000000",16), "end_addr": int("0x00000c000000",16)},
	{"idx": {"x": 4, "y": 1}, "name": "jtag", "mgr_port": {"narrow": True, "wide": False}, "sbr_port": {"narrow": True, "wide": False}, "start_addr": int("0x000000000000",16), "end_addr": int("0x000000001000",16)},
	{"idx": {"x": 4, "y": 0}, "name": "zero_mem", "mgr_port": {"narrow": False, "wide": False}, "sbr_port": {"narrow": False, "wide": True}, "start_addr": int("0x000100000000",16), "end_addr": int("0x000300000000",16)}
]


