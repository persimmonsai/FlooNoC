<%
from floogen.utils import snake_to_camel
narrow_sv_array = None
wide_sv_array = None
for port in ep.sbr_ports:
    if port.name == "narrow":
        narrow_sv_array = port._array_to_sv_array()
        narrow_type = port._type_name()
        narrow_name = port.base_name
    else:
        wide_sv_array = port._array_to_sv_array()
        wide_type = port._type_name()
        wide_name = port.base_name
%>\
% for port in ep.sbr_ports:
${port.req_type()} ${port._array_to_sv_array()} ${port.base_name}_req;
${port.rsp_type()} ${port._array_to_sv_array()} ${port.base_name}_rsp;
% endfor

% if wide_sv_array is not None:
floo_hbm_model #(
    .TA         (ApplTime),
    .TT         (TestTime),
    .Latency    (HBMLatency),
    .NumChannels(1),
    .AddrWidth  (${snake_to_camel(wide_type)}AddrWidth),
    .DataWidth  (${snake_to_camel(wide_type)}DataWidth),
    .UserWidth  (${snake_to_camel(wide_type)}UserWidth),
    .IdWidth    (${snake_to_camel(wide_type)}IdWidth),
    .axi_req_t  (${wide_type}_req_t),
    .axi_rsp_t  (${wide_type}_rsp_t),
    .aw_chan_t  (${wide_type}_aw_chan_t),
    .w_chan_t   (${wide_type}_w_chan_t),
    .b_chan_t   (${wide_type}_b_chan_t),
    .ar_chan_t  (${wide_type}_ar_chan_t),
    .r_chan_t   (${wide_type}_r_chan_t)
) i_floo_wide_${ep.name}_model${wide_sv_array} (
    .clk_i    (clk),
    .rst_ni   (rst_n),
    .hbm_req_i(${wide_name}_req),
    .hbm_rsp_o(${wide_name}_rsp)
);
% endif
% if narrow_sv_array is not None:
floo_hbm_model #(
    .TA         (ApplTime),
    .TT         (TestTime),
    .Latency    (HBMLatency),
    .NumChannels(1),
    .AddrWidth  (${snake_to_camel(narrow_type)}AddrWidth),
    .DataWidth  (${snake_to_camel(narrow_type)}DataWidth),
    .UserWidth  (${snake_to_camel(narrow_type)}UserWidth),
    .IdWidth    (${snake_to_camel(narrow_type)}IdWidth),
    .axi_req_t  (${narrow_type}_req_t),
    .axi_rsp_t  (${narrow_type}_rsp_t),
    .aw_chan_t  (${narrow_type}_aw_chan_t),
    .w_chan_t   (${narrow_type}_w_chan_t),
    .b_chan_t   (${narrow_type}_b_chan_t),
    .ar_chan_t  (${narrow_type}_ar_chan_t),
    .r_chan_t   (${narrow_type}_r_chan_t)
) i_floo_narrow_${ep.name}_model${narrow_sv_array} (
    .clk_i    (clk),
    .rst_ni   (rst_n),
    .hbm_req_i(${narrow_name}_req),
    .hbm_rsp_o(${narrow_name}_rsp)
);
% endif