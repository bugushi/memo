### 2. Add Two Numbers

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
