## 120. Triangle
Given a triangle, find the minimum path sum from top to bottom. Each step you may move to adjacent numbers on the row below.

```java
class Solution {
    public int minimumTotal(List<List<Integer>> triangle) {
        if(triangle.size() == 0) return 0;
        if(triangle.size() == 1) return triangle.get(0).get(0);
        
        for(int h=triangle.size()-2; h>=0; h--) {
            List<Integer> lastRow = triangle.get(h+1);
            List<Integer> row = triangle.get(h);
            for(int col=0; col<row.size(); col++) {
                int min = Math.min(lastRow.get(col), lastRow.get(col+1)) + row.get(col);
                System.out.println(min);
                row.set(col, min);
            }
        }
        
        return triangle.get(0).get(0);
    }
}
```