//===--- ARCompactInstrInfo.td - Target Description for ARCompact Target --===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file contains the ARCompact implementation of the TargetInstrInfo class.
//
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// Instruction format superclass
//===----------------------------------------------------------------------===//

include "ARCompactInstrFormats.td"

//===----------------------------------------------------------------------===//
// ARCompact-specific profiles and nodes
//===----------------------------------------------------------------------===//

// A return node.
def ARCompactRet : SDNode<"ARCompactISD::Ret", SDTNone,
                          [SDNPHasChain, SDNPOptInGlue]>;

//===----------------------------------------------------------------------===//
// ARCompact Operand, Complex Patterns and Transformations Definitions
//===----------------------------------------------------------------------===//

let PrintMethod = "printImmOperand" in {
  def uimm6  : Operand<i32>;
  def simm9  : Operand<i32>;
  def simm12 : Operand<i32>;
  def simm32 : Operand<i32>;
}

def uimm6Pred : PatLeaf<(i32 imm), [{
  // True if immediate fits in an unsigned 6-bit field.
  int64_t v = (int64_t) N->getSExtValue();
  return isUInt<6>(v);
}]>;
def simm9Pred : PatLeaf<(i32 imm), [{
  // True if immediate fits in a signed 9-bit field.
  int64_t v = (int64_t) N->getSExtValue();
  return isInt<9>(v);
}]>;
def simm12Pred : PatLeaf<(i32 imm), [{
  // True if immediate fits in a signed 12-bit field.
  int64_t v = (int64_t) N->getSExtValue();
  return isInt<12>(v);
}]>;
def simm32Pred : PatLeaf<(i32 imm), [{
  // True if immediate fits in a signed 32-bit field.
  int64_t v = (int64_t) N->getSExtValue();
  return isInt<32>(v);
}]>;


def MEMri : Operand<i32> {
  let PrintMethod = "printMemOperand";
  let MIOperandInfo = (ops CPURegs, simm9);
}

def ADDRri : ComplexPattern<i32, 2, "SelectADDri", [frameindex], []>;

//===----------------------------------------------------------------------===//
// Instructions specific format
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// Instruction definition
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
// ARCompact Instructions
//===----------------------------------------------------------------------===//

// ADD - Page 180.
//    Add two source operands together, and place the result in the destination
//    register.

def ADDri : Pseudo<(outs CPURegs:$dst), (ins CPURegs:$src1, uimm6:$src2),
                   "add $dst,$src1,$src2",
                   [(set CPURegs:$dst, (add CPURegs:$src1, uimm6Pred:$src2))]>;

// LD - page 239 of ISA reference.
//    Loads the value stored at a memory address into the destination register.
//    The memory address may be given as a single long immediate, or as two
//    operands whose values will be added together to get the address.
//
//    The suffixes given here refer to the memory address format - for example,
//    ri means an address given by a register + a signed 9-bit immediate.

def LDri : Pseudo<(outs CPURegs:$dst), (ins MEMri:$addr),
                  "ld $dst,$addr",
                  [(set CPURegs:$dst, (load ADDRri:$addr))]>;

// MOV - Page 262.
//    The contents of the source are moved into the destination register.

let isAsCheapAsAMove = 1 in {
  def MOVrui : Pseudo<(outs CPURegs:$dst), (ins uimm6:$imm),
                      "mov $dst,$imm",
                      [(set CPURegs:$dst, uimm6Pred:$imm)]>;

  def MOVrsi : Pseudo<(outs CPURegs:$dst), (ins simm12:$imm),
                      "mov $dst,$imm",
                      [(set CPURegs:$dst, simm12Pred:$imm)]>;

  def MOVrli : Pseudo<(outs CPURegs:$dst), (ins simm32:$imm),
                      "mov $dst,$imm",
                      [(set CPURegs:$dst, simm32Pred:$imm)]>;
}

// ST - page 310 of ISA reference.
//    Stores the value stored in the source operand in the destination memory
//    address. The source operand may either be a register or a long immediate
//    value. The memory address may be given as a single long immediate, or
//    as two operands whose values will be added together to get the address.
//
//    The suffixes given here refer to the whole instruction format - for
//    example, rri means store a value from a register into an address given by
//    a register + a signed 9-bit immediate.

def STrri : Pseudo<(outs), (ins MEMri:$addr, CPURegs:$src),
                   "st $src,$addr",
                   [(store CPURegs:$src, ADDRri:$addr)]>;

//===----------------------------------------------------------------------===//
// Misc Instructions
//===----------------------------------------------------------------------===//

// A return is modelled as an explicit jump from BLINK.
let isReturn = 1, isTerminator = 1, hasDelaySlot = 1, isBarrier = 1 in
  def RET : Pseudo<(outs), (ins), "j.d [blink]", [(ARCompactRet)]>;

//===----------------------------------------------------------------------===//
// Arbitrary patterns that map to one or more instructions
//===----------------------------------------------------------------------===//
