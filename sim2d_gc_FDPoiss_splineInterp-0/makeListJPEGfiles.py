import sys, os, getopt
# *******************************
# Creates a file named buildFile 
# that contains all the jpeg files 
# which are in the specified path
# *******************************

def main(argv):
   inputdirectory = ''
   outputfile = ''
   try:
      opts, args = getopt.getopt(argv,"hi:o:",["idirec=","ofile="])
   except getopt.GetoptError:
      print "Error : Wrong usage the syntax is "
      print 'test.py -i <inputdirectory> -o <outputfile>'
      sys.exit(2)
   if (opts==[]) :
      print "Error : Wrong usage the syntax is "
      print 'test.py -i <inputdirectory> -o <outputfile>'
      sys.exit(2)
   for opt, arg in opts:
      if opt == '-h':
         print 'test.py -i <inputdirectory> -o <outputfile>'
         sys.exit()
      elif opt in ("-i", "--idir"):
         inputdirectory = arg
      elif opt in ("-o", "--ofile"):
         outputfile = arg
      else:
         print "Error : Wrong usage the syntax is "
         print 'test.py -i <inputdirectory> -o <outputfile>'
         sys.exit(2)
   print 'Input directory is "', inputdirectory, '"'


   #Creation of file
   if (outputfile == '') :
      os.system("ls ./"+inputdirectory+"*.jpeg > buildFile")
      print " *** SUCCESS *** "
      print " File created : buildFile "

   else :
      os.system("ls ./"+inputdirectory+"*.jpeg > "+outputfile)
      print " *** SUCCESS *** "
      print " File created :"+outputfile

if __name__ == "__main__":
   main(sys.argv[1:])
