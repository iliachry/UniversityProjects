import java.util.ArrayList;

/**
*This is a class of a Heuristic player, checking the deck and returning what
*he should do to come closer to a win (or at least not loose)
*
**/
public class SecondPlayer implements AbstractPlayer
{
// these were already given by the template
  int score;
  int id;
  String name;
  boolean FirstTurn = true; // with this variable we keep track of wether it is the first time we play or not

  // these are a couple of contructors (given to us)
  public SecondPlayer (Integer pid)
  {
    id = pid;
    score = 0;

  }

  public SecondPlayer(Integer pid, int pscore, String pname){
	  score = pscore;
	  id = pid;
	  name=pname;

  }

  // a few simple functions (given to us)
  public String getName ()
  {

    return "SecondHeuristic";

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

  /**
   * @details this function returns the coordinates of what we want as the next move
   *
   *  in the first part
   *  we check for each piece if they are empty and therefor available to play,
   *  and then we give then a value (this.evaluate(i,j,board))
   *  to keep track of how "important each piece is"
   *
   *  in the second part
   *  here we search for the maximum "importance" as mentioned above.
   *   the int position is to keep track of where the max occured and afterwards
   *   to be able to retrieve the respective point(coordinates)
   */
  public int[] getNextMove (Board board)
  {
	  //First part
	  ArrayList <int[]> evaluationArray = new ArrayList <int[]>();
	  for(int i=0; i< GomokuUtilities.NUMBER_OF_ROWS ; i++){
		  for(int j=0 ; j < GomokuUtilities.NUMBER_OF_COLUMNS ; j++){
			  Tile temp = new Tile();
			  temp = board.getTile(i, j);
			  if (temp.getColor() == 0) {
				  int[] result = new int[]{i,j, this.evaluate(i,j,board)};
				  evaluationArray.add(result);
			  }
		  }
	  }

	  // Second part
	  int position = 0;
	  int[] temp = new int[3];
	  temp = evaluationArray.get(position);
	  int max = temp[2] ;
	  for (int i=1 ; i < evaluationArray.size(); i++){
		  temp = evaluationArray.get(i);
		  if (temp[2] > max){
			  max = temp[2];
			  position = i;
		  }
	  }
	  //this variable will contain the point we will return
	  int[] choice = new int[2];
	  //if it is the first time we play we want to randomly put a piece somewhere near the center
	  if(this.FirstTurn){
		  this.FirstTurn = false;
		  choice[0] = (int)(5 * Math.random()+5);
		  choice[1] = (int)(5 * Math.random()+5);
		  if (board.getTile(choice[0], choice[1]).getColor() == 0)
			  return choice;
	  }
	  // here we retrieve the point (as mentioned before) with the max "importance" and return it
	  temp = evaluationArray.get(position);
	  choice[0] = temp[0];
	  choice[1] = temp[1];
	  return choice;
  }

  /**this is the function that determines the importance (= weight) of each point
   *
   * @param x,y are the coordinates we want to check
   * @param board the board we play on
   * @return the value of a specific point
   *
   * in vectors me&enemy we put for each direction the amount of continuous pieces
   * and the number of ways it is possible to expand (for each direction of course)
   *
   * in the two loops we calculate the weight according to our (simple) strategy
   */
  int evaluate (int x, int y, Board board){
  	  // each function we use here will be explained later
	  int result=0;
	  int[] me = new int[8];
	  int[] enemy = new int[8];
	  int[] temp = new int[2];

	  temp  =  searching(x , y, this.id, board , 0, 1);
	  me[0] = temp[0];
	  me[1] = temp[1];
	  temp  =  searching(x , y, this.id, board , 1, 0);
	  me[2] = temp[0];
	  me[3] = temp[1];
	  temp  =  searching(x , y, this.id, board , 1, 1);
	  me[4] = temp[0];
	  me[5] = temp[1];
	  temp  =  searching(x , y, this.id, board , -1, 1);
	  me[6] = temp[0];
	  me[7] = temp[1];

	  temp     = searching(x , y, 1+this.id%2, board , 0, 1);
	  enemy[0] = temp[0];
	  enemy[1] = temp[1];
	  temp     = searching(x , y, 1+this.id%2, board , 1, 0);
	  enemy[2] = temp[0];
	  enemy[3] = temp[1];
	  temp     = searching(x , y, 1+this.id%2, board , 1, 1);
	  enemy[4] = temp[0];
	  enemy[5] = temp[1];
	  temp     = searching(x , y, 1+this.id%2, board , -1, 1);
	  enemy[6] = temp[0];
	  enemy[7] = temp[1];

	  for(int j = 0; j < 4 ; j++){
		  switch(me[2*j]){
		  case 1: break;
		  case 2:
			  if (me[2*j+1] == 1)
				  result += 3;
			  else if (me[2*j+1] == 2)
				  result += 8;
			  break;
		  case 3:
			  if (me[2*j+1] == 1)
				  result += 12;
			  else if (me[2*j+1] == 2)
				  result += 20;
			  break;
		  case 4:
			  if (me[2*j+1] == 1)
				  result += 30;
			  else if (me[2*j+1] == 2)
				  return 998;
			  break;
		  default:
			  return 1000;
		  }

		  switch(enemy[2*j]){
		  case 1: break;
		  case 2:
			  if (enemy[2*j+1] == 1)
				  result += 2;
			  else if (enemy[2*j+1] == 2)
				  result += 7;
			  break;
		  case 3:
			  if (enemy[2*j+1] == 1)
				  result += 11;
			  else if (enemy[2*j+1] == 2)
				  result += 19;
			  break;
		  case 4:
			  if (enemy[2*j+1] == 1)
				  result += 29;
			  else if (enemy[2*j+1] == 2)
				  return 997;
			  break;
		  default:
			  return 999;
		  }
	  }
	  return result;
  }





  /**
   *
   * @param x, y he coordinates of the piece we are evaluating
   * @param who wether we want it to search for our pieces or the "enemy's"
   * @param board the board of the game
   * @param xDirection, yDirection the dyrection that we want to search at
   * @return a vector containing the number of continuous pieces & the number of ways it may expand
   *
   * the search happens in two steps. We first check for the one half of the direction
   * and then for the other
   * When we finish counting the continuous pieces of the one half, before we move to the next,
   * we count the number of possible expansion pieces that have the ability to occur in the future.
   *
   *
   */
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


