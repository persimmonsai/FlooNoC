## Parameter configuration from yml file and floogen framework
FlooNoC use static logic routing implementation that create from .yml and floogen framework.
Changing parameter such as address of each AXI4 endpoint MUST RE-GENERATE FlooNoC warpper from floogen.

# Goto FlooNoC dir
cd FlooNoC

# narrow_wide_pkg.yml and axi_pkg.yml use for generating package only, so [--only-pkg] need to used
mkdir -p generated/axi_pkg
floogen -c floogen/examples/narrow_wide_pkg.yml --pkg-outdir generated/axi_pkg --only-pkg
floogen -c floogen/examples/axi_pkg.yml --pkg-outdir generated/axi_pkg --only-pkg

## Generate package with FlooNoC interconnect source code
# Compute tile arrray (XY base rounting with ID table)
# The result is two file. 'hw/floo_narrow_wide_pkg.sv' and 'hw/compute_tile_array_floo_noc.sv'
floogen -c floogen/examples/compute_tile_array.yml --outdir hw --pkg-outdir hw --visualize





# Optional command to generate reference result for understanding purpose
# Occamy mesh (XY base rounting with ID table)
mkdir -p generated/occamy_mesh/pkg
mkdir -p generated/occamy_mesh/src
floogen -c floogen/examples/occamy_mesh.yml --outdir generated/occamy_mesh/src --pkg-outdir generated/occamy_mesh/pkg
# Occamy tree (ID base rounting with ID table)
mkdir -p generated/occamy_tree/pkg
mkdir -p generated/occamy_tree/src
floogen -c floogen/examples/occamy_tree.yml --outdir generated/occamy_tree/src --pkg-outdir generated/occamy_tree/pkg
# Single cluster (ID base rounting with ID table)
mkdir -p generated/single_cluster/pkg
mkdir -p generated/single_cluster/src
floogen -c floogen/examples/single_cluster.yml --outdir generated/single_cluster/src --pkg-outdir generated/single_cluster/pkg
