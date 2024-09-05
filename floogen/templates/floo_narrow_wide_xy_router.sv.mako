<% def camelcase(s):
     return ''.join(x.capitalize() or '_' for x in s.split('_'))
%>\
<% req_type = next(d for d in router.incoming._asdict().values() if d is not None).req_type %>\
<% rsp_type = next(d for d in router.incoming._asdict().values() if d is not None).rsp_type %>\
<% wide_type = next(d for d in router.incoming._asdict().values() if d is not None).wide_type %>\
<% actual_xy_id = router.id - id_offset %>\
<% router_id = router.name + "_id" %>\

${req_type} [NumDirections-1:0] ${router.name}_req_in;
${rsp_type} [NumDirections-1:0] ${router.name}_rsp_out;
${req_type} [NumDirections-1:0] ${router.name}_req_out;
${rsp_type} [NumDirections-1:0] ${router.name}_rsp_in;
${wide_type} [NumDirections-1:0] ${router.name}_wide_in;
${wide_type} [NumDirections-1:0] ${router.name}_wide_out;

% for dir, link in router.incoming._asdict().items():
  % if link is not None:
    % if link.export_ni:
  assign ${router.name}_req_in[${camelcase(dir)}] = ${"{}_floo_req_i{}".format(link.source_name,link.source_idx)};
    % else:
  assign ${router.name}_req_in[${camelcase(dir)}] = ${link.req_name()};
    % endif
  % else:
  assign ${router.name}_req_in[${camelcase(dir)}] = '0;
  % endif
% endfor

% for dir, link in router.incoming._asdict().items():
  % if link is not None:
    % if link.export_ni:
  assign ${"{}_floo_rsp_o{}".format(link.source_name,link.source_idx)} = ${router.name}_rsp_out[${camelcase(dir)}];
    % else:
  assign ${link.rsp_name()} = ${router.name}_rsp_out[${camelcase(dir)}];
    % endif
  % endif
% endfor

% for dir, link in router.outgoing._asdict().items():
  % if link is not None:
    % if link.export_ni:
  assign ${"{}_floo_req_o{}".format(link.dest_name,link.dest_idx)} = ${router.name}_req_out[${camelcase(dir)}];
    % else:
  assign ${link.req_name()} = ${router.name}_req_out[${camelcase(dir)}];
    % endif
  % endif
% endfor

% for dir, link in router.outgoing._asdict().items():
  % if link is not None:
    % if link.export_ni:
  assign ${router.name}_rsp_in[${camelcase(dir)}] = ${"{}_floo_rsp_i{}".format(link.dest_name,link.dest_idx)};
    % else:
  assign ${router.name}_rsp_in[${camelcase(dir)}] = ${link.rsp_name()};
    % endif
  % else:
  assign ${router.name}_rsp_in[${camelcase(dir)}] = '0;
  % endif
% endfor

% for dir, link in router.incoming._asdict().items():
  % if link is not None:
    % if link.export_ni:
  assign ${router.name}_wide_in[${camelcase(dir)}] = ${"{}_floo_wide_i{}".format(link.source_name,link.source_idx)};
    % else:
  assign ${router.name}_wide_in[${camelcase(dir)}] = ${link.wide_name()};
    % endif
  % else:
  assign ${router.name}_wide_in[${camelcase(dir)}] = '0;
  % endif
% endfor

% for dir, link in router.outgoing._asdict().items():
  % if link is not None:
    % if link.export_ni:
  assign ${"{}_floo_wide_o{}".format(link.dest_name,link.dest_idx)} = ${router.name}_wide_out[${camelcase(dir)}];
    % else:
  assign ${link.wide_name()} = ${router.name}_wide_out[${camelcase(dir)}];
    % endif
  % endif
% endfor

localparam id_t ${router_id} = ${actual_xy_id.render()};
floo_narrow_wide_router #(
  .NumRoutes (NumDirections),
  .ChannelFifoDepth (2),
  .OutputFifoDepth (2),
  .RouteAlgo (XYRouting),
  .XYRouteOpt(XYRouteOpt),
  .id_t(id_t),
  .border_id_t(floo_narrow_wide_pkg::border_id_t),
  .BorderId(floo_narrow_wide_pkg::BorderId)
) ${router.name} (
  .clk_i,
  .rst_ni,
  .test_enable_i,
  .id_i (${router_id}),
  .id_route_map_i ('0),
  .floo_req_i (${router.name}_req_in),
  .floo_rsp_o (${router.name}_rsp_out),
  .floo_req_o (${router.name}_req_out),
  .floo_rsp_i (${router.name}_rsp_in),
  .floo_wide_i (${router.name}_wide_in),
  .floo_wide_o (${router.name}_wide_out)
);
