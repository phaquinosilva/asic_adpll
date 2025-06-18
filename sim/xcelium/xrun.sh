#!/bin/bash

module purge
module load xcelium 

export CURRENT_PATH=$(dirname $(dirname $(dirname -- $(readlink -fn -- "$0"))))
export LIB_HOME="${HOME}/work/tsmc65lp_workspace/tcbn65lpbwp7tlvt_220a_FE/TSMCHOME/digital/Front_End/verilog/tcbn65lpbwp7tlvt_141a/tcbn65lpbwp7tlvt.v"

echo "THIS: $(dirname -- $(readlink -fn -- "$0"))"
echo "PARENT: $CURRENT_PATH"

if [ "$1" == "annot" ]; then
  xrun -smartorder -lwdgen -sdf_cmd_file ${CURRENT_PATH}/scripts/sdf.cmd ${LIB_HOME} \
    -linedebu -access +rwc -f file_list_annotated.f -gui

else 
  xrun -lwdgen -linedebu -access rwc -f file_list.f -gui
fi


