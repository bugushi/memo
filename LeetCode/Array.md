### 1. Two Sum

```
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