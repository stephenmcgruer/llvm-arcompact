# CMakeLists.txt
# All tablegen files are included by ARCompact.td.
set(LLVM_TARGET_DEFINITIONS ARCompact.td)

# Generate tablegen.
tablegen(LLVM ARCompactGenRegisterInfo.inc -gen-register-info)
tablegen(LLVM ARCompactGenInstrInfo.inc -gen-instr-info)
tablegen(LLVM ARCompactGenSubtargetInfo.inc -gen-subtarget)

# ARCompactCommonTableGen must be defined
add_public_tablegen_target(ARCompactCommonTableGen)

# ARCompactCodeGen should match with LLVMBuild.txt ARCompactCodeGen
add_llvm_target(ARCompactCodeGen
  ARCompactTargetMachine.cpp
)

# Should match with "subdirectories =  MCTargetDesc TargetInfo" in LLVMBuild.txt
add_subdirectory(TargetInfo)
add_subdirectory(MCTargetDesc)
