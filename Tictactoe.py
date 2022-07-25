def startgame():
    writeboard(board)
    place(0)

board = ["_____","*","*","*","*","*","*","*","*","*","-----"]

def writeboard(board):
    print(board[0])
    print(board[1], board[2], board[3])
    print(board[4], board[5], board[6])
    print(board[7], board[8], board[9])
    print(board[10])

def checkwin(marker):
    if (board[1] and board[2] and board[3] != '*') and(board[1] and board[2] and board[3] == marker) and (board[1] == board[2]) and(board[2] == board[3]):
        return True
    if (board[4] and board[5] and board[6] != '*') and(board[4] and board[5] and board[6] == marker) and (board[4] == board[5]) and(board[5] == board[6]):
        return True
    if (board[7] and board[8] and board[9] != '*') and(board[7] and board[8] and board[9] == marker) and (board[7] == board[8]) and(board[8] == board[9]):
        return True
    if (board[1] and board[4] and board[7] != '*') and(board[1] and board[4] and board[7] == marker) and (board[1] == board[4]) and(board[4] == board[7]):
        return True
    if (board[2] and board[5] and board[8] != '*') and(board[2] and board[5] and board[8] == marker) and (board[2] == board[5]) and(board[5] == board[8]):
        return True
    if (board[3] and board[6] and board[9] != '*') and(board[3] and board[6] and board[9] == marker) and (board[3] == board[6]) and(board[6] == board[9]):
        return True
    if (board[1] and board[5] and board[9] != '*') and(board[1] and board[5] and board[9] == marker) and (board[1] == board[5]) and(board[5] == board[9]):
        return True
    if (board[5] and board[7] and board[3] != '*') and(board[5] and board[7] and board[3] == marker) and (board[5] == board[7]) and(board[7] == board[3]):
        return True

def place(count):
    nc = False
    if count%2==0:
        marker = 'X'
    if count%2==1:
        marker = 'O'
    
    b = int(input('1..9 {}  sin tur!'.format(marker)))
    tmp = board[b]
    if tmp != '*':
        print("ulovelig move amigo :/")
        nc = True
    tmp = marker
    board[b] = tmp
    if nc == False:
        count+=1
    writeboard(board) 
    if checkwin(marker):
        count == 9
        print("{} vant!".format(marker))
    elif count<=8:
        place(count)

startgame()
