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
<% sv_array_irq = "[{}:{}]".format((tile_id+1)*num_snitch_core, tile_id*num_snitch_core+1) %>\

${req_type} [West:North] ${router.name}_req_in;
${rsp_type} [West:North] ${router.name}_rsp_out;
${req_type} [West:North] ${router.name}_req_out;
${rsp_type} [West:North] ${router.name}_rsp_in;
${wide_type} [West:North] ${router.name}_wide_in;
${wide_type} [West:North] ${router.name}_wide_out;

% for dir, link in router.incoming._asdict().items():
  % if dir != 'EJECT':
    % if link is not None:
      % if link.export_ni:
  assign ${router.name}_req_in[${camelcase(dir)}] = ${"{}_floo_req_i{}".format(link.source_name,link.source_idx)};
      % else:
  assign ${router.name}_req_in[${camelcase(dir)}] = ${link.req_name()};
      % endif
    % else:
  assign ${router.name}_req_in[${camelcase(dir)}] = '0;
    % endif
  % endif
% endfor

% for dir, link in router.incoming._asdict().items():
  % if (link is not None) and (dir != 'EJECT'):
    % if link.export_ni:
  assign ${"{}_floo_rsp_o{}".format(link.source_name,link.source_idx)} = ${router.name}_rsp_out[${camelcase(dir)}];
    % else:
  assign ${link.rsp_name()} = ${router.name}_rsp_out[${camelcase(dir)}];
    % endif
  % endif
% endfor

% for dir, link in router.outgoing._asdict().items():
  % if (link is not None) and (dir != 'EJECT'):
    % if link.export_ni:
  assign ${"{}_floo_req_o{}".format(link.dest_name,link.dest_idx)} = ${router.name}_req_out[${camelcase(dir)}];
    % else:
  assign ${link.req_name()} = ${router.name}_req_out[${camelcase(dir)}];
    % endif
  % endif
% endfor

% for dir, link in router.outgoing._asdict().items():
  % if dir != 'EJECT':
    % if link is not None:
      % if link.export_ni:
  assign ${router.name}_rsp_in[${camelcase(dir)}] = ${"{}_floo_rsp_i{}".format(link.dest_name,link.dest_idx)};
      % else:
  assign ${router.name}_rsp_in[${camelcase(dir)}] = ${link.rsp_name()};
      % endif
    % else:
  assign ${router.name}_rsp_in[${camelcase(dir)}] = '0;
    % endif
  % endif
% endfor

% for dir, link in router.incoming._asdict().items():
  % if dir != 'EJECT':
    % if link is not None:
      % if link.export_ni:
  assign ${router.name}_wide_in[${camelcase(dir)}] = ${"{}_floo_wide_i{}".format(link.source_name,link.source_idx)};
      % else:
  assign ${router.name}_wide_in[${camelcase(dir)}] = ${link.wide_name()};
      % endif
    % else:
  assign ${router.name}_wide_in[${camelcase(dir)}] = '0;
    % endif
  % endif
% endfor

% for dir, link in router.outgoing._asdict().items():
  % if (link is not None) and (dir != 'EJECT'):
    % if link.export_ni:
  assign ${"{}_floo_wide_o{}".format(link.dest_name,link.dest_idx)} = ${router.name}_wide_out[${camelcase(dir)}];
    % else:
  assign ${link.wide_name()} = ${router.name}_wide_out[${camelcase(dir)}];
    % endif
  % endif
% endfor

% for dir in ["north","east","south","west"]:
  floo_vec_req_t  ${router.name}_${dir}_req_in;
  floo_vec_rsp_t  ${router.name}_${dir}_rsp_out;
  floo_vec_req_t  ${router.name}_${dir}_req_out;
  floo_vec_rsp_t  ${router.name}_${dir}_rsp_in;
  floo_vec_wide_t ${router.name}_${dir}_wide_in;
  floo_vec_wide_t ${router.name}_${dir}_wide_out;
  assign ${router.name}_req_out[${camelcase(dir)}] = ${router.name}_${dir}_req_out;
  assign ${router.name}_rsp_out[${camelcase(dir)}] = ${router.name}_${dir}_rsp_out;
  assign ${router.name}_wide_out[${camelcase(dir)}] = ${router.name}_${dir}_wide_out;
  assign ${router.name}_${dir}_req_in = ${router.name}_req_in[${camelcase(dir)}];
  assign ${router.name}_${dir}_rsp_in = ${router.name}_rsp_in[${camelcase(dir)}];
  assign ${router.name}_${dir}_wide_in = ${router.name}_wide_in[${camelcase(dir)}];
% endfor

localparam id_t ${compute_tile_id} = ${actual_xy_id.render()};
% if (router.id.x==0 and router.id.y==0):
`ifdef TARGET_COMPUTE_TILE_0_0_NETLIST
  compute_tile_netlist
`else
  compute_tile 
`ifdef TARGET_DMA_TEST
#(
  .id_x(${actual_xy_id.x}),
  .id_y(${actual_xy_id.y})
) 
`endif
`endif
% else:
  compute_tile 
`ifdef TARGET_DMA_TEST
#(
  .id_x(${actual_xy_id.x}),
  .id_y(${actual_xy_id.y})
) 
`endif
% endif:
 ${compute_tile_name} (
  .clk_i (clk_i),
  .rst_ni (rst_ni),
  .test_enable_i (test_enable_i),
  .tile_id_i (${tile_id_bit_num}'d${tile_id}),
  .meip_i (${num_snitch_core}'b0),
  .mtip_i (mtip_i${sv_array_irq}),
  .msip_i (msip_i${sv_array_irq}),
  .id_i (${compute_tile_id}),
% for dir in ["north","east","south","west"]:
  .floo_${dir}_req_i (${router.name}_${dir}_req_in),
  .floo_${dir}_rsp_o (${router.name}_${dir}_rsp_out),
  .floo_${dir}_req_o (${router.name}_${dir}_req_out),
  .floo_${dir}_rsp_i (${router.name}_${dir}_rsp_in),
  .floo_${dir}_wide_i (${router.name}_${dir}_wide_in),
% if dir!="west":
  .floo_${dir}_wide_o (${router.name}_${dir}_wide_out),
% else:
  .floo_${dir}_wide_o (${router.name}_${dir}_wide_out)
% endif
% endfor
);
