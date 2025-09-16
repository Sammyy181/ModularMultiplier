import random

def main():
    Y = int("92e5c273477d21d8361651a6eea3cb5b1c424d77f1b750a99cc6df2b0ee713a2",16)
    X = int("5b013b70ddf11560736ff50d7c982339",16)
    #X = 2**128 - 1
    binX = bin(X)[2:].zfill(128)
    binY = bin(Y)[2:].zfill(256)
    
    #print(f"Product = {hex(X * Y)[2:]}")
    
    # 1st Cycle
    P00 = int(binX[64:],2) * int(binY[192:],2)
    P11 = int(binX[:64],2) * int(binY[128:192],2)
    
    
    S10 = (int(binY[128:192],2) + int(binY[192:],2)) * (int(binX[64:],2) + int(binX[:64],2))
    X1X0 = (int(binX[64:],2) + int(binX[:64],2))
    Y1Y0 = (int(binY[128:192],2) + int(binY[192:],2))
    #print(f"X1X0 = {hex(X1X0)[2:]}")
    #print(f"Y1Y0 = {hex(Y1Y0)[2:]}")
    #print(f"S10 - {hex(S10)[2:]}")
    S20 = (int(binY[64:128],2) + int(binY[192:],2)) * int(binX[64:],2)
    S21 = (int(binY[64:128],2) + int(binY[128:192],2)) * int(binX[:64],2)
    S30 = (int(binY[:64],2) + int(binY[192:],2)) * int(binX[64:],2)
    S31 = (int(binY[:64],2) + int(binY[128:192],2)) * int(binX[:64],2)
    
    # 2nd Cycle
    T0K = P00
    P1P0 = P11 + P00
    M20 = S20 - P00
    M21 = S21 - P11
    M30 = S30 - P00
    T4K = S31 - P11
    
    #print(f"P1P0 - {hex(P1P0)[2:]}")
    #print(f"P00 - {hex(P00)[2:]}")
    
    # 3rd Cycle
    T1K = S10 - P1P0
    T2K = M20 + P11
    T3K = M30 + M21
    
    #print(f"T1K - {hex(T1K)[2:]}")
    
    # 4th Cycle
    sum_1 = (T0K // (2**64)) + T1K
    #print(f"sum_1 - {hex(sum_1)[2:]}")
    sum_3 = (T2K // (2**64)) + (T3K % (2**64))
    sum_4 = (T3K // (2**64)) + T4K
    
    # 5th Cycle
    sum_2 = (sum_1 // (2**64)) + (T2K % (2**64))
    upSum = (((sum_3 // (2**64)) + sum_4) * (2**64)) + (sum_3 % (2**64))
    #print(f"upSum - {hex(upSum)}")
    
    # 6th Cycle
    P = (T0K % (2**64)) + ((sum_1 % (2**64)) * (2**64)) + ((sum_2 % (2**64)) * (2**128)) + (upSum * (2**192))
    #print(f"Karatsuba Product - {hex(P)[2:]}")
    
if __name__ == "__main__":
    main()