import java.util.ArrayList;

/**
	This class illustrates how a Node of the minMaxTree should work.
	Let's go into details ...
*/
public class Node79858009
{
	Node79858009 parent;
	ArrayList<Node79858009> children;
	int nodeDepth;
	int[] nodeMove;
	Board nodeBoard;
	int nodeEvaluation;
	int id;
	
	//a couple of useful constructors
	public Node79858009(Board board){
		nodeMove = new int[2];
		this.nodeBoard = board;
		this.children = new ArrayList<Node79858009>();
	}
	public Node79858009(int x, int y, Board board, int nodeDepth, Node79858009 parent, int id){
		this.nodeMove = new int[2];
		this.nodeMove[0] = x;
		this.nodeMove[1] = y;
		this.nodeBoard = board;
		this.nodeDepth = nodeDepth;
		this.parent = parent;
		this.id = id;
		this.children = new ArrayList<Node79858009>();
	}
	
	// setters for the variables of the class
	public void setParent(Node79858009 p){
		this.parent = p;
	}
	public void setChildren(Node79858009 x){
		this.children.add(x);
	}
	public void setNodeDepth(int x){
		this.nodeDepth = x;
	}
	public void setNodeBoard(Board x){
		this.nodeBoard = x;
	}
	
	/**
	   for this specific setter we performed this overload, as it was considered needed. 
	   the first one calls the method evaluate() and computes the evaluation of the board
	   the second one, directly sets a value-- which is determined by other factors (eg. is the MAX value of it children)
	   */
	public void setNodeEvaluation(){
		this.nodeEvaluation = this.evaluate();
	}
	public void setNodeEvaluation(int m){
		this.nodeEvaluation = m;
	}
	
	//getters for our variables
	public Node79858009 getParent(){
		return this.parent;
	} 
	public ArrayList<Node79858009> getChildren(){
		return this.children;
	}
	public int getNodeDepth(){
		return this.nodeDepth;
	}
	public Board getNodeBoard(){
		return this.nodeBoard;
	}
	public int getNodeEvaluation(){
		return this.nodeEvaluation;
	}
	public int[] getNodeMove(){
		int[] result = {this.nodeMove[0], this.nodeMove[1]};
		return result;
	}
	public int getId(){
		return this.id;
	}

	// this method just adds one child to the arrayList of children
	public void addChild(Node79858009 x){
		this.children.add(x);
	}
	
