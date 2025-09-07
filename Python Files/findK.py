import random
import math

def findKvalues(length = 256, output_file=""):
    """
    
    Find the values for MK1 and MK2

    Args:
        length (int, optional): Length of X, Y, Q. Defaults to 256.
        output_file (str, optional): File to write data to. Defaults to "".
    """
    random.seed(42)
    modulus = random.getrandbits(length)
    binary_modulus = bin(modulus)[2:]
    #print(binary_modulus)
    bitwidth = len(binary_modulus)
    while bitwidth < 256:
        binary_modulus = "1" + binary_modulus
        bitwidth += 1
    
    modulus = int(binary_modulus, 2)
    print(f"Modulus - {modulus}")
    print(f"Binary length - {len(binary_modulus)}")
    
    lines = []
    
    for P in range(16):
        Pfine = P * (2**255)
        K1 = math.floor(Pfine/modulus)
        K2 = K1 + 1
        
        MK1 = modulus * K1
        MK2 = modulus * K2
        print(f"P - {P} |  K1 - {K1} | K2 - {K2}")
        
        hexK1 = hex(MK1)[2:] + ","
        hexK2 = hex(MK2)[2:] + ","
        #print(len(hexK1)-1)
        #print(len(hexK2)-1)
        #lines.append(hexK1)
        lines.append(hexK2)
        
    with open(output_file, "w") as f:
        for line in lines:
            f.write(line + "\n")

if __name__ == "__main__":
    findKvalues(256,"Pfine_values.coe")