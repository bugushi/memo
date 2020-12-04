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

## 101. Symmetric Tree
Given a binary tree, check whether it is a mirror of itself (ie, symmetric around its center).
```java
class Solution {
    public boolean isSymmetric(TreeNode root) {
        if(root == null) return true;
        return isSymmetric(root.left, root.right);
    }
    
    private boolean isSymmetric(TreeNode left, TreeNode right) {
        if(left == null && right == null) return true;
        if(left == null || right == null) return false;
        return (left.val == right.val) && isSymmetric(left.left, right.right) && isSymmetric(left.right, right.left);
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

## 111. Minimum Depth of Binary Tree
Given a binary tree, find its minimum depth.
```java
class Solution {
    public int minDepth(TreeNode root) {
        if(root == null) return 0;
        if(root.left == null && root.right == null) return 1;
        
        int leftDepth = minDepth(root.left);
        int rightDepth = minDepth(root.right);
        if(root.left == null || root.right == null) return leftDepth + rightDepth + 1;
        
        return Math.min(leftDepth, rightDepth) + 1;
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

## 144 Binary Tree Preorder Traversal
Given the root of a binary tree, return the preorder traversal of its nodes' values.
```java
class Solution {
    public List<Integer> preorderTraversal(TreeNode root) {
        List<Integer> res = new ArrayList<>();
        if(root == null) {
            return res;
        }
        Stack<TreeNode> stack = new Stack();
        while(!stack.isEmpty() || root != null) {
            while(root != null) {
                stack.push(root);
                res.add(root.val);
                root = root.left;
            }
            root = stack.pop();
            root = root.right;
        }
        return res;
    }
}
```
## 701. Insert into a Binary Search Tree
You are given the root node of a binary search tree (BST) and a value to insert into the tree. Return the root node of the BST after the insertion. It is guaranteed that the new value does not exist in the original BST.
```java
class Solution {
    public TreeNode insertIntoBST(TreeNode root, int val) {
        if(root == null) return new TreeNode(val);
        
        if(val <= root.val) {
            if(root.left == null) {
                root.left = new TreeNode(val);
                return root;
            }
            insertIntoBST(root.left, val);
        } else {
            if(root.right == null) {
                root.right = new TreeNode(val);
                return root;
            }
            insertIntoBST(root.right, val);
        }
        
        return root;
    }
}
```