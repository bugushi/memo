## 1. Two Sum
思路：用HashMap保存期望值，向前遍历寻找期望值
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
思路：双指针，p1指向第一个，p2指向第二个；p2向前走，遇到不同值p1进一，并前移此值
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
思路：二分法
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
