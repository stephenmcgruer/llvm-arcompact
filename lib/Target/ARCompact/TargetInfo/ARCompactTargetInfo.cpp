//===-- ARCompactTargetInfo.cpp - ARCompact Target Implementation ---------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#include "ARCompact.h"
#include "llvm/IR/Module.h"
#include "llvm/Support/TargetRegistry.h"
using namespace llvm;

Target llvm::TheARCompactTarget;

extern "C" void LLVMInitializeARCompactTargetInfo() {
  RegisterTarget<Triple::arcompact, /*HasJIT=*/false>
      X(TheARCompactTarget, "arcompact", "ARCompact");
}
