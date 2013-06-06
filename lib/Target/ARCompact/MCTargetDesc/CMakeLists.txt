# MCTargetDesc/CMakeLists.txt
add_llvm_library(LLVMARCompactDesc
  ARCompactMCTargetDesc.cpp
)

add_dependencies(LLVMARCompactDesc ARCompactCommonTableGen)
