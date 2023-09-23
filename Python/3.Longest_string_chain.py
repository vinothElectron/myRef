class Solution(object):
    def longestStrChain(self, words):
        """
        :type words: List[str]
        :rtype: int
        """
        if len(words)==1: return 1
        chain={}
        words=sorted(words,key=len)
        for i in range(len(words)):
            maxi=-1
            for j in range(len(words[i])):
                temp=1
                if words[i][:j]+words[i][j+1:] in chain.keys():
                   temp+=chain[words[i][:j]+words[i][j+1:]]
                if maxi<temp:
                    maxi=temp
            chain[words[i]]=maxi
        return max(chain.values())
