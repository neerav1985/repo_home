

class Node:
    def __init__(self, val):
        self.v = val
        self.l = None
        self.r = None
        self.h = None #height

class Btree:
    def __init__(self ):
        self.root = None

    def add(self, val):
        if self.root:
            self._add(self.root, val)
        else:
            self.root = Node(val)

    def _add(self, node, val):
        if val<node.v:
            if node.l:
                self._add(node.l, val)
            else:
                node.l = Node(val)
        else:
            if node.r:
                self._add(node.r, val)
            else:
                node.r = Node(val)

    def find(self, val):
        if self.root:
            print "found root"
            return self._find(self.root, val)
        else:
            return None

    def _find(self, node, val):
        if val == node.v:
            print "equal"
            return node
        elif (val < node.v) and node.l:
            print "left"
            return self._find(node.l, val)
        elif (val > node.v) and node.r:
            print "right"
            return self._find(node.r, val)

    def printTree(self):
        if self.root:
            self._printTree(self.root)

    def _printTree(self, node):
        if node:
            self._printTree(node.l)
            print str(node.v) 
            self._printTree(node.r)

    def maxHeight(self):
        if not self.root:
            return 0
        else:
            return self._maxHeight(self.root)

    def _maxHeight(self, node):
        if not node:
            return 0
        lh, rh = 1, 1
        if node.l:
            lh = 1 + self._maxHeight(node.l)
        if node.r:
            rh = 1 + self._maxHeight(node.l)
        return lh if lh > rh else rh

if __name__ == "__main__":
    
    bt = Btree()
    bt.add(6)
    bt.add(3)
    bt.add(2)
    bt.add(8)
    bt.add(1)
    bt.add(9)
    bt.add(4)
    bt.add(7)
    bt.printTree()
    print str(bt) 
    print str(bt.root.v) 
    fn = bt.find(1)
    print str(fn) 
    print "found 1:" + str(fn) + ":" + str(fn.v)
    print "max height" + str(bt.maxHeight())
