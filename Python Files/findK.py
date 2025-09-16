import random
import math

def findKvalues(modulus = 0,output_file1 = "", output_file2 = ""):
    """
    
    Find the values for MK1 and MK2

    Args:
        length (int, optional): Length of X, Y, Q. Defaults to 256.
        output_file (str, optional): File to write data to. Defaults to "".
    """
    
    lines1 = []
    lines2 = []
    
    lines1.append('; File to store values for M * K1')
    lines1.append('; 5 address bits, 256 bits wide')
    lines1.append('')
    lines1.append('memory_initialization_radix=16;')
    lines1.append('memory_initialization_vector=')
    
    lines2.append('; File to store values for M * K2')
    lines2.append('; 5 address bits, 256 bits wide')
    lines2.append('')
    lines2.append('memory_initialization_radix=16;')
    lines2.append('memory_initialization_vector=')
    
    for P in range(32):
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
        lines1.append(hexK1)
        lines2.append(hexK2)
    
    lines1[-1] = lines1[-1][:-1]
    lines2[-1] = lines2[-1][:-1]
        
    with open(output_file1, "w") as f:
        for line in lines1:
            f.write(line + "\n")
    
    with open(output_file2, "w") as f:
        for line in lines2:
            f.write(line + "\n")

if __name__ == "__main__":
    length = 256
    random.seed(42)
    modulus = random.getrandbits(length)
    binary_modulus = bin(modulus)[2:]
    #print(binary_modulus)
    bitwidth = len(binary_modulus)
    while bitwidth < 256:
        binary_modulus = "1" + binary_modulus
        bitwidth += 1
    
    modulus = int(binary_modulus, 2)
    print(f"Modulus - {hex(modulus)[2:]}")
    
    findKvalues(modulus=modulus,output_file1="MK1values.coe",output_file2="MK2values.coe")