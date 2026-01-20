import math

def twoComp(num):
    if num >= 0:
        raise ValueError("Input must be negative")

    mag = abs(num)

    # minimal bits to represent the magnitude
    bits = ((mag.bit_length() + 3) // 4) * 4
    hex_digits = bits // 4

    tc = (1 << bits) - mag

    return '1' + format(tc, f'0{hex_digits}x')


def getHex(decDict):
        
        hexDict = {}
        
        partMults = decDict.keys()
        for dec in partMults:
            if decDict[dec] > 0:
                hexDict[dec] = '0' + hex(decDict[dec])[2:]
            elif decDict[dec] == 0:
                hexDict[dec] = 0
            else:
                hexDict[dec] = twoComp(decDict[dec])
        
        return hexDict
    
def extract_bitsM8(hex_str, high, low):
    total_bits = 256
    start_digit = (total_bits - (high*8)) // 4
    end_digit = (total_bits - (low*8)) // 4
    
    hex_value = hex_str[start_digit:end_digit]
    return int(hex_value, 16) if hex_value else 0

def findParts(X: int, Y: int):
    
    product = X * Y
    
    hexX = format(X, '064x')
    hexY = format(Y, '064x')
    
    # Cycle 1
    Z0 = extract_bitsM8(hexX, 2, 0) * extract_bitsM8(hexY, 3, 0)
    Z2 = extract_bitsM8(hexX, 4, 2) * extract_bitsM8(hexY, 3, 0)
    Z3 = extract_bitsM8(hexX, 2, 0) * extract_bitsM8(hexY, 6, 3)
    Z4 = extract_bitsM8(hexX, 6, 4) * extract_bitsM8(hexY, 3, 0)
    Z5 = extract_bitsM8(hexX, 4, 2) * extract_bitsM8(hexY, 6, 3)
    Z7 = extract_bitsM8(hexX, 6, 4) * extract_bitsM8(hexY, 6, 3)
    Z8 = extract_bitsM8(hexX, 4, 2) * extract_bitsM8(hexY, 9, 6)
    Z9 = extract_bitsM8(hexX, 8, 6) * extract_bitsM8(hexY, 6, 3)
    Z10 = extract_bitsM8(hexX, 6, 4) * extract_bitsM8(hexY, 9, 6)
    Z12 = extract_bitsM8(hexX, 8, 6) * extract_bitsM8(hexY, 9, 6)
    Z14 = extract_bitsM8(hexX, 10, 8) * extract_bitsM8(hexY, 9, 6)
    Z15 = extract_bitsM8(hexX, 8, 6) * extract_bitsM8(hexY, 12, 9)
    Z16 = extract_bitsM8(hexX, 12, 10) * extract_bitsM8(hexY, 9, 6)
    Z17 = extract_bitsM8(hexX, 10, 8) * extract_bitsM8(hexY, 12, 9)
    Z19 = extract_bitsM8(hexX, 12, 10) * extract_bitsM8(hexY, 12, 9)
    Z20 = extract_bitsM8(hexX, 10, 8) * extract_bitsM8(hexY, 15, 12)
    Z21 = extract_bitsM8(hexX, 14, 12) * extract_bitsM8(hexY, 12, 9)
    Z22 = extract_bitsM8(hexX, 12, 10) * extract_bitsM8(hexY, 15, 12)
    Z24 = extract_bitsM8(hexX, 14, 12) * extract_bitsM8(hexY, 15, 12)
    Z26 = extract_bitsM8(hexX, 16, 14) * extract_bitsM8(hexY, 15, 12)
    Z27 = extract_bitsM8(hexX, 14, 12) * extract_bitsM8(hexY, 18, 15)
    Z28 = extract_bitsM8(hexX, 18, 16) * extract_bitsM8(hexY, 15, 12)
    Z29 = extract_bitsM8(hexX, 16, 14) * extract_bitsM8(hexY, 18, 15)
    Z31 = extract_bitsM8(hexX, 18, 16) * extract_bitsM8(hexY, 18, 15)
    Z32 = extract_bitsM8(hexX, 16, 14) * extract_bitsM8(hexY, 21, 18)
    Z33 = extract_bitsM8(hexX, 20, 18) * extract_bitsM8(hexY, 18, 15)
    Z34 = extract_bitsM8(hexX, 18, 16) * extract_bitsM8(hexY, 21, 18)
    Z36 = extract_bitsM8(hexX, 20, 18) * extract_bitsM8(hexY, 21, 18)
    Z38 = extract_bitsM8(hexX, 22, 20) * extract_bitsM8(hexY, 21, 18)
    Z39 = extract_bitsM8(hexX, 20, 18) * extract_bitsM8(hexY, 24, 21)
    Z40 = extract_bitsM8(hexX, 24, 22) * extract_bitsM8(hexY, 21, 18)
    Z41 = extract_bitsM8(hexX, 22, 20) * extract_bitsM8(hexY, 24, 21)
    Z43 = extract_bitsM8(hexX, 24, 22) * extract_bitsM8(hexY, 24, 21)
    Z44 = extract_bitsM8(hexX, 22, 20) * extract_bitsM8(hexY, 27, 24)
    Z45 = extract_bitsM8(hexX, 26, 24) * extract_bitsM8(hexY, 24, 21)
    Z46 = extract_bitsM8(hexX, 24, 22) * extract_bitsM8(hexY, 27, 24)
    Z48 = extract_bitsM8(hexX, 26, 24) * extract_bitsM8(hexY, 27, 24)
    Z50 = extract_bitsM8(hexX, 28, 26) * extract_bitsM8(hexY, 27, 24)
    Z51 = extract_bitsM8(hexX, 26, 24) * extract_bitsM8(hexY, 30, 27)
    Z52 = extract_bitsM8(hexX, 30, 28) * extract_bitsM8(hexY, 27, 24)
    Z53 = extract_bitsM8(hexX, 28, 26) * extract_bitsM8(hexY, 30, 27)
    Z55 = extract_bitsM8(hexX, 30, 28) * extract_bitsM8(hexY, 30, 27)
    Z56 = extract_bitsM8(hexX, 28, 26) * extract_bitsM8(hexY, 32, 30)
    Z57 = extract_bitsM8(hexX, 32, 30) * extract_bitsM8(hexY, 30, 27)
    Z58 = extract_bitsM8(hexX, 30, 28) * extract_bitsM8(hexY, 32, 30)
    Z60 = extract_bitsM8(hexX, 32, 30) * extract_bitsM8(hexY, 32, 30)
    
    M6 = (extract_bitsM8(hexX, 2, 0) - extract_bitsM8(hexX, 8, 6)) * (extract_bitsM8(hexY, 9, 6) - extract_bitsM8(hexY, 3, 0))
    M8 = (extract_bitsM8(hexX, 4, 2) - extract_bitsM8(hexX, 10, 8)) * (extract_bitsM8(hexY, 9, 6) - extract_bitsM8(hexY, 3, 0))
    M9 = (extract_bitsM8(hexX, 2, 0) - extract_bitsM8(hexX, 8, 6)) * (extract_bitsM8(hexY, 12, 9) - extract_bitsM8(hexY, 6, 3))
    M10 = (extract_bitsM8(hexX, 6, 4) - extract_bitsM8(hexX, 12, 10)) * (extract_bitsM8(hexY, 9, 6) - extract_bitsM8(hexY, 3, 0))
    M11 = (extract_bitsM8(hexX, 4, 2) - extract_bitsM8(hexX, 10, 8)) * (extract_bitsM8(hexY, 12, 9) - extract_bitsM8(hexY, 6, 3))
    M12 = (extract_bitsM8(hexX, 2, 0) - extract_bitsM8(hexX, 14, 12)) * (extract_bitsM8(hexY, 15, 12) - extract_bitsM8(hexY, 3, 0))
    M13 = (extract_bitsM8(hexX, 6, 4) - extract_bitsM8(hexX, 12, 10)) * (extract_bitsM8(hexY, 12, 9) - extract_bitsM8(hexY, 6, 3))
    M14 = (extract_bitsM8(hexX, 4, 2) - extract_bitsM8(hexX, 16, 14)) * (extract_bitsM8(hexY, 15, 12) - extract_bitsM8(hexY, 3, 0))
    M15 = (extract_bitsM8(hexX, 2, 0) - extract_bitsM8(hexX, 14, 12)) * (extract_bitsM8(hexY, 18, 15) - extract_bitsM8(hexY, 6, 3))
    M16 = (extract_bitsM8(hexX, 6, 4) - extract_bitsM8(hexX, 18, 16)) * (extract_bitsM8(hexY, 15, 12) - extract_bitsM8(hexY, 3, 0))
    M17 = (extract_bitsM8(hexX, 16, 14) - extract_bitsM8(hexX, 4, 2)) * (extract_bitsM8(hexY, 6, 3) - extract_bitsM8(hexY, 18, 15))
    M18_1 = (extract_bitsM8(hexX, 14, 12) - extract_bitsM8(hexX, 8, 6)) * (extract_bitsM8(hexY, 9, 6) - extract_bitsM8(hexY, 15, 12))
    M18_2 = (extract_bitsM8(hexX, 20, 18) - extract_bitsM8(hexX, 2, 0)) * (extract_bitsM8(hexY, 3, 0) - extract_bitsM8(hexY, 21, 18))
    M19 = (extract_bitsM8(hexX, 18, 16) - extract_bitsM8(hexX, 6, 4)) * (extract_bitsM8(hexY, 6, 3) - extract_bitsM8(hexY, 18, 15))
    M20_1 = (extract_bitsM8(hexX, 16, 14) - extract_bitsM8(hexX, 10, 8)) * (extract_bitsM8(hexY, 9, 6) - extract_bitsM8(hexY, 15, 12))
    M20_2 = (extract_bitsM8(hexX, 22, 20) - extract_bitsM8(hexX, 4, 2)) * (extract_bitsM8(hexY, 3, 0) - extract_bitsM8(hexY, 21, 18))
    M21_1 = (extract_bitsM8(hexX, 14, 12) - extract_bitsM8(hexX, 8, 6)) * (extract_bitsM8(hexY, 12, 9) - extract_bitsM8(hexY, 18, 15))
    M21_2 = (extract_bitsM8(hexX, 20, 18) - extract_bitsM8(hexX, 2, 0)) * (extract_bitsM8(hexY, 6, 3) - extract_bitsM8(hexY, 24, 21))
    M22_1 = (extract_bitsM8(hexX, 18, 16) - extract_bitsM8(hexX, 12, 10)) * (extract_bitsM8(hexY, 9, 6) - extract_bitsM8(hexY, 15, 12))
    M22_2 = (extract_bitsM8(hexX, 24, 22) - extract_bitsM8(hexX, 6, 4)) * (extract_bitsM8(hexY, 3, 0) - extract_bitsM8(hexY, 21, 18))
    M23_1 = (extract_bitsM8(hexX, 16, 14) - extract_bitsM8(hexX, 10, 8)) * (extract_bitsM8(hexY, 12, 9) - extract_bitsM8(hexY, 18, 15))
    M23_2 = (extract_bitsM8(hexX, 22, 20) - extract_bitsM8(hexX, 4, 2)) * (extract_bitsM8(hexY, 6, 3) - extract_bitsM8(hexY, 24, 21))
    M24_1 = (extract_bitsM8(hexX, 20, 18) - extract_bitsM8(hexX, 8, 6)) * (extract_bitsM8(hexY, 9, 6) - extract_bitsM8(hexY, 21, 18))
    M24_2 = (extract_bitsM8(hexX, 26, 24) - extract_bitsM8(hexX, 2, 0)) * (extract_bitsM8(hexY, 3, 0) - extract_bitsM8(hexY, 27, 24))
    M25_1 = (extract_bitsM8(hexX, 18, 16) - extract_bitsM8(hexX, 12, 10)) * (extract_bitsM8(hexY, 12, 9) - extract_bitsM8(hexY, 18, 15))
    M25_2 = (extract_bitsM8(hexX, 24, 22) - extract_bitsM8(hexX, 6, 4)) * (extract_bitsM8(hexY, 6, 3) - extract_bitsM8(hexY, 24, 21))
    M26_1 = (extract_bitsM8(hexX, 22, 20) - extract_bitsM8(hexX, 10, 8)) * (extract_bitsM8(hexY, 9, 6) - extract_bitsM8(hexY, 21, 18))
    M26_2 = (extract_bitsM8(hexX, 28, 26) - extract_bitsM8(hexX, 4, 2)) * (extract_bitsM8(hexY, 3, 0) - extract_bitsM8(hexY, 27, 24))
    M27_1 = (extract_bitsM8(hexX, 20, 18) - extract_bitsM8(hexX, 8, 6)) * (extract_bitsM8(hexY, 12, 9) - extract_bitsM8(hexY, 24, 21))
    M27_2 = (extract_bitsM8(hexX, 26, 24) - extract_bitsM8(hexX, 2, 0)) * (extract_bitsM8(hexY, 6, 3) - extract_bitsM8(hexY, 30, 27))
    M28_1 = (extract_bitsM8(hexX, 24, 22) - extract_bitsM8(hexX, 12, 10)) * (extract_bitsM8(hexY, 9, 6) - extract_bitsM8(hexY, 21, 18))
    M28_2 = (extract_bitsM8(hexX, 30, 28) - extract_bitsM8(hexX, 6, 4)) * (extract_bitsM8(hexY, 3, 0) - extract_bitsM8(hexY, 27, 24))
    M29_1 = (extract_bitsM8(hexX, 22, 20) - extract_bitsM8(hexX, 10, 8)) * (extract_bitsM8(hexY, 12, 9) - extract_bitsM8(hexY, 24, 21))
    M29_2 = (extract_bitsM8(hexX, 28, 26) - extract_bitsM8(hexX, 4, 2)) * (extract_bitsM8(hexY, 6, 3) - extract_bitsM8(hexY, 30, 27))
    M30_1 = (extract_bitsM8(hexX, 20, 18) - extract_bitsM8(hexX, 14, 12)) * (extract_bitsM8(hexY, 15, 12) - extract_bitsM8(hexY, 21, 18))
    M30_2 = (extract_bitsM8(hexX, 26, 24) - extract_bitsM8(hexX, 8, 6)) * (extract_bitsM8(hexY, 9, 6) - extract_bitsM8(hexY, 27, 24))
    M30_3 = (extract_bitsM8(hexX, 32, 30) - extract_bitsM8(hexX, 2, 0)) * (extract_bitsM8(hexY, 3, 0) - extract_bitsM8(hexY, 32, 30))
    M31_1 = (extract_bitsM8(hexX, 24, 22) - extract_bitsM8(hexX, 12, 10)) * (extract_bitsM8(hexY, 12, 9) - extract_bitsM8(hexY, 24, 21))
    M31_2 = (extract_bitsM8(hexX, 30, 28) - extract_bitsM8(hexX, 6, 4)) * (extract_bitsM8(hexY, 6, 3) - extract_bitsM8(hexY, 30, 27))
    M32_1 = (extract_bitsM8(hexX, 22, 20) - extract_bitsM8(hexX, 10, 8)) * (extract_bitsM8(hexY, 15, 12) - extract_bitsM8(hexY, 27, 24))
    M32_2 = (extract_bitsM8(hexX, 28, 26) - extract_bitsM8(hexX, 4, 2)) * (extract_bitsM8(hexY, 9, 6) - extract_bitsM8(hexY, 32, 30))
    M33_1 = (extract_bitsM8(hexX, 26, 24) - extract_bitsM8(hexX, 14, 12)) * (extract_bitsM8(hexY, 12, 9) - extract_bitsM8(hexY, 24, 21))
    M33_2 = (extract_bitsM8(hexX, 32, 30) - extract_bitsM8(hexX, 8, 6)) * (extract_bitsM8(hexY, 6, 3) - extract_bitsM8(hexY, 30, 27))
    M34_1 = (extract_bitsM8(hexX, 24, 22) - extract_bitsM8(hexX, 12, 10)) * (extract_bitsM8(hexY, 15, 12) - extract_bitsM8(hexY, 27, 24))
    M34_2 = (extract_bitsM8(hexX, 30, 28) - extract_bitsM8(hexX, 6, 4)) * (extract_bitsM8(hexY, 9, 6) - extract_bitsM8(hexY, 32, 30))
    M35_1 = (extract_bitsM8(hexX, 22, 20) - extract_bitsM8(hexX, 16, 14)) * (extract_bitsM8(hexY, 18, 15) - extract_bitsM8(hexY, 24, 21))
    M35_2 = (extract_bitsM8(hexX, 28, 26) - extract_bitsM8(hexX, 10, 8)) * (extract_bitsM8(hexY, 12, 9) - extract_bitsM8(hexY, 30, 27))
    M36_1 = (extract_bitsM8(hexX, 26, 24) - extract_bitsM8(hexX, 14, 12)) * (extract_bitsM8(hexY, 15, 12) - extract_bitsM8(hexY, 27, 24))
    M36_2 = (extract_bitsM8(hexX, 32, 30) - extract_bitsM8(hexX, 8, 6)) * (extract_bitsM8(hexY, 9, 6) - extract_bitsM8(hexY, 32, 30))
    M37_1 = (extract_bitsM8(hexX, 24, 22) - extract_bitsM8(hexX, 18, 16)) * (extract_bitsM8(hexY, 18, 15) - extract_bitsM8(hexY, 24, 21))
    M37_2 = (extract_bitsM8(hexX, 30, 28) - extract_bitsM8(hexX, 12, 10)) * (extract_bitsM8(hexY, 12, 9) - extract_bitsM8(hexY, 30, 27))
    M38_1 = (extract_bitsM8(hexX, 22, 20) - extract_bitsM8(hexX, 16, 14)) * (extract_bitsM8(hexY, 21, 18) - extract_bitsM8(hexY, 27, 24))
    M38_2 = (extract_bitsM8(hexX, 28, 26) - extract_bitsM8(hexX, 10, 8)) * (extract_bitsM8(hexY, 15, 12) - extract_bitsM8(hexY, 32, 30))
    M39_1 = (extract_bitsM8(hexX, 26, 24) - extract_bitsM8(hexX, 20, 18)) * (extract_bitsM8(hexY, 18, 15) - extract_bitsM8(hexY, 24, 21))
    M39_2 = (extract_bitsM8(hexX, 32, 30) - extract_bitsM8(hexX, 14, 12)) * (extract_bitsM8(hexY, 12, 9) - extract_bitsM8(hexY, 30, 27))
    M40_1 = (extract_bitsM8(hexX, 24, 22) - extract_bitsM8(hexX, 18, 16)) * (extract_bitsM8(hexY, 21, 18) - extract_bitsM8(hexY, 27, 24))
    M40_2 = (extract_bitsM8(hexX, 30, 28) - extract_bitsM8(hexX, 12, 10)) * (extract_bitsM8(hexY, 15, 12) - extract_bitsM8(hexY, 32, 30))
    M41 = (extract_bitsM8(hexX, 28, 26) - extract_bitsM8(hexX, 16, 14)) * (extract_bitsM8(hexY, 18, 15) - extract_bitsM8(hexY, 30, 27))
    M42_1 = (extract_bitsM8(hexX, 26, 24) - extract_bitsM8(hexX, 20, 18)) * (extract_bitsM8(hexY, 21, 18) - extract_bitsM8(hexY, 27, 24))
    M42_2 = (extract_bitsM8(hexX, 32, 30) - extract_bitsM8(hexX, 14, 12)) * (extract_bitsM8(hexY, 15, 12) - extract_bitsM8(hexY, 32, 30))
    M43 = (extract_bitsM8(hexX, 30, 28) - extract_bitsM8(hexX, 18, 16)) * (extract_bitsM8(hexY, 18, 15) - extract_bitsM8(hexY, 30, 27))
    M44 = (extract_bitsM8(hexX, 28, 26) - extract_bitsM8(hexX, 16, 14)) * (extract_bitsM8(hexY, 21, 18) - extract_bitsM8(hexY, 32, 30))
    M45 = (extract_bitsM8(hexX, 32, 30) - extract_bitsM8(hexX, 20, 18)) * (extract_bitsM8(hexY, 18, 15) - extract_bitsM8(hexY, 30, 27))
    M46 = (extract_bitsM8(hexX, 30, 28) - extract_bitsM8(hexX, 18, 16)) * (extract_bitsM8(hexY, 21, 18) - extract_bitsM8(hexY, 32, 30))
    M47 = (extract_bitsM8(hexX, 28, 26) - extract_bitsM8(hexX, 22, 20)) * (extract_bitsM8(hexY, 24, 21) - extract_bitsM8(hexY, 30, 27))
    M48 = (extract_bitsM8(hexX, 32, 30) - extract_bitsM8(hexX, 20, 18)) * (extract_bitsM8(hexY, 21, 18) - extract_bitsM8(hexY, 32, 30))
    M49 = (extract_bitsM8(hexX, 30, 28) - extract_bitsM8(hexX, 24, 22)) * (extract_bitsM8(hexY, 24, 21) - extract_bitsM8(hexY, 30, 27))
    M50 = (extract_bitsM8(hexX, 28, 26) - extract_bitsM8(hexX, 22, 20)) * (extract_bitsM8(hexY, 27, 24) - extract_bitsM8(hexY, 32, 30))
    M51 = (extract_bitsM8(hexX, 32, 30) - extract_bitsM8(hexX, 26, 24)) * (extract_bitsM8(hexY, 24, 21) - extract_bitsM8(hexY, 30, 27))
    M52 = (extract_bitsM8(hexX, 30, 28) - extract_bitsM8(hexX, 24, 22)) * (extract_bitsM8(hexY, 27, 24) - extract_bitsM8(hexY, 32, 30))
    M54 = (extract_bitsM8(hexX, 32, 30) - extract_bitsM8(hexX, 26, 24)) * (extract_bitsM8(hexY, 27, 24) - extract_bitsM8(hexY, 32, 30))
    
    # Cycle 2
    S80_0 = Z0 + (Z2 * pow(2, 16)) + (Z3 * pow(2, 24)) + (Z4 * pow(2, 32)) + (Z5 * pow(2, 40))
    S106_48 = M6 + Z0 + Z12 + (Z7 * pow(2, 8)) + (M8 * pow(2, 16)) + (Z2 * pow(2, 16)) + (Z14 * pow(2, 16))
    S122_72 = M9 + Z3 + Z15 + (M10 * pow(2, 8)) + (Z4 * pow(2, 8)) + (Z16 * pow(2, 8))
    S139_88 = M11 + Z5 + Z17 + (Z12 * pow(2, 8)) + (M12 * pow(2, 8)) + (Z0 * pow(2, 8)) + (Z24 * pow(2, 8))
    S155_104 = M13 + Z7 + Z19 + (Z14 * pow(2, 8)) + (M14 * pow(2, 8)) + (Z2 * pow(2, 8)) + (Z26 * pow(2, 8))
    S171_120 = Z15 + M15 + Z3 + Z27 + ((Z16 + M16 + Z4 + Z28) * pow(2, 8))
    S186_136 = Z17 + M17 + Z5 + Z29 + ((M18_1 + Z12 + Z24) * pow(2, 8))
    S195_144 = M18_2 + Z0 + Z36 + ((Z19 + M19 + Z7 + Z31) * pow(2, 8))
    S203_160 = M20_1 + M20_2 + Z14 + Z26 + Z2 + Z38
    S211_168 = M21_1 + M21_2 + Z15 + Z27 + Z3 + Z39
    S219_176 = M22_1 + M22_2 + Z16 + Z28 + Z4 + Z40
    S227_184 = M23_1 + M23_2 + Z17 + Z29 + Z5 + Z41
    S235_192 = M24_1 + M24_2 + Z24 + Z12 + Z36 + Z0 + Z48
    S243_200 = M25_1 + M25_2 + Z19 + Z31 + Z7 + Z43
    S251_208 = M26_1 + M26_2 + Z26 + Z14 + Z38 + Z2 + Z50
    S259_216 = M27_1 + M27_2 + Z27 + Z15 + Z39 + Z3 + Z51
    S267_224 = M28_1 + M28_2 + Z28 + Z16 + Z40 + Z4 + Z52
    S275_232 = M29_1 + M29_2 + Z29 + Z17 + Z41 + Z5 + Z53
    S283_240 = M30_1 + M30_2 + M30_3 + Z0 + Z12 + Z24 + Z36 + Z48 + Z60
    S291_248 = M31_1 + M31_2 + Z31 + Z19 + Z43 + Z7 + Z55
    S299_256 = M32_1 + M32_2 + Z32 + Z20 + Z44 + Z8 + Z56
    S307_264 = M33_1 + M33_2 + Z33 + Z21 + Z45 + Z9 + Z57
    S315_272 = M34_1 + M34_2 + Z34 + Z22 + Z46 + Z10 + Z58
    S323_280 = M35_1 + M35_2 + Z29 + Z41 + Z17 + Z53
    S331_288 = M36_1 + M36_2 + Z36 + Z12 + Z24 + Z48 + Z60
    S339_296 = M37_1 + M37_2 + Z31 + Z43 + Z19 + Z55
    S347_304 = M38_1 + M38_2 + Z32 + Z44 + Z20 + Z56
    S355_312 = M39_1 + M39_2 + Z33 + Z45 + Z21 + Z57
    S363_320 = M40_1 + M40_2 + Z34 + Z46 + Z22 + Z58
    S378_328 = M41 + Z41 + Z29 + Z53 + ((M42_1 + Z36 + Z48) * pow(2, 8))
    S387_336 = M42_2 + Z24 + Z60 + ((M43 + Z43 + Z31 + Z55) * pow(2, 8))
    S403_352 = M44 + Z44 + Z32 + Z56 + ((M45 + Z45 + Z33 + Z57) * pow(2, 8))
    S418_368 = M46 + Z46 + Z34 + Z58 + ((M47 + Z41 + Z53) * pow(2, 8))
    S434_384 = M48 + Z48 + Z36 + Z60 + ((M49 + Z43 + Z55) * pow(2, 8))
    S450_400 = M50 + Z44 + Z56 + ((M51 + Z45 + Z57) * pow(2, 8))
    S465_416 = M52 + Z46 + Z58 + (Z53 * pow(2, 8))
    S489_432 = M54 + Z48 + Z60 + (Z55 * pow(2, 8)) + (Z56 * pow(2, 16))
    S511_456 = Z57 + (Z58 * pow(2, 8)) + (Z60 * pow(2, 24))
    
    # Cycle 3
    S123_0 = S80_0 + (S106_48 * pow(2, 48)) + (S122_72 * pow(2, 72))
    S187_88 = S139_88 + (S155_104 * pow(2, 16)) + (S171_120 * pow(2, 32)) + (S186_136 * pow(2, 48))
    S220_144 = S195_144 + (S203_160 * pow(2, 16)) + (S211_168 * pow(2, 24)) + (S219_176 * pow(2, 32))
    S252_184 = S227_184 + (S235_192 * pow(2, 8)) + (S243_200 * pow(2, 16)) + (S251_208 * pow(2, 24))
    S284_216 = S259_216 + (S267_224 * pow(2, 8)) + (S275_232 * pow(2, 16)) + (S283_240 * pow(2, 24))
    S316_248 = S291_248 + (S299_256 * pow(2, 8)) + (S307_264 * pow(2, 16)) + (S315_272 * pow(2, 24))
    S348_280 = S323_280 + (S331_288 * pow(2, 8)) + (S339_296 * pow(2, 16)) + (S347_304 * pow(2, 24))
    S388_312 = S355_312 + (S363_320 * pow(2, 8)) + (S378_328 * pow(2, 16)) + (S387_336 * pow(2, 24))
    S451_352 = S403_352 + (S418_368 * pow(2, 16)) + (S434_384 * pow(2, 32)) + (S450_400 * pow(2, 48))
    S511_416 = S465_416 + (S489_432 * pow(2, 16)) + (S511_456 * pow(2, 40))
    
    # Cycle 4
    S188_0 = S123_0 + (S187_88 * pow(2, 88))
    S253_144 = S220_144 + (S252_184 * pow(2, 40))
    S317_216 = S284_216 + (S316_248 * pow(2, 32))
    S389_280 = S348_280 + (S388_312 * pow(2, 32))
    S511_352 = S451_352 + (S511_416 * pow(2, 64))
    
    # Cycle 5
    S254_0 = S188_0 + (S253_144 * pow(2, 144))
    S390_216 = S317_216 + (S389_280 * pow(2, 64))
    
    # Cycle 6
    S391_0 = S254_0 + (S390_216 * pow(2, 216))
    
    # Cycle 7
    P_theory = S391_0 + (S511_352 * pow(2, 352))
    
    """
    P_low = Z0 + (Z2 * (1 << 16)) + (Z3 * (1 << 24)) + (Z4 * (1 << 32)) + (Z5 * (1 << 40)) + ((M6 + Z0 + Z12) * (1 << 48)) + (Z7 * (1 << 56)) + ((M8 + Z2 + Z14) * (1 << 64)) + ((M9 + Z3 + Z15) * (1 << 72)) + ((M10 + Z4 + Z16) * (1 << 80)) + ((M11 + Z5 + Z17) * (1 << 88)) + ((M12 + Z12 + Z0 + Z24) * (1 << 96)) + ((M13 + Z7 + Z19) * (1 << 104)) + ((M14 + Z14 + Z2 + Z26) * (1 << 112)) + ((M15 + Z15 + Z3 + Z27) * (1 << 120)) + ((M16 + Z16 + Z4 + Z28) * (1 << 128)) + ((M17 + Z17 + Z5 + Z29) * (1 << 136)) + ((M18_1 + M18_2 + Z0 + Z12 + Z24 + Z36) * (1 << 144)) + ((M19 + Z19 + Z7 + Z31) * (1 << 152)) + ((M20_1 + M20_2 + Z14 + Z26 + Z2 + Z38) * (1 << 160)) + ((M21_1 + M21_2 + Z15 + Z27 + Z3 + Z39) * (1 << 168))
    P_mid = ((M22_1 + M22_2 + Z16 + Z28 + Z4 + Z40) * (1 << 176)) + ((M23_1 + M23_2 + Z17 + Z29 + Z5 + Z41) * (1 << 184)) + ((M24_1 + M24_2 + Z0 + Z12 + Z24 + Z36 + Z48) * (1 << 192)) + ((M25_1 + M25_2 + Z19 + Z31 + Z7 + Z43) * (1 << 200)) + ((M26_1 + M26_2 + Z26 + Z14 + Z38 + Z2 + Z50) * (1 << 208)) + ((M27_1 + M27_2 + Z27 + Z15 + Z39 + Z3 + Z51) * (1 << 216)) + ((M28_1 + M28_2 + Z28 + Z16 + Z40 + Z4 + Z52) * (1 << 224)) + ((M29_1 + M29_2 + Z29 + Z17 + Z41 + Z5 + Z53) * (1 << 232)) + ((M30_1 + M30_2 + M30_3 + Z0 + Z12 + Z24 + Z36 + Z48 + Z60) * (1 << 240)) + ((M31_1 + M31_2 + Z31 + Z19 + Z43 + Z7 + Z55) * (1 << 248)) + ((M32_1 + M32_2 + Z32 + Z20 + Z44 + Z8 + Z56) * (1 << 256)) + ((M33_1 + M33_2 + Z33 + Z21 + Z45 + Z9 + Z57) * (1 << 264))
    P_high = ((M34_1 + M34_2 + Z34 + Z22 + Z46 + Z10 + Z58) * (1 << 272)) + ((M35_1 + M35_2 + Z29 + Z41 + Z17 + Z53) * (1 << 280)) + ((M36_1 + M36_2 + Z36 + Z12 + Z24 + Z48 + Z60) * (1 << 288)) + ((M37_1 + M37_2 + Z31 + Z43 + Z19 + Z55) * (1 << 296)) + ((M38_1 + M38_2 + Z32 + Z44 + Z20 + Z56) * (1 << 304)) + ((M39_1 + M39_2 + Z33 + Z45 + Z21 + Z57) * (1 << 312)) + ((M40_1 + M40_2 + Z34 + Z46 + Z22 + Z58) * (1 << 320)) + ((M41 + Z41 + Z29 + Z53) * (1 << 328)) + ((M42_1 + M42_2 + Z24 + Z36 + Z48 + Z60) * (1 << 336)) + ((M43 + Z43 + Z31 + Z55) * (1 << 344)) + ((M44 + Z44 + Z32 + Z56) * (1 << 352)) + ((M45 + Z45 + Z33 + Z57) * (1 << 360)) + ((M46 + Z46 + Z34 + Z58) * (1 << 368)) + ((M47 + Z41 + Z53) * (1 << 376)) + ((M48 + Z48 + Z36 + Z60) * (1 << 384)) + ((M49 + Z43 + Z55) * (1 << 392)) + ((M50 + Z44 + Z56) * (1 << 400)) + ((M51 + Z45 + Z57) * (1 << 408)) + ((M52 + Z46 + Z58) * (1 << 416)) + (Z53 * (1 << 424)) + ((M54 + Z48 + Z60) * (1 << 432)) + (Z55 * (1 << 440)) + (Z56 * (1 << 448)) + (Z57 * (1 << 456)) + (Z58 * (1 << 464)) + (Z60 * (1 << 480))
    
    P = P_low + P_mid + P_high
    print(f"Karatsuba Product taken from individual Z's and M's: {hex(P)[2:]}")
    
    # Store all Z values in a dictionary
    z_values = {
        'Z0': Z0, 'Z2': Z2, 'Z3': Z3, 'Z4': Z4, 'Z5': Z5, 'Z7': Z7,
        'Z8': Z8, 'Z9': Z9, 'Z10': Z10, 'Z12': Z12, 'Z14': Z14, 'Z15': Z15,
        'Z16': Z16, 'Z17': Z17, 'Z19': Z19, 'Z20': Z20, 'Z21': Z21, 'Z22': Z22,
        'Z24': Z24, 'Z26': Z26, 'Z27': Z27, 'Z28': Z28, 'Z29': Z29, 'Z31': Z31,
        'Z32': Z32, 'Z33': Z33, 'Z34': Z34, 'Z36': Z36, 'Z38': Z38, 'Z39': Z39,
        'Z40': Z40, 'Z41': Z41, 'Z43': Z43, 'Z44': Z44, 'Z45': Z45, 'Z46': Z46,
        'Z48': Z48, 'Z50': Z50, 'Z51': Z51, 'Z52': Z52, 'Z53': Z53, 'Z55': Z55,
        'Z56': Z56, 'Z57': Z57, 'Z58': Z58, 'Z60': Z60
    }
    
    z_values = getHex(z_values)
    
    # Print all Z values
    print("\nZ Values:")
    for key in sorted(z_values.keys(), key=lambda x: int(x[1:])):
        print(f"{key} = {z_values[key]}")
    
    
    m_values = {
        'M6': M6, 'M8': M8, 'M9': M9, 'M10': M10, 'M11': M11, 'M12': M12,
        'M13': M13, 'M14': M14, 'M15': M15, 'M16': M16, 'M17': M17,
        'M18_1': M18_1, 'M18_2': M18_2, 'M19': M19,
        'M20_1': M20_1, 'M20_2': M20_2,
        'M21_1': M21_1, 'M21_2': M21_2,
        'M22_1': M22_1, 'M22_2': M22_2,
        'M23_1': M23_1, 'M23_2': M23_2,
        'M24_1': M24_1, 'M24_2': M24_2,
        'M25_1': M25_1, 'M25_2': M25_2,
        'M26_1': M26_1, 'M26_2': M26_2,
        'M27_1': M27_1, 'M27_2': M27_2,
        'M28_1': M28_1, 'M28_2': M28_2,
        'M29_1': M29_1, 'M29_2': M29_2,
        'M30_1': M30_1, 'M30_2': M30_2, 'M30_3': M30_3,
        'M31_1': M31_1, 'M31_2': M31_2,
        'M32_1': M32_1, 'M32_2': M32_2,
        'M33_1': M33_1, 'M33_2': M33_2,
        'M34_1': M34_1, 'M34_2': M34_2,
        'M35_1': M35_1, 'M35_2': M35_2,
        'M36_1': M36_1, 'M36_2': M36_2,
        'M37_1': M37_1, 'M37_2': M37_2,
        'M38_1': M38_1, 'M38_2': M38_2,
        'M39_1': M39_1, 'M39_2': M39_2,
        'M40_1': M40_1, 'M40_2': M40_2,
        'M41': M41,
        'M42_1': M42_1, 'M42_2': M42_2,
        'M43': M43, 'M44': M44, 'M45': M45, 'M46': M46, 'M47': M47,
        'M48': M48, 'M49': M49, 'M50': M50, 'M51': M51, 'M52': M52,
        'M54': M54
    }
    m_values = getHex(m_values)

    # Print all M values
    print("\nM Values:")
    for key in sorted(m_values.keys(), key=lambda x: (int(x.split('_')[0][1:]), x.split('_')[1] if '_' in x else '')):
        print(f"{key} = {m_values[key]}")
    
    print(f"S80_0 = {hex(S80_0)[2:]}")
    print(f"S106_48 = {hex(S106_48)[2:]}")
    print(f"S122_72 = {hex(S122_72)[2:]}")
    print(f"S139_88 = {hex(S139_88)[2:]}")
    print(f"S155_104 = {hex(S155_104)[2:]}")
    print(f"S171_120 = {hex(S171_120)[2:]}")
    print(f"S186_136 = {hex(S186_136)[2:]}")
    print(f"S195_144 = {hex(S195_144)[2:]}")
    print(f"S203_160 = {hex(S203_160)[2:]}")
    print(f"S211_168 = {hex(S211_168)[2:]}")
    print(f"S219_176 = {hex(S219_176)[2:]}")
    print(f"S227_184 = {hex(S227_184)[2:]}")
    print(f"S235_192 = {hex(S235_192)[2:]}")
    print(f"S243_200 = {hex(S243_200)[2:]}")
    print(f"S251_208 = {hex(S251_208)[2:]}")
    print(f"S259_216 = {hex(S259_216)[2:]}")
    print(f"S267_224 = {hex(S267_224)[2:]}")
    print(f"S275_232 = {hex(S275_232)[2:]}")
    print(f"S283_240 = {hex(S283_240)[2:]}")
    print(f"S291_248 = {hex(S291_248)[2:]}")
    print(f"S299_256 = {hex(S299_256)[2:]}")
    print(f"S307_264 = {hex(S307_264)[2:]}")
    print(f"S315_272 = {hex(S315_272)[2:]}")
    print(f"S323_280 = {hex(S323_280)[2:]}")
    print(f"S331_288 = {hex(S331_288)[2:]}")
    print(f"S339_296 = {hex(S339_296)[2:]}")
    print(f"S347_304 = {hex(S347_304)[2:]}")
    print(f"S355_312 = {hex(S355_312)[2:]}")
    print(f"S363_320 = {hex(S363_320)[2:]}")
    print(f"S378_328 = {hex(S378_328)[2:]}")
    print(f"S387_336 = {hex(S387_336)[2:]}")
    print(f"S403_352 = {hex(S403_352)[2:]}")
    print(f"S418_368 = {hex(S418_368)[2:]}")
    print(f"S434_384 = {hex(S434_384)[2:]}")
    print(f"S450_400 = {hex(S450_400)[2:]}")
    print(f"S465_416 = {hex(S465_416)[2:]}")
    print(f"S489_432 = {hex(S489_432)[2:]}")
    print(f"S511_456 = {hex(S511_456)[2:]}")
    
    print(f"S123_0 = {hex(S123_0)[2:]}")
    print(f"S187_88 = {hex(S187_88)[2:]}")
    print(f"S220_144 = {hex(S220_144)[2:]}")
    print(f"S252_184 = {hex(S252_184)[2:]}")
    print(f"S284_216 = {hex(S284_216)[2:]}")
    print(f"S316_248 = {hex(S316_248)[2:]}")
    print(f"S348_280 = {hex(S348_280)[2:]}")
    print(f"S388_312 = {hex(S388_312)[2:]}")
    print(f"S451_352 = {hex(S451_352)[2:]}")
    print(f"S511_416 = {hex(S511_416)[2:]}")
    """
    
    print(f"P = {hex(product)[2:]}")

    #return z_values
    #return P_theory, product

def check(X: int, Y:int):
    
    print(f"Real Product: {hex(X*Y)[2:]}")
    
    hexX = format(X, '064x')
    hexY = format(Y, '064x')
    
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
    Z16 = extract_mult(4, 12) + extract_mult(10, 6) + extract_mult(16, 0)
    Z17 = extract_mult(2, 15) + extract_mult(8, 9) + extract_mult(14, 3)
    Z18 = extract_mult(0, 18) + extract_mult(6, 12) + extract_mult(12, 6) + extract_mult(18, 0)
    Z19 = extract_mult(4, 15) + extract_mult(10, 9) + extract_mult(16, 3)
    Z20 = extract_mult(2, 18) + extract_mult(8, 12) + extract_mult(14, 6) + extract_mult(20, 0)
    Z21 = extract_mult(0, 21) + extract_mult(6, 15) + extract_mult(12, 9) + extract_mult(18, 3)
    Z22 = extract_mult(4, 18) + extract_mult(10, 12) + extract_mult(16, 6) + extract_mult(22, 0)
    Z23 = extract_mult(2, 21) + extract_mult(8, 15) + extract_mult(14, 9) + extract_mult(20, 3)
    Z24 = extract_mult(0, 24) + extract_mult(6, 18) + extract_mult(12, 12) + extract_mult(18, 6) + extract_mult(24, 0)
    Z25 = extract_mult(4, 21) + extract_mult(10, 15) + extract_mult(16, 9) + extract_mult(22, 3)
    Z26 = extract_mult(2, 24) + extract_mult(8, 18) + extract_mult(14, 12) + extract_mult(20, 6) + extract_mult(26, 0)
    Z27 = extract_mult(0, 27) + extract_mult(6, 21) + extract_mult(12, 15) + extract_mult(18, 9) + extract_mult(24, 3)
    Z28 = extract_mult(4, 24) + extract_mult(10, 18) + extract_mult(16, 12) + extract_mult(22, 6) + extract_mult(28, 0)
    Z29 = extract_mult(2, 27) + extract_mult(8, 21) + extract_mult(14, 15) + extract_mult(20, 9) + extract_mult(26, 3)
    Z30 = extract_mult(0, 30) + extract_mult(6, 24) + extract_mult(12, 18) + extract_mult(18, 12) + extract_mult(24, 6) + extract_mult(30, 0)
    Z31 = extract_mult(4, 27) + extract_mult(10, 21) + extract_mult(16, 15) + extract_mult(22, 9) + extract_mult(28, 3)
    Z32 = extract_mult(2, 30) + extract_mult(8, 24) + extract_mult(14, 18) + extract_mult(20, 12) + extract_mult(26, 6)
    Z33 = extract_mult(6, 27) + extract_mult(12, 21) + extract_mult(18, 15) + extract_mult(24, 9) + extract_mult(30, 3)
    Z34 = extract_mult(4, 30) + extract_mult(10, 24) + extract_mult(16, 18) + extract_mult(22, 12) + extract_mult(28, 6)
    Z35 = extract_mult(8, 27) + extract_mult(14, 21) + extract_mult(20, 15) + extract_mult(26, 9)
    Z36 = extract_mult(6, 30) + extract_mult(12, 24) + extract_mult(18, 18) + extract_mult(24, 12) + extract_mult(30, 6)
    Z37 = extract_mult(10, 27) + extract_mult(16, 21) + extract_mult(22, 15) + extract_mult(28, 9)
    Z38 = extract_mult(8, 30) + extract_mult(14, 24) + extract_mult(20, 18) + extract_mult(26, 12)
    Z39 = extract_mult(12, 27) + extract_mult(18, 21) + extract_mult(24, 15) + extract_mult(30, 9)
    Z40 = extract_mult(10, 30) + extract_mult(16, 24) + extract_mult(22, 18) + extract_mult(28, 12)
    Z41 = extract_mult(14, 27) + extract_mult(20, 21) + extract_mult(26, 15)
    Z42 = extract_mult(12, 30) + extract_mult(18, 24) + extract_mult(24, 18) + extract_mult(30, 12)
    Z43 = extract_mult(16, 27) + extract_mult(22, 21) + extract_mult(28, 15)
    Z44 = extract_mult(14, 30) + extract_mult(20, 24) + extract_mult(26, 18)
    Z45 = extract_mult(18, 27) + extract_mult(24, 21) + extract_mult(30, 15)
    Z46 = extract_mult(16, 30) + extract_mult(22, 24) + extract_mult(28, 18)
    Z47 = extract_mult(20, 27) + extract_mult(26, 21)
    Z48 = extract_mult(18, 30) + extract_mult(24, 24) + extract_mult(30, 18)
    Z49 = extract_mult(22, 27) + extract_mult(28, 21)
    Z50 = extract_mult(20, 30) + extract_mult(26, 24)
    Z51 = extract_mult(24, 27) + extract_mult(30, 21)
    Z52 = extract_mult(22, 30) + extract_mult(28, 24)
    Z53 = extract_mult(26, 27)
    Z54 = extract_mult(30, 24) + extract_mult(24, 30)
    Z55 = extract_mult(28, 27)
    Z56 = extract_mult(26, 30)
    Z57 = extract_mult(30, 27)
    Z58 = extract_mult(28, 30)
    Z60 = extract_mult(30, 30)
    
    productKaratsuba = (Z0 + (Z2  << (2*8)) + (Z3  << (3*8)) + (Z4  << (4*8)) + (Z5  << (5*8)) + (Z6  << (6*8)) + (Z7  << (7*8)) + (Z8  << (8*8)) + (Z9  << (9*8)) + (Z10 << (10*8)) + (Z11 << (11*8)) + (Z12 << (12*8)) + (Z13 << (13*8)) + (Z14 << (14*8)) + (Z15 << (15*8)) + (Z16 << (16*8)) + (Z17 << (17*8)) + (Z18 << (18*8)) + (Z19 << (19*8))  + (Z20 << (20*8)) + (Z21 << (21*8)) + (Z22 << (22*8)) + (Z23 << (23*8)) + (Z24 << (24*8)) + (Z25 << (25*8)) + (Z26 << (26*8)) + (Z27 << (27*8)) + (Z28 << (28*8)) + (Z29 << (29*8)) + (Z30 << (30*8)) + (Z31 << (31*8)) + (Z32 << (32*8)) + (Z33 << (33*8)) + (Z34 << (34*8)) + (Z35 << (35*8)) + (Z36 << (36*8)) + (Z37 << (37*8)) + (Z38 << (38*8)) + (Z39 << (39*8)) + (Z40 << (40*8)) + (Z41 << (41*8)) + (Z42 << (42*8)) + (Z43 << (43*8)) + (Z44 << (44*8)) + (Z45 << (45*8)) + (Z46 << (46*8)) + (Z47 << (47*8)) + (Z48 << (48*8)) + (Z49 << (49*8)) + (Z50 << (50*8)) + (Z51 << (51*8)) + (Z52 << (52*8)) + (Z53 << (53*8)) + (Z54 << (54*8)) + (Z55 << (55*8)) + (Z56 << (56*8)) + (Z57 << (57*8)) + (Z58 << (58*8)) + (Z60 << (60*8)))
    
    print(f"Karatsuba Product: {hex(productKaratsuba)[2:]}")

 
# Example usage
if __name__ == "__main__":
    # Test vectors from testbench
    test_cases = [
        (
            0x0123456789ABCDEF_FEDCBA9876543210_0F0F0F0F0F0F0F0F_F0F0F0F0F0F0F0F0,
            0x89ABCDEF01234567_76543210FEDCBA98_A5A5A5A5A5A5A5A5_5A5A5A5A5A5A5A5A
        ),
        (
            0xFFFFFFFFFFFFFFFF_0000000000000000_1234567890ABCDEF_0FEDCBA098765432,
            0x0000000000000001_FFFFFFFFFFFFFFFF_FFFFFFFFFFFFFFFE_0000000000000002
        ),
        (
            0xAAAAAAAAAAAAAAAA_5555555555555555_DEADBEEFCAFEBABE_0123456789ABCDEF,
            0x13579BDF2468ACE0_0F0E0D0C0B0A0908_FEDCBA9876543210_1111111111111111
        ),
        (
            0x0001020304050607_08090A0B0C0D0E0F_1011121314151617_18191A1B1C1D1E1F,
            0xFFEEDDCCBBAA9988_7766554433221100_FF00FF00FF00FF00_00FF00FF00FF00FF
        ),
        (
            0x7FFFFFFFFFFFFFFF_8000000000000000_0000000000000001_FFFFFFFFFFFFFFFE,
            0x3C3C3C3C3C3C3C3C_C3C3C3C3C3C3C3C3_AAAAAAAAAAAAAAAA_5555555555555555
        ),
        (
            0xCAFEBABEDEADBEEF_FEEDFACE12345678_87654321ABCDEF01_0BADF00DDEADC0DE,
            0x0D15EA5EBAADF00D_0123456789ABCDEF_FFFFFFFFFFFFFFFF_0000000000000000
        ),
        (
            0xFFFFFFFF00000000_FFFFFFFF00000000_00000000FFFFFFFF_00000000FFFFFFFF,
            0x1111111122222222_3333333344444444_5555555566666666_7777777788888888
        ),
        (
            0x13579BDF13579BDF_2468ACE02468ACE0_0F1E2D3C4B5A6978_8697A5B4C3D2E1F0,
            0xFEDCBA9876543210_0123456789ABCDEF_89ABCDEF01234567_76543210FEDCBA98
        ),
        (
            0xAAAAAAAA00000000_55555555FFFFFFFF_DEADBEEF00000000_CAFEBABEFFFFFFFF,
            0x00000000FFFFFFFF_FFFFFFFF00000000_123456789ABCDEF0_0FEDCBA987654321
        ),
        (
            0x0123456789ABCDEF_0011223344556677_8899AABBCCDDEEFF_FFEEDDCCBBAA9988,
            0xF0F1F2F3F4F5F6F7_0807060504030201_1020304050607080_90A0B0C0D0E0F000
        )
    ]
    
    print("=" * 80)
    print("Karatsuba 256-bit Multiplier - 10 Test Cases")
    print("=" * 80)
    
    for i, (X, Y) in enumerate(test_cases):
        print(f"\nTest Case {i}:")
        print(f"X = 0x{X:064X}")
        print(f"Y = 0x{Y:064X}")
        
        # Calculate expected product
        expected = X * Y
        #print(f"Product = 0x{expected:0128X}")
        
        # Also run through the findParts function to verify
        findParts(X, Y)
        print("-" * 80)