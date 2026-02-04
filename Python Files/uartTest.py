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