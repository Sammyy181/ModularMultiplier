def compare_hex(hex1: str, hex2: str):
    # Normalize: remove 0x if present, make lowercase
    h1 = hex1.lower().lstrip("0x")
    h2 = hex2.lower().lstrip("0x")

    if len(h1) != len(h2):
        print(f"Lengths differ: {len(h1)} vs {len(h2)} hex digits")
        return False

    # Compare digit by digit
    identical = True
    for i, (d1, d2) in enumerate(zip(h1, h2)):
        if d1 != d2:
            print(f"Difference at hex digit {i}: {d1} vs {d2}")
            identical = False

    if identical:
        print("The numbers are identical ✅")
    else:
        print("The numbers are NOT identical ❌")

    return identical


# Example usage
hex1 = "c7395290d3f5ef84f4fb7f5caa67c9cd7b35814e96fa37d6be58667a4e96041b"
hex2 = "c7395290d3f5ef84f4fb7f5caa67c9cd7b35814e96fa37d6be58667a4e96041b"

compare_hex(hex1, hex2)
