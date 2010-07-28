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

public class AVLTree {
	public AVLTreeNode root;
	
    public AVLTree() {

    }
    
    // insert a new element
    public void insert(String Name, String Data) {
        //System.out.println("[DEBUG] Adding Element '" + Name + "'");
        if (this.root == null)
            this.root = new AVLTreeNode(Name, Data, null, this);
        else
        	this.root.insert(Name, Data);
    }
    
    // search for an element in the tree
    // returns level the element is on
    // path = Display breadcrumbs or not
    public String search(String Name, Boolean path) {
        return this.root.search(Name, path);   // just use the root's search function recursivly
    }
}
