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
hex1 = "12b6c2791cdc006619d8c0f4aa5bdd04ff71234c9886372e3b70e7917a4ea10451b48517f7c6fc9921aec852344d38313"
hex2 = "12b6c2791cdc006619d8c0f4aa5bdd04ff71234c9886372e3b70e7917a4ea10451b48517f7c6fc9921aec852344d38313"

compare_hex(hex1, hex2)
