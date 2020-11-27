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