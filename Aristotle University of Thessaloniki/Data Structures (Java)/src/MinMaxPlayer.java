/**
This is the class that illustrates how a player performing min max algorith should play.
Note that for the first moves we are playing like our previous Heuristic player since the MinMax is slow at the start
*/
public class MinMaxPlayer implements AbstractPlayer
{
  static int counter;
  int score;
  int id;
  String name;
  int finalDepth = 2;
  HeuristicPlayer heuristic ;

//Constructors of the class
  public MinMaxPlayer (Integer pid)
  {
    id = pid;
    score = 0;
	this.heuristic = new HeuristicPlayer(this.id);

  }
// getters and setters provided to us
  public String getName ()
  {

    return "MinMax";

  }

  public int getId ()
  {
    return id;
  }

  public void setScore (int score)
  {
    this.score = score;
  }

  public int getScore ()
  {
    return score;
  }

  public void setId (int id)
  {
    this.id = id;
  }

  public void setName (String name)
  {
    this.name = name;
  }

  // This function returns the piece on the board we want to play.
  public int[] getNextMove ( Board board)
  {		
	// index will contain the place/number of the kid of the root that we want to reach
	  int[] index=new int[]{-1};
	  Board newBoard = new Board(true);
	  newBoard = GomokuUtilities.cloneBoard(board);
	  Node79858009 newRoot = new Node79858009(newBoard);	  
	  this.createMySubTree(newRoot, 1,index);
      int[] bestTile = newRoot.getChildren().get(index[0]).getNodeMove();
      return bestTile;
   	  
  }

  /**
	This function takes as parameters a node, the depth of the node and index 
	(index is used so that we can return its value without 'return' anything)
	for each empty tile in the board we create a node, called newNode.
	we set this newNode as the child of the node parent. 
	and for each of these newNodes we call a function to create the subtree that starts from them.
	At the last block we keep track of the maximum value/evaluation of the different nodes and its position,
    that is put at the index (which is here used as a pointer would be used in C++)
	{these evaluation are set by the next method -createOpponentSubTree-}
  */
  private void createMySubTree (Node79858009 parent, int depth,int[] index)
  {	  int max=-10000;
  	  int position=-1;
  	  int numberOfChildren=0;
	  for(int i=0; i< GomokuUtilities.NUMBER_OF_ROWS ; i++){
		  for(int j=0 ; j < GomokuUtilities.NUMBER_OF_COLUMNS ; j++){
			  Tile temp = new Tile();
			  temp = parent.getNodeBoard().getTile(i, j);
			  if (temp.getColor() == 0) {
				  numberOfChildren++;
				  Board newBoard = new Board(true);
				  newBoard = GomokuUtilities.cloneBoard(parent.getNodeBoard());
				  GomokuUtilities.playTile(newBoard, i, j, this.id);
				  Node79858009 newNode = new Node79858009(i,j,newBoard, depth, parent, this.id);
				  parent.addChild(newNode);
				  this.createOpponentSubTree(newNode, depth +1);
				  if (max<newNode.getNodeEvaluation()){
					  max=newNode.getNodeEvaluation();
					  position=numberOfChildren-1;
					  parent.setNodeEvaluation(max);
					  index[0]=position;
				  }
			  }
		  }
	  }
  }

  /**
	This function takes as parameters a node and the depth of the node 
	for each empty tile in the board we create a node, called newNode.
	we set this newNode as the child of the node parent. 
	Then, if we are at the final depth (in this version we always are)
	we set the proper evaluation of the node, 
	and we keep track of the minimum evaluation found, which is 
	set as the evaluation of the parent.. 
	Finally, we put this line of code, which does the AB-pruning to win some time and RAM.
  */
  private void createOpponentSubTree (Node79858009 parent, int depth)
  {	  int min=10000;
	  for(int i=0; i< GomokuUtilities.NUMBER_OF_ROWS ; i++){
		  for(int j=0 ; j < GomokuUtilities.NUMBER_OF_COLUMNS ; j++){
			  Tile temp = new Tile();
			  temp = parent.getNodeBoard().getTile(i, j);
			  if (temp.getColor() == 0) {
				  int evaluation;
				  Board newBoard = new Board(false);
				  newBoard = GomokuUtilities.cloneBoard(parent.getNodeBoard());
				  GomokuUtilities.playTile(newBoard, i, j, 1+this.id%2);
				  Node79858009 newNode = new Node79858009(i,j,newBoard, depth, parent, 1+this.id%2);
				  parent.addChild(newNode);
				  if (depth==this.finalDepth){
					  newNode.setNodeEvaluation();
					  evaluation=newNode.getNodeEvaluation();
					  if (evaluation<min){
						  min=evaluation;
						  parent.setNodeEvaluation(min);
					  }
					  // This is the AB-pruning  ..... :)
					  if (min<=parent.getParent().getNodeEvaluation() && parent.getParent().getChildren().size()>1){
						  return;
					  }
				  }
			  }
		  }
	  }  
  }

  private int chooseMove (Node79858009 root)
  {		
	  int index = 0;
	  int numberOfChildren = root.getChildren().size();
	  int[] evaluation = new int[numberOfChildren];
	  for(int i=0; i<numberOfChildren;i++){
		  evaluation[i] = calculate(root.getChildren().get(i));
	  }
	  int max = evaluation[0];
	  for(int i=1; i< numberOfChildren; i++){
			  if(max < evaluation[i]){
				  index = i;
				  max = evaluation[i];
			  }
	  }
	  return index;	  
  }

  private int calculate(Node79858009 currentNode ){
	  if(currentNode.getNodeDepth()==finalDepth){ 
		  return currentNode.evaluate();
	  }
	  else{
		  
		  int numberOfChildren = currentNode.getChildren().size();
		  int[] evaluation = new int[numberOfChildren];
		  for(int i=0; i<numberOfChildren;i++){
			  evaluation[i] = calculate(currentNode.getChildren().get(i));
			  //System.out.println(evaluation[i]);
		  }
			  //max
			  int min = evaluation[0];
			  for(int i=1; i< numberOfChildren; i++){
				  if(min > evaluation[i])
					 min = evaluation[i];
			  }
			  System.out.println("max="+min); 
			  return min;	 
	  }
  }
  
  
  
  
}
