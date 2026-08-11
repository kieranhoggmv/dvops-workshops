import { validateUserId } from '../../src/validator';

describe('validateUserId', () => {
    // Task 1 Test: Positive ID (Rule 1)
    it('returns true for a valid, positive integer ID', () => {
        expect(validateUserId(101)).toBe(true);
    });

    // Task 3 Test: Negative ID (Rule 2)
    it('returns false if the ID is a negative number', () => {
        expect(validateUserId(-5)).toBe(false);
    });

    // Implicit test for zero
    it('returns false if the ID is zero', () => {
        expect(validateUserId(0)).toBe(false);
    });

    // Simple Task 4 Test: Non-Integer Type (Rule 3)
    it('raises a specific TypeError if the ID is passed as a string or float', () => {
        // Test for string input
        expect(() => validateUserId("abc")).toThrow(TypeError);
        expect(() => validateUserId("abc")).toThrow("User ID must be an integer.");
        
        // Test for float input
        expect(() => validateUserId(10.5)).toThrow(TypeError);
        expect(() => validateUserId(10.5)).toThrow("User ID must be an integer.");
    });

    // Advanced Task 4 Test: Non-Integer Type (Rule 3) 
    it.each([
        ["3"], 
        [3.5], 
        [true], 
        [null]
    ])('raises a specific TypeError for invalid input: %p', (invalidInput) => {
        expect(() => validateUserId(invalidInput)).toThrow(TypeError);
        expect(() => validateUserId(invalidInput)).toThrow("User ID must be an integer.");
    });
});