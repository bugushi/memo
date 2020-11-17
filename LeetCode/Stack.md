## 20. Valid Parentheses
Given a string s containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.
```java
class Solution {
    private HashMap<String, String> pairs;
    
    public Solution() {
        pairs = new HashMap<String, String>();
        pairs.put("{", "}");
        pairs.put("(", ")");
        pairs.put("[", "]");
    }
    
    public boolean isValid(String s) {
        Stack<String> stack = new Stack();
        for(int i=0; i<s.length(); i++) {
            String curr = String.valueOf(s.charAt(i));
            if(pairs.containsKey(curr)) {
                stack.push(curr);
            } else if(stack.empty() || !curr.equals(pairs.get(stack.pop()))) {
                return false;
            }
        }
        if(stack.empty()) {
            return true;
        }
        return false;
    }
}
```

## 155. Min Stack
Design a stack that supports push, pop, top, and retrieving the minimum element in constant time.

- push(x) -- Push element x onto stack.
- pop() -- Removes the element on top of the stack.
- top() -- Get the top element.
- getMin() -- Retrieve the minimum element in the stack.


```java
class MinStack {
    
    Deque<Integer> xStack;
    Deque<Integer> minStack;

    /** initialize your data structure here. */
    public MinStack() {
        xStack = new LinkedList();
        minStack = new LinkedList();
        minStack.push(Integer.MAX_VALUE);
    }
    
    public void push(int x) {
        xStack.push(x);
        minStack.push(Math.min(x, minStack.peek()));
    }
    
    public void pop() {
        xStack.pop();
        minStack.pop();
    }
    
    public int top() {
        return xStack.peek();
    }
    
    public int getMin() {
        return minStack.peek();
    }
}

/**
 * Your MinStack object will be instantiated and called as such:
 * MinStack obj = new MinStack();
 * obj.push(x);
 * obj.pop();
 * int param_3 = obj.top();
 * int param_4 = obj.getMin();
 */
```

## 496. Next Greater Element I
You are given two arrays (without duplicates) nums1 and nums2 where nums1’s elements are subset of nums2. Find all the next greater numbers for nums1's elements in the corresponding places of nums2.

```java
class Solution {
    public int[] nextGreaterElement(int[] nums1, int[] nums2) {
        HashMap<Integer, Integer> map = new HashMap();
        Stack<Integer> stack = new Stack();
        
        for(int i=0; i<nums2.length; i++) {
            while(!stack.empty() && stack.peek() < nums2[i]) {
                map.put(stack.pop(), nums2[i]);
            }
            stack.push(nums2[i]);
        }

        while(!stack.empty()) {
            map.put(stack.pop(), -1);
        }
        
        int[] res = new int[nums1.length];
        for(int i=0; i<nums1.length; i++) {
            res[i] = map.get(nums1[i]);
        }
        return res;
    }
}
```

## 1544. Make The String Great 
```java
class Solution {
    public String makeGood(String s) {
        Deque<Character> deque = new LinkedList();
        
        String res = "";
        
        for(int i=0; i<s.length(); i++) {
            char curr = s.charAt(i);
            if(!deque.isEmpty() && deque.peekFirst() != curr 
               && Character.toLowerCase(deque.peekFirst()) == Character.toLowerCase(curr)) {
                deque.removeFirst();
                continue;
            }
            deque.addFirst(s.charAt(i));
        }
        
        while(!deque.isEmpty()) {
            res += deque.removeLast();
        }
        
        return res;
    }
}
```