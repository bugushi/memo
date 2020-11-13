## 53. Maximum Subarray
Given an integer array nums, find the contiguous subarray (containing at least one number) which has the largest sum and return its sum.
```java
class Solution {
    public int maxSubArray(int[] nums) {
        int maxSoFar = nums[0];
        int maxEndingHere = nums[0];
        for(int i=1; i<nums.length; i++) {
            maxEndingHere = Math.max(maxEndingHere + nums[i], nums[i]);
            maxSoFar = Math.max(maxSoFar, maxEndingHere);
        }
        return maxSoFar;
    }
}
```

## 70. Climbing Stairs
You are climbing a stair case. It takes n steps to reach to the top.

Each time you can either climb 1 or 2 steps. In how many distinct ways can you climb to the top?
```java
class Solution {
    public int climbStairs(int n) {
        if(n == 1) {
            return 1;
        }
        int[] dp = new int[n + 1];
        dp[1] = 1;
        dp[2] = 2;
        for(int i=3; i<= n; i++) {
            dp[i] = dp[i-1] + dp[i-2];
        }
        return dp[n];
    }
}
```

## 96. Unique Binary Search Trees
Given n, how many structurally unique BST's (binary search trees) that store values 1 ... n?
```java
class Solution {
    int res = 0;
    HashMap<Integer, Integer> cache = new HashMap<>();
    
    public int numTrees(int n) {
        if(n == 0 || n == 1) {
            return 1;
        }
        if(cache.containsKey(n)) {
            return cache.get(n);
        }
        for(int i=0; i<n; i++) {
            int leftLen = i;
            int rightLen = n - i - 1;
            res += numTrees(leftLen) * numTrees(rightLen);
        }
        
        cache.put(n, res);
        return res;
    }
}
```

## 121. Best Time to Buy and Sell Stock
Say you have an array for which the ith element is the price of a given stock on day i.

If you were only permitted to complete at most one transaction (i.e., buy one and sell one share of the stock), design an algorithm to find the maximum profit.
```java
class Solution {
    public int maxProfit(int[] prices) {
        int min = Integer.MAX_VALUE;
        int maxByNow = 0;
        int maxEndingHere = 0;
        for(int i=0; i<prices.length; i++) {
            min = Math.min(min, prices[i]);
            maxEndingHere = prices[i] - min;
            maxByNow = Math.max(maxByNow, maxEndingHere);
        }
        return maxByNow;
    }
}
```