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
## 84. Largest Rectangle in Histogram
Given n non-negative integers representing the histogram's bar height where the width of each bar is 1, find the area of largest rectangle in the histogram.
```java
class Solution {
    public int largestRectangleArea(int[] heights) {
        int[] newHeights = new int[heights.length+2];
        for(int i=0; i<heights.length; i++) {
            newHeights[i+1] = heights[i];
        }

        int area = 0;
        Stack<Integer> stack = new Stack();
        for(int i=0; i<newHeights.length; i++) {
            while(!stack.empty() && newHeights[stack.peek()] > newHeights[i]) {
                int height = newHeights[stack.pop()];
                int width = i - stack.peek() - 1;
                area = Math.max(width * height, area);
            }
            
            stack.push(i);
        }
        
        return area;
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

## 316. Remove Duplicate Letters
Given a string s, remove duplicate letters so that every letter appears once and only once. You must make sure your result is the smallest in lexicographical order among all possible results.

```java
class Solution {
    public String removeDuplicateLetters(String s) {
        int[] count = new int[256];
        for(int i=0; i<s.length(); i++) {
            count[s.charAt(i)]++;
        }
        
        Stack<Character> stack = new Stack();
        HashSet<Character> set = new HashSet();
        for(int i=0; i<s.length(); i++) {
            char curr = s.charAt(i);
            count[curr]--;
            
            if(set.contains(curr)) {
                continue;
            }
            
            while(!stack.empty() && stack.peek() > curr) {
                // if top will never show again, don't pop
                if(count[stack.peek()] == 0) {
                    break;
                }
                set.remove(stack.pop());
            }
            
            stack.push(curr);
            set.add(curr);
        }
        
        StringBuilder sb = new StringBuilder();
        while(!stack.empty()) {
            sb.append(stack.pop());
        }
        return sb.reverse().toString();
    }
}
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