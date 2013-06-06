//===-- ARCompactMCTargetDesc.cpp - Cpu0 Target Descriptions --------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file provides ARCompact specific target descriptions.
//
//===----------------------------------------------------------------------===//

#include "ARCompactMCTargetDesc.h"
#include "llvm/MC/MachineLocation.h"
#include "llvm/MC/MCCodeGenInfo.h"
#include "llvm/MC/MCInstrInfo.h"
#include "llvm/MC/MCRegisterInfo.h"
#include "llvm/MC/MCStreamer.h"
#include "llvm/MC/MCSubtargetInfo.h"
#include "llvm/Support/ErrorHandling.h"
#include "llvm/Support/TargetRegistry.h"

#define GET_INSTRINFO_MC_DESC
#include "ARCompactGenInstrInfo.inc"

// Because we don't define any features, this include would bring in an empty
// array and cause the compile to fail.
//#define GET_SUBTARGETINFO_MC_DESC
//#include "ARCompactGenSubtargetInfo.inc"

#define GET_REGINFO_MC_DESC
#include "ARCompactGenRegisterInfo.inc"

using namespace llvm;


extern "C" void LLVMInitializeARCompactTargetMC() {
}
