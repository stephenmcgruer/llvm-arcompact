//===------ ARCompactSubtarget.cpp - ARCompact Subtarget Information ------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file declares the ARCompact specific subclass of TargetSubtargetInfo.
//
//===----------------------------------------------------------------------===//

#ifndef ARCOMPACT_SUBTARGET_H
#define ARCOMPACT_SUBTARGET_H

#include "llvm/Target/TargetSubtargetInfo.h"
#include "llvm/MC/MCInstrItineraries.h"
#include <string>

namespace llvm {
class StringRef;

class ARCompactSubtarget {
  virtual void anchor();

public:
  // Note: We generally follow the GCC ABI for ARCompact, which I believe is
  //       a slightly modified version of the real one.
  enum ARCompactABIEnum {
    UnknownABI, GCC
  };

protected:
  // Note: We generally aim at ARC700 compliance.
  enum ARCompactArchEnum {
    ARC700
  };

  // The architecture and ABI for the subtarget.
  ARCompactArchEnum ARCompactArchVersion;
  ARCompactABIEnum ARCompactABI;

  // IsLittle - whether or not the target is little endian.
  // TODO: This makes no difference until we can directly emit machine code.
  bool IsLittle;

  InstrItineraryData InstrItins;

public:
  unsigned getTargetABI() const { return ARCompactABI; }

  /// This constructor initializes the data members to match that
  /// of the specified triple.
  Cpu0Subtarget(const std::string &TT, const std::string &CPU,
                const std::string &FS, bool little);

  bool isLittle() const { return IsLittle; }
};
} // End llvm namespace

#endif
