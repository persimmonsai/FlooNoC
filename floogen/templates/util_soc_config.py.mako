
<% 
for pt in noc.protocols:
  if pt.name=="narrow":
    narrow_dw = pt.data_width
  if pt.name=="wide":
    wide_dw = pt.data_width
%>\

NUM_X = ${noc.routers[0].array[0]}

data_widths = {"wide": ${wide_dw}, "narrow": ${narrow_dw}}

# New soc_type attribute to facilitate auto-testbench generation
# soc_type = {"cluster", "memory", "processor", "peripheral", "serial_link"}

${noc.routing.table.render_util(name="addr_map", aw=noc.routing.addr_width, id_offset=noc.routing.id_offset)}

