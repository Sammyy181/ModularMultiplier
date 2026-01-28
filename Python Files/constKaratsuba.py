def extract_bitsM8(hex_str, high, low):
    total_bits = 256
    start_digit = (total_bits - (high*8)) // 4
    end_digit = (total_bits - (low*8)) // 4
    
    hex_value = hex_str[start_digit:end_digit]
    return int(hex_value, 16) if hex_value else 0

def constMult(X: int):
    
    Y = int("92e5c273477d21d8361651a6eea3cb5b1c424d77f1b750a99cc6df2b0ee713a2", 16)
    
    hexX = hex(X)[2:].zfill(64)
    hexY = hex(Y)[2:].zfill(64)
    
    P = X * Y
    
    # Cycle 1
    Z0 = extract_bitsM8(hexX, 2, 0) * extract_bitsM8(hexY, 3, 0)
    Z2 = extract_bitsM8(hexX, 4, 2) * extract_bitsM8(hexY, 3, 0)
    Z3 = extract_bitsM8(hexX, 2, 0) * extract_bitsM8(hexY, 6, 3)
    Z4 = extract_bitsM8(hexX, 6, 4) * extract_bitsM8(hexY, 3, 0)
    Z5 = extract_bitsM8(hexX, 4, 2) * extract_bitsM8(hexY, 6, 3)
    Z7 = extract_bitsM8(hexX, 6, 4) * extract_bitsM8(hexY, 6, 3)
    Z12 = extract_bitsM8(hexX, 8, 6) * extract_bitsM8(hexY, 9, 6)
    Z14 = extract_bitsM8(hexX, 10, 8) * extract_bitsM8(hexY, 9, 6)
    Z15_0 = extract_bitsM8(hexX, 8, 6) * extract_bitsM8(hexY, 12, 9)
    Z15_1 = extract_bitsM8(hexX, 2, 0) * extract_bitsM8(hexY, 18, 15)
    Z15_2 = extract_bitsM8(hexX, 14, 12) * extract_bitsM8(hexY, 6, 3)
    Z16_0 = extract_bitsM8(hexX, 12, 10) * extract_bitsM8(hexY, 9, 6)
    Z16_1 = extract_bitsM8(hexX, 6, 4) * extract_bitsM8(hexY, 15, 12)
    Z17_0 = extract_bitsM8(hexX, 10, 8) * extract_bitsM8(hexY, 12, 9)
    Z17_1 = extract_bitsM8(hexX, 4, 2) * extract_bitsM8(hexY, 18, 15)
    Z17_2 = extract_bitsM8(hexX, 16, 14) * extract_bitsM8(hexY, 6, 3)
    Z18 = extract_bitsM8(hexX, 2, 0) * extract_bitsM8(hexY, 21, 18)
    Z19_0 = extract_bitsM8(hexX, 12, 10) * extract_bitsM8(hexY, 12, 9)
    Z19_1 = extract_bitsM8(hexX, 6, 4) * extract_bitsM8(hexY, 18, 15)
    Z20 = extract_bitsM8(hexX, 4, 2) * extract_bitsM8(hexY, 21, 18)
    Z21_0 = extract_bitsM8(hexX, 2, 0) * extract_bitsM8(hexY, 24, 21)
    Z21_1 = extract_bitsM8(hexX, 8, 6) * extract_bitsM8(hexY, 18, 15)
    Z21_2 = extract_bitsM8(hexX, 14, 12) * extract_bitsM8(hexY, 12, 9)
    Z22_0 = extract_bitsM8(hexX, 6, 4) * extract_bitsM8(hexY, 21, 18)
    Z22_1 = extract_bitsM8(hexX, 12, 10) * extract_bitsM8(hexY, 15, 12)
    Z23_0 = extract_bitsM8(hexX, 4, 2) * extract_bitsM8(hexY, 24, 21)
    Z23_1 = extract_bitsM8(hexX, 10, 8) * extract_bitsM8(hexY, 18, 15)
    Z23_2 = extract_bitsM8(hexX, 16, 14) * extract_bitsM8(hexY, 12, 9)
    Z24 = extract_bitsM8(hexX, 14, 12) * extract_bitsM8(hexY, 15, 12)
    Z25_0 = extract_bitsM8(hexX, 6, 4) * extract_bitsM8(hexY, 24, 21)
    Z25_1 = extract_bitsM8(hexX, 12, 10) * extract_bitsM8(hexY, 18, 15)
    Z26 = extract_bitsM8(hexX, 16, 14) * extract_bitsM8(hexY, 15, 12)
    Z27 = extract_bitsM8(hexX, 8, 6) * extract_bitsM8(hexY, 24, 21)
    Z28_0 = extract_bitsM8(hexX, 6, 4) * extract_bitsM8(hexY, 27, 24)
    Z28_1 = extract_bitsM8(hexX, 12, 10) * extract_bitsM8(hexY, 21, 18)
    Z29 = extract_bitsM8(hexX, 10, 8) * extract_bitsM8(hexY, 24, 21)
    Z30 = extract_bitsM8(hexX, 8, 6) * extract_bitsM8(hexY, 27, 24)
    Z32 = extract_bitsM8(hexX, 10, 8) * extract_bitsM8(hexY, 27, 24)
    Z37 = extract_bitsM8(hexX, 12, 10) * extract_bitsM8(hexY, 30, 27)
    Z39 = extract_bitsM8(hexX, 14, 12) * extract_bitsM8(hexY, 30, 27)
    Z40 = extract_bitsM8(hexX, 12, 10) * extract_bitsM8(hexY, 32, 30)
    Z41 = extract_bitsM8(hexX, 16, 14) * extract_bitsM8(hexY, 30, 27)
    Z42 = extract_bitsM8(hexX, 14, 12) * extract_bitsM8(hexY, 32, 30)
    Z44 = extract_bitsM8(hexX, 16, 14) * extract_bitsM8(hexY, 32, 30)
    M6 = (extract_bitsM8(hexX, 2, 0) - extract_bitsM8(hexX, 8, 6)) * (extract_bitsM8(hexY, 9, 6) - extract_bitsM8(hexY, 3, 0))
    M8 = (extract_bitsM8(hexX, 4, 2) - extract_bitsM8(hexX, 10, 8)) * (extract_bitsM8(hexY, 9, 6) - extract_bitsM8(hexY, 3, 0))
    M9 = (extract_bitsM8(hexX, 2, 0) - extract_bitsM8(hexX, 8, 6)) * (extract_bitsM8(hexY, 12, 9) - extract_bitsM8(hexY, 6, 3))
    M10 = (extract_bitsM8(hexX, 6, 4) - extract_bitsM8(hexX, 12, 10)) * (extract_bitsM8(hexY, 9, 6) - extract_bitsM8(hexY, 3, 0))
    M11 = (extract_bitsM8(hexX, 4, 2) - extract_bitsM8(hexX, 10, 8)) * (extract_bitsM8(hexY, 12, 9) - extract_bitsM8(hexY, 6, 3))
    M12 = (extract_bitsM8(hexX, 2, 0) - extract_bitsM8(hexX, 14, 12)) * (extract_bitsM8(hexY, 15, 12) - extract_bitsM8(hexY, 3, 0))
    M13 = (extract_bitsM8(hexX, 6, 4) - extract_bitsM8(hexX, 12, 10)) * (extract_bitsM8(hexY, 12, 9) - extract_bitsM8(hexY, 6, 3))
    M14 = (extract_bitsM8(hexX, 4, 2) - extract_bitsM8(hexX, 16, 14)) * (extract_bitsM8(hexY, 15, 12) - extract_bitsM8(hexY, 3, 0))
    M18 = (extract_bitsM8(hexX, 8, 6) - extract_bitsM8(hexX, 14, 12)) * (extract_bitsM8(hexY, 15, 12) - extract_bitsM8(hexY, 9, 6))
    M20 = (extract_bitsM8(hexX, 10, 8) - extract_bitsM8(hexX, 16, 14)) * (extract_bitsM8(hexY, 15, 12) - extract_bitsM8(hexY, 9, 6))
    M24 = (extract_bitsM8(hexX, 2, 0) - extract_bitsM8(hexX, 8, 6)) * (extract_bitsM8(hexY, 27, 24) - extract_bitsM8(hexY, 21, 18))
    M26 = (extract_bitsM8(hexX, 4, 2) - extract_bitsM8(hexX, 10, 8)) * (extract_bitsM8(hexY, 27, 24) - extract_bitsM8(hexY, 21, 18))
    M27 = (extract_bitsM8(hexX, 2, 0) - extract_bitsM8(hexX, 14, 12)) * (extract_bitsM8(hexY, 30, 27) - extract_bitsM8(hexY, 18, 15))
    M29 = (extract_bitsM8(hexX, 4, 2) - extract_bitsM8(hexX, 16, 14)) * (extract_bitsM8(hexY, 30, 27) - extract_bitsM8(hexY, 18, 15))
    M30 = (extract_bitsM8(hexX, 2, 0) - extract_bitsM8(hexX, 14, 12)) * (extract_bitsM8(hexY, 32, 30) - extract_bitsM8(hexY, 21, 18))
    M31 = (extract_bitsM8(hexX, 6, 4) - extract_bitsM8(hexX, 12, 10)) * (extract_bitsM8(hexY, 30, 27) - extract_bitsM8(hexY, 24, 21))
    M32 = (extract_bitsM8(hexX, 4, 2) - extract_bitsM8(hexX, 16, 14)) * (extract_bitsM8(hexY, 32, 30) - extract_bitsM8(hexY, 21, 18))
    M33 = (extract_bitsM8(hexX, 8, 6) - extract_bitsM8(hexX, 14, 12)) * (extract_bitsM8(hexY, 30, 27) - extract_bitsM8(hexY, 24, 21))
    M34 = (extract_bitsM8(hexX, 6, 4) - extract_bitsM8(hexX, 12, 10)) * (extract_bitsM8(hexY, 32, 30) - extract_bitsM8(hexY, 27, 24))
    M35 = (extract_bitsM8(hexX, 10, 8) - extract_bitsM8(hexX, 16, 14)) * (extract_bitsM8(hexY, 30, 27) - extract_bitsM8(hexY, 24, 21))
    M36 = (extract_bitsM8(hexX, 8, 6) - extract_bitsM8(hexX, 14, 12)) * (extract_bitsM8(hexY, 32, 30) - extract_bitsM8(hexY, 27, 24))
    M38 = (extract_bitsM8(hexX, 10, 8) - extract_bitsM8(hexX, 16, 14)) * (extract_bitsM8(hexY, 32, 30) - extract_bitsM8(hexY, 27, 24))
    
    # Cycle 2
    S81_0 = Z0 + (Z2 * pow(2, 16)) + (Z3 * pow(2, 24)) + (Z4 * pow(2, 32)) + (Z5 * pow(2, 40))
    S98_48 = M6 + Z0 + Z12 + (Z7 * pow(2, 8))
    S114_64 = M8 + Z2 + Z14 + ((M9 + Z15_0 + Z3) * pow(2, 8))
    S130_80 = M10 + Z16_0 + Z4 + ((M11+ Z17_0 + Z5) * pow(2, 8))
    S138_96 = M12 + Z12 + Z0 + Z24
    S145_104 = M13 + Z7 + Z19_0
    S154_112 = M14 + Z14 + Z26 + Z2
    S162_120 = Z15_0 + Z15_1 + Z15_2
    S169_128 = Z16_0 + Z16_1
    S178_136 = Z17_0 + Z17_1 + Z17_2
    S186_144 = M18 + Z18 + Z12 + Z24
    S193_152 = Z19_0 + Z19_1
    S202_160 = M20 + Z20 + Z26 + Z14
    S210_168 = Z21_0 + Z21_1 + Z21_2
    S217_176 = Z22_0 + Z22_1
    S226_184 = Z23_0 + Z23_1 + Z23_2
    S234_192 = M24 + Z24 + Z30 + Z18 
    S241_200 = Z25_0 + Z25_1
    S250_208 = M26 + Z26 + Z32 + Z20
    S258_216 = M27 + Z27 + Z39 + Z15_1
    S265_224 = Z28_0 + Z28_1
    S274_232 = M29 + Z29 + Z41 + Z17_1
    S282_240 = M30 + Z30 + Z42 + Z18
    S289_248 = M31 + Z37 + Z25_0
    S298_256 = M32 + Z32 + Z20 + Z44
    S314_264 = M33 + Z39 + Z27 +((M34 + Z40 + Z28_0) * pow(2, 8))
    S330_280 = M35 + Z41 + Z29 + ((M36 + Z42 + Z30) * pow(2, 8))
    S346_296 = Z37 + ((M38 + Z44 + Z32) * pow(2, 8))
    S383_312 = Z39 + (Z40 * pow(2, 8)) + (Z41 * pow(2, 16)) + (Z42 * pow(2, 24)) + (Z44 * pow(2, 40))
    
    """
    print("\n=== Cycle 2 Values ===")
    print(f"S81_0 = {hex(S81_0)}")
    print(f"S383_312 = {hex(S383_312)}")
    print(f"S98_48 = {hex(S98_48)}")
    print(f"S114_64 = {hex(S114_64)}")
    print(f"S130_80 = {hex(S130_80)}")
    print(f"S314_264 = {hex(S314_264)}")
    print(f"S330_280 = {hex(S330_280)}")
    print(f"S346_296 = {hex(S346_296)}")
    print(f"S138_96 = {hex(S138_96)}")
    print(f"S154_112 = {hex(S154_112)}")
    print(f"S162_120 = {hex(S162_120)}")
    print(f"S178_136 = {hex(S178_136)}")
    print(f"S186_144 = {hex(S186_144)}")
    print(f"S202_160 = {hex(S202_160)}")
    print(f"S210_168 = {hex(S210_168)}")
    print(f"S226_184 = {hex(S226_184)}")
    print(f"S234_192 = {hex(S234_192)}")
    print(f"S250_208 = {hex(S250_208)}")
    print(f"S258_216 = {hex(S258_216)}")
    print(f"S274_232 = {hex(S274_232)}")
    print(f"S282_240 = {hex(S282_240)}")
    print(f"S289_248 = {hex(S289_248)}")
    print(f"S298_256 = {hex(S298_256)}")
    print(f"S145_104 = {hex(S145_104)}")
    print(f"S169_128 = {hex(S169_128)}")
    print(f"S193_152 = {hex(S193_152)}")
    print(f"S217_176 = {hex(S217_176)}")
    print(f"S241_200 = {hex(S241_200)}")
    print(f"S265_224 = {hex(S265_224)}")
    print(f"S289_248 = {hex(S289_248)}")"""
    
    # Cycle 3
    S99_0 = S81_0 + (S98_48 * pow(2, 48))
    S139_64 = S114_64 + (S130_80 * pow(2, 16)) + (S138_96 * pow(2, 32))
    S163_104 = S145_104 + (S154_112 * pow(2, 8)) + (S162_120 * pow(2, 16))
    S187_128 = S169_128 + (S178_136 * pow(2, 8)) + (S186_144 * pow(2, 16))
    S211_152 = S193_152 + (S202_160 * pow(2, 8)) + (S210_168 * pow(2, 16))
    S235_176 = S217_176 + (S226_184 * pow(2, 8)) + (S234_192 * pow(2, 16))
    S259_200 = S241_200 + (S250_208 * pow(2, 8)) + (S258_216 * pow(2, 16))
    S290_224 = S265_224 + (S274_232 * pow(2, 8)) + (S282_240 * pow(2, 16)) + (S289_248 * pow(2, 24))
    S331_256 = S298_256 + (S314_264 * pow(2, 8)) + (S330_280 * pow(2, 24))
    S383_296 = S346_296 + (S383_312 * pow(2, 16))
    
    # Cycle 4
    S140_0 = S99_0 + (S139_64 * pow(2, 64))
    S188_104 = S163_104 + (S187_128 * pow(2, 24))
    S236_152 = S211_152 + (S235_176 * pow(2, 24))
    S291_200 = S259_200 + (S290_224 * pow(2, 24))
    S383_256 = S331_256 + (S383_296 * pow(2, 40))
    
    # Cycle 5
    S189_0 = S140_0 + (S188_104 * pow(2, 104))
    S292_152 = S236_152 + (S291_200 * pow(2, 48))
    
    # Cycle 6
    S383_152 = S292_152 + (S383_256 * pow(2, 104))
    
    # Cycle 7
    P_test = S189_0 + (S383_152 * pow(2, 152))
    
    print(f"Theoretical Product = {hex(P)[2:]}")
    print(f"Test Product = {hex(P_test)[2:]}")
    
    return hex(P)[2:]
    
