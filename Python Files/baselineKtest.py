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
    
def extract_bits(bin_str, high, low):
    total_bits = len(bin_str)
    
    bin_value = bin_str[(total_bits - high) : (total_bits - low)]
    return int(bin_value, 2) if bin_value else 0

def baselineKaratsuba(X, Y):
    
    binX = bin(X)[2:]
    binY = bin(Y)[2:]
    
    P0 = extract_bits(binX, 26, 0) * extract_bits(binY, 26, 0)
    P1 = extract_bits(binX, 52, 26) * extract_bits(binY, 52, 26)
    P2 = extract_bits(binX, 78, 52) * extract_bits(binY, 78, 52)
    P3 = extract_bits(binX, 104, 78) * extract_bits(binY, 104, 78)
    P4 = extract_bits(binX, 130, 104) * extract_bits(binY, 130, 104)
    
    M10 = (extract_bits(binX, 52, 26) - extract_bits(binX, 26, 0)) * (extract_bits(binY, 52, 26) - extract_bits(binY, 26, 0))
    M21 = (extract_bits(binX, 78, 52) - extract_bits(binX, 52, 26)) * (extract_bits(binY, 78, 52) - extract_bits(binY, 52, 26))
    M20 = (extract_bits(binX, 78, 52) - extract_bits(binX, 26, 0)) * (extract_bits(binY, 78, 52) - extract_bits(binY, 26, 0))
    M32 = (extract_bits(binX, 104, 78) - extract_bits(binX, 78, 52)) * (extract_bits(binY, 104, 78) - extract_bits(binY, 78, 52))
    M31 = (extract_bits(binX, 104, 78) - extract_bits(binX, 52, 26)) * (extract_bits(binY, 104, 78) - extract_bits(binY, 52, 26))
    M30 = (extract_bits(binX, 104, 78) - extract_bits(binX, 26, 0)) * (extract_bits(binY, 104, 78) - extract_bits(binY, 26, 0))
    M43 = (extract_bits(binX, 130, 104) - extract_bits(binX, 104, 78)) * (extract_bits(binY, 130, 104) - extract_bits(binY, 104, 78))
    M42 = (extract_bits(binX, 130, 104) - extract_bits(binX, 78, 52)) * (extract_bits(binY, 130, 104) - extract_bits(binY, 78, 52))
    M41 = (extract_bits(binX, 130, 104) - extract_bits(binX, 52, 26)) * (extract_bits(binY, 130, 104) - extract_bits(binY, 52, 26))
    M40 = (extract_bits(binX, 130, 104) - extract_bits(binX, 26, 0)) * (extract_bits(binY, 130, 104) - extract_bits(binY, 26, 0))
    
    
    # Cycle 3
    S01 = P0 + P1
    S23 = P2 + P3
    S34 = P3 + P4
    S14 = P1 + P4
    
    # Cycle 4
    T1K = S01 - M10
    S012 = S01 + P2
    S0123 = S01 + S23
    
    M4 = M31 + M40
    M3 = M30 + M21
    
    