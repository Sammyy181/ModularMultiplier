import random
import math

class ModularMultiplier():
    """
        Software Implementation of Modular Multiplier
    """
    def __init__(self, modulus):
        self.modulus = modulus
        self.bin_mod = bin(modulus)[2:]
        
    def mult(self, x, y):
        self.P0 = x*y
        #print(f"Length of P0 - {len(bin(self.P0)) - 2}")
        #print(f"Multiplication value - {hex(self.P0)}")
        
    def get_parts(self, P, Plen, L=0):
        binP = bin(P)[2:]
        
        while(len(binP) < Plen):
            binP = '0' + binP
        
        binP_H = binP[0:L]
        binP_L = binP[L:]
        
        P_H = int(binP_H, 2)
        P_L = int(binP_L, 2)
        
        return P_H, P_L
    
    def folding1(self):
        P0_H, P0_L = self.get_parts(P=self.P0, Plen=512, L=128)
        
        C0 = (2**384) % self.modulus
        #print(f"C0 - {hex(C0)}")
        C0PH = C0 * P0_H
        #print(f"C0 * PH = {hex(C0PH)[2:]}")
        #print(f"storeLSB value - {hex(P0_L)[2:]}")
        #print(f"In first folding, bit length of C0 * P0_H is {len(bin(C0PH)) - 2}")
        
        self.P1 = C0PH + P0_L
        #print(f"Value after first folding - {hex(self.P1)}")
        #print(f"Length of P1 - {len(hex(self.P1)) - 2}")
    
    def folding2(self):
        P1H, P1L = self.get_parts(P=self.P1, Plen=385, L=65)
        
        C1 = (2**320) % self.modulus
        C1PH = C1 * P1H
        #print(f"P1L - {hex(P1L)}")
        #print(f"In second folding, bit length of C1 * P1_H is {len(bin(C1PH)) - 2}")

        self.P2 = C1PH + P1L
        #print(f"Value after second folding - {hex(self.P2)}")
        #print(f"Length of P2 - {len(bin(self.P2)) - 2}")
        
    def folding3(self):
        P2H, P2L = self.get_parts(P=self.P2, Plen=322, L=33)

        C2 = (2**289) % self.modulus
        C2PH = C2 * P2H
        #print(f"In third folding, bit length of C2 * P2_H is {len(bin(C2PH)) - 2}")

        self.P3 = C2PH + P2L

        binP3 = bin(self.P3)[2:]
        while len(binP3) < 290:
            binP3 = '0' + binP3
        self.P3 = int(binP3, 2)

        #print(f"Length of P3 - {len(bin(self.P3)) - 2}")
        #print(f"Value after third folding - {hex(self.P3)}")

    
    def coarse_grain(self):
        n = len(bin(self.modulus)) - 2  
        beta = 9                       

        binP3 = bin(self.P3)[2:]
        binP3 = binP3.rjust(len(binP3), '0')  

        excess = len(binP3) - n
        if excess <= 0:
            self.Pcoarse = self.P3
            return

        c = (excess + beta - 1) // beta

        top_bits = binP3[:excess].rjust(c * beta, '0')

        chunks = [int(top_bits[i*beta:(i+1)*beta], 2) for i in range(c)]

        Pbase = int(binP3[excess:], 2)

        self.Pcoarse = Pbase
        for i, chunk in enumerate(chunks):
            exp = n + (c - 1 - i) * beta
            term = (pow(2, exp, self.modulus) * chunk) % self.modulus
            self.Pcoarse = (self.Pcoarse + term) % self.modulus

        #print(f"After coarse grain reduction, length of P becomes {len(bin(self.Pcoarse)) - 2}")

    
    def findK(self):
        Plen = len(bin(self.Pcoarse)) - 2
        bin_Pcoarse = bin(self.Pcoarse)[2:]
        
        while Plen < 259:
            bin_Pcoarse = '0' + bin_Pcoarse
            Plen += 1
        
        gamma = bin_Pcoarse[:4]
        gamma = int(gamma,2) * (2**255)
        
        self.K1 = math.floor(gamma/self.modulus)
        #print(f"Value of K1: {self.K1}")
        
    def fine_grain(self):
        self.findK()
        
        Q1 = self.Pcoarse - (self.modulus * self.K1)
        Q2 = self.Pcoarse - (self.modulus * (self.K1 + 1))
        
        self.Q = Q1 if Q2<0 else Q2
        #print(f"Q2: {Q2}")
        #print(f"Modulus according to paper: {self.Q}")
    
def main():
    random.seed(42)
    modulus = random.getrandbits(256)
    binary_modulus = bin(modulus)[2:]
    
    bitwidth = len(binary_modulus)
    while bitwidth < 256:
        binary_modulus = "1" + binary_modulus
        bitwidth += 1
    
    modulus = int(binary_modulus, 2)
    print(f"Modulus - {modulus}")
    
    sample = ModularMultiplier(modulus)
    X = random.getrandbits(256)
    Y = random.getrandbits(256)

    #print(f"Values\nX: {X}\nY: {Y}")
    print(f"X in hex: {hex(X)}")
    print(f"Y in hex: {hex(Y)}")
    calculated_mod = (X*Y) % modulus
    calculated_mod = hex(calculated_mod)
    print(f"Theoretical Q = {calculated_mod}")
    
    sample.mult(X,Y)
    sample.folding1()
    sample.folding2()
    sample.folding3()
    sample.coarse_grain()
    sample.fine_grain()
    
    #print(f"Error: {sample.Q - calculated_mod}")

if __name__ == "__main__":
    main()