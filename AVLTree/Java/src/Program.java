/*
 *  AVLTree Class demo
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

import java.io.*;
import java.util.*;

import org.binarytree.avl.AVLTree;

public class Program {
	private static AVLTree myTree;

	public static void main(String[] args){
		File file = new File("German.txt");
	    FileInputStream fis = null;
	    BufferedInputStream bis = null;
	    DataInputStream dis = null;
	    
	    // this is actually already an unordered tree, so that might be the reason why Java is so much faster compared to python
	    HashMap<String, String> Dict = new HashMap<String, String>();
	    
	    try {
	    	fis = new FileInputStream(file);
	    	bis = new BufferedInputStream(fis);
	    	dis = new DataInputStream(bis);

	    	while (dis.available() != 0) {
	    		String s3 = dis.readLine();
	    		String [] temp = null;
	    		temp = s3.split("\t");
	    		String str = "";
	    		if (Dict.containsKey(temp[0]))
	    			str = Dict.get(temp[0]) + "\n";
	    		Dict.put(temp[0], str + " * " + temp[1]);
	    	}
	    	fis.close();
	    	bis.close();
	    	dis.close();
	    } catch (FileNotFoundException e) {
	    	e.printStackTrace();
	    } catch (IOException e) {
	    	e.printStackTrace();
	    }
		
		long start, end;
		start = System.currentTimeMillis();
		
		myTree = new AVLTree();
		
        for ( String key : Dict.keySet()) {
            myTree.insert(key, Dict.get(key));
        }

		end = System.currentTimeMillis();
		System.out.println("Tree generated in " + (end - start) + " ms.");
		start = System.currentTimeMillis();
		
		Scanner in = new Scanner(System.in);
		
		String word, Data;
		
		while (true) {
			System.out.print("What word do you want to have translated? ");
			word = in.nextLine();
			Data = myTree.search(word, false);
			if (Data == null)
				System.out.println("Not found in dictionary");
			else
				System.out.println(Data);
		}
	}
}
