import random

def findC(length=256, p=0):
    """
    
    Code to find the modulus of 2^(length + shift) mod M

    Args:
        length (int, optional): Length of X, Y, Q. Defaults to 256.
        p (int, optional): Additional Length to find the shift value. Defaults to 0.
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
    print(f"Modulus in binary - {(binary_modulus)}")
    
    C = (2**(p+length)) % modulus
    print(f"Value of C is {C}")
    hexC = hex(C)[2:]
    print(hexC)
    print(f"Length of C - {len(hexC)}")
    
if __name__ == "__main__":
    power = 33
    findC(length=256, p=power)