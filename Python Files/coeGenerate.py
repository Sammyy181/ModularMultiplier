import random

def generate_bits(output_file = "", power=256, modulus = 0):
    """
    Generate the modulus of (2^(power)*P) mod M for P in range(0,128), change 128 to whatever range you want in line 30
    """
    #print(f"Modulus in binary - {binary_modulus}")
    #print(f"Length of number - {len(binary_modulus)}")
    
    """with open(output_file, "") as file:
        lines = file.read().split("\n")"""
    
    #print(lines)
    lines = []
    
    lines.append(f'; Stores modulus values for (2^({power})*P) mod M - indexes P[{power+8}:{power}]')
    lines.append('; 9 address bits, outputs 256 bits')
    lines.append('')
    lines.append('memory_initialization_radix=16;')
    lines.append('memory_initialization_vector=')
    
    for P in range(512):
        prod = P * (2**power)
        remainder = prod % modulus
        hex_rem = hex(remainder)[2:] + ","
        #print(hex_rem)
        lines.append(hex_rem)
    
    lines[-1] = lines[-1][:-1]
    #print(lines)
    
    with open(output_file, "w") as f:
        for line in lines:
            f.write(line + "\n")
    
    print(f"Coefficient File for power {power} and modulus {hex(modulus)[2:]} generated")

    #rem = (P * (2**power)) % modulus
    #print(f"Remainder for P = 0 - {rem}")
    
if __name__ == "__main__":   
    length = 256 
    random.seed(42)
    modulus = random.getrandbits(length)
    binary_modulus = format(modulus, "0b")
    bitwidth = len(binary_modulus)
    while bitwidth < 256:
        binary_modulus = "1" + binary_modulus
        bitwidth += 1
    
    modulus = int(binary_modulus, 2)
    
    for power in range(256, 384, 9):
        output_file = f"coarse_{power}.coe"
    
        generate_bits(output_file=output_file,power=power, modulus=modulus)