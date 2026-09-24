def calculate_shipping_cost(weight):
    """Calculates shipping costs based on package weight."""
    if weight <= 0:
        raise ValueError("Weight must be greater than zero.")
    
    print(f"Processing shipment for package weight: {weight}")
    
    rate = 1.50
    return weight * rate

if __name__ == "__main__":
    try:
        print(f"Total Shipping Cost: £{calculate_shipping_cost(10)}")
    except Exception as e:
        print(f"Error: {e}")
