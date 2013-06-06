//===--------- ARCompactRegisterInfo.td - ARCompact Register defs ---------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

//===----------------------------------------------------------------------===//
//  Declarations that describe the ARCompact register file
//===----------------------------------------------------------------------===//

class ARCompactReg<string n> : Register<n> {
  // We have banks of 32 registers each.
  field bits<5> Num;

  let Namespace = "ARCompact";
}

// A general purpose register.
class ARCompactGPRReg<bits<5> num, string n> : ARCompactReg<n> {
  let Num = num;
}

//===----------------------------------------------------------------------===//
//  Registers
//===----------------------------------------------------------------------===//

let Namespace = "ARCompact" in {

  // General purpose registers (used also for arguments.)
  def R0 : ARCompactGPRReg<0, "R0">,    DwarfRegNum<[0]>;
  def R1 : ARCompactGPRReg<1, "R1">,    DwarfRegNum<[1]>;
  def R2 : ARCompactGPRReg<2, "R2">,    DwarfRegNum<[2]>;
  def R3 : ARCompactGPRReg<3, "R3">,    DwarfRegNum<[3]>;
  def R4 : ARCompactGPRReg<4, "R4">,    DwarfRegNum<[4]>;
  def R5 : ARCompactGPRReg<5, "R5">,    DwarfRegNum<[5]>;
  def R6 : ARCompactGPRReg<6, "R6">,    DwarfRegNum<[6]>;
  def R7 : ARCompactGPRReg<7, "R7">,    DwarfRegNum<[7]>;

  // Temp registers (R8-R12 caller-saved, R13-R15 callee saved.)
  // Note: R12 is reserved for temporary calculations by both
  //       GCC and LLVM-ARCompact.
  def T0 : ARCompactGPRReg<8, "R8">,    DwarfRegNum<[8]>;
  def T1 : ARCompactGPRReg<9, "R9">,    DwarfRegNum<[9]>;
  def T2 : ARCompactGPRReg<10, "R10">,  DwarfRegNum<[10]>;
  def T3 : ARCompactGPRReg<11, "R11">,  DwarfRegNum<[11]>;
  def T4 : ARCompactGPRReg<12, "R12">,  DwarfRegNum<[12]>;
  def T5 : ARCompactGPRReg<13, "R13">,  DwarfRegNum<[13]>;
  def T6 : ARCompactGPRReg<14, "R14">,  DwarfRegNum<[14]>;
  def T7 : ARCompactGPRReg<15, "R15">,  DwarfRegNum<[15]>;

  // Saved registers (all callee saved.)
  def S0 : ARCompactGPRReg<16, "R16">,  DwarfRegNum<[16]>;
  def S1 : ARCompactGPRReg<17, "R17">,  DwarfRegNum<[17]>;
  def S2 : ARCompactGPRReg<18, "R18">,  DwarfRegNum<[18]>;
  def S3 : ARCompactGPRReg<19, "R19">,  DwarfRegNum<[19]>;
  def S4 : ARCompactGPRReg<20, "R20">,  DwarfRegNum<[20]>;
  def S5 : ARCompactGPRReg<21, "R21">,  DwarfRegNum<[21]>;
  def S6 : ARCompactGPRReg<22, "R22">,  DwarfRegNum<[22]>;
  def S7 : ARCompactGPRReg<23, "R23">,  DwarfRegNum<[23]>;
  def S8 : ARCompactGPRReg<24, "R24">,  DwarfRegNum<[24]>;
  def S9 : ARCompactGPRReg<25, "R25">,  DwarfRegNum<[25]>;

  // Global, frame, and stack pointer registers.
  def GP : ARCompactGPRReg<26, "GP">,  DwarfRegNum<[26]>;
  def FP : ARCompactGPRReg<27, "FP">,  DwarfRegNum<[27]>;
  def SP : ARCompactGPRReg<28, "SP">,  DwarfRegNum<[28]>;

  // Interrupt link registers.
  def ILINK1 : ARCompactGPRReg<29, "ILINK1">, DwarfRegNum<[29]>;
  def ILINK2 : ARCompactGPRReg<30, "ILINK2">, DwarfRegNum<[30]>;

  // Branch link register.
  def BLINK : ARCompactGPRReg<31, "BLINK">, DwarfRegNum<[31]>;
}

//===----------------------------------------------------------------------===//
//  Register classes
//===----------------------------------------------------------------------===//

// General purpose registers.
// Note: These are actually i32 and f32, but fp is currently not
// supported.
def CPURegs : RegisterClass<"ARCompact", [i32], 32, (add
  // Argument registers.
  R0, R1, R2, R3, R4, R5, R6, R7,
  // Not preserved across procedure calls.
  T0, T1, T2, T3, T4,
  // Callee saved.
  T5, T6, T7, S0, S1, S2, S3, S4, S5, S6, S7, S8, S9,
  // Reserved.
  GP, FP, SP, ILINK1, ILINK2, BLINK)>;
