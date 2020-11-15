## 136. Single Number
Given a non-empty array of integers nums, every element appears twice except for one. Find that single one.

```java
class Solution {
    public int singleNumber(int[] nums) {
        int a = 0;
        for(int num : nums) {
            a ^= num;
        }
        return a;
    }
}
```