def check(X: int):
    
    Y = int("92e5c273477d21d8361651a6eea3cb5b1c424d77f1b750a99cc6df2b0ee713a2",16)
    
    hexX = hex(X)[2:].zfill(64)
    hexY = hex(Y)[2:].zfill(64)
    
    print(f"Real Product: {hex(X*Y)[2:]}")
    
    def extract_mult(acoeff, bcoeff):
        if bcoeff!=30:
            Zx = extract_bitsM8(hexX, acoeff + 2, acoeff) * extract_bitsM8(hexY, bcoeff + 3, bcoeff) 
            return Zx
        else:
            Zx = extract_bitsM8(hexX, acoeff + 2, acoeff) * extract_bitsM8(hexY, bcoeff + 2, bcoeff) 
            return Zx     
    
    Z0 = extract_mult(0, 0)
    Z2 = extract_mult(2, 0)
    Z3 = extract_mult(0, 3)
    Z4 = extract_mult(4, 0)
    Z5 = extract_mult(2, 3)
    Z6 = extract_mult(6, 0) + extract_mult(0, 6)
    Z7 = extract_mult(4, 3)
    Z8 = extract_mult(2, 6) + extract_mult(8, 0)
    Z9 = extract_mult(6, 3) + extract_mult(0, 9)
    Z10 = extract_mult(4, 6) + extract_mult(10, 0)
    Z11 = extract_mult(2, 9) + extract_mult(8, 3)
    Z12 = extract_mult(0, 12) + extract_mult(6, 6) + extract_mult(12, 0)
    Z13 = extract_mult(4, 9) + extract_mult(10, 3)
    Z14 = extract_mult(2, 12) + extract_mult(8, 6) + extract_mult(14, 0)
    Z15 = extract_mult(0, 15) + extract_mult(6, 9) + extract_mult(12, 3)
    Z16 = extract_mult(4, 12) + extract_mult(10, 6) 
    Z17 = extract_mult(2, 15) + extract_mult(8, 9) + extract_mult(14, 3)
    Z18 = extract_mult(0, 18) + extract_mult(6, 12) + extract_mult(12, 6) 
    Z19 = extract_mult(4, 15) + extract_mult(10, 9)
    Z20 = extract_mult(2, 18) + extract_mult(8, 12) + extract_mult(14, 6)
    Z21 = extract_mult(0, 21) + extract_mult(6, 15) + extract_mult(12, 9)
    Z22 = extract_mult(4, 18) + extract_mult(10, 12)
    Z23 = extract_mult(2, 21) + extract_mult(8, 15) + extract_mult(14, 9)
    Z24 = extract_mult(0, 24) + extract_mult(6, 18) + extract_mult(12, 12)
    Z25 = extract_mult(4, 21) + extract_mult(10, 15)
    Z26 = extract_mult(2, 24) + extract_mult(8, 18) + extract_mult(14, 12)
    Z27 = extract_mult(0, 27) + extract_mult(6, 21) + extract_mult(12, 15)
    Z28 = extract_mult(4, 24) + extract_mult(10, 18)
    Z29 = extract_mult(2, 27) + extract_mult(8, 21) + extract_mult(14, 15)
    Z30 = extract_mult(0, 30) + extract_mult(6, 24) + extract_mult(12, 18)
    Z31 = extract_mult(4, 27) + extract_mult(10, 21)
    Z32 = extract_mult(2, 30) + extract_mult(8, 24) + extract_mult(14, 18)
    Z33 = extract_mult(6, 27) + extract_mult(12, 21)
    Z34 = extract_mult(4, 30) + extract_mult(10, 24)
    Z35 = extract_mult(8, 27) + extract_mult(14, 21)
    Z36 = extract_mult(6, 30) + extract_mult(12, 24)
    Z37 = extract_mult(10, 27)
    Z38 = extract_mult(8, 30) + extract_mult(14, 24)
    Z39 = extract_mult(12, 27)
    Z40 = extract_mult(10, 30)
    Z41 = extract_mult(14, 27)
    Z42 = extract_mult(12, 30)
    Z44 = extract_mult(14, 30)
    
    productKaratsuba = (Z0 + (Z2  << (2*8)) + (Z3  << (3*8)) + (Z4  << (4*8)) + (Z5  << (5*8)) + (Z6  << (6*8)) + (Z7  << (7*8)) + (Z8  << (8*8)) + (Z9  << (9*8)) + (Z10 << (10*8)) + (Z11 << (11*8)) + (Z12 << (12*8)) + (Z13 << (13*8)) + (Z14 << (14*8)) + (Z15 << (15*8)) + (Z16 << (16*8)) + (Z17 << (17*8)) + (Z18 << (18*8)) + (Z19 << (19*8))  + (Z20 << (20*8)) + (Z21 << (21*8)) + (Z22 << (22*8)) + (Z23 << (23*8)) + (Z24 << (24*8)) + (Z25 << (25*8)) + (Z26 << (26*8)) + (Z27 << (27*8)) + (Z28 << (28*8)) + (Z29 << (29*8)) + (Z30 << (30*8)) + (Z31 << (31*8)) + (Z32 << (32*8)) + (Z33 << (33*8)) + (Z34 << (34*8)) + (Z35 << (35*8)) + (Z36 << (36*8)) + (Z37 << (37*8)) + (Z38 << (38*8)) + (Z39 << (39*8)) + (Z40 << (40*8)) + (Z41 << (41*8)) + (Z42 << (42*8)) + (Z44 << (44*8)))
    
    print(f"Karatsuba Product = {hex(productKaratsuba)}")
    
