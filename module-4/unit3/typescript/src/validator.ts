/**
 * Validates a user ID based on TDD requirements.
 * Rules:
 * 1. Returns true for a valid, positive integer ID.
 * 2. Returns false for a negative integer ID or zero.
 * 3. Throws TypeError for non-integer inputs (string, float, boolean, etc.).
 */
export function validateUserId(userId: unknown): boolean {
    // Rule 3: Check for type first (Type Guard)
    if (typeof userId !== 'number' || !Number.isInteger(userId)) {
        throw new TypeError("User ID must be an integer.");
    }

    // Rule 1 & 2: Return true for positive, false for non-positive
    return userId > 0;
}