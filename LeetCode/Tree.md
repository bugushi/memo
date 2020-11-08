## 94. Binary Tree Inorder Traversal
Given the root of a binary tree, return the inorder traversal of its nodes' values.
```java
class Solution {
    public List<Integer> inorderTraversal(TreeNode root) {
        List<Integer> result = new ArrayList<>();
        helper(root, result);
        return result;
    }
    
    public void helper(TreeNode root, List<Integer> result) {
        if(root != null) {
            if(root.left != null) {
                helper(root.left, result);
            }
            result.add(root.val);
            if(root.right != null) {
                helper(root.right, result);
            }
        }
    }
}
```

## 98. Validate Binary Search Tree
Given a binary tree, determine if it is a valid binary search tree (BST).
```java
// recursion
class Solution {
    public boolean isValidBST(TreeNode root) {
        return helper(root, null, null);
    }
    
    public boolean helper(TreeNode node, Integer lower, Integer upper) {
        if(node == null) {
            return true;
        }
        
        if((lower != null && node.val <= lower) || (upper != null && node.val >= upper)) {
            return false;
        }
        
        return helper(node.left, lower, node.val) && helper(node.right, node.val, upper);
    }
}
```

```java
//inorder traversal
class Solution {
    Stack<TreeNode> stack = new Stack();
    double leftChildVal = -Double.MAX_VALUE;
    
    public boolean isValidBST(TreeNode root) {
        while(!stack.isEmpty() || root != null) {
            while(root != null) {
                stack.push(root);
                root = root.left;
            }
            
            root = stack.pop();
            if(root.val <= leftChildVal) {
                return false;
            }
            
            leftChildVal = root.val;
            root = root.right;
        }
        
        return true;
    }
}
```

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

## 112. Path Sum
Given a binary tree and a sum, determine if the tree has a root-to-leaf path such that adding up all the values along the path equals the given sum.
```java
class Solution {
    public boolean hasPathSum(TreeNode root, int sum) {
        if(root == null) {
            return false;
        }
        
        int remain = sum - root.val;
        if(remain == 0 && root.left == null && root.right == null) {
            return true;
        }
        
        return hasPathSum(root.left, remain) || hasPathSum(root.right, remain);   
    }
}
```

## 124. Binary Tree Maximum Path Sum
Given a non-empty binary tree, find the maximum path sum.
```java
class Solution {
    public int maxPathSum(TreeNode root) {
        int[] res = {Integer.MIN_VALUE};
        pathSum(root, res);
        return res[0];
    }
    
    private int pathSum(TreeNode node, int[] res) {
        if(node == null) {
            return 0;
        }
        int leftSum = Math.max(0, pathSum(node.left, res));
        int rightSum = Math.max(0, pathSum(node.right, res));
        res[0] = Math.max(res[0], node.val + leftSum + rightSum);
        return Math.max(node.val + leftSum, node.val + rightSum);
    }
}
```