## 104. Maximum Depth of Binary Tree
Given a binary tree, find its maximum depth.
```java
class Solution {
    public int maxDepth(TreeNode root) {
        if(root == null) {
            return 0;
        }
        return Math.max(maxDepth(root.left), maxDepth(root.right)) + 1;
    }
}
```

## 108. Convert Sorted Array to Binary Search Tree
Given an array where elements are sorted in ascending order, convert it to a height balanced BST.
```java
class Solution {
    public TreeNode sortedArrayToBST(int[] nums) {
        if(nums == null || nums.length == 0) {
            return null;
        } 
        
        int mid = nums.length / 2;
        TreeNode root = new TreeNode(nums[mid]);
        int[] left = mid > 0 ? Arrays.copyOfRange(nums, 0, mid) : null;
        int[] right = mid+1 < nums.length ? Arrays.copyOfRange(nums, mid+1, nums.length) : null;
        
        root.left = sortedArrayToBST(left);
        root.right = sortedArrayToBST(right);
        return root;
    }
}
```