if __name__ == "__main__":
    
    test_cases = [
        0x00000000000000000000000000000000,  # Test 0: All zeros
        0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF,  # Test 1: All ones
        0x00000000000000000000000000000001,  # Test 2: Single bit set in LSB
        0x80000000000000000000000000000000,  # Test 3: Single bit set in MSB
        0xAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA,  # Test 4: Alternating bits pattern 1
        0x55555555555555555555555555555555,  # Test 5: Alternating bits pattern 2
        0x0000000000000000FFFFFFFFFFFFFFFF,  # Test 6: Lower 64 bits set
        0xFFFFFFFFFFFFFFFF0000000000000000,  # Test 7: Upper 64 bits set
        0xF0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0,  # Test 8: Checkerboard pattern by nibbles
        0x0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F,  # Test 9: Inverse checkerboard pattern
        0x0000000100000001000000010000001,   # Test 10: Progressive bit pattern
        0xFFFF0000FFFF0000FFFF0000FFFF0000,  # Test 11: All bits set in 16-bit segments
        0x0123456789ABCDEF0FEDCBA987654321,  # Test 12: Sequential increments
        0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC5,  # Test 13: Large prime-like number
        0x0000000000000000FFFFFFFFFFFFFFFF,  # Test 14: Power of 2 minus 1
        0x00FFFFFF00FFFFFF00FFFFFF00FFFFFF,  # Test 15: Multiple 24-bit segment boundaries
        0x7FFFFFFFFFFFFFFF8000000000000000,  # Test 16: Signed/unsigned boundaries
        0x000000FFFFFFFFFF000000FFFFFFFFFF,  # Test 17: Consecutive ones in different positions
        0xDEADBEEFCAFEBABEFEEDFACE13579BDF,  # Test 18: Random-looking but structured
        0x8000000040000000200000001000000,   # Test 19: Bit rotation pattern
        0x3F8A7B2E5D19C64F8E2A3B7D6F1C9E45,  # Test 20: Random
        0xB4E9F1C3A7D2856B4F3E8A1D7C592B6E,  # Test 21: Random
        0x7C3D9E4A2F8B1D5E6A9C4F2E8B3D7A1C,  # Test 22: Random
        0x91E6D4B8F2A5C7394E1D8B6F3A2C9E57,  # Test 23: Random
        0x5D8A3F9E1C7B4E2D6F8A9C3E5B7D1F4A,  # Test 24: Random
        0xC8F4E9A1D3B6279E5A4D8F1C3E7B9A26,  # Test 25: Random
        0x2E9D5A8F3C1B7E46D8F2A3C9B5E7D41A,  # Test 26: Random
        0xA7C4E8D1F93B6A25E8D1C4F7A2B9E356,  # Test 27: Random
        0x6B1F8E3D9A4C27E5F8B3D6A1C9E4F728,  # Test 28: Random
        0xD9A2F5E8B1C4736E2D8F9A3C6E5B1D4F,  # Test 29: Random
    ]
    
    print("=" * 80)
    print("Karatsuba Constant Multiplier - 10 Test Cases")
    print("=" * 80)
    
    products = []
    
    for i, Y in enumerate(test_cases):
        print(f"\nTest Case {i}:")
        print(f"Y = 0x{Y:032X}")
        
        # Also run through the findParts function to verify
        product = constMult(Y)
        products.append(product)
        print("-" * 80)
    
    print("=" * 80)
    print("Products:")
    print("=" * 80)
    for i, product in enumerate(products):
        print(f"Product {i}: {product.zfill(96)}")
    print("=" * 80)