
for i in range(1, 11):
    print("beginShape();")
    for j in range(1, 11):
        if i == j:
            pass
        else:
            print("fill(255, 0, 0);")
            print("vertex(P"+str(i)+".x, P"+str(i)+".y, P"+str(i)+".z);")
            print("vertex(P"+str(j)+".x, P"+str(j)+".y, P"+str(j)+".z);")
    print("endShape();")