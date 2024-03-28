

NUM_X = 2

data_widths = {"wide": 512, "narrow": 64}

# New soc_type attribute to facilitate auto-testbench generation
# soc_type = {"cluster", "memory", "processor", "peripheral", "serial_link"}

AddrMap = [
	{"idx": {"x": 1, "y": 1}, "name": "cluster", "soc_type": "cluster", "start_addr": int("0x000010000000",16), "end_addr": int("0x000010040000",16)},
	{"idx": {"x": 1, "y": 2}, "name": "cluster", "soc_type": "cluster", "start_addr": int("0x000010040000",16), "end_addr": int("0x000010080000",16)},
	{"idx": {"x": 2, "y": 1}, "name": "cluster", "soc_type": "cluster", "start_addr": int("0x000010080000",16), "end_addr": int("0x0000100c0000",16)},
	{"idx": {"x": 2, "y": 2}, "name": "cluster", "soc_type": "cluster", "start_addr": int("0x0000100c0000",16), "end_addr": int("0x000010100000",16)},
	{"idx": {"x": 1, "y": 3}, "name": "hbm_north", "soc_type": "memory", "start_addr": int("0x000080000000",16), "end_addr": int("0x000100000000",16)},
	{"idx": {"x": 2, "y": 3}, "name": "hbm_north", "soc_type": "memory", "start_addr": int("0x000100000000",16), "end_addr": int("0x000180000000",16)},
	{"idx": {"x": 1, "y": 0}, "name": "hbm_south", "soc_type": "memory", "start_addr": int("0x000180000000",16), "end_addr": int("0x000200000000",16)},
	{"idx": {"x": 2, "y": 0}, "name": "hbm_south", "soc_type": "memory", "start_addr": int("0x000200000000",16), "end_addr": int("0x000280000000",16)},
	{"idx": {"x": 0, "y": 2}, "name": "pcie", "soc_type": "serial_link", "start_addr": int("0x010000000000",16), "end_addr": int("0x010100000000",16)},
	{"idx": {"x": 3, "y": 1}, "name": "bootrom", "soc_type": "memory", "start_addr": int("0x000000000000",16), "end_addr": int("0x000001000000",16)},
	{"idx": {"x": 3, "y": 2}, "name": "peripherals", "soc_type": "peripheral", "start_addr": int("0x000001000000",16), "end_addr": int("0x000002000000",16)}
]


