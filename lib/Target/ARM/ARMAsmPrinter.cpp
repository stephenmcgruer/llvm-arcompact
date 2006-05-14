//===-- ARMAsmPrinter.cpp - ARM LLVM assembly writer ----------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file was developed by the "Instituto Nokia de Tecnologia" and
// is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file contains a printer that converts from our internal representation
// of machine-dependent LLVM code to GAS-format ARM assembly language.
//
//===----------------------------------------------------------------------===//

#include "ARM.h"
#include "ARMInstrInfo.h"
#include "llvm/Constants.h"
#include "llvm/DerivedTypes.h"
#include "llvm/Module.h"
#include "llvm/Assembly/Writer.h"
#include "llvm/CodeGen/AsmPrinter.h"
#include "llvm/CodeGen/MachineFunctionPass.h"
#include "llvm/CodeGen/MachineConstantPool.h"
#include "llvm/CodeGen/MachineInstr.h"
#include "llvm/Target/TargetMachine.h"
#include "llvm/Support/Mangler.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/ADT/StringExtras.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/MathExtras.h"
#include <cctype>
#include <iostream>
using namespace llvm;

namespace {
  Statistic<> EmittedInsts("asm-printer", "Number of machine instrs printed");

  struct ARMAsmPrinter : public AsmPrinter {
    ARMAsmPrinter(std::ostream &O, TargetMachine &TM) : AsmPrinter(O, TM) {
      Data16bitsDirective = "\t.half\t";
      Data32bitsDirective = "\t.word\t";
      Data64bitsDirective = 0;
      ZeroDirective = "\t.skip\t";
      CommentString = "!";
      ConstantPoolSection = "\t.section \".rodata\",#alloc\n";
    }

    /// We name each basic block in a Function with a unique number, so
    /// that we can consistently refer to them later. This is cleared
    /// at the beginning of each call to runOnMachineFunction().
    ///
    typedef std::map<const Value *, unsigned> ValueMapTy;
    ValueMapTy NumberForBB;

    virtual const char *getPassName() const {
      return "ARM Assembly Printer";
    }

    void printOperand(const MachineInstr *MI, int opNum);
    void printMemOperand(const MachineInstr *MI, int opNum,
                         const char *Modifier = 0);
    void printCCOperand(const MachineInstr *MI, int opNum);

    bool printInstruction(const MachineInstr *MI);  // autogenerated.
    bool runOnMachineFunction(MachineFunction &F);
    bool doInitialization(Module &M);
    bool doFinalization(Module &M);
  };
} // end of anonymous namespace

#include "ARMGenAsmWriter.inc"

/// createARMCodePrinterPass - Returns a pass that prints the ARM
/// assembly code for a MachineFunction to the given output stream,
/// using the given target machine description.  This should work
/// regardless of whether the function is in SSA form.
///
FunctionPass *llvm::createARMCodePrinterPass(std::ostream &o,
                                               TargetMachine &tm) {
  return new ARMAsmPrinter(o, tm);
}

/// runOnMachineFunction - This uses the printMachineInstruction()
/// method to print assembly for each instruction.
///
bool ARMAsmPrinter::runOnMachineFunction(MachineFunction &MF) {
  assert(0 && "not implemented");
  // We didn't modify anything.
  return false;
}

void ARMAsmPrinter::printOperand(const MachineInstr *MI, int opNum) {
  assert(0 && "not implemented");
}

void ARMAsmPrinter::printMemOperand(const MachineInstr *MI, int opNum,
                                      const char *Modifier) {
  assert(0 && "not implemented");
}

void ARMAsmPrinter::printCCOperand(const MachineInstr *MI, int opNum) {
  assert(0 && "not implemented");
}

bool ARMAsmPrinter::doInitialization(Module &M) {
  Mang = new Mangler(M);
  return false; // success
}

bool ARMAsmPrinter::doFinalization(Module &M) {
  assert(0 && "not implemented");
  AsmPrinter::doFinalization(M);
  return false; // success
}
