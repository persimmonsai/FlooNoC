<%
from floogen.utils import snake_to_camel
is_sbr_narrow = False
is_sbr_wide = False
is_mgr_narrow = False
is_mgr_wide = False
for port in ep.sbr_ports:
    if port.name == "narrow":
        narrow_name = port.base_name
        is_sbr_narrow = True
    else:
        wide_name = port.base_name
        is_sbr_wide = True
for port in ep.mgr_ports:
    if port.name == "narrow":
        narrow_name = port.base_name
        is_mgr_narrow = True
    else:
        wide_name = port.base_name
        is_mgr_wide = True
%>\
% for port in ep.sbr_ports:
${port.req_type()} ${port._array_to_sv_array()} ${port.base_name}_out_req;
${port.rsp_type()} ${port._array_to_sv_array()} ${port.base_name}_out_rsp;
% endfor
% for port in ep.mgr_ports:
${port.req_type()} ${port._array_to_sv_array()} ${port.base_name}_in_req;
${port.rsp_type()} ${port._array_to_sv_array()} ${port.base_name}_in_rsp;
% endfor

% if is_sbr_wide or is_mgr_wide:
dma_test_node #(
    .id_x          (${endpoint_id.x}),
    .id_y          (${endpoint_id.y}),
    .is_narrow     (1'b0),
    .axi_out_req_t (axi_wide_out_req_t),
    .axi_out_rsp_t (axi_wide_out_rsp_t),
    .axi_in_req_t  (axi_wide_in_req_t),
    .axi_in_rsp_t  (axi_wide_in_rsp_t),
    .AxiAddrWidth  (AxiWideOutAddrWidth),
    .AxiDataWidth  (AxiWideOutDataWidth),
    .AxiUserWidth  (AxiWideOutUserWidth),
    .AxiOutIdWidth (AxiWideOutIdWidth),
    .AxiInIdWidth  (AxiWideInIdWidth),
    .MaxTxnsPerId  (WideMaxTxnsPerId)
) i_floo_wide_${ep.name}_model (
    .clk_i    (clk),
    .rst_ni   (rst_n),
% if is_sbr_wide:
    .axi_in_req_i(${wide_name}_out_req),
    .axi_in_resp_o(${wide_name}_out_rsp),
% else:
    .axi_in_req_i('0),
    .axi_in_resp_o(),
% endif
% if is_mgr_wide:
    .axi_out_req_o(${wide_name}_in_req),
    .axi_out_resp_i(${wide_name}_in_rsp)
% else:
    .axi_out_req_o(),
    .axi_out_resp_i('0)
% endif
);
% endif
% if is_sbr_narrow or is_mgr_narrow:
dma_test_node #(
    .id_x          (${endpoint_id.x}),
    .id_y          (${endpoint_id.y}),
    .is_narrow     (1'b1),
    .axi_out_req_t (axi_narrow_out_req_t),
    .axi_out_rsp_t (axi_narrow_out_rsp_t),
    .axi_in_req_t  (axi_narrow_in_req_t),
    .axi_in_rsp_t  (axi_narrow_in_rsp_t),
    .AxiAddrWidth  (AxiNarrowOutAddrWidth),
    .AxiDataWidth  (AxiNarrowOutDataWidth),
    .AxiUserWidth  (AxiNarrowOutUserWidth),
    .AxiOutIdWidth (AxiNarrowOutIdWidth),
    .AxiInIdWidth  (AxiNarrowInIdWidth),
    .MaxTxnsPerId  (NarrowMaxTxnsPerId)
) i_floo_narrow_${ep.name}_model (
    .clk_i    (clk),
    .rst_ni   (rst_n),
% if is_sbr_narrow:
    .axi_in_req_i(${narrow_name}_out_req),
    .axi_in_resp_o(${narrow_name}_out_rsp),
% else:
    .axi_in_req_i('0),
    .axi_in_resp_o(),
% endif
% if is_mgr_narrow:
    .axi_out_req_o(${narrow_name}_in_req),
    .axi_out_resp_i(${narrow_name}_in_rsp)
% else:
    .axi_out_req_o(),
    .axi_out_resp_i('0)
% endif
);
% endif