import { mockPaymentDatabaseQuery } from '../../src/dbMock';
import { validateUserId } from '../../src/validator';

describe('Payment System Integration', () => {
    it('correctly interprets a successful status from the mocked external payment database', () => {
        // 1. Define the user and the mock's expected input
        const userId = 9001;

        // 2. Call the mock function (simulating the external call)
        const dbResponse = mockPaymentDatabaseQuery(userId, 200);

        // 3. Ensure the returned user ID is valid
        expect(validateUserId(dbResponse.user_id)).toBe(true);

        // 4. Assert the contract: The response must contain the expected success status
        expect(dbResponse.user_id).toBe(userId);
        expect(dbResponse.payment_status).toBe("PAID");
    });

    it('correctly handles a non-200 status from the mocked external payment database', () => {
        // 1. Define the user and the mock's expected input
        const userId = 9002;
        
        // 2. Call the mock function (simulating the external call)
        const dbResponse = mockPaymentDatabaseQuery(userId, 500);

        // 3. Ensure the returned user ID is valid
        expect(validateUserId(dbResponse.user_id)).toBe(true);

        // 4. Assert the contract: The response must contain the expected failure status
        expect(dbResponse.user_id).toBe(userId);
        expect(dbResponse.payment_status).toBe("PENDING");
    });
});