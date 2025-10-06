def karatsuba_2(x, y, depth=0):
    indent = "  " * depth
    # Base case for recursion
    if x < (1 << 32) and y < (1 << 32):
        result = x * y
        print(f"{indent}Base: {x:#018x} * {y:#018x} = {result:#034x}")
        return result

    # Split x and y into high and low 32 bits
    mask = (1 << 32) - 1
    x_high, x_low = x >> 32, x & mask
    y_high, y_low = y >> 32, y & mask

    print(f"{indent}Split: x={x:#018x} (high={x_high:#010x}, low={x_low:#010x}), y={y:#018x} (high={y_high:#010x}, low={y_low:#010x})")

    # 3 recursive multiplications
    z0 = karatsuba_2(x_low, y_low, depth+1)
    z2 = karatsuba_2(x_high, y_high, depth+1)
    z1 = karatsuba_2(x_low + x_high, y_low + y_high, depth+1) - z2 - z0

    # Combine results
    result = (z2 << 64) + (z1 << 32) + z0
    print(f"{indent}Karatsuba: ({x:#018x} * {y:#018x}) = {result:#034x}")
    return result

if __name__ == "__main__":
    x = int("972a846916419f82",16)
    y = int("9a1de644815ef6d1",16)
    print("\nKaratsuba multiplication steps:")
    result = karatsuba_2(x, y)
    print(f"\nFinal result: {result:#034x}")