# # # # #
# AVLTreeNode
# A single node in our tree
#
class AVLTreeNode:
    # constructor
    def __init__(self, Name, Parent, tree):
        self.Name = Name
        self.Parent = Parent
        self.LeftNode = None
        self.RightNode = None
        self.tree = tree         # tree is a reference to the AVLTree class holding our nodes; necessary to change the root element
    
    # get the deepest level under the current node (recursivly)
    def getDepth(self, node):
        depth = 1
        left = 0
        right = 0
        if node.LeftNode != None:
            left = node.LeftNode.getDepth(node.LeftNode)    # if it has a left element ping down
        if node.RightNode != None:
            right = node.RightNode.getDepth(node.RightNode) # same for right
        # use the bigger one
        if left > right:
            depth += left
        else:
            depth += right
        return depth
    
    # is the current node balanced (equal amount of levels under left and right branch?)
    def getBalance(self):
        balance = 0
        if self.LeftNode != None:
            balance -= self.LeftNode.getDepth(self.LeftNode)   # sub left depth
        if self.RightNode != None:
            balance += self.RightNode.getDepth(self.RightNode) # add right depth
        return balance
    
    # called from a node under the current one. Changes the connection to said node to a new one
    def updateMyConnector(self, old, new):
        if old == self.LeftNode:
            self.LeftNode = new
        if old == self.RightNode:
            self.RightNode = new
    
    # insert a new element somewhere under this node
    def insert(self, Name):
        if Name < self.Name:                                         # name comes before current -> go left
            if self.LeftNode == None:                                # no node under left branch
                self.LeftNode = AVLTreeNode(Name, self, self.tree)   # create new node here
                self.LeftNode.changeBalance()                        # update the balance settings (check if a rotation is needed)
            else:
                self.LeftNode.insert(Name)
        elif Name > self.Name:                                       # name comes after current -> go right
            if self.RightNode == None:
                self.RightNode = AVLTreeNode(Name, self, self.tree)
                self.RightNode.changeBalance()
            else:
                self.RightNode.insert(Name)
        else:
            print("[DEBUG] Adding failed. Already exists.")          # new node has same name as this one
    
    # searches for a node
    # returns the level a node is found on
    # term = what we are looking for
    # step = used for recursition (current level)
    # path = true if we want to print "breadcrumbs"
    def search(self, term, step, path):
        if path:
            print("[SEARCH] Currently looking at node " + self.Name)
        if self.Name == term:                # we found it?
            return step
        else:
            step += 1
            if term < self.Name:                                 # go left
                if self.LeftNode == None:                        # there is no way left
                    print "[SEARCH] Can't continue search after " + self.Name
                    return -1
                return self.LeftNode.search(term, step, path)    # continue search (recursivly)
            elif self.Name < term:                               # go right
                if self.RightNode == None:
                    print "[SEARCH] Can't continue search after " + self.Name
                    return -1
                return self.RightNode.search(term, step, path)
    
    # RR rotation
    def rotateRR(self):
        Me = self
        Left = self.LeftNode
        
        # switch 'Me' and 'Left' and attach 'Me' to the right connector of 'Left'
        if Me.Parent != None:
            Me.Parent.updateMyConnector(Me, Left)
        
        Left.Parent = Me.Parent
        if Left.Parent == None:
            self.tree.root = Left
        Me.Parent = Left
        Me.LeftNode = None
        
        if Left.RightNode != None:
            # we need to drop a node attached to the place where 'Me' is going to be attached
            # so we don't lose it. We're going to attach it to 'Me' instead
            #
            # Before: Element attached to 'Left'
            # Going to be: Element attached to 'Me' which is attached to 'Left'
            print("[DEBUG] Dropping right node " + Left.RightNode.Name + " caught by " + Me.Name)
            Left.RightNode.Parent = Me
            Me.LeftNode = Left.RightNode
        # finally attach 'Me'
        Left.RightNode = Me
    
    # LL rotation (same as for RR but mirrored)
    def rotateLL(self):
        Me = self
        Right = self.RightNode

        if Me.Parent != None:
            Me.Parent.updateMyConnector(Me, Right)
                
        Right.Parent = Me.Parent
        if Right.Parent == None:
            self.tree.root = Right
        Me.Parent = Right
        Me.RightNode = None
        if Right.LeftNode != None:
            print("[DEBUG] Dropping left node " + Right.LeftNode.Name + " caught by " + Me.Name)
            Right.LeftNode.Parent = Me
            Me.RightNode = Right.LeftNode
        Right.LeftNode = Me
    
    # LR rotation
    def rotateLR(self):
        self.LeftNode.rotateLL()
        self.rotateRR()
    
    # RL rotation
    def rotateRL(self):
        self.RightNode.rotateRR()
        self.rotateLL()
    
    # check the balances (check if a rotation is needed)
    def changeBalance(self):
        print("[DEBUG] Balance of " + self.Name + " is " + str(self.getBalance()))
        if self.getBalance() <= -2:
            if self.LeftNode.getBalance() == -1:
                print("[DEBUG] RR rotation at " + self.Name)
                self.rotateRR()
            else:
                print("[DEBUG] LR rotation at " + self.Name)
                self.rotateLR()
        elif self.getBalance() >= 2:
            if self.RightNode.getBalance() == 1:
                print("[DEBUG] LL rotation at " + self.Name)
                self.rotateLL()
            else:
                print("[DEBUG] RL rotation at " + self.Name)
                self.rotateRL()
        else:
            if self.Parent != None:
                self.Parent.changeBalance()

# # # # #
# AVLTree Class
# This is the main class of the tree
#
class AVLTree:
    # constructor
    def __init__(self):
        self.root = None;
    
    # insert a new element
    def insert(self, Name):
        print("[DEBUG] Adding Element '" + Name + "'")
        if self.root == None:
            self.root = AVLTreeNode(Name, None, self)
        else:
            self.root.insert(Name)
    
    # search for an element in the tree
    # returns level the element is on
    # path = Display breadcrumbs or not
    def search(self, Name, path=False):
        return self.root.search(Name, 0, path)   # just use the root's search function recursivly

# # # # #
#   Main
#
myTree = AVLTree();

# bunch of cities in an array ...
cities = ["Bonn", "Bern", "Berlin", "New York", "Washington", "Chicago", "Seatle", "Hamburg", "London", "Berkley", "Bensheim", "Heppenheim", "Buerstadt", "Biblis", "Reichenbach", "Amsterdam", "Los Angeles", "Houston", "Phoenix", "Philadelphia", "Dellas", "San Diego", "Tokyo", "Mexico City", "San Andonio", "Detroit", "Inianapolis", "Austin", "Denver", "San Jose", "Jacksonville", "San Francisco", "Baltimore", "Paris", "Osaka", "Boston", "Atlanta", "Miami", "Sydney", "Minneapolis", "Cleveland", "Bangkok", "St. Petersburg", "Vancouver", "Johannesburg", "Monterrey", "Madrid", "Delhi", "Lima", "Manchester"]

# Adding all elemtents in array as tree nodes
for city in cities:
    myTree.insert(city)

# Print the layer the city is on
print("========= Cities and layers =========")
for city in cities:
    print(city + ": " + str(myTree.search(city)))

# Detailed search for the last added city
print("========= Search in Detail =========")
print(city + ": " + str(myTree.search(city, True)))