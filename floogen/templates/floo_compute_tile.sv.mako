<% def camelcase(s):
     return ''.join(x.capitalize() or '_' for x in s.split('_'))
%>\
<%
  import math
%>\
<% req_type = next(d for d in router.incoming._asdict().values() if d is not None).req_type %>\
<% rsp_type = next(d for d in router.incoming._asdict().values() if d is not None).rsp_type %>\
<% wide_type = next(d for d in router.incoming._asdict().values() if d is not None).wide_type %>\
<% compute_tile_name = "compute_tile_" + str(router.id.x) + "_" + str(router.id.y) %>\
<% compute_tile_id = compute_tile_name + "_id" %>\
<% actual_xy_id = router.id - id_offset %>\
<% NUM_X = xy_array[0] %>\
<% NUM_Y = xy_array[1] %>\
<% tile_id = router.id.y*NUM_X + router.id.x %>\
<% tile_id_bit_num = int(math.ceil(math.log2(NUM_X*NUM_Y))) %>\
<% sv_array_irq = "[{}:{}]".format((tile_id+1)*num_snitch_core, tile_id*num_snitch_core+1) %>\

${req_type} [West:North] ${router.name}_req_in;
${rsp_type} [West:North] ${router.name}_rsp_out;
${req_type} [West:North] ${router.name}_req_out;
${rsp_type} [West:North] ${router.name}_rsp_in;
${wide_type} [West:North] ${router.name}_wide_in;
${wide_type} [West:North] ${router.name}_wide_out;

% for dir, link in router.incoming._asdict().items():
  % if dir != 'EJECT':
  assign ${router.name}_req_in[${camelcase(dir)}] = ${"'0" if link is None else link.req_name()};
  % endif
% endfor

% for dir, link in router.incoming._asdict().items():
  % if (link is not None) and (dir != 'EJECT'):
  assign ${link.rsp_name()} = ${router.name}_rsp_out[${camelcase(dir)}];
  % endif
% endfor

% for dir, link in router.outgoing._asdict().items():
  % if (link is not None) and (dir != 'EJECT'):
  assign ${link.req_name()} = ${router.name}_req_out[${camelcase(dir)}];
  % endif
% endfor

% for dir, link in router.outgoing._asdict().items():
  % if dir != 'EJECT':
  assign ${router.name}_rsp_in[${camelcase(dir)}] = ${"'0" if link is None else link.rsp_name()};
  % endif
% endfor

% for dir, link in router.incoming._asdict().items():
  % if dir != 'EJECT':
  assign ${router.name}_wide_in[${camelcase(dir)}] = ${"'0" if link is None else link.wide_name()};
  % endif
% endfor

% for dir, link in router.outgoing._asdict().items():
  % if (link is not None) and (dir != 'EJECT'):
  assign ${link.wide_name()} = ${router.name}_wide_out[${camelcase(dir)}];
  % endif
% endfor

localparam id_t ${compute_tile_id} = ${actual_xy_id.render()};
  compute_tile 
`ifdef DMA_TESTNODE
#(
  .id_x(${actual_xy_id.x}),
  .id_y(${actual_xy_id.y})
) 
`endif
 ${compute_tile_name} (
  .clk_i (clk_i),
  .rst_ni (rst_ni),
  .test_enable_i (test_mode_i),
  .tile_id_i (${tile_id_bit_num}'d${tile_id}),
  .meip_i (${num_snitch_core}'b0),
  .mtip_i (mtip_i${sv_array_irq}),
  .msip_i (msip_i${sv_array_irq}),
  .id_i (${compute_tile_id}),
  .floo_req_i (${router.name}_req_in),
  .floo_rsp_o (${router.name}_rsp_out),
  .floo_req_o (${router.name}_req_out),
  .floo_rsp_i (${router.name}_rsp_in),
  .floo_wide_i (${router.name}_wide_in),
  .floo_wide_o (${router.name}_wide_out),
  .sram_cfgs_i (sram_cfgs_i)
);
