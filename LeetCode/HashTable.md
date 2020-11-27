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

## 242. Valid Anagram
Given two strings s and t , write a function to determine if t is an anagram of s.
```java
class Solution {
    public boolean isAnagram(String s, String t) {
        if(s.length() != t.length()) {
            return false;
        }
        
        int[] counter = new int[26];
        for(int i=0; i<s.length(); i++) {
            counter[s.charAt(i) - 'a']++;
            counter[t.charAt(i) - 'a']--;
        }
        
        for(int count : counter) {
            if(count != 0) {
                return false;
            }
        }
        return true;
    }
}
```