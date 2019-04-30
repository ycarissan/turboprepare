#!/bin/sh

DEFAULT_ANOTHER_CONTROL=""
DEFAULT_BASIS="def2-TZVP"
DEFAULT_CHARGE=0
DEFAULT_DESY="1d-1"
DEFAULT_FUNC="b-p"
DEFAULT_GRID="m4"
DEFAULT_RI="on"
DEFAULT_RIMEM=500
DEFAULT_SCFTHRS="7"
DEFAULT_TITLE="Auto-generated input"
DEFAULT_WF="DFT"
DEFAULT_SPIN="s"
DEFAULT_UHF=0

ANOTHER_CONTROL=${DEFAULT_ANOTHER_CONTROL}
BASIS=${DEFAULT_BASIS}
CHARGE=${DEFAULT_CHARGE}
DESY=${DEFAULT_DESY}
FUNC=${DEFAULT_FUNC}
GRID=${DEFAULT_GRID}
RI=${DEFAULT_RI}
RIMEM=${DEFAULT_RIMEM}
SCFTHRS=${DEFAULT_SCFTHRS}
TITLE=${DEFAULT_TITLE}
WF=${DEFAULT_WF}
SPIN=${DEFAULT_SPIN}
UHF=${DEFAULT_UHF}

function blank() {
  echo
}

function exit_menu() {
  echo '*'
}

function another_control() {
  echo ${ANOTHER_CONTROL}
}

function title() {
  echo ${TITLE}
}

function addcoord() {
  echo "a coord"
}

function determine_symmetry() {
  echo "desy ${DESY}"
}

function generate_redundant() {
  echo "ired"
}

function assign_basis() {
  echo "b all ${BASIS}"
}

function define_guess() {
  echo "eht"
  echo "y"
  echo ${CHARGE}
  if [ $UHF -eq 0 ]; then
    echo "y"
  else
    echo "n"
    echo ${SPIN}
    exit_menu
  fi
}

function define_wf() {
  case ${WF} in
    HF) define_hf_job;;
    DFT) define_dft_job;;
    MP2) define_mp2_job;;
    CC2) define_cc2_job;;
    SCS) define_scs_job;;
    CCSD) define_ccsd_job;;
    CCSD_T_) define_ccsd_t__job;;
    *) error WF
  esac
}

function define_hf_job() {
  define_scfthrs
}

function define_scfthrs() {
  echo "scf"
  echo "conv"
  echo ${SCFTHRS}
  #blank to exit menu : * does not work
  blank
}

function define_dft_job() {
  define_scfthrs
  echo "dft"
  echo "on"
  echo func $FUNC
  echo grid $GRID
  exit_menu
  case ${RI} in
    on) define_ri;;
    off) ;;
    *) error RI
  esac
}

function define_ccsd_job() {
  define_hf_job
  printf "cc\nfreeze\n"
  exit_menu
  printf "cbas\n"
  exit_menu
  printf "ricc2\nccsd\n"
  exit_menu
  exit_menu
}

function define_ccsd_t__job() {
  define_hf_job
  printf "cc\nfreeze\n"
  exit_menu
  printf "cbas\n"
  exit_menu
  printf "ricc2\nccsd(t)\n"
  exit_menu
  exit_menu
}

function define_mp2_job() {
  define_hf_job
  printf "cc\nfreeze\n"
  exit_menu
  printf "cbas\n"
  exit_menu
  printf "ricc2\nmp2\n"
  exit_menu
  exit_menu
}

function define_cc2_job() {
  define_hf_job
  printf "cc\nfreeze\n"
  exit_menu
  printf "cbas\n"
  exit_menu
  printf "ricc2\ncc2\n"
  exit_menu
  exit_menu
}

function define_scs_job() {
  define_mp2_job
  printf "cc\nricc2\nscs\n"
  exit_menu
  exit_menu
}

function define_ri() {
  echo "ri"
  echo "on"
  echo "m ${RIMEM}"
  exit_menu
}

function error() {
  case $1 in
    RI) echo "RI $RI option unknown (on|off)";;
    WF) echo "WF $WF unknown";;
    *) echo "undetermined error"
  esac
  exit 1
}

function generate_define_in() {
  another_control
  title
  addcoord
  determine_symmetry
  generate_redundant
  exit_menu
  assign_basis
  exit_menu
  define_guess
  define_wf
  exit_menu
}

function show_parameters() {
[ "$ANOTHER_CONTROL" != "$DEFAULT_ANOTHER_CONTROL" ] && echo "[ANOTHER_CONTROL=$ANOTHER_CONTROL]"
[ "$BASIS"           != "$DEFAULT_BASIS"           ] && echo "[BASIS=$BASIS]"
[ "$CHARGE"          != "$DEFAULT_CHARGE"          ] && echo "[CHARGE=$CHARGE]"
[ "$DESY"            != "$DEFAULT_DESY"            ] && echo "[DESY=$DESY]"
[ "$FUNC"            != "$DEFAULT_FUNC"            ] && echo "[FUNC=$FUNC]"
[ "$GRID"            != "$DEFAULT_GRID"            ] && echo "[GRID=$GRID]"
[ "$RI"              != "$DEFAULT_RI"              ] && echo "[RI=$RI]"
[ "$RIMEM"           != "$DEFAULT_RIMEM"           ] && echo "[RIMEM=$RIMEM]"
[ "$SCFTHRS"         != "$DEFAULT_SCFTHRS"         ] && echo "[SCFTHRS=$SCFTHRS]"
[ "$TITLE"           != "$DEFAULT_TITLE"           ] && echo "[TITLE=$TITLE]"
[ "$WF"              != "$DEFAULT_WF"              ] && echo "[WF=$WF]"
}