	// This method computes the evaluation of a node, that is how good playing this tile at the current board is.
	int evaluate(){
		// each function we use here will be explained later
		  int result=0;
		  int[] me = new int[8];
		  int[] enemy = new int[8];
		  int[] temp = new int[2];
		  //me[0]=continuous, me[1]=sides
		  temp  =  searching(this.nodeMove[0] , this.nodeMove[1], this.id, this.nodeBoard , 0, 1);
		  me[0] = temp[0];
		  me[1] = temp[1];
		  temp  =  searching(this.nodeMove[0] , this.nodeMove[1], this.id, this.nodeBoard , 1, 0);
		  me[2] = temp[0];
		  me[3] = temp[1];
		  temp  =  searching(this.nodeMove[0] , this.nodeMove[1], this.id, this.nodeBoard , 1, 1);
		  me[4] = temp[0];
		  me[5] = temp[1];
		  temp  =  searching(this.nodeMove[0] , this.nodeMove[1], this.id, this.nodeBoard , -1, 1);
		  me[6] = temp[0];
		  me[7] = temp[1];
		  
		  temp     = searching(this.nodeMove[0] , this.nodeMove[1], 1+this.id%2, this.nodeBoard , 0, 1);
		  enemy[0] = temp[0];
		  enemy[1] = temp[1];
		  temp     = searching(this.nodeMove[0] , this.nodeMove[1], 1+this.id%2, this.nodeBoard , 1, 0);
		  enemy[2] = temp[0];
		  enemy[3] = temp[1];
		  temp     = searching(this.nodeMove[0] , this.nodeMove[1], 1+this.id%2, this.nodeBoard , 1, 1);
		  enemy[4] = temp[0];
		  enemy[5] = temp[1];
		  temp     = searching(this.nodeMove[0] , this.nodeMove[1], 1+this.id%2, this.nodeBoard , -1, 1);
		  enemy[6] = temp[0];
		  enemy[7] = temp[1];
		  
		  for(int j = 0; j < 4 ; j++){
			  switch(me[2*j]){
			  case 1: break;
			  case 2: 
				  if (me[2*j+1] == 1)
					  result -= 2;
				  else if (me[2*j+1] == 2)
					  result -= 7;
				  break;
			  case 3:
				  if (me[2*j+1] == 1)
					  result -= 11;
				  else if (me[2*j+1] == 2)
					  result -= 19;
				  break;
			  case 4:
				  if (me[2*j+1] == 1)
					  result -= 29;
				  else if (me[2*j+1] == 2)
					  return -997;
				  break;
			  default:
				  return -999;
			  }
			  
			  switch(enemy[2*j]){
			  case 1: break;
			  case 2: 
				  if (enemy[2*j+1] == 1)
					  result += 3;
				  else if (enemy[2*j+1] == 2)
					  result += 8;
				  break;
			  case 3:
				  if (enemy[2*j+1] == 1)
					  result += 12;
				  else if (enemy[2*j+1] == 2)
					  result += 20;
				  break;
			  case 4:
				  if (enemy[2*j+1] == 1)
					  result += 30;
				  else if (enemy[2*j+1] == 2)
					  return 998;
				  break;
			  default:
				  return 1000;
			  }
			  
		  }
		  
		  return result;
	  }
	  int[] searching(int x, int y, int who, Board board, int xDirection, int yDirection){
		  int continuous = 0;
		  int expandable = 0;
		  // this variable will see if it is expandable by both sides
		  int sides = 0;
		  boolean flag = true;
		  int[] search = {x,y};
		  // here it checks for the one half of the direction you gave 
		  //In this while, it counts how many pieces of the wanted color are in sequence on the one half of the direction
		  while(true){
			  search[0] += xDirection;
			  search[1] += yDirection;
			  // at this if we check to be inside the matrix/board
			  if		(search[0]<0
						||search[1]<0 
						||search[0]>=GomokuUtilities.NUMBER_OF_ROWS  
						||search[1]>=GomokuUtilities.NUMBER_OF_COLUMNS)
					break;
			  if ( board.getTile(search[0], search[1]).getColor() == who)
				  continuous +=1;
			  else
				  break;
		  }
		  // here we check for the availability of expansion (the potential Quintiple ) 
		  while(true){
			  if		(search[0]<0
						||search[1]<0 
						||search[0]>=GomokuUtilities.NUMBER_OF_ROWS  
						||search[1]>=GomokuUtilities.NUMBER_OF_COLUMNS)
					break;
			  if ( board.getTile(search[0], search[1]).getColor() == 0){
				  expandable +=1;
			  	  sides = 1;
			  }
			  else
				  break;
			  search[0] += xDirection;
			  search[1] += yDirection;
		  }
		  // the same as above but the other half of the direction (the opposite vector, which is parallel)
		  search[0] = x;
		  search[1] = y;
		  while(true){
			  search[0] -= xDirection;
			  search[1] -= yDirection;
			  if		(search[0]<0
						||search[1]<0 
						||search[0]>=GomokuUtilities.NUMBER_OF_ROWS
						||search[1]>=GomokuUtilities.NUMBER_OF_COLUMNS)
					break;
			  if (board.getTile(search[0], search[1]).getColor() == who){
				  continuous +=1;
			  }
			  else
				  break;
		  }
		  while(true){
			  if		(search[0]<0
						||search[1]<0 
						||search[0]>=GomokuUtilities.NUMBER_OF_ROWS  
						||search[1]>=GomokuUtilities.NUMBER_OF_COLUMNS)
					break;
			  if ( board.getTile(search[0], search[1]).getColor() == 0){
				  expandable +=1;
				  if ((sides == 0 || sides == 1)&flag){
					  sides += 1;
					  flag = false;
				  }
			  }		  
			  else
				  break;
			  search[0] -= xDirection;
			  search[1] -= yDirection;
		  }
		  // we set sides to be 0 (=zero) in case that a Quintuple may Never occur in the certain direction
		  // so that we don't waste turns putting pieces there
		  if (continuous+expandable+1<5)
			  sides = 0;
		  // we add +1 to the continuous, so that it contains the point (x,y) we are talking about
		  int[] result = new int[]{continuous+1, sides};
		  return result;
	  }
}
