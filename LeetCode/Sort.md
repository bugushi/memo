## 56. Merge Intervals
Given an array of intervals where intervals[i] = [starti, endi], merge all overlapping intervals, and return an array of the non-overlapping intervals that cover all the intervals in the input.
```java
class Solution {
    public int[][] merge(int[][] intervals) {
        Arrays.sort(intervals, Comparator.comparingInt(item -> item[0]));
        int[][] output = new int[intervals.length][2];
        output[0] = intervals[0];
        int count = 1;
        for(int i=1; i<intervals.length; i++) {
            if(output[count-1][1] >= intervals[i][0]) {
                output[count-1][1] = Math.max(output[count-1][1], intervals[i][1]);
            } else {
                output[count] = intervals[i];
                count++;
            }
        }
        return Arrays.copyOf(output, count);
    }
}
```

## 215. Kth Largest Element in an Array
Find the kth largest element in an unsorted array. Note that it is the kth largest element in the sorted order, not the kth distinct element.
```java
class Solution {
    public int findKthLargest(int[] nums, int k) {
        quickSort(nums, 0, nums.length-1);
        return nums[nums.length - k];
    }

    private void quickSort(int[] nums, int low, int high) {
        if(low < high) {
            int pivotLocation = partition(nums, low, high);
            System.out.println(pivotLocation);
            quickSort(nums, low, pivotLocation - 1);
            quickSort(nums, pivotLocation + 1, high);
        }
    }

    private int partition(int[] nums, int low, int high) {
        int pivot = nums[high];
        int left = low;
        int right = high-1;
        while(left <= right) {
            while(nums[left] <= pivot && left <= right) {
                left++;
            }
            while(nums[right] >= pivot && right > 0) {
                right--;
            }
            if(left >= right) {
                swap(nums, left, high);
                break;
            }
            swap(nums, left, right);
        }
        return left;
    }

    private void swap(int[] nums, int i, int j) {
        int temp = nums[i];
        nums[i] = nums[j];
        nums[j] = temp;
    }
}
```