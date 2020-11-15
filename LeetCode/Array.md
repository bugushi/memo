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

## 3. Longest Substring Without Repeating Characters
Given a string s, find the length of the longest substring without repeating characters.
```java
class Solution {
    public int lengthOfLongestSubstring(String s) {
        HashMap<Character, Integer> map = new HashMap<>();
        int maxLen = 0;
        int left = 0;
        for(int i=0; i<s.length(); i++){
            char c = s.charAt(i);
            if(map.containsKey(c)) {
                left = Math.max(left, map.get(c) + 1);
            }
            
            int len = i - left + 1;
            maxLen = Math.max(maxLen, len);
            
            map.put(c, i);
        }
        return maxLen;
    }
}
```
## 11. Container With Most Water
Given n non-negative integers a1, a2, ..., an , where each represents a point at coordinate (i, ai). n vertical lines are drawn such that the two endpoints of the line i is at (i, ai) and (i, 0). Find two lines, which, together with the x-axis forms a container, such that the container contains the most water.
```java
class Solution {
    public int maxArea(int[] height) {
        int volume = 0;
        int left = 0;
        int right = height.length -1;
        while(left < right) {
            if(height[left] <= height[right]) {
                volume = Math.max(volume, (right-left) * height[left]);
                left++;
            } else {
                volume = Math.max(volume, (right-left) * height[right]);
                right--;
            }
        }
        return volume;
    }
}
```

## 15. 3Sum
Given an array nums of n integers, are there elements a, b, c in nums such that a + b + c = 0? Find all unique triplets in the array which gives the sum of zero.
```java
class Solution {
    public List<List<Integer>> threeSum(int[] nums) {
        Arrays.sort(nums);
        List<List<Integer>> res = new ArrayList();
        
        for(int i=0; i<nums.length-2; i++) {
            if(i==0 || (i>0 && nums[i] != nums[i-1])) {
                int target = -nums[i];
                int low = i + 1;
                int high = nums.length - 1;
                while(low < high) {
                    if(nums[low] + nums[high] == target) {
                        res.add(Arrays.asList(nums[i], nums[low], nums[high]));
                        while(low < high && nums[low] == nums[low+1]) {
                            low++;
                        }
                        while(low < high && nums[high] == nums[high-1]) {
                            high--;
                        }
                        low++;
                        high--;
                    } else if(nums[low] + nums[high] < target) {
                        low++;
                    } else {
                        high--;
                    }
                }
            }
        }
        
        return res;
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

## 118. Pascal's Triangle
Given a non-negative integer numRows, generate the first numRows of Pascal's triangle.
```java
class Solution {
    public List<List<Integer>> generate(int numRows) {
        List<List<Integer>> res = new ArrayList<>();
        if(numRows == 0) {
            return res;
        }
        for(int i=0; i<numRows; i++) {
            if(i == 0) {
                List<Integer> row = Arrays.asList(1);
                res.add(row);
                continue;
            }
            
            List<Integer> row = new ArrayList<>();
            for(int j=0; j<i+1; j++) {
                List<Integer> prevRow = res.get(i-1);
                Integer left = j-1 >= 0 ? prevRow.get(j-1) : 0;
                Integer right = j < prevRow.size() ? prevRow.get(j) : 0;
                row.add(left + right);
            }
            res.add(row);
        }
        return res;
    }
}
```

## 406. Queue Reconstruction by Height
Suppose you have a random list of people standing in a queue. Each person is described by a pair of integers (h, k), where h is the height of the person and k is the number of people in front of this person who have a height greater than or equal to h. Write an algorithm to reconstruct the queue.

```java
class Solution {
    public int[][] reconstructQueue(int[][] people) {
        Arrays.sort(people, (x, y) -> {
            if(x[0] <= y[0]) {
                return 1;
            } else {
                return -1;
            }
        });
        
        List<int[]> res = new ArrayList<>();
        for(int[] person: people) {
            res.add(person[1], person);
        }
        return res.toArray(new int[res.size()][]);
    }
}
```