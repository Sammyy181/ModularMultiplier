import serial
import threading
import binascii

# === Adjust for your setup ===
PORT = "COM9"           # e.g. "/dev/ttyUSB0" on Linux
BAUD = 115200           # Matches FPGA UART
SEND_SIZE = 64          # 64 bytes = 512 bits

def listen_uart(ser):
    """ Continuously read data from FPGA and print it """
    while True:
        data_in = ser.read(ser.in_waiting or 1)
        if data_in:
            print(f"\n[FPGA → PC] {data_in.hex()}")

def main():
    with serial.Serial(PORT, BAUD, timeout=0.1) as ser:
        print(f"Opened {PORT} at {BAUD} baud")
        print("Type 128 hex characters (64 bytes) to send to FPGA.")
        print("Press Ctrl+C to exit.\n")

        # Start listener thread
        t = threading.Thread(target=listen_uart, args=(ser,), daemon=True)
        t.start()

        # Main loop: accept user input for sending
        while True:
            user_input = input("\n[PC → FPGA] Enter 128 hex chars: ").strip()
            try:
                data_out = binascii.unhexlify(user_input)
            except binascii.Error:
                print("❌ Invalid hex string.")
                continue

            if len(data_out) != SEND_SIZE:
                print(f"❌ Must be exactly {SEND_SIZE} bytes ({SEND_SIZE*2} hex chars).")
                continue

            ser.write(data_out)
            ser.flush()
            print(f"✅ Sent {SEND_SIZE} bytes.")

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\nExiting.")

#371ecd7b27cd813047229389571aa8766c307511b2b9437a28df6ec4ce4a2bbd
#5be6128e18c267976142ea7d17be31111a2a73ed562b0f79c37459eef50bea63
#bd2b4acec46edf287a43b9b21175306c76a81a57899322473081cd277bcd1e3763ea0bf5ee59379cf7b062d5eda7321a1131be177dea42619767c2188e12e65b
#dc5d40d4a3a0ed5401bdd047567dac7042040ec1ff24d3a3b161db9a429c36a
#b30fcb06a6c1ad8f2906e732b10f4db789d35ea68c088ab3f648818ba4a6656be0cb6e382a5dff72ac1dda96908137478bd536cf4b778ade1fe7a9010b3341c2


