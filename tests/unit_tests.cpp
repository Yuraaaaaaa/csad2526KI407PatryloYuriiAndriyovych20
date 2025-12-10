#include <gtest/gtest.h>
#include "../math_operations.h"

// Tests for add(int a, int b)
TEST(AdditionTest, PositiveNumbers) {
    EXPECT_EQ(add(2, 3), 5);
    EXPECT_EQ(add(10, 20), 30);
}

TEST(AdditionTest, NegativeNumbers) {
    EXPECT_EQ(add(-4, -6), -10);
    EXPECT_EQ(add(-1, -1), -2);
}

TEST(AdditionTest, ZeroAddition) {
    EXPECT_EQ(add(0, 5), 5);
    EXPECT_EQ(add(0, 0), 0);
    EXPECT_EQ(add(7, 0), 7);
}

TEST(AdditionTest, LargeNumber) {
    // Use values that fit in 32-bit int
    EXPECT_EQ(add(1000000000, 200000000), 1200000000);
}

int main(int argc, char **argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
