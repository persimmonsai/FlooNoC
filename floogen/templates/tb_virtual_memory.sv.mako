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
tb_memory_axi #(
    .AxiAddrWidth  (${snake_to_camel(wide_type)}AddrWidth),
    .AxiDataWidth  (${snake_to_camel(wide_type)}DataWidth),
    .AxiUserWidth  (${snake_to_camel(wide_type)}UserWidth),
    .AxiIdWidth    (${snake_to_camel(wide_type)}IdWidth),
    .req_t  (${wide_type}_req_t),
    .rsp_t  (${wide_type}_rsp_t)
) i_wide_${ep.name}_memory${wide_sv_array} (
    .clk_i    (clk_i),
    .rst_ni   (rst_ni),
    .req_i(${wide_name}_req),
    .rsp_o(${wide_name}_rsp)
);
% endif
% if narrow_sv_array is not None:
tb_memory_axi #(
    .AxiAddrWidth  (${snake_to_camel(narrow_type)}AddrWidth),
    .AxiDataWidth  (${snake_to_camel(narrow_type)}DataWidth),
    .AxiUserWidth  (${snake_to_camel(narrow_type)}UserWidth),
    .AxiIdWidth    (${snake_to_camel(narrow_type)}IdWidth),
    .req_t  (${narrow_type}_req_t),
    .rsp_t  (${narrow_type}_rsp_t)
) i_narrow_${ep.name}_memory${narrow_sv_array} (
    .clk_i    (clk_i),
    .rst_ni   (rst_ni),
    .req_i(${narrow_name}_req),
    .rsp_o(${narrow_name}_rsp)
);
% endif