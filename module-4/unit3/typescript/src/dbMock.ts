export interface PaymentResponse {
    user_id: number;
    payment_status: "PAID" | "PENDING";
    query_time_ms: number;
}

/**
 * Simulates a database query for payment status.
 * Returns "PAID" if the status code is 200, and "PENDING" otherwise[.
 */
export function mockPaymentDatabaseQuery(userId: number, statusCode: number): PaymentResponse {
    if (statusCode === 200) {
        return { user_id: userId, payment_status: "PAID", query_time_ms: 10 };
    } else {
        return { user_id: userId, payment_status: "PENDING", query_time_ms: 10 };
    }
}