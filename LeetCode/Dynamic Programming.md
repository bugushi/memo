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