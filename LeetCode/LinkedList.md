## 2. Add Two Numbers
You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order, and each of their nodes contains a single digit. Add the two numbers and return the sum as a linked list.
```java
/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode() {}
 *     ListNode(int val) { this.val = val; }
 *     ListNode(int val, ListNode next) { this.val = val; this.next = next; }
 * }
 */
class Solution {
    public ListNode addTwoNumbers(ListNode l1, ListNode l2) {
        int carry = 0;
        ListNode root = new ListNode(0);
        ListNode cursor = root;
        while(l1 != null || l2 != null || carry != 0) {
            int l1val = l1 != null ? l1.val : 0;
            int l2val = l2 != null ? l2.val : 0;
            int sum = l1val  + l2val + carry;
            
            cursor.next = new ListNode(sum % 10);
            carry = sum / 10;
            
            if(l1 != null) l1 = l1.next;
            if(l2 != null) l2 = l2.next;
            cursor = cursor.next;
        }
        return root.next;
    }
}
```

## 206. Reverse Linked List
```java
class Solution {
    public ListNode reverseList(ListNode head) {
        if(head == null) return head;
        ListNode prevNode = null;
        ListNode currNode = head;
        while(currNode != null) {
            ListNode nextNode = currNode.next;
            currNode.next = prevNode;
            prevNode = currNode;
            currNode = nextNode;
        }
        return prevNode;
    }
}
```

## 83. Remove Duplicates from Sorted List
Given a sorted linked list, delete all duplicates such that each element appear only once.
```java
class Solution {
    public ListNode deleteDuplicates(ListNode head) {
        if(head == null) return head;
        ListNode prev = head;
        ListNode curr = head.next;
        while(curr != null) {
            if(prev.val == curr.val) {
                prev.next = curr.next;
                curr = prev.next;
                continue;
            }
            prev = curr;
            curr = curr.next;
        }
        return head;
    }
}
```
## 19. Remove Nth Node From End of List
Given the head of a linked list, remove the nth node from the end of the list and return its head.
```java
class Solution {
    public ListNode removeNthFromEnd(ListNode head, int n) {
        ListNode dummy = new ListNode(0);
        dummy.next = head;
        ListNode slow = dummy;
        ListNode fast = dummy;
        
        for(int i=0; i<=n; i++) {
            fast = fast.next;
        }
        
        while(fast != null) {
            slow = slow.next;
            fast = fast.next;
        }
        
        slow.next = slow.next.next;
        return dummy.next;
    }
}
```

## 141. Linked List Cycle
Given head, the head of a linked list, determine if the linked list has a cycle in it.
```java
public class Solution {
    public boolean hasCycle(ListNode head) {
        ListNode fast = head;
        ListNode slow = head;
        while(fast != null && fast.next != null) {
            fast = fast.next.next;
            slow = slow.next;
            if(fast == slow) {
                return true;
            }
        }
        return false;
    }
}
```

## 147. Insertion Sort List
Sort a linked list using insertion sort.
```java
class Solution {
    public ListNode insertionSortList(ListNode head) {
        if(head == null || head.next == null) {
            return head;
        }
        ListNode dummy = new ListNode();
        ListNode currNode = head, prevNode, nextNode;
        
        while(currNode != null) {
            prevNode = dummy;
            nextNode = dummy.next;
            while(nextNode != null && nextNode.val < currNode.val) {
                prevNode = prevNode.next;
                nextNode = nextNode.next;
            }
            ListNode nextIter = currNode.next;
            currNode.next = nextNode;
            prevNode.next = currNode;
            
            currNode = nextIter;
        }
        return dummy.next;
    }
}
```