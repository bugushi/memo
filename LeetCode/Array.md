## 1. Two Sum
Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.
```java
class Solution {
    public int[] twoSum(int[] nums, int target) {
        int[] indexs = new int[2];
        HashMap<Integer, Integer> expectations = new HashMap<>();
        for(int i=0; i<nums.length; i++) {
            if(expectations.containsKey(nums[i])) {
                indexs[0] = i;
                indexs[1] = expectations.get(nums[i]);
                break;
            }
            expectations.put(target-nums[i], i);
        }
        return indexs;
    }
}
```

## 26. Remove Duplicates from Sorted Array
Given a sorted array nums, remove the duplicates in-place such that each element appears only once and returns the new length.
> Do not allocate extra space for another array, you must do this by modifying the input array in-place with O(1) extra memory.
```java
class Solution {
    public int removeDuplicates(int[] nums) {
        if(nums.length == 0) {
            return 0;
        }
        
        int pointer1 = 0;
        
        for(int pointer2=1; pointer2<nums.length; pointer2++) {
            if(nums[pointer1] != nums[pointer2]) {
                pointer1++;
                nums[pointer1] = nums[pointer2];
            }
        }
        
        return pointer1 + 1;
    }
}
```

## 35. Search Insert Position
Given a sorted array of distinct integers and a target value, return the index if the target is found. If not, return the index where it would be if it were inserted in order.
```java
class Solution {
    public int searchInsert(int[] nums, int target) {
        if(nums ==null || nums.length == 0) return 0;
        
        int left = 0;
        int right = nums.length - 1;  
        
        while(left <= right) {
            int mid = (left + right) / 2;
            if(nums[mid] == target) {
                return mid;
            } else if(nums[mid] < target) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return left;
    }
}
```

## 88. Merge Sorted Array
Given two sorted integer arrays nums1 and nums2, merge nums2 into nums1 as one sorted array.
> The number of elements initialized in nums1 and nums2 are m and n respectively.
>
> You may assume that nums1 has enough space (size that is equal to m + n) to hold additional elements from nums2.
```java
class Solution {
    public void merge(int[] nums1, int m, int[] nums2, int n) {
        int end = m + n -1;
        while(m-1 >= 0 || n-1 >= 0) {
            int lastOfNum1 = m-1 >= 0 ? nums1[m-1] : Integer.MIN_VALUE;
            int lastOfNum2 = n-1 >= 0 ? nums2[n-1] : Integer.MIN_VALUE;
            if(lastOfNum1 >= lastOfNum2) {
                nums1[end] = lastOfNum1;
                m--;
                end--;
            } else {
                nums1[end] = lastOfNum2;
                n--;
                end--;
            }
        }
    }
}
```