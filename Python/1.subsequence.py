#Given two strings s and t, return true if s is a subsequence of t, or false otherwise.
#A subsequence of a string is a new string that is formed from the original string by deleting some (can be none) of the characters 
#  without disturbing the relative positions of the remaining characters. (i.e., "ace" is a subsequence of "abcde" while "aec" is not).

#Solution1
class sample(object):
	def subsequence(self,s,t):
	  i,j=0,0
	  while i<len(s) and j<len(t):
	    if s[i]==t[j]:
		  i+=1
		j+=1
		
	  return i==len(s)
    
#Solution2
#class Solution(object):
#    def isSubsequence(self, s, t):
#        if len(s)==0: return True
#        if len(s)>len(t): return False
#        subseq=0
#        for i in range(0,len(t)):
#            if subseq <= len(s)-1:
#              if s[subseq]==t[i]:
#                subseq+=1
#
#        return subseq==len(s)
