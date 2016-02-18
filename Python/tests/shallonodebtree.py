import sys

class TreeNode:
    def __init__(self, data):
        self.left  = None 
        self.right = None 
        self.data = data

    def insert_left(self, left):
        self.left = TreeNode(left) if left else None
        return self.left
    
    def insert_right(self, right):
        self.right= TreeNode(right) 
        return self.right

    def search(self,data, height= 1):
        if data == self.data:
            print self.data,height
            return self, height
        if self.left:
            print self.left.data,height+1
            return self.left.search(data, height+1)
        if self.right:
            print self.right.data,height+1
            return self.right.search(data, height+1)
            else:
                return 

    def children_count(self):
        count = 0
        if self.left: count += 1
        if self.right: count += 1
        return count

def get_height(node):
    if not node:
        return 0
    else:
        return max(get_height(node.left), get_height(node.right)) + 1


if __name__ == "__main__":
    
    input_lines = sys.stdin.readlines()

    root, left, right = input_lines[0].strip().split(',')
    rootNode = TreeNode(root)
    allNodes = [rootNode]
    allNodes.append(rootNode.insert_left(left))
    allNodes.append(rootNode.insert_right(right))
        
    for line in input_lines[1:]: 
        node, left, right = line.strip().split(',')
        childNode,height = rootNode.search(node)
        allNodes.append(childNode.insert_left(left))
        allNodes.append(childNode.insert_right(right))
        
    uniqNodes= [n for n in list(set(allNodes)) if n]        
    print [n.data for n in uniqNodes]

    nodeNoChild = [n for n in uniqNodes if n.children_count()==0] 
    print [n.data for n in nodeNoChild]

    heights = []
    for node in nodeNoChild:
        print rootNode.data, node.data
        temp, height = rootNode.search(node.data)
        heights.append(height)
    print heights    
    print min(heights)

        

