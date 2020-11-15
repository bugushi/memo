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