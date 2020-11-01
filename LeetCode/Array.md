## 1. Two Sum

```java
class Solution {
    public int[] twoSum(int[] nums, int target) {
        int[] indexs = new int[2];
        HashMap<Integer, Integer> potentials = new HashMap<>();
        for(int i=0; i<nums.length; i++) {
            if(potentials.containsKey(nums[i])) {
                indexs[0] = i;
                indexs[1] = potentials.get(nums[i]);
                break;
            }
            potentials.put(target-nums[i], i);
        }
        return indexs;
    }
}
```

## 26. Remove Duplicates from Sorted Array
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