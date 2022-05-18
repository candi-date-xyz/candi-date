##* * * * * *\\
## 📽️ Pr0J3ct1D
## uses inspiration
##* * * * * *//
function Pr0J3ct1D {
    _b00t_INSPIRATION_FILE=""
    local wordCount=$( cat $_b00t_INSPIRATION_FILE | jq '. | length' )
    # echo "wordCount: $wordCount"

    local word1=$( rand0 $wordCount )
    # echo "word1: $word1"
    local wordOne=$( cat $_b00t_INSPIRATION_FILE | jq ".[$word1].word" -r )
    local word2=$( rand0 $wordCount )
    # echo "word2: $word2"
    local wordTwo=$( cat $_b00t_INSPIRATION_FILE | jq ".[$word2].word" -r )
    local result="${wordOne}_${wordTwo}"

    ## todo: substitute 
    if [ $( rand0 10 ) -lt 5 ] ; then 
        result=$( echo $result | sed 's/l/1/g' )
    fi

    if [ $( rand0 10 ) -lt 2 ] ; then 
        result=$( echo $result | sed 's/o/0/g' )
    elif [ $( rand0 10 ) -lt 2 ] ; then 
        result=$( echo $result | sed 's/oo/00/g' )
    fi

    if [ $( rand0 10 ) -lt 2 ] ; then 
        result=$( echo $result | sed 's/e/3/g' )
    elif [ $( rand0 10 ) -lt 8 ] ; then 
        result=$( echo $result | sed 's/ee/33/g' )
    fi

    # Todo: fix first letter is a number. naming issue.

    echo $result
    return 0
}


