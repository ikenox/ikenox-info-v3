module Domain.BlogPost exposing (BlogPost, PostId)


type alias PostId =
    String


type alias BlogPost =
    { postId : PostId
    , title : String
    , bodyMd : String
    }
