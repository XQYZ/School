/*
 *  AVLTree Class for Java
 *  Copyright (C) 2009  Patrick Lerner [PaddyLerner@gmail.com]
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *  
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

package org.binarytree.avl;

public class AVLTreeNode {
	private String Name, Data;
	private AVLTreeNode Parent, LeftNode, RightNode;
	private AVLTree tree;
	
	public AVLTreeNode(String Name, String Data, AVLTreeNode Parent, AVLTree tree) {
        this.Name = Name;
        this.Parent = Parent;
        this.LeftNode = null;
        this.RightNode = null;
        this.Data = Data;         // whatever you want to store in the node
        this.tree = tree;         // tree is a reference to the AVLTree class holding our nodes; necessary to change the root element
	}
	
    // get the deepest level under the current node (recursivly)
    private int getDepth(AVLTreeNode node) {
        int depth = 1;
        int left = 0;
        int right = 0;
        if (node.LeftNode != null)
            left = node.LeftNode.getDepth(node.LeftNode);    // if it has a left element ping down
        if (node.RightNode != null)
            right = node.RightNode.getDepth(node.RightNode); // same for right
        // use the bigger one
        if (left > right)
            depth += left;
        else
            depth += right;
        return depth;
    }
    
    // is the current node balanced (equal amount of levels under left and right branch?)
    private int getBalance() {
        int balance = 0;
        if (this.LeftNode != null)
            balance -= this.LeftNode.getDepth(this.LeftNode);   // sub left depth
        if (this.RightNode != null)
            balance += this.RightNode.getDepth(this.RightNode); // add right depth
        return balance;
    }
    
    // called from a node under the current one. Changes the connection to said node to a new one
    private void updateMyConnector(AVLTreeNode old, AVLTreeNode replace){
        if (old == this.LeftNode)
        	this.LeftNode = replace;
        if (old == this.RightNode)
        	this.RightNode = replace;
    }
    
    // searches for a node
    // returns the level a node is found on
    // term = what we are looking for
    // path = true if we want to print "breadcrumbs"
	public String search(String term, Boolean path) {
        if (path)
            System.out.println("[SEARCH] Currently looking at node " + this.Name);
        if (this.Name.equals(term)) {                             // we found it?
            return this.Data;
        }
        else {
            if (term.compareTo(this.Name) < 0) {                  // go left
                if (this.LeftNode == null) {                      // there is no way left
                    if (path)
                    	System.out.println("[SEARCH] Can't continue search after " + this.Name);
                    return null;
            	}
                return this.LeftNode.search(term, path);         // continue search (recursivly)
            }
            else if (term.compareTo(this.Name) > 0) {            // go right
                if (this.RightNode == null) {
                    if (path)
                    	System.out.println("[SEARCH] Can't continue search after " + this.Name);
                    return null;
                }
                return this.RightNode.search(term, path);
            }
            else
            	return "";
        }
	}
	
    // insert a new element somewhere under this node
    public void insert(String Name, String Data) {
    	// (Name < this.Name)
        if (Name.compareTo(this.Name) < 0) {                                   // name comes before current -> go left
        	if (this.LeftNode == null) {                                       // no node under left branch
        		this.LeftNode = new AVLTreeNode(Name, Data, this, this.tree);  // create new node here
        		this.LeftNode.changeBalance();                                 // update the balance settings (check if a rotation is needed)
        	}
        	else
        		this.LeftNode.insert(Name, Data);
        }
        else if (Name.compareTo(this.Name) > 0) {                              // name comes after current -> go right
        	if (this.RightNode == null) {
        		this.RightNode = new AVLTreeNode(Name, Data, this, this.tree);
        		this.RightNode.changeBalance();
        	}
        	else
        		this.RightNode.insert(Name, Data);
        }
        //else:
        //    print("[DEBUG] Adding failed. Already exists.")         # new node has same name as this one
    }
    
    // RR rotation
    private void rotateRR() {
        AVLTreeNode Me = this;
        AVLTreeNode Left = this.LeftNode;
        
        // switch 'Me' and 'Left' and attach 'Me' to the right connector of 'Left'
        if (Me.Parent != null)
            Me.Parent.updateMyConnector(Me, Left);
        
        Left.Parent = Me.Parent;
        if (Left.Parent == null)
        	this.tree.root = Left;
        Me.Parent = Left;
        Me.LeftNode = null;
        
        if (Left.RightNode != null) {
            // we need to drop a node attached to the place where 'Me' is going to be attached
            // so we don't lose it. We're going to attach it to 'Me' instead
            //
            // Before: Element attached to 'Left'
            // Going to be: Element attached to 'Me' which is attached to 'Left'
            //print("[DEBUG] Dropping right node " + Left.RightNode.Name + " caught by " + Me.Name)
            Left.RightNode.Parent = Me;
            Me.LeftNode = Left.RightNode;
        }
        // finally attach 'Me'
        Left.RightNode = Me;
    }
    
    // LL rotation (same as for RR but mirrored)
    private void rotateLL() {
    	AVLTreeNode Me = this;
        AVLTreeNode Right = this.RightNode;

        if (Me.Parent != null)
            Me.Parent.updateMyConnector(Me, Right);
                
        Right.Parent = Me.Parent;
        if (Right.Parent == null)
            this.tree.root = Right;
        Me.Parent = Right;
        Me.RightNode = null;
        
        if (Right.LeftNode != null) {
            //print("[DEBUG] Dropping left node " + Right.LeftNode.Name + " caught by " + Me.Name)
            Right.LeftNode.Parent = Me;
            Me.RightNode = Right.LeftNode;
        }
        Right.LeftNode = Me;
    }
    
    // LR rotation
    private void rotateLR() {
        this.LeftNode.rotateLL();
        this.rotateRR();
    }
    
    // RL rotation
    private void rotateRL() {
    	this.RightNode.rotateRR();
    	this.rotateLL();
    }
    
    // check the balances (check if a rotation is needed)
    private void changeBalance() {
        //print("[DEBUG] Balance of " + self.Name + " is " + str(self.getBalance()))
        if (this.getBalance() <= -2) {
            if (this.LeftNode.getBalance() == -1) {
                //print("[DEBUG] RR rotation at " + this.Name)
                this.rotateRR();
            }
            else {
                //print("[DEBUG] LR rotation at " + this.Name)
                this.rotateLR();
            }
        }
        else if (this.getBalance() >= 2) {
            if (this.RightNode.getBalance() == 1) {
                //print("[DEBUG] LL rotation at " + this.Name)
                this.rotateLL();
            }
            else {
                //print("[DEBUG] RL rotation at " + this.Name)
                this.rotateRL();
            }
        }
        else
            if (this.Parent != null)
            	this.Parent.changeBalance();
    }
}
