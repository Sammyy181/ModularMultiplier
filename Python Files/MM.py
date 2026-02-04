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
        
        binC = bin(C0)[2:].zfill(256)
        hexC = hex(int(binC,2))[2:]
        C0_ = int(binC[192:],2)
        C1 = int(binC[128:192],2)
        C2 = int(binC[64:128],2)
        C3 = int(binC[:64],2)
        
        Y1Y0 = C0_ + C1
        Y2Y0 = C2 + C0_
        Y2Y1 = C2 + C1
        Y3Y0 = C3 + C0_
        Y3Y1 = C3 + C1
        
        binX = bin(P0_H)[2:]
        X1X0 = int(binX[:64],2) + int(binX[64:],2)
        
        #print(f"X = {hex(P0_H)[2:]}")
        #print(f"Y = {hexC[32:]}")
        #print(f"X1X0 = {hex(X1X0)[2:]}")
        #print(f"Y1Y0 = {hex(Y1Y0)[2:]}")
        #print(f"Y2Y0 = {hex(Y2Y0)[2:]}")
        #print(f"Y2Y1 = {hex(Y2Y1)[2:]}")
        #print(f"Y3Y0 = {hex(Y3Y0)[2:]}")
        #print(f"Y3Y1 = {hex(Y3Y1)[2:]}")
        
        C0PH = C0 * P0_H
        
        self.P1 = C0PH + P0_L
        #print(f"redP = {hex(C0PH)[2:]}")

        #print(f"Value after first folding - {hex(self.P1)[2:]}")
        #print(f"coarseGrainlow = {hex(self.P1)[-64:]}")

        foldLow = (C0PH % (2**192)) + (P0_L % (2**192))
        foldHigh = (C0PH // (2**192)) + (P0_L // (2**192))

        #print(f"foldLow - {hex(foldLow)[2:]}")
        #print(f"foldHigh - {hex(foldHigh)[2:]}")

    
    def coarse_grain(self):
        n = 256
        beta = 9

        binP1 = bin(self.P1)[2:]
        binP1 = binP1.rjust(391, '0')

        c = 15
        chunks = []

        for i in range (c):
            chunks.append(int(binP1[i*beta:(i+1)*beta],2))
        
        #print(chunks)
        chunks.reverse()

        self.Pcoarse = int(binP1[-256:],2)

        for i, chunk in enumerate(chunks):
            exp = 256 + (i * beta)
            partTerm = ((2**exp) * chunk) % self.modulus
            #print(f"Term Number {i+1} - {hex(partTerm)[2:]}")
            self.Pcoarse += partTerm

        #print(f"Pcoarse = {hex(self.Pcoarse)[2:]}")
        #print(f"Check - {hex(self.Pcoarse % self.modulus)}")

    
    def findK(self):
        Plen = len(bin(self.Pcoarse)) - 2
        bin_Pcoarse = bin(self.Pcoarse)[2:]
        
        while Plen < 260:
            bin_Pcoarse = '0' + bin_Pcoarse
            Plen += 1
        
        gamma = bin_Pcoarse[:5]
        gamma = int(gamma,2) * (2**255)
        
        self.K1 = math.floor(gamma/self.modulus)
        #print(f"Value of K1: {self.K1}")
        
    def fine_grain(self):
        self.findK()
        
        Q1 = self.Pcoarse - (self.modulus * self.K1)
        Q2 = self.Pcoarse - (self.modulus * (self.K1 + 1))
        
        self.Q = Q1 if Q2<0 else Q2
        #print(f"Q2: {Q2}")
        #print(f"Modulus according to paper: {hex(self.Q)[2:]}")

def to_little_endian(hex_str):
    hex_str = hex_str.strip().replace(" ", "").replace("\n", "")
    
    if len(hex_str) % 2 != 0:
        raise ValueError("Hex string length must be even")
    
    bytes_list = [hex_str[i:i+2] for i in range(0, len(hex_str), 2)]
    
    little_endian_bytes = bytes_list[::-1]
    
    return "".join(little_endian_bytes)
    
def main():
    random.seed(42)
    modulus = random.getrandbits(256)
    binary_modulus = bin(modulus)[2:]
    
    bitwidth = len(binary_modulus)
    while bitwidth < 256:
        binary_modulus = "1" + binary_modulus
        bitwidth += 1
    
    modulus = int(binary_modulus, 2)
    print(f"Modulus - {hex(modulus)[2:]}")
    
    sample = ModularMultiplier(modulus)

    #print(f"Values\nX: {X}\nY: {Y}")

    for i in range(10):
        X = random.getrandbits(256)
        Y = random.getrandbits(256)
        le_X = to_little_endian(hex(X)[2:])
        le_Y = to_little_endian(hex(Y)[2:])

        print(f"Iteration No {i}")
        print(f"X in hex: {hex(X)}")
        print(f"Y in hex: {hex(Y)}")
        print(f"Little Endian X - {le_X}")
        print(f"Little Endian Y - {le_Y}")
        print(f"Little Endian Combined - {le_X + le_Y}")
        calculated_mod = (X*Y) % modulus
        calculated_mod = hex(calculated_mod)
        print(f"Theoretical Q = {calculated_mod[2:]}")
        #print(f"X*Y = {hex(X*Y)[2:]}")
        #print(f"Plow = {hex(X*Y)[-96:]}")
        
        sample.mult(X,Y)
        sample.folding1()
        sample.coarse_grain()
        sample.fine_grain()
        print("########################################################")
    
    #print(f"Error: {sample.Q - calculated_mod}")

if __name__ == "__main__":
    main()