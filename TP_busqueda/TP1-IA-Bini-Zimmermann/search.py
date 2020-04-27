# search.py
# ---------
# Licensing Information: Please do not distribute or publish solutions to this
# project. You are free to use and extend these projects for educational
# purposes. The Pacman AI projects were developed at UC Berkeley, primarily by
# John DeNero (denero@cs.berkeley.edu) and Dan Klein (klein@cs.berkeley.edu).
# For more info, see http://inst.eecs.berkeley.edu/~cs188/sp09/pacman.html

"""
In search.py, you will implement generic search algorithms which are called
by Pacman agents (in searchAgents.py).
"""

import util

class SearchProblem:
    """
    This class outlines the structure of a search problem, but doesn't implement
    any of the methods (in object-oriented terminology: an abstract class).

    You do not need to change anything in this class, ever.
    """

    def getStartState(self):
        """
        Returns the start state for the search problem
        """
        util.raiseNotDefined()

    def isGoalState(self, state):
        """
          state: Search state

        Returns True if and only if the state is a valid goal state
        """
        util.raiseNotDefined()

    def getSuccessors(self, state):
        """
          state: Search state

        For a given state, this should return a list of triples,
        (successor, action, stepCost), where 'successor' is a
        successor to the current state, 'action' is the action
        required to get there, and 'stepCost' is the incremental
        cost of expanding to that successor
        """
        util.raiseNotDefined()

    def getCostOfActions(self, actions):
        """
         actions: A list of actions to take

        This method returns the total cost of a particular sequence of actions.  The sequence must
        be composed of legal moves
        """
        util.raiseNotDefined()


def tinyMazeSearch(problem):
    """
    Returns a sequence of moves that solves tinyMaze.  For any other
    maze, the sequence of moves will be incorrect, so only use this for tinyMaze
    """
    from game import Directions
    s = Directions.SOUTH
    w = Directions.WEST
    return  [s,s,w,s,w,w,s,w]

def search(problem, fringe):
    initial_state = problem.getStartState()
    initial_actions = []
    initial_candidate = (initial_state, initial_actions)
    fringe.push(initial_candidate)
    closed_set = set()
    while not fringe.isEmpty():
        candidate = fringe.pop()
        state, actions = candidate
        if problem.isGoalState(state):
            return actions
        if state not in closed_set:
            closed_set.add(state)
            candidate_successors = problem.getSuccessors(state)
            candidate_successors = filter(lambda x: x[0] not in closed_set, candidate_successors)
            candidate_successors = map(lambda x: (x[0], actions + [x[1]]), candidate_successors)
            for candidate in candidate_successors:
                fringe.push(candidate)


def makeSolution(parents, node):
        
    successor, action, cost = node
    solution = [action]
        
    while (parents[successor] != None):
        node = parents[successor]
        successor, action, cost = node
        solution = [action] + solution 
    
    return solution[1:]

def depthFirstSearch(problem):
    """
    Search the deepest nodes in the search tree first

    Your search algorithm needs to return a list of actions that reaches
    the goal.  Make sure to implement a graph search algorithm

    To get started, you might want to try some of these simple commands to
    understand the search problem that is being passed in:

    print "Start:", problem.getStartState()
    print "Is the start a goal?", problem.isGoalState(problem.getStartState())
    print "Start's successors:", problem.getSuccessors(problem.getStartState())
    """
    
    nodeList = util.Stack()
    init = problem.getStartState()
    nodeList.push((init, "Init", 1))
    solution = []
    parents = {}
    parents[init] = None
    
    while (not(nodeList.isEmpty())):
        node = nodeList.pop()
        state, action, cost = node
        
        if (problem.isGoalState(state)):
            return makeSolution(parents, node)
        
        else:
            childList = problem.getSuccessors(state)
            for child in childList:
                stateC, actionC, costC = child
                if (not(parents.has_key(stateC))): 
                    parents[stateC] = node
                    nodeList.push(child)
    
    return []


def breadthFirstSearch(problem):
    """
    Search the shallowest nodes in the search tree first.
    """
    nodeList = util.Queue()
    init = problem.getStartState()
    nodeList.push((init, "Init", 1))
    solution = []
    parents = {}
    parents[init] = None
    
    while (not(nodeList.isEmpty())):
        node = nodeList.pop()
        state, action, cost = node
        
        if (problem.isGoalState(state)):
            return makeSolution(parents, node)
        
        else:
            childList = problem.getSuccessors(state)
            for child in childList:
                stateC, actionC, costC = child
                if (not(parents.has_key(stateC))): 
                    parents[stateC] = node
                    nodeList.push(child)
    
    return []
    

def makeSolutionCost(parents, node):
    
    successor, action, cost = node
    solution = [action]
        
    while (parents[successor] != (None, 0)):
        node, cost = parents[successor]
        successor, action, cost = node
        solution = [action] + solution 
    
    return solution[1:]

def uniformCostSearch(problem):

    nodeList = util.PriorityQueue()
    init = problem.getStartState()
    nodeList.push((init, "Init", 1), 0)
    solution = []
    parents = {}
    parents[init] = (None, 0)
    
    while (not(nodeList.isEmpty())):
        node = nodeList.pop()
        state, action, cost = node
        
        if (problem.isGoalState(state)):
            return makeSolutionCost(parents, node)
        
        else:
            childList = problem.getSuccessors(state)
            for child in childList:
                stateC, actionC, costC = child
                totalCost = cost + costC
                accumChild = (stateC, actionC, totalCost)
                exists = parents.has_key(stateC)
                if (exists):
                    actualParent, actualCost = parents[stateC]
                if (not(exists) or totalCost < actualCost):
                    parents[stateC] = (node, totalCost)
                    nodeList.push(accumChild, totalCost)

    return []

def nullHeuristic(state, problem=None):
    """
    A heuristic function estimates the cost from the current state to the nearest
    goal in the provided SearchProblem.  This heuristic is trivial.
    """
    return 0

def aStarSearch(problem, heuristic=nullHeuristic):
    "Search the node that has the lowest combined cost and heuristic first."
    
    nodeList = util.PriorityQueue()
    init = problem.getStartState()
    nodeList.push((init, "Init", 1), 0)
    solution = []
    parents = {}
    parents[init] = (None, 0)
    
    while (not(nodeList.isEmpty())):
        node = nodeList.pop()
        state, action, cost = node
        
        if (problem.isGoalState(state)):
            return makeSolutionCost(parents, node)
        
        else:
            childList = problem.getSuccessors(state)
            for child in childList:
                stateC, actionC, costC = child
                costG = cost + costC
                costH = heuristic(stateC, problem)
                costF = costG + costH                 
                accumChild = (stateC, actionC, costF)
                exists = parents.has_key(stateC)
                if (exists):
                    actualParent, actualCost = parents[stateC]
                if (not(exists) or costG < actualCost):
                    parents[stateC] = (node, costG)
                    nodeList.push(accumChild, costF)

    return []    

# Abbreviations
bfs = breadthFirstSearch
dfs = depthFirstSearch
astar = aStarSearch
ucs = uniformCostSearch
