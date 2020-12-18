/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20200925 (64-bit version)
 * Copyright (c) 2000 - 2020 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of iASLZZ2i1l.aml, Fri Dec 18 23:16:42 2020
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x000005FF (1535)
 *     Revision         0x02
 *     Checksum         0x8D
 *     OEM ID           "CORP"
 *     OEM Table ID     "BATT"
 *     OEM Revision     0x00000000 (0)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20200925 (538970405)
 */
DefinitionBlock ("", "SSDT", 2, "CORP", "BATT", 0x00000000)
{
    External (_SB_.PCI0.LPCB, DeviceObj)
    External (_SB_.PCI0.LPCB.BAT0.BFB0, UnknownObj)
    External (_SB_.PCI0.LPCB.BAT0.PAK1, UnknownObj)
    External (_SB_.PCI0.LPCB.EC__, DeviceObj)
    External (_SB_.PCI0.LPCB.EC__.ECON, UnknownObj)
    External (_SB_.PCI0.LPCB.EC__.PSTA, IntObj)
    External (BFB0, IntObj)
    External (PAK1, IntObj)

    Scope (_SB.PCI0.LPCB.EC)
    {
        OperationRegion (ERM2, EmbeddedControl, 0x90, 0x0A)
        Field (ERM2, ByteAcc, NoLock, Preserve)
        {
            IF00,   8, 
            IF01,   8, 
            IF10,   8, 
            IF11,   8, 
            IF20,   8, 
            IF21,   8, 
            IF30,   8, 
            IF31,   8, 
            IF40,   8, 
            IF41,   8
        }

        OperationRegion (ERM3, EmbeddedControl, 0xA2, 0x08)
        Field (ERM3, ByteAcc, NoLock, Preserve)
        {
            ST00,   8, 
            ST01,   8, 
            ST10,   8, 
            ST11,   8, 
            ST20,   8, 
            ST21,   8, 
            ST30,   8, 
            ST31,   8
        }
    }

    Method (\_SB.PCI0.LPCB.EC.RE1B, 1, NotSerialized)
    {
        OperationRegion (ERAM, EmbeddedControl, Arg0, One)
        Field (ERAM, ByteAcc, NoLock, Preserve)
        {
            BYTE,   8
        }

        Return (BYTE) /* \_SB_.PCI0.LPCB.EC__.RE1B.BYTE */
    }

    Method (\_SB.PCI0.LPCB.EC.RECB, 2, Serialized)
    {
        Arg1 = ((Arg1 + 0x07) >> 0x03)
        Name (TEMP, Buffer (Arg1){})
        Arg1 += Arg0
        Local0 = Zero
        While ((Arg0 < Arg1))
        {
            TEMP [Local0] = RE1B (Arg0)
            Arg0++
            Local0++
        }

        Return (TEMP) /* \_SB_.PCI0.LPCB.EC__.RECB.TEMP */
    }

    Method (\_SB.PCI0.LPCB.BAT0._BIF, 0, NotSerialized)  // _BIF: Battery Information
    {
        If ((\_SB.PCI0.LPCB.EC.ECON == One))
        {
            Local0 = (\_SB.PCI0.LPCB.EC.PSTA & 0x02)
            If (Local0)
            {
                Local0 = B1B2 (\_SB.PCI0.LPCB.EC.IF00, \_SB.PCI0.LPCB.EC.IF01)
                PAK1 [Zero] = Local0
                If (Local0)
                {
                    PAK1 [One] = B1B2 (\_SB.PCI0.LPCB.EC.IF10, \_SB.PCI0.LPCB.EC.IF11)
                    PAK1 [0x02] = B1B2 (\_SB.PCI0.LPCB.EC.IF20, \_SB.PCI0.LPCB.EC.IF21)
                }
                Else
                {
                    Local1 = (B1B2 (\_SB.PCI0.LPCB.EC.IF10, \_SB.PCI0.LPCB.EC.IF11) * 0x0A)
                    PAK1 [One] = Local1
                    Local1 = (B1B2 (\_SB.PCI0.LPCB.EC.IF20, \_SB.PCI0.LPCB.EC.IF21) * 0x0A)
                    PAK1 [0x02] = Local1
                }

                PAK1 [0x03] = B1B2 (\_SB.PCI0.LPCB.EC.IF30, \_SB.PCI0.LPCB.EC.IF31)
                PAK1 [0x04] = B1B2 (\_SB.PCI0.LPCB.EC.IF40, \_SB.PCI0.LPCB.EC.IF41)
                PAK1 [0x05] = (B1B2 (\_SB.PCI0.LPCB.EC.IF10, \_SB.PCI0.LPCB.EC.IF11) / 0x32)
                PAK1 [0x06] = (B1B2 (\_SB.PCI0.LPCB.EC.IF10, \_SB.PCI0.LPCB.EC.IF11) / 0x64)
                PAK1 [0x0A] = ToString (\_SB.PCI0.LPCB.EC.RECB (0x60, 0x0100), 0x20)
                Return (PAK1) /* External reference */
            }
            Else
            {
                Return (PAK1) /* External reference */
            }
        }
        Else
        {
            Return (PAK1) /* External reference */
        }
    }

    Method (\_SB.PCI0.LPCB.BAT0._BST, 0, NotSerialized)  // _BST: Battery Status
    {
        If ((\_SB.PCI0.LPCB.EC.ECON == One))
        {
            Local0 = (\_SB.PCI0.LPCB.EC.PSTA & 0x02)
            If (Local0)
            {
                BFB0 [Zero] = B1B2 (\_SB.PCI0.LPCB.EC.ST00, \_SB.PCI0.LPCB.EC.ST01)
                BFB0 [One] = B1B2 (\_SB.PCI0.LPCB.EC.ST10, \_SB.PCI0.LPCB.EC.ST11)
                BFB0 [0x02] = B1B2 (\_SB.PCI0.LPCB.EC.ST20, \_SB.PCI0.LPCB.EC.ST21)
                BFB0 [0x03] = B1B2 (\_SB.PCI0.LPCB.EC.ST30, \_SB.PCI0.LPCB.EC.ST31)
                Return (BFB0) /* External reference */
            }
            Else
            {
                Return (BFB0) /* External reference */
            }
        }
        Else
        {
            Return (BFB0) /* External reference */
        }
    }

    Method (B1B2, 2, NotSerialized)
    {
        Return ((Arg0 | (Arg1 << 0x08)))
    }
}
