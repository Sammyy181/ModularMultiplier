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

    X = random.getrandbits(256)
    Y = random.getrandbits(256)
    #Y = X = (2**256) - 1
    
    binX = bin(X)[2:].zfill(256)
    binY = bin(Y)[2:].zfill(256)
    print(f"X - {hex(X)[2:]}")
    print(f"Y - {hex(Y)[2:]}")
    #print(f"Product - {hex(X * Y)[2:]}")
    
    # 1st Cycle
    P00 = int(binX[192:],2) * int(binY[192:],2)
    P11 = int(binX[128:192],2) * int(binY[128:192],2)
    P22 = int(binX[64:128],2) * int(binY[64:128],2)
    P33 = int(binX[:64],2) * int(binY[:64],2)
    
    S10X = int(binX[192:],2) + int(binX[128:192],2)
    S20X = int(binX[64:128],2) + int(binX[192:],2)
    S21X = int(binX[64:128],2) + int(binX[128:192],2)
    S30X = int(binX[192:],2) + int(binX[:64],2)
    S31X = int(binX[:64],2) + int(binX[128:192],2)
    S32X = int(binX[:64],2) + int(binX[64:128],2)
    
    S10Y = int(binY[192:],2) + int(binY[128:192],2)
    S20Y = int(binY[64:128],2) + int(binY[192:],2)
    S21Y = int(binY[64:128],2) + int(binY[128:192],2)
    S30Y = int(binY[192:],2) + int(binY[:64],2)
    S31Y = int(binY[:64],2) + int(binY[128:192],2)
    S32Y = int(binY[:64],2) + int(binY[64:128],2)
    
    # 2nd Cycle
    S10 = S10X * S10Y
    S20 = S20X * S20Y
    S21 = S21X * S21Y
    S30 = S30X * S30Y
    S31 = S31X * S31Y
    S32 = S32X * S32Y
    
    P1P0 = P11 + P00
    P2P0 = P22 + P00
    P2P1 = P22 + P11
    P3P0 = P33 + P00
    P3P1 = P33 + P11
    P3P2 = P33 + P22
    
    T0K = P00
    T6K = P33
    
    # 3rd Cycle
    T1K = S10 - P1P0
    M20 = S20 - P2P0
    M21 = S21 - P2P1
    M30 = S30 - P3P0
    M31 = S31 - P3P1
    T5K = S32 - P3P2
    #print(f"M20 - {hex(M20)[2:]}")
    
    # 4th Cycle
    lowSum = T1K + (T0K // (2**64))
    upSum = T6K + (T5K // (2**64))
    T2K = M20 + P11
    T3K = M30 + M21
    T4K = M31 + P22
    
    T5KL = T5K % (2**64)
    #print(f"lowSum - {hex(lowSum)[2:]}")
    #print(f"upSum - {hex(upSum)[2:]}")
    #print(f"T2K - {hex(T2K)[2:]}")
    #print(f"T4K - {hex(T4K)[2:]}")
    #print(f"T5KL - {hex(T5KL)[2:]}")
    
    # 5th Cycle
    sum3 = T2K + (lowSum // (2**64))
    sum5 = (T4K // (2**64)) + (T5K % (2**64))
    #print(f"sum3 - {hex(sum3)[2:]}")
    #print(f"T3K - {hex(T3K)[2:]}")
    #print(f"sum5 - {hex(sum5)[2:]}")
    
    # 6th Cycle
    sum4 = (sum3 // (2**64)) + T3K
    upSum2 = ((upSum + (sum5 // (2**64))) * (2 ** 64)) + (sum5 % (2**64))
    #print(f"sum4 - {hex(sum4)[2:]}")
    #print(f"upSum2 - {hex(upSum2)[2:]}")
    
    # 7th Cycle
    sum6 = (sum4 // (2**64)) + (T4K % (2**64))
    #uppersum6 = sum6 // (2**64)
    #print(f"sum6 - {hex(sum6)[2:]}")
    #print(f"Upper - {hex(uppersum6)[2:]}")
    
    # 8th Cycle
    upperSum = upSum2 + (sum6 // (2**64))
    #print(f"upperSum - {hex(upperSum)[2:]}")
    P = (T0K % (2**64)) + ((lowSum % (2**64)) * (2**64)) + ((sum3 % (2**64)) * (2**128)) + ((sum4 % (2**64)) * (2**192)) + ((sum6 % (2**64)) * (2**256)) + (upperSum* (2**320))
    print(f"Product - {hex(P)[2:]}")
    

if __name__ == "__main__":
    main()
    
#5b013b70ddf11560736ff50d7c982339f733c6715932f085be571f6bdf62d9c9f04df57594f140f730187fdd3d7a5c97f79df6f74821c3fb749521933b80fe01
#5b013b70ddf11560736ff50d7c982339f733c6715932f085be571f6bdf62d9c9f04df57594f140f730187fdd3d7a5c97f79df6f74821c3fb749521933b80fe01
#fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffe0000000000000000000000000000000000000000000000000000000000000001
#fffffffffffffffffffffffffffffffdfffffffffffffffffffffffffffffffe0000000000000000000000000000000000000000000000000000000000000001