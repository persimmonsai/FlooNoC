<% def camelcase(s):
     return ''.join(x.capitalize() or '_' for x in s.split('_'))
%>\
<% req_type = next(d for d in router.incoming._asdict().values() if d is not None).req_type %>\
<% rsp_type = next(d for d in router.incoming._asdict().values() if d is not None).rsp_type %>\
<% wide_type = next(d for d in router.incoming._asdict().values() if d is not None).wide_type %>\
<% compute_tile_name = "compute_tile_" + str(router.id.x) + "_" + str(router.id.y) %>\
<% compute_tile_id = compute_tile_name + "_id" %>\
<% actual_xy_id = router.id - id_offset %>\

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
  .clk_i,
  .rst_ni,
  .test_enable_i,
  .msip_i (msip_i),
  .id_i (${compute_tile_id}),
  .floo_req_i (${router.name}_req_in),
  .floo_rsp_o (${router.name}_rsp_out),
  .floo_req_o (${router.name}_req_out),
  .floo_rsp_i (${router.name}_rsp_in),
  .floo_wide_i (${router.name}_wide_in),
  .floo_wide_o (${router.name}_wide_out)
);
