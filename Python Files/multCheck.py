import random
import math

def to_twos_complement_hex(num: int, bit_width: int = 256):
    """
    Convert signed integer to its two's complement hex representation.
    
    :param num: The integer (can be positive or negative).
    :param bit_width: Width in bits (e.g., 256 for a 256-bit number).
    :return: Hex string of the two's complement representation.
    """
    if num >= 0:
        return hex(num)[2:].zfill(bit_width // 4)  # normal hex, zero-padded
    else:
        # two's complement: add 2^bit_width to make it positive
        return hex((1 << bit_width) + num)[2:].zfill(bit_width // 4)

def main():
    """
    Reviewing Karatsuba Implementation Algorithm
    """

    random.seed(42)
    modulus = random.getrandbits(256)
    binary_modulus = bin(modulus)[2:]
    
    bitwidth = len(binary_modulus)
    while bitwidth < 256:
        binary_modulus = "1" + binary_modulus
        bitwidth += 1
    
    modulus = int(binary_modulus, 2)
    print(f"Modulus - {modulus}")

    X = random.getrandbits(256)
    Y = random.getrandbits(256)

    binX = bin(X)[2:].zfill(256)
    binY = bin(Y)[2:].zfill(256)

    Phh = int(binX[:64], 2) * int(binY[:64], 2)
    Phl = int(binX[64:128], 2) * int(binY[64:128], 2)
    Plh = int(binX[128:192], 2) * int(binY[128:192], 2)
    Pll = int(binX[192:], 2) * int(binY[192:], 2)

    As = int(binX[:128],2) + int(binX[128:],2)
    Bs = int(binY[:128],2) + int(binY[128:],2)

    Ps_L = (As % (2**64)) * (Bs % (2**64))
    Ps_H = (As // (2**64)) * (Bs // (2**64))

    trial = (Phh * (2**384)) + (Phl * (2**256)) + (Plh * (2**128)) + Pll - (Phh * (2**256)) - (Phl * (2**128))
    print(f"Cycle 2 - {hex(trial)}")
    trial = trial - (Plh * (2**256)) - (Pll * (2**128))
    print(f"Cycle 3 - {hex(trial)}")

    Phsum = (int(binX[:64],2) + int(binX[64:128],2)) * (int(binY[:64],2) + int(binY[64:128],2))
    Plsum = (int(binX[128:192],2) + int(binX[192:],2)) * (int(binY[128:192],2) + int(binY[192:],2))
    Psumsums = Phh + Phl + Plh + Pll
    tempP = Phsum + Plsum - Psumsums

    Ph_mid = Phsum - Phh - Phl
    Pl_mid = Plsum - Plh - Pll

    trial = trial + (Ph_mid * (2**320)) + (Pl_mid * (2**64))
    print(f"Cycle 4 - {hex(trial)}")

    trial = trial + (Ps_H * (2**256))
    print(f"Cycle 5 - {hex(trial)}")
    midSumPart = Ps_H + Ps_L
    P_midSum = ((As % (2**64)) + (As // (2**64))) * ((Bs % (2**64)) + (Bs // (2**64)))
    midSumTerm = P_midSum - midSumPart

    tempP = tempP - midSumTerm
    compP = to_twos_complement_hex(tempP,132)
    print(f"tempP - {compP}")

    trial = trial - (tempP * (2**192))
    print(f"Cycle 6 - {hex(trial)}")

    trial = trial +  (Ps_L * (2**128))
    print(f"Cycle 7 - {hex(trial)}")

if __name__ == "__main__":
    main()