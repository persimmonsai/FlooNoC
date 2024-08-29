<% def camelcase(s):
     return ''.join(x.capitalize() or '_' for x in s.split('_'))
%>\
<%
  import math
%>\
<% req_type = next(d for d in router.incoming._asdict().values() if d is not None).req_type %>\
<% rsp_type = next(d for d in router.incoming._asdict().values() if d is not None).rsp_type %>\
<% wide_type = next(d for d in router.incoming._asdict().values() if d is not None).wide_type %>\
<% hbm_name_xy = router.outgoing.EJECT.dest_name + str(router.id.x) + "_" + str(router.id.y) %>\
<% hbm_tile_id = hbm_name_xy + "_id" %>\
<% actual_xy_id = router.id - id_offset %>\

${req_type} [West:North] ${router.name}_req_in;
${rsp_type} [West:North] ${router.name}_rsp_out;
${req_type} [West:North] ${router.name}_req_out;
${rsp_type} [West:North] ${router.name}_rsp_in;
${wide_type} [West:North] ${router.name}_wide_in;
${wide_type} [West:North] ${router.name}_wide_out;

% for dir, link in router.incoming._asdict().items():
  % if dir != 'EJECT':
    % if link.export_ni:
  assign ${router.name}_req_in[${camelcase(dir)}] = ${"'0" if link is None else "{}_floo_req_i{}".format(link.source_name,link.source_idx)};
    % else:
  assign ${router.name}_req_in[${camelcase(dir)}] = ${"'0" if link is None else link.req_name()};
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
    % if link.export_ni:
  assign ${router.name}_rsp_in[${camelcase(dir)}] = ${"'0" if link is None else "{}_floo_rsp_i{}".format(link.dest_name,link.dest_idx)};
    % else:
  assign ${router.name}_rsp_in[${camelcase(dir)}] = ${"'0" if link is None else link.rsp_name()};
    % endif
  % endif
% endfor

% for dir, link in router.incoming._asdict().items():
  % if dir != 'EJECT':
    % if link.export_ni:
  assign ${router.name}_wide_in[${camelcase(dir)}] = ${"'0" if link is None else "{}_floo_wide_i{}".format(link.source_name,link.source_idx)};
    % else:
  assign ${router.name}_wide_in[${camelcase(dir)}] = ${"'0" if link is None else link.wide_name()};
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

localparam id_t ${hbm_tile_id} = ${actual_xy_id.render()};
  hbm_tile i_${hbm_name_xy}_tile (
  .clk_i (clk_i),
  .rst_ni (rst_ni),
  .test_enable_i (test_enable_i),
  .id_i (${hbm_tile_id}),
  // hbm interface
  .clk_hbmphy_i (${hbm_name_xy}_clk_hbmphy_i),
  .pll_lock_hbmphy_i (${hbm_name_xy}_pll_lock_hbmphy_i),,
  .clk_hbmcfg_i (clk_hbmcfg_i),
  .rst_hbmcfg_ni (rst_hbmcfg_ni),
  .XbarAddrMap (${hbm_name_xy}_XbarAddrMap),
  .Xdram_CK (${hbm_name_xy}_Xdram_CK),
  .Xdram_CKB (${hbm_name_xy}_Xdram_CKB),
  .Xdram_APAR (${hbm_name_xy}_Xdram_APAR),
  .Xdram_ARFU (${hbm_name_xy}_Xdram_ARFU),
  .Xdram_AERR (${hbm_name_xy}_Xdram_AERR),
  .Xdram_RA (${hbm_name_xy}_Xdram_RA),
  .Xdram_CA (${hbm_name_xy}_Xdram_CA),
  .Xdram_RRC (${hbm_name_xy}_Xdram_RRC),
  .Xdram_DQ (${hbm_name_xy}_Xdram_DQ),
  .Xdram_ECC (${hbm_name_xy}_Xdram_ECC),
  .Xdram_SEV (${hbm_name_xy}_Xdram_SEV),
  .Xdram_DBI (${hbm_name_xy}_Xdram_DBI),
  .Xdram_DPAR (${hbm_name_xy}_Xdram_DPAR),
  .Xdram_DERR (${hbm_name_xy}_Xdram_DERR),
  .Xdram_RDQSP (${hbm_name_xy}_Xdram_RDQSP),
  .Xdram_RDQSN (${hbm_name_xy}_Xdram_RDQSN),
  .Xdram_WDQSP (${hbm_name_xy}_Xdram_WDQSP),
  .Xdram_WDQSN (${hbm_name_xy}_Xdram_WDQSN),
  .Xdram_RD (${hbm_name_xy}_Xdram_RD),
  .floo_req_i (${hbm_name_xy}_req_in),
  .floo_rsp_o (${hbm_name_xy}_rsp_out),
  .floo_req_o (${hbm_name_xy}_req_out),
  .floo_rsp_i (${hbm_name_xy}_rsp_in),
  .floo_wide_i (${hbm_name_xy}_wide_in),
  .floo_wide_o (${hbm_name_xy}_wide_out)
);
